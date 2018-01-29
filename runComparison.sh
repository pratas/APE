#!/bin/bash
#==============================================================================
#
# WARNING: YOU NEED APPROX. 1 GB OF FREE DISK
#
GET_GOOSE=1;
GET_GECO=1;
#==============================================================================
SIMULATE=0;
#==============================================================================
MUTATE=0;
#==============================================================================
RUN=0;
#==============================================================================
PLOT=0;
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
if [[ "$SIMULATE" -eq "1" ]]; then
  ./goose-genrandomdna -s 1 -n 1000000 > SAMPLE;  
  ./goose-extract -s 1 -l 900000 < SAMPLE > SAMPLE_900000; 
  ./goose-extract -s 1 -l 800000 < SAMPLE > SAMPLE_800000; 
  ./goose-extract -s 1 -l 700000 < SAMPLE > SAMPLE_700000; 
  ./goose-extract -s 1 -l 600000 < SAMPLE > SAMPLE_600000; 
  ./goose-extract -s 1 -l 500000 < SAMPLE > SAMPLE_500000; 
  ./goose-extract -s 1 -l 400000 < SAMPLE > SAMPLE_400000; 
  ./goose-extract -s 1 -l 300000 < SAMPLE > SAMPLE_300000; 
  ./goose-extract -s 1 -l 200000 < SAMPLE > SAMPLE_200000; 
  ./goose-extract -s 1 -l 100000 < SAMPLE > SAMPLE_100000; 
