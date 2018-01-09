#!/bin/bash
#==============================================================================
#
# WARNING: YOU NEED APPROX. 20 GB OF FREE DISK
#
# RUNNING FLAGS
GET_GOOSE=1;
GET_GECO=1;
#==============================================================================
GET_HUMAN=1;
GET_CHIMPANZEE=1;
GET_GORILLA=1;
GET_ORANGUTAN=1;
GET_GIBBON=1;
GET_ANUBIS=1;
GET_MARMOSET=1;
#==============================================================================
GET_MTDNA=1;
#==============================================================================
RUN_MITO=1;
RUN_WGS=1;
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
  rm -f HS;
  cat HS* > DFGSERGF
  mv DFGSERGF HS
fi
#==============================================================================
if [[ "$GET_CHIMPANZEE" -eq "1" ]]; then
  . GetChimpParse.sh
  rm -f PT PT24 PT25 PT26 PT27
  cat PT* > DFGSERGF
  mv DFGSERGF PT
fi
#==============================================================================
if [[ "$GET_GORILLA" -eq "1" ]]; then
  . GetGorillaParse.sh
  rm -f GG GG24 GG25
  cat GG* > DFGSERGF
  mv DFGSERGF GG
fi
#==============================================================================
if [[ "$GET_ORANGUTAN" -eq "1" ]]; then
  . GetOrangutanParse.sh
  rm -f PA PA24 PA25 PA26
  cat PA* > DFGSERGF
  mv DFGSERGF PA
fi
#==============================================================================
if [[ "$GET_GIBBON" -eq "1" ]]; then
  . GetGibbonParse.sh
  rm -f GB GB27 GB28
  cat GB* > DFGSERGF
  mv DFGSERGF GB
fi
#==============================================================================
if [[ "$GET_ANUBIS" -eq "1" ]]; then
  . GetAnubisParse.sh
  rm -f AN AN22
  cat AN* > DFGSERGF
  mv DFGSERGF AN
fi
#==============================================================================
if [[ "$GET_MARMOSET" -eq "1" ]]; then
  . GetCallithrixjacchus.sh
  rm -f CJ CJ24 CJ25 CJ26
  cat CJ* > DFGSERGF
  mv DFGSERGF CJ
