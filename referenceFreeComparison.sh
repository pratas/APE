#!/bin/bash
###############################################################################
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
function Parse {
  zcat $1.fa.gz | grep -v ">" | tr -d -c "ACGT" > XTMP
  cat HEADER XTMP > datasets/$1;
  }
#
function RunGReEn {
  PARAM=" -v " # -i -k 16 -f 5 ";
  # 1 - TARGET
  # 2 - REFERENCE
  cp ../../datasets/$1 .
  cp ../../datasets/$2 .
  rm -f $1.co
  (time ./GReEnC $PARAM -o $1.co $2 $1 ) &> ../../results/C_GREEN_$1-$2
  ls -la $1.co | awk '{ print $5;}' > ../../results/BC_GREEN_$1-$2
  rm -f $2 $1;
  }
#
function RunGeCo {
  PARAM=" -rm 20:200:1:5/10 -rm 14:100:1:0/0 -rm 13:20:0:0/0 -rm 11:10:0:0/0 -rm 9:1:0:0/0 -c 50 -g 0.88 ";
  # 1 - TARGET
  # 2 - REFERENCE
  cp ../../datasets/$1 .
  cp ../../datasets/$2 .
  rm -f $1.co
  (time ./GeCo $PARAM -r $2 $1 ) &> ../../results/C_GECO_REF_$1-$2
  ls -la $1.co | awk '{ print $5;}' > ../../results/BC_GECO_REF_$1-$2
  rm -f $2 $1;
  }
#
function RunIDoComp {
  # 1 - TARGET
  # 2 - REFERENCE
  cp ../../datasets/$1 $1.fa
  cp ../../datasets/$2 $2.fa
  
  cd ..
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
if [[ "$RUN_GDC2" -eq "1" ]]; then
  echo "Running GDC2 ...";
  mkdir -p results
  cd progs/gdc2
  # target $1, reference $2:
  RunGDC2 "HS5" "PT5"
  RunGDC2 "HS5" "GG5"
  #
  RunGDC2 "HS9" "PT9"
  RunGDC2 "HS9" "GG9"
  #
  RunGDC2 "HS13" "PT13"
  RunGDC2 "HS13" "GG13"
  #
  RunGDC2 "HS17" "PT17"
  RunGDC2 "HS17" "GG17"
  # 
  cd ../../
  echo "Done!";
fi
#==============================================================================
if [[ "$RUN_IDOCOMP" -eq "1" ]]; then
  echo "Running iDoComp ...";
  mkdir -p results
  cd progs/idocomp/
  # target $1, reference $2:
  RunIDoComp "HS5" "PT5"
  RunIDoComp "HS5" "GG5"
  #
  RunIDoComp "HS9" "PT9"
  RunIDoComp "HS9" "GG9"
  #
  RunIDoComp "HS13" "PT13"
  RunIDoComp "HS13" "GG13"
  #
  RunIDoComp "HS17" "PT17"
  RunIDoComp "HS17" "GG17"
  # 
  cd ../../
  echo "Done!";
fi
#==============================================================================
if [[ "$RUN_GECO" -eq "1" ]]; then
  echo "Running GeCo ...";
  mkdir -p results
  cd progs/geco
  # target $1, reference $2:
  RunGeCo "HS5" "PT5"
  RunGeCo "HS5" "GG5"
  #
  RunGeCo "HS9" "PT9"
  RunGeCo "HS9" "GG9"
  #
  RunGeCo "HS13" "PT13"
  RunGeCo "HS13" "GG13"
  #
  RunGeCo "HS17" "PT17"
  RunGeCo "HS17" "GG17"
  # 
  cd ../../
  echo "Done!";
fi
#==============================================================================
if [[ "$RUN_GREEN" -eq "1" ]]; then
  echo "Running GReEn ...";
  mkdir -p results
  cd progs/green
  # target $1, reference $2:
  RunGReEn "HS5" "PT5"
  RunGReEn "HS5" "GG5"
  #
  RunGReEn "HS9" "PT9"
  RunGReEn "HS9" "GG9"
  #
  RunGReEn "HS13" "PT13"
  RunGReEn "HS13" "GG13"
  #
  RunGReEn "HS17" "PT17"
  RunGReEn "HS17" "GG17"
  # 
  cd ../../
  echo "Done!";
fi
#==============================================================================
###############################################################################
# PLOT
if [[ "$RUN_JOIN" -eq "1" ]]; then
  rm -f DATAPN;
  printf "Deliminate\t%s\n" `cat results/BC_DEL_HS5-PT5 results/BC_DEL_HS5-GG5 results/BC_DEL_HS9-PT9 results/BC_DEL_HS9-GG9 results/BC_DEL_HS13-PT13 results/BC_DEL_HS13-GG13 results/BC_DEL_HS17-PT17 results/BC_DEL_HS17-GG17 | awk '{s+=$1}END{print s}'` >> DATAPN
  printf "MFCompress\t%s\n" `cat results/BC_MFC_HS5-PT5 results/BC_MFC_HS5-GG5 results/BC_MFC_HS9-PT9 results/BC_MFC_HS9-GG9 results/BC_MFC_HS13-PT13 results/BC_MFC_HS13-GG13 results/BC_MFC_HS17-PT17 results/BC_MFC_HS17-GG17 | awk '{s+=$1}END{print s}'` >> DATAPN
  printf "GeCo\t%s\n" `cat results/BC_GECO_REF_HS5-PT5 results/BC_GECO_REF_HS5-GG5 results/BC_GECO_REF_HS9-PT9 results/BC_GECO_REF_HS9-GG9 results/BC_GECO_REF_HS13-PT13 results/BC_GECO_REF_HS13-GG13 results/BC_GECO_REF_HS17-PT17 results/BC_GECO_REF_HS17-GG17 | awk '{s+=$1}END{print s}'` >> DATAPN
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
###############################################################################
