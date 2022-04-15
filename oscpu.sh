#!/bin/sh

# Work directory, should be defined by generate.sh
SG_DIR=$1

# Filter stuff
IFS=$'\n'
for f in $(cat $SG_DIR/user-agents.txt | cut -d"(" -f2 | cut -d")" -f1)
do
    SG_CC=1
    SG_LINE=""
    echo oscpu: Line to filter: $f
    while true
    do
	case $(echo $f | cut -d";" -f $SG_CC) in
	    "")
		break
	    ;;
	    *rv:* | *Ubuntu* | *Fedora* | *Gentoo* | *-* | *U* | en_CA | *\ am | *\ ar | *\ eu | *\ bn | *\ en-GB | *\ pt-BR | *\ bg | *\ ca | *\ chr | *\ hr | *\ cs | *\ da | *\ nl | *\ en | *\ et | *\ fil | *\ fi | *\ fr | *\ de | *\ el | *\ gu | *\ iw | *\ hi | *\ hu | *\ is | *\ id | *\ it | *\ ja | *\ kn | *\ ko | *\ lv | *\ lt | *\ ms | *\ ml | *\ mr | *\ no | *\ pl | *\ pt-PT | *\ ro | *\ ru | *\ sr | *\ zh-CN | *\ sk | *\ sl | *\ es | *\ sw | *\ sv | *\ ta | *\ te | *\ th | *\ zh-TW | *\ tr | *\ ur | *\ uk | *\ vi | *\ cy | *\ nb | *\ zh | *\ pt)
		echo $(echo $f | cut -d";" -f $SG_CC) filtered !
	    ;;								      
	    *)
		SG_LINE=$SG_LINE"; "$(echo $f | cut -d";" -f $SG_CC)
		;;
        esac
        SG_CC=$((SG_CC+1))
    done
    echo $(echo $SG_LINE | cut -d";" -f2-999 | cut -d" " -f2-999) >> $SG_DIR/oscpu.txt
done


