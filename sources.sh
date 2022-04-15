#!/bin/sh
# This is the file containing user agents sources.
# You can add more if you want, feel free to make a pull request or open an issue if you think your changes could be added.

# To add more sources:
# - copy the extra-sources-template.sh file to extra-sources.sh
# - modify it to ajust it to your needs

# Info: duplicates are NOT removed in the process.


# Work directory, should be defined by generate.sh
SG_DIR=$1

# Plaintext sources, space separated. Should be an URL
PLAIN_SOURCES="https://raw.githubusercontent.com/DavidWittman/requests-random-user-agent/master/requests_random_user_agent/useragents.txt https://raw.githubusercontent.com/sqlmapproject/sqlmap/master/data/txt/user-agents.txt"
EXTRA_PLAIN_SOURCES=""
if [ -f $SG_DIR/extra-sources.sh ]; then
    source $SG_DIR/extra-sources.sh
fi

for f in $PLAIN_SOURCES $EXTRA_PLAIN_SOURCES ; do curl $f >> $SG_DIR/unprocessed_useragents.txt ; done

#
# Non-plaintext sources (some random way to transform them into plaintext then output to $SG_DIR/unprocessed_useragents.txt)
#

# Source 1
curl https://gist.githubusercontent.com/amidart/6090f8a8038b7c3e560cb3f6eb79c805/raw/10b6bd497dfba71d1c4da3d6381250f0738a6572/most-common-user-agents.html | grep Mozilla/5.0 | grep -v "<" >> $SG_DIR/unprocessed_useragents.txt

# Extra sources
if [ -f $SG_DIR/extra-sources.sh ]; then
    sh $SG_DIR/extra-sources.sh
fi
