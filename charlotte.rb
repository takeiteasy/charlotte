#!/usr/bin/env ruby
=begin
https://github.com/takeiteasy/charlotte

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
=end

require 'optparse'
require 'nokogiri'
require "selenium-webdriver"
require 'fcntl'
require 'open-uri'

opts = {
    :verbose => false,
    :files => [],
    :url => nil,
    :selector => nil,
    :xpath => nil
}
OptionParser.new do |o|
    o.banner = " Usage: #{$0} ..."
    o.on '-h', '--help', 'Print help' do
        puts o
        exit
    end
    o.on '-v', '--verbose', 'Enable verbose logging' do
        opts[:verbose] = true
    end
    o.on '-f', '--files A,B,C', Array, 'Pass list of HTML/XML files' do |a|
        opts[:files] += a
    end
    o.on '-u', '--url=URL', String, 'Get HTML/XML from URL' do |a|
        opts[:url] = a
    end
    o.on '-c', '--css=SELECTOR', String, 'Filter HTML by CSS selector' do |a|
        opts[:selector] = a
    end
    o.on '-x', '--xpath=PATH', String, 'Filter XML by XPath' do |a|
        opts[:xpath] = a
    end
end.parse!

def stdin_timeout(timeout = 0.1)
    # Set STDIN to non-blocking mode
    flags = STDIN.fcntl Fcntl::F_GETFL, 0
    flags |= Fcntl::O_NONBLOCK
    STDIN.fcntl Fcntl::F_SETFL, flags
    
    # Set a timeout for the read operation
    io = IO::select [STDIN], [], [], timeout
    
    begin
        if not io.nil? and io[0].any?
            # Data is available, proceed with reading
            text = STDIN.read
            return text.chomp if text
        else
            # Timeout reached, no data available
            return nil
        end
    rescue Errno::EAGAIN
        # Expected exception for non-blocking reads, no data available
        return nil
    ensure
        # Restore original flags (optional)
        STDIN.fcntl Fcntl::F_SETFL, flags
    end
end

def die(msg="unknown error!")
    STDERR.puts "ERROR! #{msg}"
    exit 1
end

def parse_document(doc)
    
end

if not opts[:url].nil?
    begin
        doc = Nokogiri::HTML(URI.open(opts[:url]))
        parse_document doc
    rescue OpenURI::HTTPError, SocketError, Errno::ECONNREFUSED => e
        die "An unexpected error occurred: #{e.message}"
    rescue Nokogiri::XML::SyntaxError => e
        die "Error parsing the HTML: #{e.message}"
    end
end

opts[:files].each do |file|
    # ...
end

text = stdin_timeout
if not text.nil?
    # ...
end

die "test"
