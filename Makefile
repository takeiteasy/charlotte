RUBY ?= ruby
PREFIX ?= /usr/local
BINDIR := $(PREFIX)/bin

.PHONY: all deps install uninstall clean

all: deps

deps:
	gem install nokogiri selenium-webdriver

install: charlotte.rb
	install -d $(BINDIR)
	install -m 755 charlotte.rb $(BINDIR)/charlotte

uninstall:
	rm -f $(BINDIR)/charlotte

clean:
	rm -rf *.gem .bundle
