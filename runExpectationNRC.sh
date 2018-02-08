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
  ./goose-mutatedna -mr 0.21 < HS_MT_0  > HS_MT_21
  ./goose-mutatedna -mr 0.22 < HS_MT_0  > HS_MT_22
  ./goose-mutatedna -mr 0.23 < HS_MT_0  > HS_MT_23
  ./goose-mutatedna -mr 0.24 < HS_MT_0  > HS_MT_24
  ./goose-mutatedna -mr 0.25 < HS_MT_0  > HS_MT_25
  ./goose-mutatedna -mr 0.26 < HS_MT_0  > HS_MT_26
  ./goose-mutatedna -mr 0.27 < HS_MT_0  > HS_MT_27
  ./goose-mutatedna -mr 0.28 < HS_MT_0  > HS_MT_28
  ./goose-mutatedna -mr 0.29 < HS_MT_0  > HS_MT_29
  ./goose-mutatedna -mr 0.30 < HS_MT_0  > HS_MT_30
  ./goose-mutatedna -mr 0.31 < HS_MT_0  > HS_MT_31
  ./goose-mutatedna -mr 0.32 < HS_MT_0  > HS_MT_32
  ./goose-mutatedna -mr 0.33 < HS_MT_0  > HS_MT_33
  ./goose-mutatedna -mr 0.34 < HS_MT_0  > HS_MT_34
  ./goose-mutatedna -mr 0.35 < HS_MT_0  > HS_MT_35
  ./goose-mutatedna -mr 0.36 < HS_MT_0  > HS_MT_36
  ./goose-mutatedna -mr 0.37 < HS_MT_0  > HS_MT_37
  ./goose-mutatedna -mr 0.38 < HS_MT_0  > HS_MT_38
  ./goose-mutatedna -mr 0.39 < HS_MT_0  > HS_MT_39
  ./goose-mutatedna -mr 0.40 < HS_MT_0  > HS_MT_40
  #WGS
  ./goose-mutatedna -mr 0.01 < HS_WGS_0 > HS_WGS_1
  ./goose-mutatedna -mr 0.02 < HS_WGS_0 > HS_WGS_2
  ./goose-mutatedna -mr 0.03 < HS_WGS_0 > HS_WGS_3
  ./goose-mutatedna -mr 0.04 < HS_WGS_0 > HS_WGS_4
  ./goose-mutatedna -mr 0.05 < HS_WGS_0 > HS_WGS_5
  ./goose-mutatedna -mr 0.06 < HS_WGS_0 > HS_WGS_6
  ./goose-mutatedna -mr 0.07 < HS_WGS_0 > HS_WGS_7
  ./goose-mutatedna -mr 0.08 < HS_WGS_0 > HS_WGS_8
  ./goose-mutatedna -mr 0.09 < HS_WGS_0 > HS_WGS_9
  ./goose-mutatedna -mr 0.10 < HS_WGS_0 > HS_WGS_10
  ./goose-mutatedna -mr 0.11 < HS_WGS_0 > HS_WGS_11
  ./goose-mutatedna -mr 0.12 < HS_WGS_0 > HS_WGS_12
  ./goose-mutatedna -mr 0.13 < HS_WGS_0 > HS_WGS_13
  ./goose-mutatedna -mr 0.14 < HS_WGS_0 > HS_WGS_14
  ./goose-mutatedna -mr 0.15 < HS_WGS_0 > HS_WGS_15
  ./goose-mutatedna -mr 0.16 < HS_WGS_0 > HS_WGS_16
  ./goose-mutatedna -mr 0.17 < HS_WGS_0 > HS_WGS_17
  ./goose-mutatedna -mr 0.18 < HS_WGS_0 > HS_WGS_18
  ./goose-mutatedna -mr 0.19 < HS_WGS_0 > HS_WGS_19
  ./goose-mutatedna -mr 0.20 < HS_WGS_0 > HS_WGS_20
  #
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$RUN" -eq "1" ]]; then
  ./GeCo $NRC_PARAM_MT -r HS_MT_0 HS_MT_0:HS_MT_1:HS_MT_2:HS_MT_3:HS_MT_4:HS_MT_5:HS_MT_6:HS_MT_7:HS_MT_8:HS_MT_9:HS_MT_10 &> REPORT_NRC_MT_SYN_1
  ./GeCo $NRC_PARAM_MT -r HS_MT_0 HS_MT_0:HS_MT_2:HS_MT_4:HS_MT_6:HS_MT_8:HS_MT_10:HS_MT_12:HS_MT_14:HS_MT_16:HS_MT_18:HS_MT_20 &> REPORT_NRC_MT_SYN_2
  ./GeCo $NRC_PARAM_WGS -r HS_WGS_0 HS_WGS_0:HS_WGS_1:HS_WGS_2:HS_WGS_3:HS_WGS_4:HS_WGS_5:HS_WGS_6:HS_WGS_7:HS_WGS_8:HS_WGS_9:HS_WGS_10  &> REPORT_NRC_WGS_SYN_1
  ./GeCo $NRC_PARAM_WGS -r HS_WGS_0 HS_WGS_0:HS_WGS_2:HS_WGS_4:HS_WGS_6:HS_WGS_8:HS_WGS_10:HS_WGS_12:HS_WGS_14:HS_WGS_16:HS_WGS_18:HS_WGS_20  &> REPORT_NRC_WGS_SYN_2
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$PLOT" -eq "1" ]]; then
  cat REPORT_NRC_MT_SYN_1 | grep "compressed bytes" | awk '{ print $12;}' | tail -n 11 | awk '{printf("%d\t%s\n", NR, $0)}' > MT_NRC_EXPECT_1
  cat REPORT_NRC_MT_SYN_2 | grep "compressed bytes" | awk '{ print $12;}' | tail -n 11 | awk '{printf("%d\t%s\n", NR, $0)}' > MT_NRC_EXPECT_2
  cat REPORT_NRC_WGS_SYN_1 | grep "compressed bytes" | awk '{ print $12;}' | tail -n 11 | awk '{printf("%d\t%s\n", NR, $0)}' > WGS_NRC_EXPECT_1
  cat REPORT_NRC_WGS_SYN_2 | grep "compressed bytes" | awk '{ print $12;}' | tail -n 11 | awk '{printf("%d\t%s\n", NR, $0)}' > WGS_NRC_EXPECT_2
