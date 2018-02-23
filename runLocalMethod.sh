#!/bin/bash
#==============================================================================
#
# WARNING: YOU NEED APPROX. 100 GB OF FREE DISK
#
RELATIVE_PARAM=" -v -rm 17:500:0:5/50 -rm 14:200:0:3/10 -rm 11:100:0:0/0 -rm 8:10:0:0/0 -rm 5:1:0:0/0 -g 0.95 -c 30 ";
CONJOINT_PARAM=" -v -tm 17:200:0:5/10 -tm 14:100:0:3/1 -tm 11:10:0:0/0 -tm 8:1:0:0/0 -tm 5:1:0:0/0 -tm 3:1:0:0/0 -g 0.95 -c 30 ";
#==============================================================================
GET_GOOSE=0;
GET_GECO=0;
#==============================================================================
SIMULATE=1;
#==============================================================================
COMPRESS=1;
#==============================================================================
FILTER=1;
#==============================================================================
PLOT=1;
#==============================================================================
###############################################################################
#==============================================================================
# GET GOOSE
if [[ "$GET_GOOSE" -eq "1" ]]; then
  rm -fr goose/ goose-*
  git clone https://github.com/pratas/goose.git
  cd goose/src/
  make
  cd ../../
  cp goose/src/goose-* .
  cp goose/scripts/Get*.sh .
fi
#==============================================================================
# GET GECO
if [[ "$GET_GECO" -eq "1" ]]; then
  rm -fr geco/
  git clone https://github.com/pratas/geco.git
  cd geco/src/
  cmake .
  make
  cp GeCo ../../
  cd ../../
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$SIMULATE" -eq "1" ]]; then
  #
  # REFERENCE
  #
  ./goose-genrandomdna -s 1   -n 200000 > R_A;
  #
  ./goose-genrandomdna -s 101 -n 100000 > R_B;
  ./goose-mutatedna -mr 0.01 < R_B > R_E;
  #
  ./goose-genrandomdna -s 201 -n 300000 > R_C;
  #
  ./goose-fastqsimulation -v -ls 100 -n 3000 -eh -eo -es -edb -f 0.3,0.2,0.2,0.3,0.0 -rn 1000 -ri 50 -ra 3000 -rm 0.01 R_D;
  #
  ./goose-fastqsimulation -s 11001 -v -ls 100 -n 1000 -eh -eo -es -edb -f 0.3,0.2,0.2,0.3,0.0 -rn 1000 -ri 50 -ra 1000 -rm 0.01 R_F; 
  #
  # TARGET
  #
  ./goose-genrandomdna -s 177 -n 200000 > T_A;
  #
  ./goose-fastqsimulation -s 1621 -v -ls 100 -n 1000 -eh -eo -es -edb -f 0.3,0.2,0.2,0.3,0.0 -rn 3000 -ri 100 -ra 1000 -rm 0.01 T_B;
  #
  cp R_F T_C;
  #
  ./goose-mutatedna -mr 0.01 < R_C > T_D;   
  #
  cp R_D T_E; 
  #
  cp R_E T_F;
  #
  cp T_A T_G;
  #
  ./goose-genrandomdna -s 7771 -n 100000 > T_H;
  #
  cat R_A R_B R_C R_D R_E R_F > REFERENCE;
  cat T_A T_B T_C T_D T_E T_F T_G T_H > TARGET;
  cat REFERENCE TARGET > REFERENCE_TARGET;
  #
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$COMPRESS" -eq "1" ]]; then
  # RELATIVE
  (./GeCo $RELATIVE_PARAM -e -r REFERENCE TARGET) &> REPORT_REFERENCE_TARGET_RELATIVE
  # CONJOINT
  (./GeCo $CONJOINT_PARAM -e REFERENCE_TARGET ) &> REPORT_REFERENCE_TARGET_CONJOINT
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$FILTER" -eq "1" ]]; then
  ./goose-filter -w 10001 -d 200 -wt 2 -1 -p1 < TARGET.iae > TARGET.fil
  ./goose-filter -w 10001 -d 200 -wt 2 -1 -p1 < REFERENCE_TARGET.iae > REFERENCE_TARGET.fil
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$PLOT" -eq "1" ]]; then
  
gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color
  set output "RelativeProf.pdf"
  set auto
  set size ratio 0.05
  unset key
  set yrange [0:2] 
  set ytics 1
  unset grid 
  set ylabel "BPS"
  set xlabel "Length"
  unset border
  unset xtics
  unset ytics
  set style line 1 lt 1 lc rgb '#dd181f' lw 1
  plot "TARGET.fil" u 1:2 w l lt rgb "#292929" title "normal"
EOF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color
  set output "ConjointProf.pdf"
  set auto
  set size ratio 0.05
  unset key
  set yrange [0:2] 
  set ytics 1
  unset grid 
  set ylabel "BPS"
  set xlabel "Length"
  unset border
  unset xtics
  unset ytics
  set style line 1 lt 1 lc rgb '#dd181f' lw 1
  plot "REFERENCE_TARGET.fil" u 1:2 w l lt rgb "#292929" title "normal"
EOF

fi
