# charlotte

Charlotte is a little spider that crawls the web. Built with nokogiri + selenium.

```
 Usage: `echo [TEXT] | charlotte.rb` or `charlotte.rb -f [FILE]` or `charlotte.rb -u [URL]`

 Description: A little spider to crawl the web!

    -h, --help                       Print help
    -v, --verbose                    Enable verbose logging
    -f, --file A,B,C                 Read document(s) from path(s)
    -u, --url=URL                    Download HTML/XML from URL
    -d, --driver=DRIVER              Specify a WebDriver to use if you would like to use Selenium
                                     when using the `--url` option. Useful for websites that have
                                     automated `prove you are human` captchas. Or if you need to
                                     wait some something on the page to load.
                                     Valid drivers: chrome, edge, firefox, ie, safari
    -H, --headless                   Enable `--headless` for Selenium WebDriver
    -e, --eager                      Make the Selenium WebDriver use the `eager` page load strategy.
                                     This will mean Selenium returns when the DOM is ready, but some
                                     other resources may still be loading.
    -t, --timeout=SECONDS            Set the page load timeout when using `--url` (in seconds)
    -p, --proxy=ADDRESS              Set a proxy for Selenium WebDriver
    -c, --css=SELECTOR               Filter documents with a CSS selector
    -x, --xpath=PATH                 Filter documents with an XML XPath
```

## About

Charlotte is a web scraping tool, built to make the whole process a bit easier. At least for me. Charlotte uses Nokogiri to parse and search HTML + XML files with CSS selectors or XPaths. Documents can be passed through STDIN, the `-f/--file` option, or with the `-u/--url` option.

Another feature of Charlotte is scraping webpages that load or edit content with Javascript, or are behind some form of anti-bot protection, thanks to Selenium. Selenium is used to automate browsers, and is used here to basically just open the website and return the source after it loads or after a timeout.

## LICENSE
```
The MIT License (MIT)

Copyright (c) 2022 George Watson

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
