#!/bin/bash
#==============================================================================
#
# WARNING: YOU NEED APPROX. 40 GB OF FREE DISK
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
GET_MRNA=1
#==============================================================================
RUN_MITO=1;
RUN_MRNA=1;
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
  rm -f HS HS.co
  cat HS* > DFGSERGF
  mv DFGSERGF HS
fi
#==============================================================================
if [[ "$GET_CHIMPANZEE" -eq "1" ]]; then
  . GetChimpParse.sh
  rm -f PT PT.co PT24 PT25 PT26 PT27
  cat PT* > DFGSERGF
  mv DFGSERGF PT
fi
#==============================================================================
if [[ "$GET_GORILLA" -eq "1" ]]; then
  . GetGorillaParse.sh
  rm -f GG GG.co GG24 GG25
  cat GG* > DFGSERGF
  mv DFGSERGF GG
fi
#==============================================================================
if [[ "$GET_ORANGUTAN" -eq "1" ]]; then
  . GetOrangutanParse.sh
  rm -f PA PA.co PA24 PA25 PA26
  cat PA* > DFGSERGF
  mv DFGSERGF PA
fi
#==============================================================================
if [[ "$GET_GIBBON" -eq "1" ]]; then
  . GetGibbonParse.sh
  rm -f GB GB.co GB27 GB28
  cat GB* > DFGSERGF
  mv DFGSERGF GB
fi
#==============================================================================
if [[ "$GET_ANUBIS" -eq "1" ]]; then
  . GetAnubisParse.sh
  rm -f AN AN.co AN22
  cat AN* > DFGSERGF
  mv DFGSERGF AN
