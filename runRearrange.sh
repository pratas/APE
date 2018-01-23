#!/bin/bash
#==============================================================================
#
# WARNING: YOU NEED APPROX. 20 MB OF FREE DISK
#
# RUNNING FLAGS
GET_GOOSE=1;
#==============================================================================
GET_SMASH=1;
#==============================================================================
GET_MTDNA=1;
#==============================================================================
RUN_MITO=1;
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
if [[ "$GET_SMASH" -eq "1" ]]; then
  rm -fr smash/
  git clone https://github.com/pratas/smash.git
  cd smash/src/
  cmake .
  make
  cp SMASH ../../
  cd ../../
fi
#==============================================================================
# GET MITOCHONDRIAS
if [[ "$GET_MTDNA" -eq "1" ]]; then
  #GET_PT
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Pan_troglodytes/Assembled_chromosomes/seq/ptr_ref_Pan_tro_3.0_chrMT.fa.gz
  zcat ptr_ref_Pan_tro_3.0_chrMT.fa.gz | grep -v ">" | tr -d -c "ACGT" > MT_PT.seq
  #GET_PA
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Pongo_abelii/Assembled_chromosomes/seq/pab_ref_P_pygmaeus_2.0.2_chrMT.fa.gz
  zcat pab_ref_P_pygmaeus_2.0.2_chrMT.fa.gz | grep -v ">" | tr -d -c "ACGT" > MT_PA.seq
  #
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
  ./SMASH -v -f -c 20 -t 1.8 -m 5 -o HS-PT.svg MT_HS.seq MT_PT.seq
fi
#==============================================================================
###############################################################################
#==============================================================================
