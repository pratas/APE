#!/bin/bash
#==============================================================================
#
# WARNING: YOU NEED APPROX. 100 GB OF FREE DISK
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
  cat HS* > DFGSERGF
  mv DFGSERGF HS
fi
#==============================================================================
if [[ "$GET_CHIMPANZEE" -eq "1" ]]; then
  . GetChimpParse.sh
  rm -f PT24 PT25 PT26 PT27
  cat PT* > DFGSERGF
  mv DFGSERGF PT
fi
#==============================================================================
if [[ "$GET_GORILLA" -eq "1" ]]; then
  . GetGorillaParse.sh
  rm -f GG24 GG25 
  cat GG* > DFGSERGF
  mv DFGSERGF GG
fi
#==============================================================================
if [[ "$GET_ORANGUTAN" -eq "1" ]]; then
  . GetOrangutanParse.sh
  rm -f PA24 PA25 PA26
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
  rm -f CJ24 CJ25 CJ26
  cat CJ* > DFGSERGF
  mv DFGSERGF CJ
fi
#==============================================================================
# GET MITOCHONDRIAS
if [[ "$GET_MTDNA" -eq "1" ]]; then
  . GetMTDNA.sh
  #
  cat MITO.fna | tr ' ' '_' \
  | ./goose-extractreadbypattern sapiens_mitoch > MT_HS.fa
  cat MITO.fna | tr ' ' '_' \
  | ./goose-extractreadbypattern troglodytes > MT_PT.fa
    cat MITO.fna | tr ' ' '_' \
  | ./goose-extractreadbypattern Gorilla_gorilla_gorilla > MT_GG.fa
    cat MITO.fna | tr ' ' '_' \
  | ./goose-extractreadbypattern abelii > MT_PA.fa
  cat MITO.fna | tr ' ' '_' \
  | ./goose-extractreadbypattern Nomascus_leucogenys > MT_GB.fa
  cat MITO.fna | tr ' ' '_' \
  | ./goose-extractreadbypattern Papio_anubis > MT_AN.fa
  cat MITO.fna | tr ' ' '_' \
  | ./goose-extractreadbypattern Callithrix jacchus > MT_CJ.fa
fi
#==============================================================================
###############################################################################
#==============================================================================









#==============================================================================
###############################################################################
#==============================================================================

