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

module namespace csv = "http://davidcassel.net/csv";

(: Convert a line of CSV text to XML based on the template :)
declare function csv:convert($line as xs:string, $tmpl as element())
{
  csv:build-element(
    $tmpl, 
    csv:build-map($line)
  )
};

(: Build a map based on the values in the CSV line :)
declare function csv:build-map($line)
{
  let $field-map := map:map()
  let $populate := (
    for $field at $i in csv:break($line)
    return map:put($field-map, xs:string($i), fn:normalize-space($field))
  )
  return $field-map
};

(: Use the template and the map of values to build an XML structure :)
declare function csv:build-element($template, $map)
{
  let $element := 
    if (fn:exists($template/@src)) then
      let $value := map:get($map, $template/@src)
      return 
        if ($value) then
          element { fn:node-name($template) } {
            $value
          }
        else ()
    else
      let $children := 
        for $element in $template/element()
        return csv:build-element($element, $map)
      return
        if ($children) then
          element { fn:node-name($template) } {
            $children
          }
        else ()
  return
    if ($template/@action) then
      xdmp:apply(
        xdmp:function(fn:QName($template/@ns, $template/@action)),
        $element
      )
    else
      $element
};

declare function csv:reformat-date($date)
{
  let $date-str := $date/fn:string()
  return
    element { fn:node-name($date) } {
      if ($date-str castable as xs:date) then
        $date-str
      else if (fn:matches($date-str, "^\d{8}$")) then
        fn:replace($date-str, "(\d{4})(\d{2})(\d{2})", "$1-$2-$3")
      else if (fn:matches($date-str, "^\d{1,2}/\d{1,2}/\d{4}")) then
        let $good-date := fn:replace($date-str, "^(\d{1,2})/(\d{1,2})/(\d{4})", "$3-$1-$2")
        return 
          fn:replace(
            fn:replace($good-date, "-(\d)$", "-0$1"),
            "-(\d)-", "-0$1-")
      else 
        $date-str
    }
};

(: Given a CSV line, break it into fields. :)
declare function csv:break($str)
{
  if ($str) then
    if (fn:starts-with($str, '"')) then
      let $after-quote := fn:substring($str, 2)
      return (
        fn:substring-before($after-quote, '"'),
        csv:break(fn:substring-after($after-quote, '",'))
      )
    else if (fn:matches($str, ",")) then (
      fn:substring-before($str, ','),
      csv:break(fn:substring-after($str, ','))
    )
    else 
      $str
  else ()
};

