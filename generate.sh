#!/bin/sh

CURR_DIR=$(pwd)
if [ ! -f $CURR_DIR/sources.sh ]; then
    echo "Cannot find sources.sh ! Are you in the right directory ?"
    exit 1
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
text/html,application/xhtml+xml,application/xml;q=0.9,image/jxl,image/webp,*/*;q=0.8
text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8
text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, application/x-shockwave-flash, application/msword, */*
text/html, application/xhtml+xml, image/jxr, */*
text/html, application/xml;q=0.9, application/xhtml+xml, image/png, image/webp, image/jpeg, image/gif, image/x-xbitmap, */*;q=0.1" | sort | uniq > $CURR_DIR/temp/accept-headers.txt

# Move the final files out of the temp dir
mv $CURR_DIR/temp/user-agents.txt $CURR_DIR/user-agents.txt &&
mv $CURR_DIR/temp/oscpu.txt $CURR_DIR/oscpu.txt &&
mv $CURR_DIR/temp/accept-headers.txt $CURR_DIR/accept-headers.txt &&

# Remove temp dir as we don't need it anymore
rm -rf $CURR_DIR/temp

# Announce that we have finished
echo "
Job done.

Files:
$CURR_DIR/user-agents.txt
$CURR_DIR/oscpu.txt
$CURR_DIR/accept-headers.txt

You can use them now."

