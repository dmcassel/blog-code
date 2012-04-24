xquery version "1.0-ml";

import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";
import module namespace csv = "http://davidcassel.net/csv" at "/app/models/csv-lib.xqy";

declare namespace curio = "http://davidcassel.net/curio";

let $template := fn:doc("/templates/item.xml")/curio:item
let $log := xdmp:log(fn:concat("convert test; template=", xdmp:quote($template)))
let $actual := csv:convert(
  'pin,Pilatus,"Pilatus mountain",7/1/1984,7/31/1984,,"a word, and another",dcassel',
  $template
)
return (
  test:assert-true($actual instance of element(curio:item)),
  test:assert-equal(<curio:type>pin</curio:type>, $actual/curio:type),
  test:assert-equal(<curio:name>Pilatus</curio:name>, $actual/curio:name),
  test:assert-equal(<curio:label>Pilatus mountain</curio:label>, $actual/curio:location/curio:label),
  test:assert-equal(<curio:start>1984-07-01</curio:start>, $actual/curio:acquired-date/curio:start),
  test:assert-equal(<curio:end>1984-07-31</curio:end>, $actual/curio:acquired-date/curio:end),
  test:assert-not-exists($actual/curio:description),
  test:assert-equal(<curio:notes>a word, and another</curio:notes>, $actual/curio:notes),
  test:assert-equal(<curio:owner>dcassel</curio:owner>, $actual/curio:owner)
)