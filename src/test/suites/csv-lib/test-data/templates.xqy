xquery version "1.0-ml";

module namespace tmpl = "http://davidcassel.net/tmpl-cat";

declare namespace curio = "http://davidcassel.net/curio";

declare variable $item := 
  <curio:item>
    <curio:type src="1"/>
    <curio:name src="2"/>
    <curio:location>
      <curio:label src="3"/>
    </curio:location>
    <curio:acquired-date>
      <curio:start src="4" ns="http://davidcassel.net/csv" action="reformat-date"/>
      <curio:end src="5" ns="http://davidcassel.net/csv" action="reformat-date"/>
    </curio:acquired-date>
    <curio:description src="6"/>
    <curio:notes src="7"/>
    <curio:owner src="8"/>
  </curio:item>;
