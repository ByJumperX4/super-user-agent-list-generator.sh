#!/bin/sh

# Work directory, should be defined by generate.sh
SG_DIR=$1

# Things that will be REQUIRED in user agents, space separated
SG_GREP="Mozilla/5.0 Gecko"

# Things that will be DENIED in user agents, space separated
SG_V_GREP="iPhone Android iPad ipad http Firefox/0 Firefox/1. Firefox/2. Firefox/3. Firefox/4. Firefox/5. Firefox/6. Firefox/8. Firefox/9. firefox compatible Compatible Gecko/200 Presto Opera/8. Opera/9. Chrome/0 Chrome/1. Chrome/2 Chrome/3 Chrome/4 Chrome/5 Chrome/6 Chrome/7 Chrome/8 Chrome/9. Chrome/10. Chrome/11. Chrome/12. Chrome/13. Chrome/14. Chrome/15. Chrome/16. Chrome/17. Chrome/18. Chrome/19. Dooble FirePHP Trident"

SG_NUMBER=0
mv $SG_DIR/unprocessed_useragents.txt $SG_DIR/unprocessed_useragents_$SG_NUMBER.txt
for f in $SG_GREP
do
    grep $f $SG_DIR/unprocessed_useragents_$SG_NUMBER.txt > $SG_DIR/unprocessed_useragents_$((SG_NUMBER+1)).txt
    SG_NUMBER=$((SG_NUMBER+1))
done


for x in $SG_V_GREP
do
    grep -v $x $SG_DIR/unprocessed_useragents_$SG_NUMBER.txt > $SG_DIR/unprocessed_useragents_$((SG_NUMBER+1)).txt
    SG_NUMBER=$((SG_NUMBER+1))
done

cp $SG_DIR/unprocessed_useragents_$SG_NUMBER.txt $SG_DIR/user-agents.txt
