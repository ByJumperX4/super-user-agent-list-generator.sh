# super-user-agent-list-generator.sh
A way to generate big lists of common desktop user agents. The main goal being user agent spoofing

Simply run `generate.sh` to generate the `user-agents.txt` and `oscpu.txt` files.

See `extra-sources-templates.sh` to add more sources

I also added the most popular accept headers in the `accept-headers.txt` file, but those are not generated automatically, even if `generate.sh` takes care of them. 

# What's this actually for ? 

It's for use with [this addon](https://www.dephormation.org.uk/?page=81)

You also should read [this](https://blackgnu.net/palemoon-hardening.html)
