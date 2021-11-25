#!/bash/bin

#download species parameters 
wget ftp://genome.crg.es/pub/software/geneid/foxysporum.param.Feb_8_2012

#run gene id
/home/fady/geneid/geneid/bin/geneid -P foxysporum_param /home/fady/Code/04polish/flang_piloned.fasta > flang.txt

#count how much gene has gene id predicted 
cat flang.txt | cut -f 3 | grep Gene | grep -v "# Optimal" | wc -l