fi
#==============================================================================
if [[ "$GET_MARMOSET" -eq "1" ]]; then
  . GetCallithrixjacchus.sh
  rm -f CJ CJ.co CJ24 CJ25 CJ26
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
# GET MRNA
if [[ "$GET_MRNA" -eq "1" ]]; then
  wget -O HS-rna.fa.gz ftp://ftp.ncbi.nlm.nih.gov/genomes/Homo_sapiens/RNA/rna.fa.gz
  wget -O PT-rna.fa.gz ftp://ftp.ncbi.nlm.nih.gov/genomes/Pan_troglodytes/RNA/rna.fa.gz
  wget -O GG-rna.fa.gz ftp://ftp.ncbi.nlm.nih.gov/genomes/Gorilla_gorilla/RNA/rna.fa.gz
  wget -O PA-rna.fa.gz ftp://ftp.ncbi.nlm.nih.gov/genomes/Pongo_abelii/RNA/rna.fa.gz
  wget -O GB-rna.fa.gz ftp://ftp.ncbi.nlm.nih.gov/genomes/Nomascus_leucogenys/RNA/rna.fa.gz
  wget -O AN-rna.fa.gz ftp://ftp.ncbi.nlm.nih.gov/genomes/Papio_anubis/RNA/rna.fa.gz
  wget -O CJ-rna.fa.gz ftp://ftp.ncbi.nlm.nih.gov/genomes/Callithrix_jacchus/RNA/rna.fa.gz
  #
  zcat HS-rna.fa.gz | grep -v ">" | tr -d -c "ACGT" > RNA_HS.seq
  zcat PT-rna.fa.gz | grep -v ">" | tr -d -c "ACGT" > RNA_PT.seq
  zcat GG-rna.fa.gz | grep -v ">" | tr -d -c "ACGT" > RNA_GG.seq
  zcat PA-rna.fa.gz | grep -v ">" | tr -d -c "ACGT" > RNA_PA.seq
  zcat GB-rna.fa.gz | grep -v ">" | tr -d -c "ACGT" > RNA_GB.seq
  zcat AN-rna.fa.gz | grep -v ">" | tr -d -c "ACGT" > RNA_AN.seq
  zcat CJ-rna.fa.gz | grep -v ">" | tr -d -c "ACGT" > RNA_CJ.seq
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$RUN_MITO" -eq "1" ]]; then
  (./GeCo -v -tm 13:200:1:5/10 -tm 10:100:1:0/0 -tm 6:1:0:0/0 -tm 3:1:0:0/0 -c 10 -g 0.95 MT_HS.seq ) &> REPORT_NCD_MITO_HS
  (./GeCo -v -tm 13:200:1:5/10 -tm 10:100:1:0/0 -tm 6:1:0:0/0 -tm 3:1:0:0/0 -c 10 -g 0.95 MT_PT.seq ) &> REPORT_NCD_MITO_PT
  (./GeCo -v -tm 13:200:1:5/10 -tm 10:100:1:0/0 -tm 6:1:0:0/0 -tm 3:1:0:0/0 -c 10 -g 0.95 MT_GG.seq ) &> REPORT_NCD_MITO_GG
  (./GeCo -v -tm 13:200:1:5/10 -tm 10:100:1:0/0 -tm 6:1:0:0/0 -tm 3:1:0:0/0 -c 10 -g 0.95 MT_PA.seq ) &> REPORT_NCD_MITO_PA
  (./GeCo -v -tm 13:200:1:5/10 -tm 10:100:1:0/0 -tm 6:1:0:0/0 -tm 3:1:0:0/0 -c 10 -g 0.95 MT_GB.seq ) &> REPORT_NCD_MITO_GB
  (./GeCo -v -tm 13:200:1:5/10 -tm 10:100:1:0/0 -tm 6:1:0:0/0 -tm 3:1:0:0/0 -c 10 -g 0.95 MT_AN.seq ) &> REPORT_NCD_MITO_AN
  (./GeCo -v -tm 13:200:1:5/10 -tm 10:100:1:0/0 -tm 6:1:0:0/0 -tm 3:1:0:0/0 -c 10 -g 0.95 MT_CJ.seq ) &> REPORT_NCD_MITO_CJ
  cat MT_HS.seq MT_HS.seq > MT_HS_HS.seq
  (./GeCo -v -tm 13:200:1:5/10 -tm 10:100:1:0/0 -tm 6:1:0:0/0 -tm 3:1:0:0/0 -c 10 -g 0.95 MT_HS_HS.seq ) &> REPORT_NCD_MITO_HS_HS
  cat MT_HS.seq MT_PT.seq > MT_HS_PT.seq
  (./GeCo -v -tm 13:200:1:5/10 -tm 10:100:1:0/0 -tm 6:1:0:0/0 -tm 3:1:0:0/0 -c 10 -g 0.95 MT_HS_PT.seq ) &> REPORT_NCD_MITO_HS_PT
  cat MT_HS.seq MT_GG.seq > MT_HS_GG.seq
  (./GeCo -v -tm 13:200:1:5/10 -tm 10:100:1:0/0 -tm 6:1:0:0/0 -tm 3:1:0:0/0 -c 10 -g 0.95 MT_HS_GG.seq ) &> REPORT_NCD_MITO_HS_GG
  cat MT_HS.seq MT_PA.seq > MT_HS_PA.seq
  (./GeCo -v -tm 13:200:1:5/10 -tm 10:100:1:0/0 -tm 6:1:0:0/0 -tm 3:1:0:0/0 -c 10 -g 0.95 MT_HS_PA.seq ) &> REPORT_NCD_MITO_HS_PA
  cat MT_HS.seq MT_GB.seq > MT_HS_GB.seq
  (./GeCo -v -tm 13:200:1:5/10 -tm 10:100:1:0/0 -tm 6:1:0:0/0 -tm 3:1:0:0/0 -c 10 -g 0.95 MT_HS_GB.seq ) &> REPORT_NCD_MITO_HS_GB
  cat MT_HS.seq MT_AN.seq > MT_HS_AN.seq
  (./GeCo -v -tm 13:200:1:5/10 -tm 10:100:1:0/0 -tm 6:1:0:0/0 -tm 3:1:0:0/0 -c 10 -g 0.95 MT_HS_AN.seq ) &> REPORT_NCD_MITO_HS_AN
  cat MT_HS.seq MT_CJ.seq > MT_HS_CJ.seq
  (./GeCo -v -tm 13:200:1:5/10 -tm 10:100:1:0/0 -tm 6:1:0:0/0 -tm 3:1:0:0/0 -c 10 -g 0.95 MT_HS_CJ.seq ) &> REPORT_NCD_MITO_HS_CJ
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$RUN_WGS" -eq "1" ]]; then
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 HS ) &> REPORT_NCD_WGS_HS
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 PT ) &> REPORT_NCD_WGS_PT
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 GG ) &> REPORT_NCD_WGS_GG
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 PA ) &> REPORT_NCD_WGS_PA
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 GB ) &> REPORT_NCD_WGS_GB
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 AN ) &> REPORT_NCD_WGS_AN
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 CJ ) &> REPORT_NCD_WGS_CJ
  cat HS HS > HS_HS
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 HS_HS ) &> REPORT_NCD_WGS_HS_HS
  cat HS PT > HS_PT
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 HS_PT ) &> REPORT_NCD_WGS_HS_PT
  cat HS GG > HS_GG
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 HS_GG ) &> REPORT_NCD_WGS_HS_GG
  cat HS PA > HS_PA
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 HS_PA ) &> REPORT_NCD_WGS_HS_PA
  cat HS GB > HS_GB
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 HS_GB ) &> REPORT_NCD_WGS_HS_GB
  cat HS AN > HS_AN
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 HS_AN ) &> REPORT_NCD_WGS_HS_AN
  cat HS CJ > HS_CJ
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 HS_CJ ) &> REPORT_NCD_WGS_HS_CJ
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$RUN_MRNA" -eq "1" ]]; then
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 RNA_HS.seq ) &> REPORT_NCD_RNA_HS
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 RNA_PT.seq ) &> REPORT_NCD_RNA_PT
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 RNA_GG.seq ) &> REPORT_NCD_RNA_GG
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 RNA_PA.seq ) &> REPORT_NCD_RNA_PA
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 RNA_GB.seq ) &> REPORT_NCD_RNA_GB
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 RNA_AN.seq ) &> REPORT_NCD_RNA_AN
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 RNA_CJ.seq ) &> REPORT_NCD_RNA_CJ
  #
  cat RNA_HS.seq RNA_HS.seq > RNA_HS.seq_RNA_HS.seq
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 RNA_HS.seq_RNA_HS.seq ) &> REPORT_NCD_RNA_HS_HS
  #
  cat RNA_HS.seq RNA_PT.seq > RNA_HS.seq_RNA_PT.seq
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 RNA_HS.seq_RNA_PT.seq ) &> REPORT_NCD_RNA_HS_PT
  #
  cat RNA_HS.seq RNA_GG.seq > RNA_HS.seq_RNA_GG.seq
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 RNA_HS.seq_RNA_GG.seq ) &> REPORT_NCD_RNA_HS_GG
  #
  cat RNA_HS.seq RNA_PA.seq > RNA_HS.seq_RNA_PA.seq
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 RNA_HS.seq_RNA_PA.seq ) &> REPORT_NCD_RNA_HS_PA
  #
  cat RNA_HS.seq RNA_GB.seq > RNA_HS.seq_RNA_GB.seq
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 RNA_HS.seq_RNA_GB.seq ) &> REPORT_NCD_RNA_HS_GB
  #
  cat RNA_HS.seq RNA_AN.seq > RNA_HS.seq_RNA_AN.seq
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 RNA_HS.seq_RNA_AN.seq ) &> REPORT_NCD_RNA_HS_AN
  #
  cat RNA_HS.seq RNA_CJ.seq > RNA_HS.seq_RNA_CJ.seq
  (./GeCo -v -tm 20:200:1:5/10 -tm 14:50:1:0/0 -tm 13:20:0:0/0 -tm 11:10:0:0/0 -tm 9:1:0:0/0 -tm 4:1:0:0/0 -c 200 -g 0.88 RNA_HS.seq_RNA_CJ.seq ) &> REPORT_NCD_RNA_HS_CJ
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$PLOT" -eq "1" ]]; then
  cat REPORT_NCD_MITO_HS | grep "compressed bytes" | awk '{ print $12;}' | tail -n 6 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_MT_VALUES
  cat REPORT_NCD_MITO_HS | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_MT_VALUES_HS
  cat REPORT_NCD_MITO_PT | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_MT_VALUES_PT
  cat REPORT_NCD_MITO_GG | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_MT_VALUES_GG
  cat REPORT_NCD_MITO_PA | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_MT_VALUES_PA
  cat REPORT_NCD_MITO_GB | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_MT_VALUES_GB
  cat REPORT_NCD_MITO_AN | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_MT_VALUES_AN
  cat REPORT_NCD_MITO_CJ | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_MT_VALUES_CJ
  #
  cat REPORT_NCD_RNA_HS | grep "compressed bytes" | awk '{ print $12;}' | tail -n 6 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_RNA_VALUES
  cat REPORT_NCD_RNA_HS | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_RNA_VALUES_HS
  cat REPORT_NCD_RNA_PT | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_RNA_VALUES_PT
  cat REPORT_NCD_RNA_GG | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_RNA_VALUES_GG
  cat REPORT_NCD_RNA_PA | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_RNA_VALUES_PA
  cat REPORT_NCD_RNA_GB | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_RNA_VALUES_GB
  cat REPORT_NCD_RNA_AN | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_RNA_VALUES_AN
  cat REPORT_NCD_RNA_CJ | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_RNA_VALUES_CJ
  #
  cat REPORT_NCD_WGS_HS | grep "compressed bytes" | awk '{ print $12;}' | tail -n 6 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_WGS_VALUES
  cat REPORT_NCD_WGS_HS | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_WGS_VALUES_HS
  cat REPORT_NCD_WGS_PT | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_WGS_VALUES_PT
  cat REPORT_NCD_WGS_GG | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_WGS_VALUES_GG
  cat REPORT_NCD_WGS_PA | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_WGS_VALUES_PA
  cat REPORT_NCD_WGS_GB | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_WGS_VALUES_GB
  cat REPORT_NCD_WGS_AN | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_WGS_VALUES_AN
  cat REPORT_NCD_WGS_CJ | grep "compressed bytes" | awk '{ print $12;}' | tail -n 7 | awk '{printf("%d\t%s\n", NR, $0)}' > NCD_WGS_VALUES_CJ

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
  set style line 2 lc rgb '#009900' lt 1 lw 4 pt 6 ps 0.4 # --- green
  set style line 3 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "NCD_MT_VALUES"  with linespoints ls 1 title "mtDNA", "NCD_RNA_VALUES"  with linespoints ls 2 title "mRNA", "NCD_WGS_VALUES" with linespoints ls 3 title "ncDNA"
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
  set style line 2 lc rgb '#009900' lt 1 lw 4 pt 6 ps 0.4 # --- green
  set style line 3 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "NCD_MT_VALUES_HS"  with linespoints ls 1 title "mtDNA", "NCD_RNA_VALUES_HS"  with linespoints ls 2 title "mRNA", "NCD_WGS_VALUES_HS" with linespoints ls 3 title "ncDNA"
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
  set style line 2 lc rgb '#009900' lt 1 lw 4 pt 6 ps 0.4 # --- green
  set style line 3 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "NCD_MT_VALUES_PT"  with linespoints ls 1 title "mtDNA", "NCD_RNA_VALUES_PT"  with linespoints ls 2 title "mRNA", "NCD_WGS_VALUES_PT" with linespoints ls 3 title "ncDNA"
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
  set style line 2 lc rgb '#009900' lt 1 lw 4 pt 6 ps 0.4 # --- green
  set style line 3 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "NCD_MT_VALUES_GG"  with linespoints ls 1 title "mtDNA", "NCD_RNA_VALUES_GG"  with linespoints ls 2 title "mRNA", "NCD_WGS_VALUES_GG" with linespoints ls 3 title "ncDNA"
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
  set style line 2 lc rgb '#009900' lt 1 lw 4 pt 6 ps 0.4 # --- green
  set style line 3 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "NCD_MT_VALUES_PA"  with linespoints ls 1 title "mtDNA", "NCD_RNA_VALUES_PA"  with linespoints ls 2 title "mRNA", "NCD_WGS_VALUES_PA" with linespoints ls 3 title "ncDNA"
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
  set style line 2 lc rgb '#009900' lt 1 lw 4 pt 6 ps 0.4 # --- green
  set style line 3 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "NCD_MT_VALUES_GB"  with linespoints ls 1 title "mtDNA", "NCD_RNA_VALUES_GB"  with linespoints ls 2 title "mRNA", "NCD_WGS_VALUES_GB" with linespoints ls 3 title "ncDNA"
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
  set xtics ("Human" 1, "Chimpanzee" 2, "Gorilla" 3, "Orangutan" 4, "Gibbon" 5, "Babbon" 6, "Marmoset" 7);
  set yrange [0:1] 
  set xrange [0.5:7.5] 
  set ytics 0.2
  set grid 
  set xtics rotate by -30
  set ylabel "NRC"
  set xlabel "Species"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#009900' lt 1 lw 4 pt 6 ps 0.4 # --- green
  set style line 3 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "NCD_MT_VALUES_AN"  with linespoints ls 1 title "mtDNA", "NCD_RNA_VALUES_AN"  with linespoints ls 2 title "mRNA", "NCD_WGS_VALUES_AN" with linespoints ls 3 title "ncDNA"
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
  set style line 2 lc rgb '#009900' lt 1 lw 4 pt 6 ps 0.4 # --- green
  set style line 3 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "NCD_MT_VALUES_CJ"  with linespoints ls 1 title "mtDNA", "NCD_RNA_VALUES_CJ"  with linespoints ls 2 title "mRNA", "NCD_WGS_VALUES_CJ" with linespoints ls 3 title "ncDNA"
EOF

fi
