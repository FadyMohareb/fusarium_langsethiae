#!/bash/bin

#extract coding sequence out
cat /home/fady/Code/05prediction/Augustus/braker/braker/augustus.hints.gtf | cut -f 3 | grep gene | grep -v "#"  | wc -l #there are 19336 coding gene sequence existing 
awk '$3=="gene"' /home/fady/Code/05prediction/Augustus/braker/braker/augustus.hints.gtf | grep -v "#" > /home/fady/Code/06annotation/gene_startstop.gff #extract start and stop sequence 

#use the assembly file, extract out the start and stop part. Only the coding sequence part remains 
bedtools getfasta -fi /home/fady/Code/04polish/flang_piloned.fasta -bed /home/fady/Code/06annotation/gene_startstop.gff -fo /home/fady/Code/06annotation/gene_seq.fasta

#check the amount of coding sequence 
grep contig /home/fady/Code/06annotation/gene_seq.fasta | wc -l #19336 contigs 

#blast coding sequence against NR database 
/opt/bix/blast/2.3.0/bin/blastx -task blastx-fast -query /home/fady/Code/06annotation/gene_seq.fasta -db /opt/bix/blast/2.3.0/db_nr/nr -outfmt 11 -out /home/fady/database/nr_out -num_threads 12 
#change the format of blast output to make it suit for Blast2GO
/opt/bix/blast/2.3.0/bin/blast_formatter -archive /home/fady/database/nr_out -outfmt 16 -out /home/fady/database/nr_xml_out
#modify the name of gene sequence, make it suitable for merge function in Blast2GO
sed -i 's/:/_/g' /home/fady/Code/06annotation/gene_seq.fasta

#run Blast2GO
/opt/bix/OmicsBox/OmicsBox/OmicsBox_Launcher

#the R script would extract some annotation out with key words. 