#!/bin/bash

#extract tar file 
tar -xvf Flang_rawdata.tar

#use samtools to convert bam file to fasta file
module load samtools
samtools bam2fq /home/fady/Code/01rawData/P101HW18100423_20181101/1_A05/m54212_181029_091055.subreads.bam > /home/fady/Code/01rawData/subreads.fasta
