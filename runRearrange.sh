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
  rm -fr smash_contigs/
  git clone https://github.com/pratas/smash-contigs.git
  cd smash-contigs/src/
  cmake .
  make
  cp smash-map ../../
  cp smash-visual ../../
  cd ../../
fi
#==============================================================================
# GET MITOCHONDRIAS
if [[ "$GET_MTDNA" -eq "1" ]]; then
  #GET_PT
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Pan_troglodytes/Assembled_chromosomes/seq/ptr_ref_Pan_tro_3.0_chrMT.fa.gz
  zcat ptr_ref_Pan_tro_3.0_chrMT.fa.gz > PT.fa
  #GET_PA
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Pongo_abelii/Assembled_chromosomes/seq/pab_ref_P_pygmaeus_2.0.2_chrMT.fa.gz
  zcat pab_ref_P_pygmaeus_2.0.2_chrMT.fa.gz > PA.fa
  #
  . GetMTDNA.sh
  #
  cat MITO.fna | tr ' ' '_' | ./goose-extractreadbypattern sapiens_mitoch > HS.fa
  #cat MITO.fna | tr ' ' '_' | ./goose-extractreadbypattern troglodytes > PT.fa
  cat MITO.fna | tr ' ' '_' | ./goose-extractreadbypattern Gorilla_gorilla_gorilla > GG.fa
  #cat MITO.fna | tr ' ' '_' | ./goose-extractreadbypattern abelii > PA.fa
  cat MITO.fna | tr ' ' '_' | ./goose-extractreadbypattern Nomascus_leucogenys > GB.fa
  cat MITO.fna | tr ' ' '_' | ./goose-extractreadbypattern Papio_anubis > AN.fa
  cat MITO.fna | tr ' ' '_' | ./goose-extractreadbypattern Callithrix_jacchus > CJ.fa
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$RUN_MITO" -eq "1" ]]; then
  # MAP:
  ./smash-map -v -m 15 -n 4 -r 1000 -k 13 -o HSPT.pos HS.fa PT.fa ; 
  ./smash-map -v -m 15 -n 4 -r 1000 -k 13 -o HSGG.pos HS.fa GG.fa ; 
  ./smash-map -v -m 15 -n 4 -r 1000 -k 13 -o HSPA.pos HS.fa PA.fa ; 
  ./smash-map -v -m 15 -n 4 -r 1000 -k 13 -o HSGB.pos HS.fa GB.fa ; 
  ./smash-map -v -m 15 -n 4 -r 1000 -k 13 -o HSAN.pos HS.fa AN.fa ; 
  ./smash-map -v -m 15 -n 4 -r 1000 -k 13 -o HSCJ.pos HS.fa CJ.fa ; 
  #
  ./smash-map -v -m 15 -n 4 -r 1000 -k 13 -o PTGG.pos PT.fa GG.fa ;
  ./smash-map -v -m 15 -n 4 -r 1000 -k 13 -o GGPA.pos GG.fa PA.fa ;
  ./smash-map -v -m 15 -n 4 -r 1000 -k 13 -o PAGB.pos PA.fa GB.fa ;
  ./smash-map -v -m 15 -n 4 -r 1000 -k 13 -o GBAN.pos GB.fa AN.fa ;
  ./smash-map -v -m 15 -n 4 -r 1000 -k 13 -o ANCJ.pos AN.fa CJ.fa ;
  # VISUAL:
  ./smash-visual -v -l 2 -s 100 -c 1 -o HSPT.svg HSPT.pos
  ./smash-visual -v -l 2 -s 100 -c 1 -o HSGG.svg HSGG.pos
  ./smash-visual -v -l 2 -s 100 -c 1 -o HSPA.svg HSPA.pos
  ./smash-visual -v -l 2 -s 100 -c 1 -o HSGB.svg HSGB.pos
  ./smash-visual -v -l 2 -s 100 -c 1 -o HSAN.svg HSAN.pos
  ./smash-visual -v -l 2 -s 100 -c 1 -o HSCJ.svg HSCJ.pos
  # 
  ./smash-visual -v -l 2 -s 100 -c 1 -o PTGG.svg PTGG.pos
  ./smash-visual -v -l 2 -s 100 -c 1 -o GGPA.svg GGPA.pos
  ./smash-visual -v -l 2 -s 100 -c 1 -o PAGB.svg PAGB.pos
  ./smash-visual -v -l 2 -s 100 -c 1 -o GBAN.svg GBAN.pos
  ./smash-visual -v -l 2 -s 100 -c 1 -o ANCJ.svg ANCJ.pos
fi
#==============================================================================
###############################################################################
#==============================================================================
