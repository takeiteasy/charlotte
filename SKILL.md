# Charlotte — Agent Skills Reference

`charlotte` is a command-line web scraper that downloads HTML (from a URL, file, or stdin), parses it with [Nokogiri](https://nokogiri.org/), and extracts data via CSS selectors or XPath expressions. When a site uses bot protection (Cloudflare, etc.), it can delegate the fetch to [Selenium WebDriver](https://www.selenium.dev/) so a real browser handles the challenge and the agent can inspect the resulting page.

---

## Input sources

HTML can come from three places, checked in this order:

### 1. URL fetch (`--url`, `-u`)
Downloads the page with `URI.open`. If `--driver` is passed, uses Selenium instead — useful when the target blocks plain HTTP clients.

### 2. File read (`--file`, `-f`)
Reads one or more local HTML/XML files. Accepts comma-separated paths.

### 3. Stdin pipe
Reads from standard input (non-blocking with a short timeout). Falls through silently if nothing is piped — making it safe to always add to a pipeline.

If all three sources are empty, charlotte prints a help message and exits 0.

---

## Selector & attribute parsing

After gathering documents, each is parsed with `Nokogiri::HTML.parse` and filtered according to the selector flags:

### CSS selector (`--selector`, `-s`)
```sh
charlotte -u https://example.com -s 'div.content p a'
```
Runs `doc.css(selector)` — any valid CSS selector works.

### XPath (`--xpath`, `-x`)
```sh
charlotte -u https://example.com -x '//div[@class="content"]//a'
```
Runs `doc.xpath(path)` — use when CSS selectors are insufficient.

### Attribute extraction (`--attrs`, `-a`)
```sh
charlotte -u https://example.com -s 'a' -a 'href'
charlotte -u https://example.com -s 'a' -a 'href,class'
```
When `--attrs` is given, only the named tag attribute values are printed (one per line), instead of serialised HTML. Multiple attributes are comma-separated.

### Body-only (`--body`, `-b`)
```sh
charlotte -u https://example.com -s 'div' -b
```
Prints only the inner HTML of each matched element (no wrapper tags). Combined with `--attrs`, prints attributes of the element's children instead.

If neither `--selector` nor `--xpath` is given, the entire document is output (or `doc.at('body').inner_html` if `--body` is set).

---

## Selenium WebDriver (`--driver`, `-d`)

By default `charlotte` fetches URLs with Ruby's `open-uri`, which is a plain HTTP client. Many modern sites (Cloudflare, Akamai, DataDome) will block or challenge it.

When `--driver` is passed, charlotte opens the URL in a real browser via Selenium:

```sh
charlotte -u https://protected-site.com --driver chrome --headless --selector 'h1'
charlotte -u https://protected-site.com --driver firefox -s '.content' -a 'href'
charlotte -u https://protected-site.com --driver safari
```

Valid drivers: `chrome`, `edge`, `firefox`, `ie`, `safari`.

### Headless mode (`--headless`, `-H`)
Runs the browser without a visible window. Add this when you don't need to solve a CAPTCHA manually — the browser transparently handles JS challenges on its own in many cases.

### Interactive CAPTCHA solving
Omit `--headless` to let the browser window appear. An operator can solve a Cloudflare challenge or CAPTCHA manually; once complete, charlotte captures the resulting page source.

### Page load strategy (`--load-strategy`, `-l`)
Controls when Selenium considers the page loaded:

| Strategy | Behaviour |
|---|---|
| `normal` (default) | Wait for full page load (all resources) |
| `eager` | Wait only for DOMContentLoaded |
| `none` | Return immediately — requires `--timeout` to set an explicit wait |

### Timeout (`--timeout`, `-t`)
Sets a page load timeout in seconds. Required when `--load-strategy none` is used.

### Proxy (`--proxy`, `-p`)
```sh
charlotte -u ... --driver chrome --proxy http://127.0.0.1:8080
```
Sets an HTTP proxy on the Selenium driver.

---

## Key flags

| Flag | Description |
|---|---|
| `-u, --url URL` | Fetch HTML from a URL |
| `-f, --file A,B,C` | Read HTML from file path(s) |
| `-s, --selector SELECTOR` | Filter with CSS selector |
| `-x, --xpath PATH` | Filter with XPath expression |
| `-a, --attrs A,B,C` | Print specific tag attributes |
| `-b, --body` | Print inner body only (no wrapper tags) |
| `-d, --driver DRIVER` | Selenium driver (chrome/edge/firefox/ie/safari) |
| `-H, --headless` | Run Selenium browser headless |
| `-l, --load-strategy STRAT` | Page load strategy (normal/eager/none) |
| `-t, --timeout SECONDS` | Page load timeout |
| `-p, --proxy ADDRESS` | HTTP proxy for Selenium |
| `-v, --verbose` | Log diagnostics to stderr |
| `-h, --help` | Print help and exit |

---

## Examples

```sh
# Extract all links from a page
charlotte -u http://example.com -s 'p a' -a 'href'

# Scrape a Cloudflare-protected site with headless Chrome
charlotte -u https://protected-site.com --driver chrome --headless -s '.content'

# Let operator solve a CAPTCHA (browser window appears)
charlotte -u https://protected-site.com --driver chrome -s 'table td' -a 'href'

# Parse a local file with XPath
charlotte -f page.html -x '//div[@class="result"]//a/@href'

# Pipe HTML in, extract all image sources
curl -s https://example.com | charlotte -s 'img' -a 'src'

# Selenium with eager load and 10 s timeout
charlotte -u https://dynamic-site.com --driver chrome --headless --load-strategy eager --timeout 10 -s 'h2'
```

---

## Backend

- **Parsing:** Nokogiri (libxml2-based, fast, standards-compliant).
- **Browser automation:** Selenium WebDriver with per-browser option classes.
- **HTTP fetch:** `open-uri` / `net/http` for plain fetches.
- **Stdin:** Non-blocking read with `IO::select` and a 100 ms timeout.