fi
#==============================================================================
# GET MITOCHONDRIAS
if [[ "$GET_MTDNA" -eq "1" ]]; then
  . GetMTDNA.sh
  #
  cat MITO.fna | tr ' ' '_' \
  | ./goose-extractreadbypattern sapiens_mitoch | ./goose-fasta2seq > MT_HS.seq
  #cat MITO.fna | tr ' ' '_' \
  #| ./goose-extractreadbypattern troglodytes | ./goose-fasta2seq > MT_PT.seq
  cat MITO.fna | tr ' ' '_' \
  | ./goose-extractreadbypattern Gorilla_gorilla_gorilla | ./goose-fasta2seq > MT_GG.seq
  #cat MITO.fna | tr ' ' '_' \
  #| ./goose-extractreadbypattern abelii | ./goose-fasta2seq > MT_PA.seq
  cat MITO.fna | tr ' ' '_' \
  | ./goose-extractreadbypattern Nomascus_leucogenys | ./goose-fasta2seq > MT_GB.seq
  cat MITO.fna | tr ' ' '_' \
  | ./goose-extractreadbypattern Papio_anubis | ./goose-fasta2seq > MT_AN.seq
  cat MITO.fna | tr ' ' '_' \
  | ./goose-extractreadbypattern Callithrix_jacchus | ./goose-fasta2seq > MT_CJ.seq
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$RUN_MITO" -eq "1" ]]; then
  ./GeCo -v -rm 13:200:1:5/10 -rm 10:100:1:0/0 -rm 6:1:0:0/0 -rm 3:1:0:0/0 -c 10 -g 0.95 -r MT_HS.seq MT_HS.seq:MT_PT.seq:MT_GG.seq:MT_PA.seq:MT_GB.seq:MT_AN.seq:MT_CJ.seq &> REPORT_MITO_HS
  ./GeCo -v -rm 13:200:1:5/10 -rm 10:100:1:0/0 -rm 6:1:0:0/0 -rm 3:1:0:0/0 -c 10 -g 0.95 -r MT_PT.seq MT_HS.seq:MT_PT.seq:MT_GG.seq:MT_PA.seq:MT_GB.seq:MT_AN.seq:MT_CJ.seq &> REPORT_MITO_PT
  ./GeCo -v -rm 13:200:1:5/10 -rm 10:100:1:0/0 -rm 6:1:0:0/0 -rm 3:1:0:0/0 -c 10 -g 0.95 -r MT_GG.seq MT_HS.seq:MT_PT.seq:MT_GG.seq:MT_PA.seq:MT_GB.seq:MT_AN.seq:MT_CJ.seq &> REPORT_MITO_GG
  ./GeCo -v -rm 13:200:1:5/10 -rm 10:100:1:0/0 -rm 6:1:0:0/0 -rm 3:1:0:0/0 -c 10 -g 0.95 -r MT_PA.seq MT_HS.seq:MT_PT.seq:MT_GG.seq:MT_PA.seq:MT_GB.seq:MT_AN.seq:MT_CJ.seq &> REPORT_MITO_PA
  ./GeCo -v -rm 13:200:1:5/10 -rm 10:100:1:0/0 -rm 6:1:0:0/0 -rm 3:1:0:0/0 -c 10 -g 0.95 -r MT_GB.seq MT_HS.seq:MT_PT.seq:MT_GG.seq:MT_PA.seq:MT_GB.seq:MT_AN.seq:MT_CJ.seq &> REPORT_MITO_GB
  ./GeCo -v -rm 13:200:1:5/10 -rm 10:100:1:0/0 -rm 6:1:0:0/0 -rm 3:1:0:0/0 -c 10 -g 0.95 -r MT_AN.seq MT_HS.seq:MT_PT.seq:MT_GG.seq:MT_PA.seq:MT_GB.seq:MT_AN.seq:MT_CJ.seq &> REPORT_MITO_AN
  ./GeCo -v -rm 13:200:1:5/10 -rm 10:100:1:0/0 -rm 6:1:0:0/0 -rm 3:1:0:0/0 -c 10 -g 0.95 -r MT_CJ.seq MT_HS.seq:MT_PT.seq:MT_GG.seq:MT_PA.seq:MT_GB.seq:MT_AN.seq:MT_CJ.seq &> REPORT_MITO_CJ
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$RUN_WGS" -eq "1" ]]; then
  ./GeCo -v -rm 20:200:1:5/10 -rm 14:100:1:0/0 -rm 13:20:0:0/0 -rm 11:10:0:0/0 -rm 9:1:0:0/0 -c 250 -g 0.88 -r HS HS:PT:GG:PA:GB:AN:CJ &> REPORT_WGS_HS
  ./GeCo -v -rm 20:200:1:5/10 -rm 14:100:1:0/0 -rm 13:20:0:0/0 -rm 11:10:0:0/0 -rm 9:1:0:0/0 -c 250 -g 0.88 -r PT HS:PT:GG:PA:GB:AN:CJ &> REPORT_WGS_PT
  ./GeCo -v -rm 20:200:1:5/10 -rm 14:100:1:0/0 -rm 13:20:0:0/0 -rm 11:10:0:0/0 -rm 9:1:0:0/0 -c 250 -g 0.88 -r GG HS:PT:GG:PA:GB:AN:CJ &> REPORT_WGS_GG
  ./GeCo -v -rm 20:200:1:5/10 -rm 14:100:1:0/0 -rm 13:20:0:0/0 -rm 11:10:0:0/0 -rm 9:1:0:0/0 -c 250 -g 0.88 -r PA HS:PT:GG:PA:GB:AN:CJ &> REPORT_WGS_PA
  ./GeCo -v -rm 20:200:1:5/10 -rm 14:100:1:0/0 -rm 13:20:0:0/0 -rm 11:10:0:0/0 -rm 9:1:0:0/0 -c 250 -g 0.88 -r GB HS:PT:GG:PA:GB:AN:CJ &> REPORT_WGS_GB
  ./GeCo -v -rm 20:200:1:5/10 -rm 14:100:1:0/0 -rm 13:20:0:0/0 -rm 11:10:0:0/0 -rm 9:1:0:0/0 -c 250 -g 0.88 -r AN HS:PT:GG:PA:GB:AN:CJ &> REPORT_WGS_AN
  ./GeCo -v -rm 20:200:1:5/10 -rm 14:100:1:0/0 -rm 13:20:0:0/0 -rm 11:10:0:0/0 -rm 9:1:0:0/0 -c 250 -g 0.88 -r CJ HS:PT:GG:PA:GB:AN:CJ &> REPORT_WGS_CJ
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$PLOT" -eq "1" ]]; then
  cat REPORT_MITO_HS | grep "compressed bytes" | awk '{ print $12;}' | tail -n 6 | awk '{printf("%d\t%s\n", NR, $0)}' > MT_VALUES
  cat REPORT_MITO_HS | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > MT_VALUES_HS
  cat REPORT_MITO_PT | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > MT_VALUES_PT
  cat REPORT_MITO_GG | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > MT_VALUES_GG
  cat REPORT_MITO_PA | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > MT_VALUES_PA
  cat REPORT_MITO_GB | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > MT_VALUES_GB
  cat REPORT_MITO_AN | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > MT_VALUES_AN
  cat REPORT_MITO_CJ | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > MT_VALUES_CJ
  #
  cat REPORT_WGS_HS | grep "compressed bytes" | awk '{ print $12;}' | tail -n 6 | awk '{printf("%d\t%s\n", NR, $0)}' > WGS_VALUES
  cat REPORT_WGS_HS | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > WGS_VALUES_HS
  cat REPORT_WGS_PT | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > WGS_VALUES_PT
  cat REPORT_WGS_GG | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > WGS_VALUES_GG
  cat REPORT_WGS_PA | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > WGS_VALUES_PA
  cat REPORT_WGS_GB | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > WGS_VALUES_GB
  cat REPORT_WGS_AN | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > WGS_VALUES_AN
  cat REPORT_WGS_CJ | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > WGS_VALUES_CJ

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color font 'Verdana,12'
  set output "APE.pdf"
  set style line 101 lc rgb '#000000' lt 1 lw 4
  set border 3 front ls 101
  set tics nomirror out scale 0.75
  set format '%g'
  set size ratio 0.8
  set key outside horiz center top
  set xtics ("Chimpanzee" 1, "Gorilla" 2, "Orangutan" 3, "Gibbon" 4, "Babbon" 5, "Marmoset" 6)
  set yrange [0:1] 
  set xrange [0.5:6.5] 
  set ytics 0.2
  set grid 
  set xtics rotate by -30
  set ylabel "NRC"
  set xlabel "Species"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "MT_VALUES"  with linespoints ls 1 title "mitochondrial", "WGS_VALUES" with linespoints ls 2 title "nuclear"
