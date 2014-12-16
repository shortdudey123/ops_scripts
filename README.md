[![Build Status](https://travis-ci.org/shortdudey123/ops_scripts.svg?branch=master)](https://travis-ci.org/shortdudey123/ops_scripts)

# Ops Scripts

This repo serves as a collection of scripts that can be useful for DevOps / Ops Engineers.

## Scripts

### dns_watch.rb

Used to do continual DNS queries against a hostname.  It is useful for doing DNS changes and watching them propigate out correctly.

```sh
host:~/ops_scripts user (master*)$ ./scripts/dns_watch.rb --help
Usage: ./scripts/dns_watch.rb [options]
    -h, --hostname HOSTNAME          Specify the hostname to check (default: www.google.com)
    -d, --delay DELAY                Delay in seconds between checks (default: 1)
    -n, --nameserver NAMESERVER      NS to query (default: the default system resolver)
    -A, --a                          Watch A records (default: true)
    -a, --aaaa                       Watch AAAA records (default: false)
    -C, --cname                      Watch CNAME records (default: false)
    -M, --mx                         Watch MX records (default: false)
    -N, --ns                         Watch NS records (default: false)
    -S, --soa                        Watch SOA records (default: false)
    -T, --txt                        Watch TXT records (default: false)
host:~/ops_scripts user (master*)$
```
```sh
host:~/ops_scripts user (master*)$ ./scripts/dns_watch.rb
Checking DNS for www.google.com with a 1s delay against the default system resolver
2014-12-16 00:24:56 UTC  ~~  74.125.239.113  74.125.239.114  74.125.239.115  74.125.239.116  74.125.239.112
2014-12-16 00:24:57 UTC  ~~  74.125.20.105  74.125.20.104  74.125.20.147  74.125.20.106  74.125.20.103  74.125.20.99
2014-12-16 00:24:58 UTC  ~~  74.125.239.113  74.125.239.114  74.125.239.115  74.125.239.116  74.125.239.112
2014-12-16 00:24:59 UTC  ~~  74.125.20.147  74.125.20.106  74.125.20.104  74.125.20.105  74.125.20.99  74.125.20.103
^C
Exiting...
host:~/ops_scripts user (master*)$
```

## Testing

  bundle install --path .bundle
  bundle exec rake

## License
[Apache 2](http://www.apache.org/licenses/LICENSE-2.0)

## Contributing

1. Fork it ( https://github.com/shortdudey123/ops_scripts/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