#==============================================================================
#==============================================================================
  cat REPORT_NCD_MT_SYN_1 | grep "compressed bytes" | awk '{ print $12;}' | tail -n 11 | awk '{printf("%d\t%s\n", NR, $0)}' > MT_NCD_EXPECT_1
  cat REPORT_NCD_MT_SYN_2 | grep "compressed bytes" | awk '{ print $12;}' | tail -n 11 | awk '{printf("%d\t%s\n", NR, $0)}' > MT_NCD_EXPECT_2
  cat REPORT_NCD_WGS_SYN_1 | grep "compressed bytes" | awk '{ print $12;}' | tail -n 11 | awk '{printf("%d\t%s\n", NR, $0)}' > WGS_NCD_EXPECT_1
  cat REPORT_NCD_WGS_SYN_2 | grep "compressed bytes" | awk '{ print $12;}' | tail -n 11 | awk '{printf("%d\t%s\n", NR, $0)}' > WGS_NCD_EXPECT_2
#==============================================================================
#==============================================================================

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color font 'Verdana,12'
  set output "ExpectNRC.pdf"
  set style line 101 lc rgb '#000000' lt 1 lw 4
  set border 3 front ls 101
  set tics nomirror out scale 0.75
  set format '%g'
  set size ratio 0.8
  set key outside horiz center top
  set xtics ("S0" 1, "S1" 2, "S2" 3, "S3" 4, "S4" 5, "S5" 6, "S6" 7, "S7" 8, "S8" 9, "S9" 10, "S10" 11)
  set yrange [0:1] 
  set xrange [0.5:11.5]
  set ytics 0.2
  set grid 
  set ylabel "NRC"
  set xlabel "Sequences"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#009900' lt 1 lw 4 pt 6 ps 0.4 # --- green
  set style line 3 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "MT_NRC_EXPECT_1"  with linespoints ls 1 title "mtDNA x1", "MT_NRC_EXPECT_2"  with linespoints ls 1 title "mtDNA x2", "WGS_NRC_EXPECT_1" with linespoints ls 3 title "gDNA x1", "WGS_NRC_EXPECT_2" with linespoints ls 3 title "gDNA x2"
EOF

fi