EOF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color font 'Verdana,12'
  set output "APE-HS.pdf"
  set style line 101 lc rgb '#000000' lt 1 lw 4
  set border 3 front ls 101
  set tics nomirror out scale 0.75
  set format '%g'
  set size ratio 0.8
  set key outside horiz center top
  set xtics ("Human" 1, "Chimpanzee" 2, "Gorilla" 3, "Orangutan" 4, "Gibbon" 5, "Babbon" 6, "Marmoset" 7)
  set yrange [0:1] 
  set xrange [0.5:7.5] 
  set ytics 0.2
  set grid 
  set xtics rotate by -30
  set ylabel "NRC"
  set xlabel "Species"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "MT_VALUES_HS"  with linespoints ls 1 title "mitochondrial", "WGS_VALUES_HS" with linespoints ls 2 title "nuclear"
EOF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color font 'Verdana,12'
  set output "APE-PT.pdf"
  set style line 101 lc rgb '#000000' lt 1 lw 4
  set border 3 front ls 101
  set tics nomirror out scale 0.75
  set format '%g'
  set size ratio 0.8
  set key outside horiz center top
  set xtics ("Human" 1, "Chimpanzee" 2, "Gorilla" 3, "Orangutan" 4, "Gibbon" 5, "Babbon" 6, "Marmoset" 7)
  set yrange [0:1] 
  set xrange [0.5:7.5] 
  set ytics 0.2
  set grid 
  set xtics rotate by -30
  set ylabel "NRC"
  set xlabel "Species"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "MT_VALUES_PT"  with linespoints ls 1 title "mitochondrial", "WGS_VALUES_PT" with linespoints ls 2 title "nuclear"