fi
#==============================================================================
if [[ "$MUTATE" -eq "1" ]]; then
  # 900k
  ./goose-mutatedna -mr 0.00 < SAMPLE_900000 > SAMPLE_900000_0
  ./goose-mutatedna -mr 0.05 < SAMPLE_900000 > SAMPLE_900000_5
  ./goose-mutatedna -mr 0.10 < SAMPLE_900000 > SAMPLE_900000_10
  ./goose-mutatedna -mr 0.15 < SAMPLE_900000 > SAMPLE_900000_15
  ./goose-mutatedna -mr 0.20 < SAMPLE_900000 > SAMPLE_900000_20
  ./goose-mutatedna -mr 0.25 < SAMPLE_900000 > SAMPLE_900000_25
  ./goose-mutatedna -mr 0.30 < SAMPLE_900000 > SAMPLE_900000_30
  ./goose-mutatedna -mr 0.35 < SAMPLE_900000 > SAMPLE_900000_35
  ./goose-mutatedna -mr 0.40 < SAMPLE_900000 > SAMPLE_900000_40
  ./goose-mutatedna -mr 0.45 < SAMPLE_900000 > SAMPLE_900000_45
  ./goose-mutatedna -mr 0.50 < SAMPLE_900000 > SAMPLE_900000_50
  # 800k 
  ./goose-mutatedna -mr 0.00 < SAMPLE_800000 > SAMPLE_800000_0
  ./goose-mutatedna -mr 0.05 < SAMPLE_800000 > SAMPLE_800000_5
  ./goose-mutatedna -mr 0.10 < SAMPLE_800000 > SAMPLE_800000_10
  ./goose-mutatedna -mr 0.15 < SAMPLE_800000 > SAMPLE_800000_15
  ./goose-mutatedna -mr 0.20 < SAMPLE_800000 > SAMPLE_800000_20
  ./goose-mutatedna -mr 0.25 < SAMPLE_800000 > SAMPLE_800000_25
  ./goose-mutatedna -mr 0.30 < SAMPLE_800000 > SAMPLE_800000_30
  ./goose-mutatedna -mr 0.35 < SAMPLE_800000 > SAMPLE_800000_35
  ./goose-mutatedna -mr 0.40 < SAMPLE_800000 > SAMPLE_800000_40
  ./goose-mutatedna -mr 0.45 < SAMPLE_800000 > SAMPLE_800000_45
  ./goose-mutatedna -mr 0.50 < SAMPLE_800000 > SAMPLE_800000_50
  # 700k
  ./goose-mutatedna -mr 0.00 < SAMPLE_700000 > SAMPLE_700000_0
  ./goose-mutatedna -mr 0.05 < SAMPLE_700000 > SAMPLE_700000_5
  ./goose-mutatedna -mr 0.10 < SAMPLE_700000 > SAMPLE_700000_10
  ./goose-mutatedna -mr 0.15 < SAMPLE_700000 > SAMPLE_700000_15
  ./goose-mutatedna -mr 0.20 < SAMPLE_700000 > SAMPLE_700000_20
  ./goose-mutatedna -mr 0.25 < SAMPLE_700000 > SAMPLE_700000_25
  ./goose-mutatedna -mr 0.30 < SAMPLE_700000 > SAMPLE_700000_30
  ./goose-mutatedna -mr 0.35 < SAMPLE_700000 > SAMPLE_700000_35
  ./goose-mutatedna -mr 0.40 < SAMPLE_700000 > SAMPLE_700000_40
  ./goose-mutatedna -mr 0.45 < SAMPLE_700000 > SAMPLE_700000_45
  ./goose-mutatedna -mr 0.50 < SAMPLE_700000 > SAMPLE_700000_50
  # 600k
  ./goose-mutatedna -mr 0.00 < SAMPLE_600000 > SAMPLE_600000_0
  ./goose-mutatedna -mr 0.05 < SAMPLE_600000 > SAMPLE_600000_5
  ./goose-mutatedna -mr 0.10 < SAMPLE_600000 > SAMPLE_600000_10
  ./goose-mutatedna -mr 0.15 < SAMPLE_600000 > SAMPLE_600000_15
  ./goose-mutatedna -mr 0.20 < SAMPLE_600000 > SAMPLE_600000_20
  ./goose-mutatedna -mr 0.25 < SAMPLE_600000 > SAMPLE_600000_25
  ./goose-mutatedna -mr 0.30 < SAMPLE_600000 > SAMPLE_600000_30
  ./goose-mutatedna -mr 0.35 < SAMPLE_600000 > SAMPLE_600000_35
  ./goose-mutatedna -mr 0.40 < SAMPLE_600000 > SAMPLE_600000_40
  ./goose-mutatedna -mr 0.45 < SAMPLE_600000 > SAMPLE_600000_45
  ./goose-mutatedna -mr 0.50 < SAMPLE_600000 > SAMPLE_600000_50
  # 500k
  ./goose-mutatedna -mr 0.00 < SAMPLE_500000 > SAMPLE_500000_0
  ./goose-mutatedna -mr 0.05 < SAMPLE_500000 > SAMPLE_500000_5
  ./goose-mutatedna -mr 0.10 < SAMPLE_500000 > SAMPLE_500000_10
  ./goose-mutatedna -mr 0.15 < SAMPLE_500000 > SAMPLE_500000_15
  ./goose-mutatedna -mr 0.20 < SAMPLE_500000 > SAMPLE_500000_20
  ./goose-mutatedna -mr 0.25 < SAMPLE_500000 > SAMPLE_500000_25
  ./goose-mutatedna -mr 0.30 < SAMPLE_500000 > SAMPLE_500000_30
  ./goose-mutatedna -mr 0.35 < SAMPLE_500000 > SAMPLE_500000_35
  ./goose-mutatedna -mr 0.40 < SAMPLE_500000 > SAMPLE_500000_40
  ./goose-mutatedna -mr 0.45 < SAMPLE_500000 > SAMPLE_500000_45
  ./goose-mutatedna -mr 0.50 < SAMPLE_500000 > SAMPLE_500000_50
  # 400k
  ./goose-mutatedna -mr 0.00 < SAMPLE_400000 > SAMPLE_400000_0
  ./goose-mutatedna -mr 0.05 < SAMPLE_400000 > SAMPLE_400000_5
  ./goose-mutatedna -mr 0.10 < SAMPLE_400000 > SAMPLE_400000_10
  ./goose-mutatedna -mr 0.15 < SAMPLE_400000 > SAMPLE_400000_15
  ./goose-mutatedna -mr 0.20 < SAMPLE_400000 > SAMPLE_400000_20
  ./goose-mutatedna -mr 0.25 < SAMPLE_400000 > SAMPLE_400000_25
  ./goose-mutatedna -mr 0.30 < SAMPLE_400000 > SAMPLE_400000_30
  ./goose-mutatedna -mr 0.35 < SAMPLE_400000 > SAMPLE_400000_35
  ./goose-mutatedna -mr 0.40 < SAMPLE_400000 > SAMPLE_400000_40
  ./goose-mutatedna -mr 0.45 < SAMPLE_400000 > SAMPLE_400000_45
  ./goose-mutatedna -mr 0.50 < SAMPLE_400000 > SAMPLE_400000_50
  # 300k
  ./goose-mutatedna -mr 0.00 < SAMPLE_300000 > SAMPLE_300000_0
  ./goose-mutatedna -mr 0.05 < SAMPLE_300000 > SAMPLE_300000_5
  ./goose-mutatedna -mr 0.10 < SAMPLE_300000 > SAMPLE_300000_10
  ./goose-mutatedna -mr 0.15 < SAMPLE_300000 > SAMPLE_300000_15
  ./goose-mutatedna -mr 0.20 < SAMPLE_300000 > SAMPLE_300000_20
  ./goose-mutatedna -mr 0.25 < SAMPLE_300000 > SAMPLE_300000_25
  ./goose-mutatedna -mr 0.30 < SAMPLE_300000 > SAMPLE_300000_30
  ./goose-mutatedna -mr 0.35 < SAMPLE_300000 > SAMPLE_300000_35
  ./goose-mutatedna -mr 0.40 < SAMPLE_300000 > SAMPLE_300000_40
  ./goose-mutatedna -mr 0.45 < SAMPLE_300000 > SAMPLE_300000_45
  ./goose-mutatedna -mr 0.50 < SAMPLE_300000 > SAMPLE_300000_50
  # 200k
  ./goose-mutatedna -mr 0.00 < SAMPLE_200000 > SAMPLE_200000_0
  ./goose-mutatedna -mr 0.05 < SAMPLE_200000 > SAMPLE_200000_5
  ./goose-mutatedna -mr 0.10 < SAMPLE_200000 > SAMPLE_200000_10
  ./goose-mutatedna -mr 0.15 < SAMPLE_200000 > SAMPLE_200000_15
  ./goose-mutatedna -mr 0.20 < SAMPLE_200000 > SAMPLE_200000_20
  ./goose-mutatedna -mr 0.25 < SAMPLE_200000 > SAMPLE_200000_25
  ./goose-mutatedna -mr 0.30 < SAMPLE_200000 > SAMPLE_200000_30
  ./goose-mutatedna -mr 0.35 < SAMPLE_200000 > SAMPLE_200000_35
  ./goose-mutatedna -mr 0.40 < SAMPLE_200000 > SAMPLE_200000_40
  ./goose-mutatedna -mr 0.45 < SAMPLE_200000 > SAMPLE_200000_45
  ./goose-mutatedna -mr 0.50 < SAMPLE_200000 > SAMPLE_200000_50
  # 100k
  ./goose-mutatedna -mr 0.00 < SAMPLE_100000 > SAMPLE_100000_0
  ./goose-mutatedna -mr 0.05 < SAMPLE_100000 > SAMPLE_100000_5
  ./goose-mutatedna -mr 0.10 < SAMPLE_100000 > SAMPLE_100000_10
  ./goose-mutatedna -mr 0.15 < SAMPLE_100000 > SAMPLE_100000_15
  ./goose-mutatedna -mr 0.20 < SAMPLE_100000 > SAMPLE_100000_20
  ./goose-mutatedna -mr 0.25 < SAMPLE_100000 > SAMPLE_100000_25
  ./goose-mutatedna -mr 0.30 < SAMPLE_100000 > SAMPLE_100000_30
  ./goose-mutatedna -mr 0.35 < SAMPLE_100000 > SAMPLE_100000_35
  ./goose-mutatedna -mr 0.40 < SAMPLE_100000 > SAMPLE_100000_40
  ./goose-mutatedna -mr 0.45 < SAMPLE_100000 > SAMPLE_100000_45
  ./goose-mutatedna -mr 0.50 < SAMPLE_100000 > SAMPLE_100000_50
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$RUN" -eq "1" ]]; then
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_900000_0 SAMPLE_100000_0) &> REPORT_900k_0_100k_0
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_900000_0 SAMPLE_100000_5) &> REPORT_900k_0_100k_5
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_900000_0 SAMPLE_100000_10) &> REPORT_900k_0_100k_10
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_900000_0 SAMPLE_100000_15) &> REPORT_900k_0_100k_15
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_900000_0 SAMPLE_100000_20) &> REPORT_900k_0_100k_20
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_900000_0 SAMPLE_100000_25) &> REPORT_900k_0_100k_25    
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_900000_0 SAMPLE_100000_30) &> REPORT_900k_0_100k_30
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_900000_0 SAMPLE_100000_35) &> REPORT_900k_0_100k_35
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_900000_0 SAMPLE_100000_40) &> REPORT_900k_0_100k_40
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_900000_0 SAMPLE_100000_45) &> REPORT_900k_0_100k_45
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_900000_0 SAMPLE_100000_50) &> REPORT_900k_0_100k_50
  #
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_800000_0 SAMPLE_200000_0) &> REPORT_800k_0_200k_0
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_800000_0 SAMPLE_200000_5) &> REPORT_800k_0_200k_5
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_800000_0 SAMPLE_200000_10) &> REPORT_800k_0_200k_10
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_800000_0 SAMPLE_200000_15) &> REPORT_800k_0_200k_15
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_800000_0 SAMPLE_200000_20) &> REPORT_800k_0_200k_20
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_800000_0 SAMPLE_200000_25) &> REPORT_800k_0_200k_25    
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_800000_0 SAMPLE_200000_30) &> REPORT_800k_0_200k_30
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_800000_0 SAMPLE_200000_35) &> REPORT_800k_0_200k_35
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_800000_0 SAMPLE_200000_40) &> REPORT_800k_0_200k_40
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_800000_0 SAMPLE_200000_45) &> REPORT_800k_0_200k_45
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_800000_0 SAMPLE_200000_50) &> REPORT_800k_0_200k_50
  # 
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_700000_0 SAMPLE_300000_0) &> REPORT_700k_0_300k_0
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_700000_0 SAMPLE_300000_5) &> REPORT_700k_0_300k_5
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_700000_0 SAMPLE_300000_10) &> REPORT_700k_0_300k_10
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_700000_0 SAMPLE_300000_15) &> REPORT_700k_0_300k_15
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_700000_0 SAMPLE_300000_20) &> REPORT_700k_0_300k_20
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_700000_0 SAMPLE_300000_25) &> REPORT_700k_0_300k_25
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_700000_0 SAMPLE_300000_30) &> REPORT_700k_0_300k_30
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_700000_0 SAMPLE_300000_35) &> REPORT_700k_0_300k_35
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_700000_0 SAMPLE_300000_40) &> REPORT_700k_0_300k_40
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_700000_0 SAMPLE_300000_45) &> REPORT_700k_0_300k_45
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_700000_0 SAMPLE_300000_50) &> REPORT_700k_0_300k_50    
  # 
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_600000_0 SAMPLE_400000_0) &> REPORT_600k_0_400k_0
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_600000_0 SAMPLE_400000_5) &> REPORT_600k_0_400k_5
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_600000_0 SAMPLE_400000_10) &> REPORT_600k_0_400k_10
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_600000_0 SAMPLE_400000_15) &> REPORT_600k_0_400k_15
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_600000_0 SAMPLE_400000_20) &> REPORT_600k_0_400k_20
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_600000_0 SAMPLE_400000_25) &> REPORT_600k_0_400k_25
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_600000_0 SAMPLE_400000_30) &> REPORT_600k_0_400k_30
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_600000_0 SAMPLE_400000_35) &> REPORT_600k_0_400k_35
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_600000_0 SAMPLE_400000_40) &> REPORT_600k_0_400k_40
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_600000_0 SAMPLE_400000_45) &> REPORT_600k_0_400k_45
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_600000_0 SAMPLE_400000_50) &> REPORT_600k_0_400k_50
  #
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_500000_0 SAMPLE_500000_0) &> REPORT_500k_0_500k_0
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_500000_0 SAMPLE_500000_5) &> REPORT_500k_0_500k_5
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_500000_0 SAMPLE_500000_10) &> REPORT_500k_0_500k_10
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_500000_0 SAMPLE_500000_15) &> REPORT_500k_0_500k_15
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_500000_0 SAMPLE_500000_20) &> REPORT_500k_0_500k_20
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_500000_0 SAMPLE_500000_25) &> REPORT_500k_0_500k_25
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_500000_0 SAMPLE_500000_30) &> REPORT_500k_0_500k_30
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_500000_0 SAMPLE_500000_35) &> REPORT_500k_0_500k_35
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_500000_0 SAMPLE_500000_40) &> REPORT_500k_0_500k_40
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_500000_0 SAMPLE_500000_45) &> REPORT_500k_0_500k_45
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_500000_0 SAMPLE_500000_50) &> REPORT_500k_0_500k_50
  #
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_400000_0 SAMPLE_600000_0) &> REPORT_400k_0_600k_0
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_400000_0 SAMPLE_600000_5) &> REPORT_400k_0_600k_5
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_400000_0 SAMPLE_600000_10) &> REPORT_400k_0_600k_10
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_400000_0 SAMPLE_600000_15) &> REPORT_400k_0_600k_15
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_400000_0 SAMPLE_600000_20) &> REPORT_400k_0_600k_20
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_400000_0 SAMPLE_600000_25) &> REPORT_400k_0_600k_25
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_400000_0 SAMPLE_600000_30) &> REPORT_400k_0_600k_30
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_400000_0 SAMPLE_600000_35) &> REPORT_400k_0_600k_35
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_400000_0 SAMPLE_600000_40) &> REPORT_400k_0_600k_40
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_400000_0 SAMPLE_600000_45) &> REPORT_400k_0_600k_45
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_400000_0 SAMPLE_600000_50) &> REPORT_400k_0_600k_50
  #
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_300000_0 SAMPLE_700000_0) &> REPORT_300k_0_700k_0
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_300000_0 SAMPLE_700000_5) &> REPORT_300k_0_700k_5
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_300000_0 SAMPLE_700000_10) &> REPORT_300k_0_700k_10
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_300000_0 SAMPLE_700000_15) &> REPORT_300k_0_700k_15
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_300000_0 SAMPLE_700000_20) &> REPORT_300k_0_700k_20
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_300000_0 SAMPLE_700000_25) &> REPORT_300k_0_700k_25
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_300000_0 SAMPLE_700000_30) &> REPORT_300k_0_700k_30
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_300000_0 SAMPLE_700000_35) &> REPORT_300k_0_700k_35
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_300000_0 SAMPLE_700000_40) &> REPORT_300k_0_700k_40
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_300000_0 SAMPLE_700000_45) &> REPORT_300k_0_700k_45
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_300000_0 SAMPLE_700000_50) &> REPORT_300k_0_700k_50
  #
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_200000_0 SAMPLE_800000_0) &> REPORT_200k_0_800k_0
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_200000_0 SAMPLE_800000_5) &> REPORT_200k_0_800k_5
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_200000_0 SAMPLE_800000_10) &> REPORT_200k_0_800k_10
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_200000_0 SAMPLE_800000_15) &> REPORT_200k_0_800k_15
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_200000_0 SAMPLE_800000_20) &> REPORT_200k_0_800k_20
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_200000_0 SAMPLE_800000_25) &> REPORT_200k_0_800k_25
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_200000_0 SAMPLE_800000_30) &> REPORT_200k_0_800k_30
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_200000_0 SAMPLE_800000_35) &> REPORT_200k_0_800k_35
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_200000_0 SAMPLE_800000_40) &> REPORT_200k_0_800k_40
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_200000_0 SAMPLE_800000_45) &> REPORT_200k_0_800k_45
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_200000_0 SAMPLE_800000_50) &> REPORT_200k_0_800k_50
  #
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_100000_0 SAMPLE_900000_0) &> REPORT_100k_0_900k_0
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_100000_0 SAMPLE_900000_5) &> REPORT_100k_0_900k_5
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_100000_0 SAMPLE_900000_10) &> REPORT_100k_0_900k_10
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_100000_0 SAMPLE_900000_15) &> REPORT_100k_0_900k_15
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_100000_0 SAMPLE_900000_20) &> REPORT_100k_0_900k_20
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_100000_0 SAMPLE_900000_25) &> REPORT_100k_0_900k_25
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_100000_0 SAMPLE_900000_30) &> REPORT_100k_0_900k_30
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_100000_0 SAMPLE_900000_35) &> REPORT_100k_0_900k_35
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_100000_0 SAMPLE_900000_40) &> REPORT_100k_0_900k_40
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_100000_0 SAMPLE_900000_45) &> REPORT_100k_0_900k_45
  (./GeCo -v -rm 14:200:0:5/10 -rm 11:100:0:1/1 -rm 6:10:0:0/0 -rm 3:1:0:0/0 -g 0.95 -r SAMPLE_100000_0 SAMPLE_900000_50) &> REPORT_100k_0_900k_50
