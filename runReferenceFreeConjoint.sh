#!/bin/bash
###############################################################################
INSTALL_MFCOMPRESS=1;
INSTALL_GECO=1;
###############################################################################
DOWNLOAD=1;
PARSE=1;
###############################################################################
RUN_MFCOMPRESS=1;
RUN_GECO=1;
###############################################################################
RUN_JOIN=1;
RUN_PLOT=1;
###############################################################################
###############################################################################
#
function Parse {
  zcat $1.fa.gz | grep -v ">" | tr -d -c "ACGT" > XTMP
  cat HEADER XTMP > datasets/$1;
  }
#
function RunMFCompress {
  cp ../../datasets/$1 $1.fa
  rm -f $1.fa.mfc
  (time ./MFCompressC -v -o $1.fa.mfc $1.fa ) &> ../../results/C_MFC_$1
  ls -la $1.fa.mfc  | awk '{ print $5;}' > ../../results/BC_MFC_$1
  }
#
function RunGeCo {
  PARAM=" -tm 20:200:1:5/10 -tm 14:100:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -c 50 -g 0.88 ";
  cp ../../datasets/$1 .
  rm -f $1.co
  (time ./GeCo $PARAM $1 ) &> ../../results/C_GECO_$1
  ls -la $1.co | awk '{ print $5;}' > ../../results/BC_GECO_$1
  rm -f $1;
  }
#
###############################################################################
# INSTALL
mkdir -p datasets
mkdir -p progs
cd progs/
###############################################################################
# GET MFCOMPRESS ==============================================================
if [[ "$INSTALL_MFCOMPRESS" -eq "1" ]]; then
  rm -rf MFCompress-src-1.01.tgz MFCompress-src-1.01/
  wget http://sweet.ua.pt/ap/software/mfcompress/MFCompress-src-1.01.tgz
  tar -xzf MFCompress-src-1.01.tgz
  mv MFCompress-src-1.01/ mfcompress
  cd mfcompress/
  cp Makefile.linux Makefile # make -f Makefile.linux
  make
  cp MFCompressC ..
  cp MFCompressD ..
  cd ..
  rm -f MFCompress-src-1.01.tgz;
fi
###############################################################################
# GET GECO ====================================================================
if [[ "$INSTALL_GECO" -eq "1" ]]; then
  rm -fr geco/
  git clone https://github.com/pratas/geco.git
  cd geco/src/
  cmake .
  make
  cp GeCo ../
  cp GeDe ../
  cd ../../
fi
###############################################################################
cd ..
###############################################################################
# DOWNLOAD
if [[ "$DOWNLOAD" -eq "1" ]]; then
  rm *.fa.gz -f
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Homo_sapiens/Assembled_chromosomes/seq/hs_ref_GRCh38.p12_chr5.fa.gz -O HS5.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Homo_sapiens/Assembled_chromosomes/seq/hs_ref_GRCh38.p12_chr9.fa.gz -O HS9.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Homo_sapiens/Assembled_chromosomes/seq/hs_ref_GRCh38.p12_chr13.fa.gz -O HS13.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Homo_sapiens/Assembled_chromosomes/seq/hs_ref_GRCh38.p12_chr17.fa.gz -O HS17.fa.gz
  #
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Pan_troglodytes/Assembled_chromosomes/seq/ptr_ref_Clint_PTRv2_chr5.fa.gz -O PT5.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Pan_troglodytes/Assembled_chromosomes/seq/ptr_ref_Clint_PTRv2_chr9.fa.gz -O PT9.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Pan_troglodytes/Assembled_chromosomes/seq/ptr_ref_Clint_PTRv2_chr13.fa.gz -O PT13.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Pan_troglodytes/Assembled_chromosomes/seq/ptr_ref_Clint_PTRv2_chr17.fa.gz -O PT17.fa.gz
  #
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Gorilla_gorilla/Assembled_chromosomes/seq/9595_ref_gorGor4_chr5.fa.gz -O GG5.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Gorilla_gorilla/Assembled_chromosomes/seq/9595_ref_gorGor4_chr9.fa.gz -O GG9.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Gorilla_gorilla/Assembled_chromosomes/seq/9595_ref_gorGor4_chr13.fa.gz -O GG13.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Gorilla_gorilla/Assembled_chromosomes/seq/9595_ref_gorGor4_chr17.fa.gz -O GG17.fa.gz
  #
