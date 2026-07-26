# charlotte

A command-line web scraper that uses [Nokogiri](https://nokogiri.org/) for HTML parsing and [Selenium WebDriver](https://www.selenium.dev/) to bypass bot detection (e.g. Cloudflare challenges).

HTML can be sourced from a URL, a local file, or piped via stdin. Results can be filtered with CSS selectors or XPath expressions, and specific tag attributes can be extracted.

## Requirements

A browser driver (e.g. [chromedriver](https://chromedriver.chromium.org/)) is required if using `--driver`.

## Install

```sh
git clone https://github.com/takeiteasy/charlotte.git
cd charlotte

# Install Ruby dependencies
make deps

# Install to /usr/local/bin (or set PREFIX to customize)
make install

# Or install to a custom prefix
make install PREFIX=~/.local
```

To uninstall:

```sh
make uninstall
```

## Usage

```
echo [TEXT] | charlotte.rb
charlotte.rb -f [FILE]
charlotte.rb -u [URL]
```

## Examples

Extract all links from a page:

```sh
ruby charlotte.rb --url http://www.example.com --selector 'p a' --attrs 'href'
# => https://www.iana.org/domains/example
```

Use Selenium with Chrome to bypass bot detection, then scrape:

```sh
ruby charlotte.rb --url https://example.com --driver chrome --headless --selector 'h1'
```

Parse a local HTML file:

```sh
ruby charlotte.rb --file page.html --selector 'table td' --body
```

Pipe HTML directly:

```sh
curl -s https://example.com | ruby charlotte.rb --selector 'a' --attrs 'href'
```

## Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Print help |
| `-v`, `--verbose` | Enable verbose logging |
| `-f`, `--file A,B,C` | Read HTML from one or more file paths |
| `-u`, `--url URL` | Fetch HTML from a URL |
| `-d`, `--driver DRIVER` | Use a Selenium WebDriver (`chrome`, `edge`, `firefox`, `ie`, `safari`). Useful for pages with bot detection or dynamic content |
| `-H`, `--headless` | Run the Selenium browser in headless mode |
| `-l`, `--load-strategy STRATEGY` | Selenium page load strategy: `normal` (wait for full load), `eager` (wait for DOM), `none` (no wait — requires `--timeout`) |
| `-t`, `--timeout SECONDS` | Page load timeout in seconds |
| `-p`, `--proxy ADDRESS` | HTTP proxy for Selenium WebDriver |
| `-s`, `--selector SELECTOR` | Filter output with a CSS selector |
| `-x`, `--xpath PATH` | Filter output with an XPath expression |
| `-a`, `--attrs A,B,C` | Print specific tag attributes instead of the full element |
| `-b`, `--body` | Print only the inner body of matched elements |

## Selenium and bot detection

When a site uses Cloudflare or similar bot checks, use `--driver` to open the page in a real browser. Omitting `--headless` lets the browser window appear so you can solve any CAPTCHA manually — once complete, charlotte will capture the resulting page source and continue scraping.

```sh
ruby charlotte.rb --url https://protected-site.com --driver chrome --selector '.content'
```

## License

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
