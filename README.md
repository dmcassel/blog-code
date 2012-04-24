blog-code
=========

Code that I write about on my blog and share here. This repository is set up using the Roxy framework to make it easy to write unit tests, but I'm intending that code in here can be used separately from Roxy. 

CSV Conversion
--------------

Code to convert lines of Comma Separated Values (CSV) into XML. You can build a template XML that includes hierarchy and you can specify actions to be applied to elements during the conversion. Relevant files:

- src/app/models/csv-lib.xqy
- src/test/suites/csv-lib/build-map.xqy
- src/test/suites/csv-lib/convert.xqy
- src/test/suites/csv-lib/suite-setup.xqy
- src/test/suites/csv-lib/suite-teardown.xqy
- src/test/suites/csv-lib/test-data/templates.xqy