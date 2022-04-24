#!/bin/sh

# Work directory, should be defined by generate.sh
SG_DIR=$1

# Filter stuff
while read f
do
    SG_CC=1
    SG_LINE=""
    SG_PFORM=$(echo $f | cut -d"(" -f2 | cut -d")" -f1)
    echo oscpu: Line to filter: $SG_PFORM
    while true
    do
       if [ ! "$(echo $SG_PFORM | grep -v ';')" = "" ] ; then
	echo "Can't be filtered"
        break
       else
	case $(echo $SG_PFORM | cut -d";" -f $SG_CC) in
	    "")
		break
	    ;;
	    *rv:* | *Ubuntu* | *Mageia* | *Fedora* | *Gentoo* | *-* | *U* | *\ en_CA | *\ am | *\ ar | *\ eu | *\ bn | *\ en-GB | *\ pt-BR | *\ bg | *\ ca | *\ chr | *\ hr | *\ cs | *\ da | *\ nl | *\ en | *\ et | *\ fil | *\ fi | *\ fr | *\ de | *\ el | *\ gu | *\ iw | *\ hi | *\ hu | *\ is | *\ id | *\ it | *\ ja | *\ kn | *\ ko | *\ lv | *\ lt | *\ ms | *\ ml | *\ mr | *\ no | *\ pl | *\ pt-PT | *\ ro | *\ ru | *\ sr | *\ zh-CN | *\ sk | *\ sl | *\ es | *\ sw | *\ sv | *\ ta | *\ te | *\ th | *\ zh-TW | *\ tr | *\ ur | *\ uk | *\ vi | *\ cy | *\ nb | *\ zh | *\ pt)
		echo $(echo $SG_PFORM | cut -d";" -f $SG_CC) filtered !
	    ;;								      
	    *)
		SG_LINE=$SG_LINE"; "$(echo $SG_PFORM | cut -d";" -f $SG_CC)
	    ;;
        esac
	echo dbg: oscpu=$(echo $SG_LINE | cut -d";" -f2-999 | cut -d" " -f2-999)
       fi
        SG_CC=$((SG_CC+1))
    done
    echo $(echo $SG_LINE | cut -d";" -f2-999 | cut -d" " -f2-999) >> $SG_DIR/oscpu-tmp.txt
    echo "------------------------------------------"
done < $SG_DIR/user-agents.txt
sort $SG_DIR/oscpu-tmp.txt | uniq > $SG_DIR/oscpu.txt