EOF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color font 'Verdana,12'
  set output "APE-GG.pdf"
  set style line 101 lc rgb '#000000' lt 1 lw 4
  set border 3 front ls 101
  set tics nomirror out scale 0.75
  set format '%g'
  set size ratio 0.8
  set key outside horiz center top
  set xtics ("Human" 1, "Chimpanzee" 2, "Gorilla" 3, "Orangutan" 4, "Gibbon" 5, "Babbon" 6, "Marmoset" 7)
  set yrange [0:1] 
  set xrange [0.5:7.5] 
  set ytics 0.2
  set grid 
  set xtics rotate by -30
  set ylabel "NRC"
  set xlabel "Species"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "MT_VALUES_GG"  with linespoints ls 1 title "mitochondrial", "WGS_VALUES_GG" with linespoints ls 2 title "nuclear"
EOF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color font 'Verdana,12'
  set output "APE-PA.pdf"
  set style line 101 lc rgb '#000000' lt 1 lw 4
  set border 3 front ls 101
  set tics nomirror out scale 0.75
  set format '%g'
  set size ratio 0.8
  set key outside horiz center top
  set xtics ("Human" 1, "Chimpanzee" 2, "Gorilla" 3, "Orangutan" 4, "Gibbon" 5, "Babbon" 6, "Marmoset" 7)
  set yrange [0:1] 
  set xrange [0.5:7.5] 
  set ytics 0.2
  set grid 
  set xtics rotate by -30
  set ylabel "NRC"
  set xlabel "Species"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "MT_VALUES_PA"  with linespoints ls 1 title "mitochondrial", "WGS_VALUES_PA" with linespoints ls 2 title "nuclear"
EOF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color font 'Verdana,12'
  set output "APE-GB.pdf"
  set style line 101 lc rgb '#000000' lt 1 lw 4
  set border 3 front ls 101
  set tics nomirror out scale 0.75
  set format '%g'
  set size ratio 0.8
  set key outside horiz center top
  set xtics ("Human" 1, "Chimpanzee" 2, "Gorilla" 3, "Orangutan" 4, "Gibbon" 5, "Babbon" 6, "Marmoset" 7)
  set yrange [0:1] 
  set xrange [0.5:7.5] 
  set ytics 0.2
  set grid 
  set xtics rotate by -30
  set ylabel "NRC"
  set xlabel "Species"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "MT_VALUES_GB"  with linespoints ls 1 title "mitochondrial", "WGS_VALUES_GB" with linespoints ls 2 title "nuclear"
EOF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color font 'Verdana,12'
  set output "APE-AN.pdf"
  set style line 101 lc rgb '#000000' lt 1 lw 4
  set border 3 front ls 101
  set tics nomirror out scale 0.75
  set format '%g'
  set size ratio 0.8
  set key outside horiz center top
  set xtics ("Human" 1, "Chimpanzee" 2, "Gorilla" 3, "Orangutan" 4, "Gibbon" 5, "Babbon" 6, "Marmoset" 7)
  set yrange [0:1] 
  set xrange [0.5:7.5] 
  set ytics 0.2
  set grid 
  set xtics rotate by -30
  set ylabel "NRC"
  set xlabel "Species"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "MT_VALUES_AN"  with linespoints ls 1 title "mitochondrial", "WGS_VALUES_AN" with linespoints ls 2 title "nuclear"
EOF

gnuplot << EOF
  reset
  set terminal pdfcairo enhanced color font 'Verdana,12'
  set output "APE-CJ.pdf"
  set style line 101 lc rgb '#000000' lt 1 lw 4
  set border 3 front ls 101
  set tics nomirror out scale 0.75
  set format '%g'
  set size ratio 0.8
  set key outside horiz center top
  set xtics ("Human" 1, "Chimpanzee" 2, "Gorilla" 3, "Orangutan" 4, "Gibbon" 5, "Babbon" 6, "Marmoset" 7)
  set yrange [0:1] 
  set xrange [0.5:7.5] 
  set ytics 0.2
  set grid 
  set xtics rotate by -30
  set ylabel "NRC"
  set xlabel "Species"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "MT_VALUES_CJ"  with linespoints ls 1 title "mitochondrial", "WGS_VALUES_CJ" with linespoints ls 2 title "nuclear"
EOF

fi
