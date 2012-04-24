(:
Copyright 2012 David M. Cassel

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
:)
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
