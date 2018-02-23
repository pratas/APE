#!/bin/bash
#==============================================================================
#
# WARNING: YOU NEED APPROX. 100 GB OF FREE DISK
#
NRC_PARAM=" -v -rm 17:500:0:5/50 -rm 14:200:0:3/10 -rm 11:100:0:0/0 -rm 8:10:0:0/0 -rm 5:1:0:0/0 -g 0.95 -c 30 ";
NCD_X=" -v -tm 17:200:0:5/10 -tm 14:100:0:3/1 -tm 11:10:0:0/0 -tm 8:1:0:0/0 -tm 5:1:0:0/0 -tm 3:1:0:0/0 -g 0.95 -c 30 ";
NCD_XY=" -v -tm 17:200:0:5/10 -tm 14:100:0:3/1 -tm 11:10:0:0/0 -tm 8:1:0:0/0 -tm 5:1:0:0/0 -tm 3:1:0:0/0 -g 0.95 -c 30 ";
#==============================================================================
GET_GOOSE=0;
GET_GECO=0;
#==============================================================================
SIMULATE=1;
#==============================================================================
RUN=1;
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
  #
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$RUN" -eq "1" ]]; then
  # NRC
  (./GeCo $NRC_PARAM -e -r REFERENCE TARGET) &> REPORT_REFERENCE_TARGET_RELATIVE
  # NCD
  #9-1 -------------------------------------------
  #0
  (./GeCo $NCD_X SAMPLE_900000_0) &> REPORT_NCD_900k_0
  (./GeCo $NCD_X SAMPLE_100000_0) &> REPORT_NCD_100k_0
  cat SAMPLE_900000_0 SAMPLE_100000_0 > CAT_XY;
  (./GeCo $NCD_XY CAT_XY) &> REPORT_NCD_900k_0_100k_0
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$PLOT" -eq "1" ]]; then
  chmod +x NCDcalc.sh
  #
  printf "0\t%s\n" `./NCDcalc.sh REPORT_NCD_900k_0 REPORT_NCD_100k_0 REPORT_NCD_900k_0_100k_0 | awk '{printf "%f", $0}'` >  NCD_9-1-VALUES;
  # NRC
  cat REPORT_100k_0_900k_0 | grep "Total bytes" | awk '{ print $16;}' | awk '{printf "%d\t%s\n", 0, $0}' > NRC_1-9_VALUES;
  #
  # PLOTS

#NCD

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color font 'Verdana,12'
  set output "NCDl.pdf"
  set style line 101 lc rgb '#000000' lt 1 lw 4
  set border 3 front ls 101
  set tics nomirror out scale 0.75
  set format '%g'
  set size ratio 0.8
  set key outside horiz center top
  set yrange [0:1.2] 
  set xrange [0:40] 
  set ytics 0.2
  set grid 
  set ylabel "NCD"
  set xlabel "Substitutions in y (%)"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#009900' lt 1 lw 4 pt 6 ps 0.4 # --- green
  set style line 3 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  set style line 4 lc rgb '#63006d' lt 1 lw 4 pt 8 ps 0.5 # --- ?
  set style line 5 lc rgb '#b1006d' lt 1 lw 4 pt 1 ps 0.5 # --- ?
  set style line 6 lc rgb '#964d1c' lt 1 lw 4 pt 10 ps 0.5 # --- ?
  set style line 7 lc rgb '#449a93' lt 1 lw 4 pt 11 ps 0.5 # --- ?
  plot "NCD_1-9-VALUES"  with linespoints ls 1 title "NCD 1-9", "NCD_2-8-VALUES"  with linespoints ls 2 title "NCD 2-8", "NCD_3-7-VALUES"  with linespoints ls 3 title "NCD 3-7", "NCD_4-6-VALUES"  with linespoints ls 4 title "NCD 4-6", "NCD_5-5-VALUES"  with linespoints ls 5 title "NCD 5-5"
