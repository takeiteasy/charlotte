# charlotte

Charlotte is a little spider that crawls the web. Built with nokogiri + selenium.

```
 Usage: `echo [TEXT] | charlotte.rb` or `charlotte.rb -f [FILE]` or `charlotte.rb -u [URL]`

 Description: A little spider to crawl the web!

 Example:
	ruby charlotte.rb --url http://www.example.com --selector 'p a' --attrs 'href'
	  => https://www.iana.org/domains/example

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
    -l, --load-strategy              Specify the page load strategy for Selenium WebDriver.
                                     Valid strats: `normal`, wait until page fully loads before
                                     returning. `eager` will wait until the DOM is loaded then
                                     return, other resources may still be loading. `none` doesn't
                                     block the WebDriver at all, `--timeout` option is required.
    -t, --timeout=SECONDS            Set the page load timeout when using `--url` (in seconds)
    -p, --proxy=ADDRESS              Set a proxy for Selenium WebDriver
    -s, --selector=SELECTOR          Filter document(s) with a CSS selector
    -x, --xpath=PATH                 Filter document(s) with an XML XPath
    -a, --attrs A,B,C                Specify any tag attributes to print
    -b, --body                       When printing a matched result, only print the tag`s body
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
