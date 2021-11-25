#!/bash/bin

module load samtools

#prepare the index of draft assembly
ln -s /home/fady/Code/02assembly/flye/raw/assembly.fasta
bwa index assembly.fasta
bwa mem -x pacbio assembly.fasta /home/fady/Code/00Fl201059/Fusarium_langsethiae_gca_001292635.ASM129263v1.cdna.all.fa > alignment.sam

#check the similarity between RNA and assembly file 
samtools view -c alignment.sam #15280 sequence total 
samtools view -c -F 4 alignment.sam # 14712 matched
#So the rna file can be use in further polish and prediction. 

#polishing 
#create a .bam formatted file with all the alignments
bwa mem assembly.fasta /home/fady/Code/00Fl201059/Fusarium_langsethiae_gca_001292635.ASM129263v1.cdna.all.fa | samtools view -bS -> rna_align.bam

#sort
samtools sort rna_align.bam -o rna_alignsorted.bam

#index the alignment file
samtools index rna_alignsorted.bam

#polish the draft assembly 
java -jar /home/fady/pilon/pilon-1.23.jar  --unpaired rna_alignsorted.bam --genome /home/fady/Code/02assembly/flye/raw/assembly.fasta --output flang_piloned --tracks > pilon_log

#run busco to examine the quality of polished assembly
python /home/fady/busco-master/scripts/run_BUSCO.py -i /home/fady/Code/04polish/flang_piloned.fasta -o flang_Piloned -l /home/fady/busco-master/sordariomyceta_odb9/ -m genome