EOF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color font 'Verdana,12'
  set output "NCDr.pdf"
  set style line 101 lc rgb '#000000' lt 1 lw 4
  set border 3 front ls 101
  set tics nomirror out scale 0.75
  set format '%g'
  set size ratio 0.8
  set key outside horiz center top
  set yrange [0:1.2] 
  set xrange [0:40] 
  set ytics 0.2
  set grid 
  set ylabel "NCD"
  set xlabel "Substitutions in y (%)"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#009900' lt 1 lw 4 pt 6 ps 0.4 # --- green
  set style line 3 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  set style line 4 lc rgb '#63006d' lt 1 lw 4 pt 8 ps 0.5 # --- ?
  set style line 5 lc rgb '#b1006d' lt 1 lw 4 pt 1 ps 0.5 # --- ?
  set style line 6 lc rgb '#964d1c' lt 1 lw 4 pt 10 ps 0.5 # --- ?
  set style line 7 lc rgb '#449a93' lt 1 lw 4 pt 11 ps 0.5 # --- ?
  plot "NCD_5-5-VALUES"  with linespoints ls 5 title "NCD 5-5", "NCD_6-4-VALUES"  with linespoints ls 4 title "NCD 6-4", "NCD_7-3-VALUES"  with linespoints ls 3 title "NCD 7-3", "NCD_8-2-VALUES"  with linespoints ls 2 title "NCD 8-2", "NCD_9-1-VALUES"  with linespoints ls 1 title "NCD 9-1"
EOF

#NRC

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color font 'Verdana,12'
  set output "NRCl.pdf"
  set style line 101 lc rgb '#000000' lt 1 lw 4
  set border 3 front ls 101
  set tics nomirror out scale 0.75
  set format '%g'
  set size ratio 0.8
  set key outside horiz center top
  set yrange [0:1.2] 
  set xrange [0:40] 
  set ytics 0.2
  set grid 
  set ylabel "NRC"
  set xlabel "Substitutions in y (%)"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#009900' lt 1 lw 4 pt 6 ps 0.4 # --- green
  set style line 3 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  set style line 4 lc rgb '#63006d' lt 1 lw 4 pt 8 ps 0.5 # --- ?
  set style line 5 lc rgb '#b1006d' lt 1 lw 4 pt 1 ps 0.5 # --- ?
  set style line 6 lc rgb '#964d1c' lt 1 lw 4 pt 10 ps 0.5 # --- ?
  set style line 7 lc rgb '#449a93' lt 1 lw 4 pt 11 ps 0.5 # --- ?
  plot "NRC_1-9_VALUES"  with linespoints ls 1 title "NRC 1-9", "NRC_2-8_VALUES"  with linespoints ls 2 title "NRC 2-8", "NRC_3-7_VALUES"  with linespoints ls 3 title "NRC 3-7", "NRC_4-6_VALUES"  with linespoints ls 4 title "NRC 4-6", "NRC_5-5_VALUES"  with linespoints ls 5 title "NRC 5-5"
EOF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color font 'Verdana,12'
  set output "NRCr.pdf"
  set style line 101 lc rgb '#000000' lt 1 lw 4
  set border 3 front ls 101
  set tics nomirror out scale 0.75
  set format '%g'
  set size ratio 0.8
  set key outside horiz center top
  set yrange [0:1.2] 
  set xrange [0:40] 
  set ytics 0.2
  set grid 
  set ylabel "NRC"
  set xlabel "Substitutions in y (%)"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#009900' lt 1 lw 4 pt 6 ps 0.4 # --- green
  set style line 3 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  set style line 4 lc rgb '#63006d' lt 1 lw 4 pt 8 ps 0.5 # --- ?
  set style line 5 lc rgb '#b1006d' lt 1 lw 4 pt 1 ps 0.5 # --- ?
  set style line 6 lc rgb '#964d1c' lt 1 lw 4 pt 10 ps 0.5 # --- ?
  set style line 7 lc rgb '#449a93' lt 1 lw 4 pt 11 ps 0.5 # --- ?
  plot "NRC_5-5_VALUES"  with linespoints ls 5 title "NRC 5-5", "NRC_6-4_VALUES"  with linespoints ls 4 title "NRC 6-4", "NRC_7-3_VALUES"  with linespoints ls 3 title "NRC 7-3", "NRC_8-2_VALUES"  with linespoints ls 2 title "NRC 8-2", "NRC_9-1_VALUES"  with linespoints ls 1 title "NRC 9-1"
EOF


fi
