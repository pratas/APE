#!/bin/bash
NCD=0;
Cx=`cat  $1 | grep "Total bytes" | awk '{print $3;}'`;
Cy=`cat  $2 | grep "Total bytes" | awk '{print $3;}'`;
Cxy=`cat $3 | grep "Total bytes" | awk '{print $3;}'`;
if (( $Cx < $Cy ));
then
  NCD=`echo "scale=8; ($Cxy - $Cx) / $Cy" | bc -l`;
else
  NCD=`echo "scale=8; ($Cxy - $Cy) / $Cx" | bc -l`;
fi
printf "$NCD\n";
