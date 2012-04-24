xquery version "1.0-ml";

import module namespace tmpl = "http://davidcassel.net/tmpl-cat" at "test-data/templates.xqy";

xdmp:document-insert("/templates/item.xml", $tmpl:item)
