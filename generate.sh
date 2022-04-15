#!/bin/sh

CURR_DIR=$(pwd)
if [ ! -f $CURR_DIR/sources.sh ]; then
    echo "Cannot find sources.sh ! Are you in the right directory ?"
    exit 1
fi

# Remove any user-agents.txt file left
if [ -f $CURR_DIR/user-agents.txt ]; then
    rm -fv $CURR_DIR/user-agents.txt
fi

# Clean any old temp dir and create a new one
if [ -d $CURR_DIR/temp ]; then
    rm -rfv $CURR_DIR/temp
fi
mkdir $CURR_DIR/temp

# Fetch sources
sh $CURR_DIR/sources.sh $CURR_DIR/temp

# Filter user agents
sh $CURR_DIR/filters.sh $CURR_DIR/temp

# Generate oscpu
sh $CURR_DIR/oscpu.sh $CURR_DIR/temp

# Accept headers, those are not generated

echo "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8
text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
text/html,application/xhtml+xml,application/xml;q=0.9,image/jxl,image/webp,*/*;q=0.8" > $CURR_DIR/temp/accept-headers.txt

# Move the final files out of the temp dir
mv $CURR_DIR/temp/user-agents.txt $CURR_DIR/user-agents.txt
mv $CURR_DIR/temp/oscpu.txt $CURR_DIR/oscpu.txt
mv $CURR_DIR/temp/accept-headers.txt $CURR_DIR/accept-headers.txt

# Remove temp dir as we don't need it anymore
rm -rfv $CURR_DIR/temp
