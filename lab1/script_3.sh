#!/bin/bash
echo "1) nano"
echo "2) vi"
echo "3) links"
echo "4) exit"
read COMM
case $COMM in
1 )
exec nano
;;
2 )
exec vi
;;
3 )
exec links
;;
4 )
echo "C U again"
exit
;;
esac