fi
#==============================================================================
###############################################################################
#==============================================================================
if [[ "$PLOT" -eq "1" ]]; then
  chmod +x NCDcalc.sh
  #
  printf "1\t%s\n" `./NCDcalc.sh REPORT_NCD_MITO_HS REPORT_NCD_MITO_PT REPORT_NCD_MITO_HS_PT | awk '{printf "%f", $0}'` >  NCD_MT_VALUES;
  printf "2\t%s\n" `./NCDcalc.sh REPORT_NCD_MITO_HS REPORT_NCD_MITO_GG REPORT_NCD_MITO_HS_GG | awk '{printf "%f", $0}'` >> NCD_MT_VALUES;
  printf "3\t%s\n" `./NCDcalc.sh REPORT_NCD_MITO_HS REPORT_NCD_MITO_PA REPORT_NCD_MITO_HS_PA | awk '{printf "%f", $0}'` >> NCD_MT_VALUES;
  printf "4\t%s\n" `./NCDcalc.sh REPORT_NCD_MITO_HS REPORT_NCD_MITO_GB REPORT_NCD_MITO_HS_GB | awk '{printf "%f", $0}'` >> NCD_MT_VALUES;
  printf "5\t%s\n" `./NCDcalc.sh REPORT_NCD_MITO_HS REPORT_NCD_MITO_AN REPORT_NCD_MITO_HS_AN | awk '{printf "%f", $0}'` >> NCD_MT_VALUES;
  printf "6\t%s\n" `./NCDcalc.sh REPORT_NCD_MITO_HS REPORT_NCD_MITO_CJ REPORT_NCD_MITO_HS_CJ | awk '{printf "%f", $0}'` >> NCD_MT_VALUES;
  #
  printf "1\t%s\n" `./NCDcalc.sh REPORT_NCD_RNA_HS REPORT_NCD_RNA_PT REPORT_NCD_RNA_HS_PT | awk '{printf "%f", $0}'` >  NCD_RNA_VALUES;
  printf "2\t%s\n" `./NCDcalc.sh REPORT_NCD_RNA_HS REPORT_NCD_RNA_GG REPORT_NCD_RNA_HS_GG | awk '{printf "%f", $0}'` >> NCD_RNA_VALUES;
  printf "3\t%s\n" `./NCDcalc.sh REPORT_NCD_RNA_HS REPORT_NCD_RNA_PA REPORT_NCD_RNA_HS_PA | awk '{printf "%f", $0}'` >> NCD_RNA_VALUES;
  printf "4\t%s\n" `./NCDcalc.sh REPORT_NCD_RNA_HS REPORT_NCD_RNA_GB REPORT_NCD_RNA_HS_GB | awk '{printf "%f", $0}'` >> NCD_RNA_VALUES;
  printf "5\t%s\n" `./NCDcalc.sh REPORT_NCD_RNA_HS REPORT_NCD_RNA_AN REPORT_NCD_RNA_HS_AN | awk '{printf "%f", $0}'` >> NCD_RNA_VALUES;
  printf "6\t%s\n" `./NCDcalc.sh REPORT_NCD_RNA_HS REPORT_NCD_RNA_CJ REPORT_NCD_RNA_HS_CJ | awk '{printf "%f", $0}'` >> NCD_RNA_VALUES; 
  #
  printf "1\t%s\n" `./NCDcalc.sh REPORT_NCD_WGS_HS REPORT_WGS_RNA_PT REPORT_WGS_RNA_HS_PT | awk '{printf "%f", $0}'` >  NCD_WGS_VALUES;
  printf "2\t%s\n" `./NCDcalc.sh REPORT_NCD_WGS_HS REPORT_WGS_RNA_GG REPORT_WGS_RNA_HS_GG | awk '{printf "%f", $0}'` >> NCD_WGS_VALUES;
  printf "3\t%s\n" `./NCDcalc.sh REPORT_NCD_WGS_HS REPORT_WGS_RNA_PA REPORT_WGS_RNA_HS_PA | awk '{printf "%f", $0}'` >> NCD_WGS_VALUES;
  printf "4\t%s\n" `./NCDcalc.sh REPORT_NCD_WGS_HS REPORT_WGS_RNA_GB REPORT_WGS_RNA_HS_GB | awk '{printf "%f", $0}'` >> NCD_WGS_VALUES;
  printf "5\t%s\n" `./NCDcalc.sh REPORT_NCD_WGS_HS REPORT_WGS_RNA_AN REPORT_WGS_RNA_HS_AN | awk '{printf "%f", $0}'` >> NCD_WGS_VALUES;
  printf "6\t%s\n" `./NCDcalc.sh REPORT_NCD_WGS_HS REPORT_WGS_RNA_CJ REPORT_WGS_RNA_HS_CJ | awk '{printf "%f", $0}'` >> NCD_WGS_VALUES;

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
  set ylabel "NCD"
  set xlabel "Species"
  set border linewidth 1.5
  set style line 1 lc rgb '#0060ad' lt 1 lw 4 pt 5 ps 0.4 # --- blue
  set style line 2 lc rgb '#009900' lt 1 lw 4 pt 6 ps 0.4 # --- green
  set style line 3 lc rgb '#dd181f' lt 1 lw 4 pt 7 ps 0.5 # --- red
  plot "NCD_MT_VALUES"  with linespoints ls 1 title "mtDNA", "NCD_RNA_VALUES"  with linespoints ls 2 title "mRNA", "NCD_WGS_VALUES" with linespoints ls 3 title "ncDNA"
EOF

fi
