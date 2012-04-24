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

import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";
import module namespace csv = "http://davidcassel.net/csv" at "/app/models/csv-lib.xqy";

let $actual := 
  csv:build-map('pin,Pilatus,"Pilatus mountain",1/7/1984,"a gondola","a word, and another",dcassel')
return (
  test:assert-equal("pin", map:get($actual, "1")),
  test:assert-equal("Pilatus", map:get($actual, "2")),
  test:assert-equal("Pilatus mountain", map:get($actual, "3")),
  test:assert-equal("1/7/1984", map:get($actual, "4")),
  test:assert-equal("a gondola", map:get($actual, "5")),
  test:assert-equal("a word, and another", map:get($actual, "6")),
  test:assert-equal("dcassel", map:get($actual, "7"))
)