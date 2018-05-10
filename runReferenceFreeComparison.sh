#!/bin/bash
###############################################################################
INSTALL_DEPENDENCIES=0;
#
INSTALL_DELIMINATE=1;
INSTALL_MFCOMPRESS=1;
INSTALL_GECO=1;
###############################################################################
DOWNLOAD=1;
PARSE=1;
###############################################################################
RUN_DELIMINATE=1;
RUN_MFCOMPRESS=1;
RUN_GECO=1;
###############################################################################
RUN_JOIN=1;
RUN_PLOT=1;
###############################################################################
#
if [[ "$INSTALL_DEPENDENCIES" -eq "1" ]]; then
  # GET 7ZIP ==================================================================
  P7ZIPPATH="projects/p7zip/files/latest";
  rm -f FILES
  wget http://sourceforge.net/$P7ZIPPATH/download?source=typ_redirect \
  -O FILES.tar.bz2
  tar -xjf FILES.tar.bz2
  cd p7zip_15.14.1/
  make all
  cd ..
  # GET ZLIB ==================================================================
  rm -f zlib_1.2.8.dfsg.orig.tar.gz
  wget \
  https://launchpad.net/ubuntu/+archive/primary/+files/zlib_1.2.8.dfsg.orig.tar.gz
  tar -xzf zlib_1.2.8.dfsg.orig.tar.gz
  cd zlib-1.2.8/
  ./configure
  make
  cd ..
fi
#
###############################################################################
#
function Parse {
  zcat $1.fa.gz | grep -v ">" | tr -d -c "ACGT" > XTMP
  cat HEADER XTMP > datasets/$1;
  }
#
function RunDeliminate {
  cp ../../datasets/$1 $1.fa
  rm -f $1.fa.dlim
  (time ./delim a $1.fa ) &> ../../results/C_DEL_$1
  ls -la $1.fa.dlim > ../../results/BC_DEL_$1
  cd ..
  }
#
function RunMFCompress {
  cp ../../datasets/$1 $1.fa
  rm -f chimpanze.fna.mfc
  (time ./MFCompressC -v -o chimpanze.fna.mfc chimpanze.fna ) &> ../../results/C_MFC_$1
  ls -la chimpanze.fna.mfc > ../../results/BC_MFC_$1
  cd ..
  }
#
function RunGeCo {
  PARAM=" -tm 20:200:1:5/10 -tm 14:100:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -c 50 -g 0.88 ";
  cp ../../datasets/$1 .
  rm -f $1.co
  (time ./GeCo $PARAM $1 ) &> ../../results/C_GECO_$1
  ls -la $1.co | awk '{ print $5;}' > ../../results/BC_GECO_$1
  rm -f $1;
  cd ..
  }
#
###############################################################################
# INSTALL
mkdir -p datasets
mkdir -p progs
cd progs/
###############################################################################
# GET DELIMINATE ===============================================================
if [[ "$INSTALL_GREEN" -eq "1" ]]; then
  rm -f DELIMINATE_LINUX_64bit.tar.gz;
  DELSEV="metagenomics.atc.tcs.com/Compression_archive";
  wget http://$DELSEV/DELIMINATE_LINUX_64bit.tar.gz
  tar -xzf DELIMINATE_LINUX_64bit.tar.gz
  mv EXECUTABLES deliminate
  rm -f DELIMINATE_LINUX_64bit.tar.gz;
fi
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
  echo "done!";
  fi
#
# RUN =========================================================================
if [[ "$RUN_DELIMINATE" -eq "1" ]]; then
  echo "Running DELIMINATE ...";
  mkdir -p results
  cd progs/deliminate/
  #
  RunDeliminate "HS5"
  RunDeliminate "PT5"
  RunDeliminate "GG5"
  #
  RunDeliminate "HS9"
  RunDeliminate "PT9"
  RunDeliminate "GG9"
  #
  RunDeliminate "HS13"
  RunDeliminate "PT13"
  RunDeliminate "GG13"
  #
  RunDeliminate "HS17"
  RunDeliminate "PT17"
  RunDeliminate "GG17"
  # 
  cd ../../
  echo "Done!";
fi
#==============================================================================
if [[ "$RUN_MFCOMPRESS" -eq "1" ]]; then
  echo "Running MFCompress ...";
  mkdir -p results
  cd progs/mfcompress
  #
  RunMFCompress "HS5"
  RunMFCompress "PT5"
  RunMFCompress "GG5"
  #
  RunMFCompress "HS9"
  RunMFCompress "PT9"
  RunMFCompress "GG9"
  #
  RunMFCompress "HS13"
  RunMFCompress "PT13"
  RunMFCompress "GG13"
  #
  RunMFCompress "HS17"
  RunMFCompress "PT17"
  RunMFCompress "GG17"
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
  RunGeCo "HS5"
  RunGeCo "PT5"
  RunGeCo "GG5"
  #
  RunGeCo "HS9"
  RunGeCo "PT9"
  RunGeCo "GG9"
  #
  RunGeCo "HS13"
  RunGeCo "PT13"
  RunGeCo "GG13"
  #
  RunGeCo "HS17"
  RunGeCo "PT17"
  RunGeCo "GG17"
  # 
  cd ../../
  echo "Done!";
fi
#==============================================================================
###############################################################################
# PLOT
if [[ "$RUN_JOIN" -eq "1" ]]; then
  rm -f DATAPN;
  printf "Deliminate\t%s\n" `cat results/BC_DEL_HS5 results/BC_DEL_PT5 results/BC_DEL_GG5 results/BC_DEL_HS9 results/BC_DEL_PT9 results/BC_DEL_GG9 results/BC_DEL_HS13 results/BC_DEL_PT13 results/BC_DEL_GG13 results/BC_DEL_HS17 results/BC_DEL_GG17 results/BC_DEL_GG17 | awk '{s+=$1}END{print s}'` >> DATAPN
  printf "MFCompress\t%s\n" `cat results/BC_MFC_HS5 results/BC_MFC_PT5 results/BC_MFC_GG5 results/BC_MFC_HS9 results/BC_MFC_PT9 results/BC_MFC_GG9 results/BC_MFC_HS13 results/BC_MFC_PT13 results/BC_MFC_GG13 results/BC_MFC_HS17 results/BC_MFC_GG17 results/BC_MFC_GG17 | awk '{s+=$1}END{print s}'` >> DATAPN
  printf "GeCo\t%s\n" `cat results/BC_GECO_HS5 results/BC_GECO_PT5 results/BC_GECO_GG5 results/BC_GECO_HS9 results/BC_GECO_PT9 results/BC_GECO_GG9 results/BC_GECO_HS13 results/BC_GECO_PT13 results/BC_GECO_GG13 results/BC_GECO_HS17 results/BC_GECO_GG17 results/BC_GECO_GG17 | awk '{s+=$1}END{print s}'` >> DATAPN
fi
#==============================================================================
###############################################################################
# PLOT
if [[ "$RUN_PLOT" -eq "1" ]]; then
  echo "set terminal pdfcairo enhanced color
  set output 'bytes.pdf'
  set auto
  set boxwidth 0.45
  set xtics nomirror
  set style fill solid 1.00
  set ylabel 'Bytes'
  set xlabel 'Methods'
  # set yrange[0:180000000]
  # Lighter grid lines
  set grid ytics lc rgb '#C0C0C0'
  unset key
  set grid
  set format y '%.0s %c'
  set style line 2 lc rgb '#406090'
  plot 'DATAPN' using 2:xtic(1) with boxes ls 2" | gnuplot -p
fi
###############################################################################
