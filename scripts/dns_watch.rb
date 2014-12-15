#!/usr/bin/env ruby
# The script does a DNS lookup of the requested domain.  Different
# record types, nameservers, and delays can be specified.
#
# Author::    Grant Ridder  (shortdudey123@gmail.com)
# Copyright:: Copyright (c) 2014 Grant Ridder
# License::   See accompanying LICENSE file

require 'resolv'
require 'optparse'

# initialize the argument parser defaults
options = {}
options[:hostname] = 'www.google.com'
options[:delay] = 1
options[:types] = []

# initialize the argument parser itself
OptionParser.new do |opts|
  opts.banner = "Usage: #{__FILE__} [options]"

  # set the domain that needs to be checked
  opts.on('-h', '--hostname HOSTNAME', 'Specify the hostname to check '\
          "(default: #{options[:hostname]})") do |arg|
    options[:hostname] = arg
  end

  opts.on('-d', '--delay DELAY', 'Delay in seconds between checks '\
          "(default: #{options[:delay]})") do |arg|
    options[:delay] = arg.to_i
  end

  opts.on('-n', '--nameserver NAMESERVER', 'NS to query '\
          '(default: the default system resolver)') do |arg|
    options[:nameserver] = arg
  end

  opts.on('-A', '--a', 'Watch A records (default: true)') do
    options[:types] << :A
  end

  opts.on('-a', '--aaaa', 'Watch AAAA records (default: false)') do
    options[:types] << :AAAA
  end

  opts.on('-C', '--cname', 'Watch CNAME records (default: false)') do
    options[:types] << :CNAME
  end

  opts.on('-M', '--mx', 'Watch MX records (default: false)') do
    options[:types] << :MX
  end

  opts.on('-N', '--ns', 'Watch NS records (default: false)') do
    options[:types] << :NS
  end

  opts.on('-S', '--soa', 'Watch SOA records (default: false)') do
    options[:types] << :SOA
  end

  opts.on('-T', '--txt', 'Watch TXT records (default: false)') do
    options[:types] << :TXT
  end
end.parse!

options[:types] = [:A] if options[:types] == []

# initialize the DNS query object
if options[:nameserver]
  dns = Resolv::DNS.open(nameserver: options[:nameserver])
else
  dns = Resolv::DNS.open
end

puts "Checking DNS for #{options[:hostname]} with a #{options[:delay]}s delay "\
     "against #{options.fetch(:nameserver, 'the default system resolver')}"
begin

  # run the loop
  loop do
    print Time.now.utc.to_s
    print '  ~~'

    if options[:types].include?(:A)
      records = dns.getresources(options[:hostname],
                                 Resolv::DNS::Resource::IN::A)
      records.each do |record|
        print '  ', record.address
      end
    end

    if options[:types].include?(:AAAA)
      records = dns.getresources(options[:hostname],
                                 Resolv::DNS::Resource::IN::AAAA)
      records.each do |record|
        print '  ', record.address
      end
    end

    if options[:types].include?(:CNAME)
      records = dns.getresources(options[:hostname],
                                 Resolv::DNS::Resource::IN::CNAME)
      records.each do |record|
        print '  ', record.name
      end
    end

    if options[:types].include?(:MX)
      records = dns.getresources(options[:hostname],
                                 Resolv::DNS::Resource::IN::MX)
      records.each do |record|
        print '  ', record.preference, ' ', record.exchange
      end
    end

    if options[:types].include?(:SOA)
      records = dns.getresources(options[:hostname],
                                 Resolv::DNS::Resource::IN::SOA)
      records.each do |record|
        print '  ', record.mname,
              ' ', record.rname,
              ' ', record.serial,
              ' ', record.refresh,
              ' ', record.retry,
              ' ', record.expire,
              ' ', record.minimum
      end
    end

    if options[:types].include?(:NS)
      records = dns.getresources(options[:hostname],
                                 Resolv::DNS::Resource::IN::NS)
      records.each do |record|
        print '  ', record.name
      end
    end

    if options[:types].include?(:TXT)
      records = dns.getresources(options[:hostname],
                                 Resolv::DNS::Resource::IN::TXT)
      records.each do |record|
        print '  ', record.strings
      end
    end

    puts
    sleep(options[:delay])
  end
# catch interrupt so we don't print an ugly stack trace
rescue Interrupt
  puts "\nExiting..."
  dns.close
end
