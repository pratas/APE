#!/bin/bash
#==============================================================================
#
NRC_PARAM_MT=" -v -rm 13:200:1:5/10 -rm 10:100:1:0/0 -rm 6:1:0:0/0 -rm 3:1:0:0/0 -c 10 -g 0.95 "; 
NRC_PARAM_WGS=" -v -rm 20:200:1:5/10 -rm 14:100:1:0/0 -rm 13:20:0:0/0 -rm 11:10:0:0/0 -rm 9:1:0:0/0 -c 250 -g 0.88 ";
# RUNNING FLAGS
GET_GOOSE=1;
GET_GECO=1;
#==============================================================================
GET_HUMAN=1;
GET_MITO=1;
#==============================================================================
MUTATE=1;
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
if [[ "$GET_HUMAN" -eq "1" ]]; then
  . GetHumanParse.sh
  rm -f HS HS.co
  cat HS* > DFGSERGF
  mv DFGSERGF HS_WGS_0
fi
#==============================================================================
if [[ "$GET_MTDNA" -eq "1" ]]; then
  . GetMTDNA.sh
  #
  cat MITO.fna | tr ' ' '_' \
  | ./goose-extractreadbypattern sapiens_mitoch | ./goose-fasta2seq > HS_MT_0
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$MUTATE" -eq "1" ]]; then
  #MT
  ./goose-mutatedna -mr 0.01 < HS_MT_0  > HS_MT_1
  ./goose-mutatedna -mr 0.02 < HS_MT_0  > HS_MT_2
  ./goose-mutatedna -mr 0.03 < HS_MT_0  > HS_MT_3
  ./goose-mutatedna -mr 0.04 < HS_MT_0  > HS_MT_4
  ./goose-mutatedna -mr 0.05 < HS_MT_0  > HS_MT_5
  ./goose-mutatedna -mr 0.06 < HS_MT_0  > HS_MT_6
  ./goose-mutatedna -mr 0.07 < HS_MT_0  > HS_MT_7
  ./goose-mutatedna -mr 0.08 < HS_MT_0  > HS_MT_8
  ./goose-mutatedna -mr 0.09 < HS_MT_0  > HS_MT_9
  ./goose-mutatedna -mr 0.10 < HS_MT_0  > HS_MT_10
  ./goose-mutatedna -mr 0.11 < HS_MT_0  > HS_MT_11
  ./goose-mutatedna -mr 0.12 < HS_MT_0  > HS_MT_12
  ./goose-mutatedna -mr 0.13 < HS_MT_0  > HS_MT_13
  ./goose-mutatedna -mr 0.14 < HS_MT_0  > HS_MT_14
  ./goose-mutatedna -mr 0.15 < HS_MT_0  > HS_MT_15
  ./goose-mutatedna -mr 0.16 < HS_MT_0  > HS_MT_16
  ./goose-mutatedna -mr 0.17 < HS_MT_0  > HS_MT_17
  ./goose-mutatedna -mr 0.18 < HS_MT_0  > HS_MT_18
  ./goose-mutatedna -mr 0.19 < HS_MT_0  > HS_MT_19
  ./goose-mutatedna -mr 0.20 < HS_MT_0  > HS_MT_20
  #WGS
  ./goose-mutatedna -mr 0.01 < HS_WGS_0 > HS_WGS_1
  ./goose-mutatedna -mr 0.02 < HS_WGS_0 > HS_WGS_2
  ./goose-mutatedna -mr 0.03 < HS_WGS_0 > HS_WGS_3
  ./goose-mutatedna -mr 0.04 < HS_WGS_0 > HS_WGS_4
  ./goose-mutatedna -mr 0.05 < HS_WGS_0 > HS_WGS_5
  ./goose-mutatedna -mr 0.06 < HS_WGS_0 > HS_WGS_6
  #./goose-mutatedna -mr 0.07 < HS_WGS_0 > HS_WGS_7
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$RUN" -eq "1" ]]; then
  ./GeCo $NRC_PARAM -r HS_MT_0 HS_MT_2:HS_MT_4:HS_MT_6:HS_MT_8:HS_MT_10:HS_MT_12 &> REPORT_MT_SYN
  ./GeCo $NRC_PARAM -r HS_WGS_0 HS_WGS_1:HS_WGS_2:HS_WGS_3:HS_WGS_4:HS_WGS_5:HS_WGS_6 &> REPORT_WGS_SYN
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$PLOT" -eq "1" ]]; then
  cat REPORT_MT_SYN | grep "compressed bytes" | awk '{ print $12;}' | tail -n 6 | awk '{printf("%d\t%s\n", NR, $0)}' > MT_EXPECT
  cat REPORT_WGS_SYN | grep "compressed bytes" | awk '{ print $12;}' | tail -n 6 | awk '{printf("%d\t%s\n", NR, $0)}' > WGS_EXPECT

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color font 'Verdana,12'
  set output "Expect.pdf"
  set style line 101 lc rgb '#000000' lt 1 lw 4
  set border 3 front ls 101
  set tics nomirror out scale 0.75
  set format '%g'
  set size ratio 0.8
  set key outside horiz center top
  set xtics ("SAS1" 1, "SAS2" 2, "SAS3" 3, "SAS4" 4, "SAS5" 5, "SAS6" 6)
  set yrange [0:1] 
  set xrange [0.5:6.5] 
  set ytics 0.2
  set grid 
  set ylabel "NRC"
  set xlabel "Sequences"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#009900' lt 1 lw 4 pt 6 ps 0.4 # --- green
  set style line 3 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "MT_EXPECT"  with linespoints ls 1 title "mtDNA", "WGS_EXPECT" with linespoints ls 3 title "gDNA"
EOF


fi