fi
# PARSE =======================================================================
if [[ "$PARSE" -eq "1" ]]; then
  echo "parsing ..."
  echo ">X" > HEADER
  #
  Parse "HS5"
  Parse "HS9"
  Parse "HS13"
  Parse "HS17"
  #
  Parse "PT5"
  Parse "PT9"
  Parse "PT13"
  Parse "PT17"
  #
  Parse "GG5"
  Parse "GG9"
  Parse "GG13"
  Parse "GG17"
  #  
  cd datasets/
  cat HS5 PT5 > HS5_PT5;
  cat HS5 GG5 > HS5_GG5;
  #
  cat HS9 PT9 > HS9_PT9;
  cat HS9 GG9 > HS9_GG9;
  #
  cat HS13 PT13 > HS13_PT13;
  cat HS13 GG13 > HS13_GG13;
  #
  cat HS17 PT17 > HS17_PT17;
  cat HS17 GG17 > HS17_GG17;
  cd ..
  #
  echo "done!";
  fi
#
# RUN =========================================================================
if [[ "$RUN_MFCOMPRESS" -eq "1" ]]; then
  echo "Running MFCompress ...";
  mkdir -p results
  cd progs/mfcompress
  #
  RunMFCompress "HS5_PT5"
  RunMFCompress "HS5_GG5"
  #
  RunMFCompress "HS9_PT9"
  RunMFCompress "HS9_GG9"
  #
  RunMFCompress "HS13_PT13"
  RunMFCompress "HS13_GG13"
  #
  RunMFCompress "HS17_PT17"
  RunMFCompress "HS17_GG17"
  #
  cd ../../
  echo "Done!";
fi
#==============================================================================
if [[ "$RUN_GECO" -eq "1" ]]; then
  echo "Running GeCo ...";
  mkdir -p results
  cd progs/geco
  #
  RunGeCo "HS5_PT5"
  RunGeCo "HS5_GG5"
  #
  RunGeCo "HS9_PT9"
  RunGeCo "HS9_GG9"
  #
  RunGeCo "HS13_PT13"
  RunGeCo "HS13_GG13"
  #
  RunGeCo "HS17_PT17"
  RunGeCo "HS17_GG17"
  # 
  cd ../../
  echo "Done!";
fi
#==============================================================================
###############################################################################
# PLOT
if [[ "$RUN_JOIN" -eq "1" ]]; then
  rm -f DATAPNC;
  printf "MFCompress\t%s\n" `cat results/BC_MFC_HS5_PT5 results/BC_MFC_HS5_GG5 results/BC_MFC_HS9_PT9 results/BC_MFC_HS9_GG9 results/BC_MFC_HS13_PT13 results/BC_MFC_HS13_GG13 results/BC_MFC_HS17_PT17 results/BC_MFC_HS17_GG17 | awk '{s+=$1}END{print s}'` >> DATAPNC
  printf "GeCo\t%s\n" `cat results/BC_GECO_HS5_PT5 results/BC_GECO_HS5_GG5 results/BC_GECO_HS9_PT9 results/BC_GECO_HS9_GG9 results/BC_GECO_HS13_PT13 results/BC_GECO_HS13_GG13 results/BC_GECO_HS17_PT17 results/BC_GECO_HS17_GG17 | awk '{s+=$1}END{print s}'` >> DATAPNC
fi
#==============================================================================
###############################################################################
# PLOT
if [[ "$RUN_PLOT" -eq "1" ]]; then
  echo "set terminal pdfcairo enhanced color
  set output 'bytes3.pdf'
  set auto
  set boxwidth 0.45
  set xtics nomirror
  set style fill solid 1.00
  set ylabel 'Bytes'
  set xlabel 'Methods'
  set yrange[0:390000000]
  set grid ytics lc rgb '#C0C0C0'
  unset key
  set grid
  set format y '%.0s %c'
  set style line 2 lc rgb '#406090'
  plot 'DATAPNC' using 2:xtic(1) with boxes ls 2" | gnuplot -p
fi
###############################################################################
