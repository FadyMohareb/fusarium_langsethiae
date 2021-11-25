#!/bin/bash

#run flye with raw data 
flye -pacbio-raw /home/fady/Code/01rawData/subreads.fasta -genome-size 37.5m -out-dir /home/fady/Code/02assembly/flye/raw/

#draft assembly file would be : /flye/raw/assembly.fasta
