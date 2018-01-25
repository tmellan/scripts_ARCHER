#!/bin/bash
#usage repeat-search-getter.sh arg1 arg2
#arg1 = thing searching for in files
#arg2 is directory to repeatedly search in
grep -w $1 -r $2 | cut -d : -f 2 | cut -d , -f 1,3  > $1.dat
