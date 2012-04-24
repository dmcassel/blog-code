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