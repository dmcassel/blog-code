#include <MarkLogic.h>
#include <stdio.h>
#include <time.h>
#include <iostream>
#include <sstream>

#ifdef _MSC_VER
#define PLUGIN_DLL __declspec(dllexport)
#else // !_MSC_VER
#define PLUGIN_DLL
#endif

using namespace marklogic;

////////////////////////////////////////////////////////////////////////////////

class DayOfWeek : public AggregateUDF
{
public:

  // Counts for each day of the week. counts[0] is for Sunday.
  uint64_t counts[7];

public:
  DayOfWeek() {
    for (int i=0; i<7; i++) counts[i]=0;
  }

  AggregateUDF* clone() const { return new DayOfWeek(*this); }
  void close() { delete this; }

  void start(Sequence&, Reporter&);
  void finish(OutputSequence& os, Reporter& reporter);

  void map(TupleIterator& values, Reporter& reporter);
  void reduce(const AggregateUDF* _o, Reporter& reporter);

  void encode(Encoder& e, Reporter& reporter);
  void decode(Decoder& d, Reporter& reporter);
};

void DayOfWeek::
start(Sequence& arg, Reporter& reporter)
{
  reporter.log(Reporter::Info, "DOW start()");
}

void DayOfWeek::
finish(OutputSequence& os, Reporter& reporter)
{
  reporter.log(Reporter::Info, "DOW finish()");
  char key[2];
  os.startMap();
  for (int i=0; i<7; i++) {
    sprintf(key, "%d", i);
    os.writeMapKey(key);
    os.writeValue(counts[i]);
  }
  os.endMap();
}

void DayOfWeek::
map(TupleIterator& values, Reporter& reporter)
{
  marklogic::DateTime v;
  time_t iVal;
  struct tm timeval;
  int dow;
  for(; !values.done(); values.next()) {
    if(!values.null(0)) {
      values.value(0, v);
      iVal = v;
      localtime_r(&iVal, &timeval);
      dow = timeval.tm_wday;
      counts[dow] += values.frequency();
    }
  }
}

void DayOfWeek::
reduce(const AggregateUDF* _o, Reporter& reporter)
{
  const DayOfWeek*o = (const DayOfWeek*)_o;
  for (int i=0; i<7; i++) {
    std::stringstream log;
    log << "reducing " << counts[i] << " + " << o->counts[i];
    reporter.log(Reporter::Info, log.str().c_str());
    counts[i] += o->counts[i];
  }
  //gt += o->gt;
  //eq += o->eq;
  //lt += o->lt;
}

void DayOfWeek::
encode(Encoder& e, Reporter& reporter)
{
//  e.encode(value);
  for (int i=0; i<7; i++)
    e.encode(counts[i]);
}

void DayOfWeek::
decode(Decoder& d, Reporter& reporter)
{
//  d.decode(value);
  for (int i=0; i<7; i++)
    d.decode(counts[i]);
}

////////////////////////////////////////////////////////////////////////////////

extern "C" PLUGIN_DLL void
marklogicPlugin(Registry& r)
{
  r.version();
  r.registerAggregate<DayOfWeek>("day-of-week");
}
