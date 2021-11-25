#!/bash/bin 

#set enviroment 
export PYTHON3_PATH=/usr/bin/
PATH=/home/fady/BRAKER/:$PATH
export ALIGNMENT_TOOL_PATH=/home/fady/gth-1.7.1-Linux_x86_64-64bit/bin/
export BSSMDIR_TO_PATH=/home/fady/gth-1.7.1-Linux_x86_64-64bit/bin/bssm 
export BAMTOOLS_PATH=/home/fady/bamtools/bin
export AUGUSTUS_CONFIG_PATH=/home/fady/Augustus/config/
export GENEMARK_PATH=/home/fady/gm_et_linux_64/gmes_petap/:$PATH
PATH=/home/fady/BRAKER/scripts/:$PATH
PATH=/home/fady/BRAKER/bin/:$PATH

#change the directory
cd /home/fady/Code/05prediction/Augustus/braker/

#run braker with protein files. As the flang model already existed before, so it should use '--useexisting', if you run it firstly, just remove it
#there is no annotation from fasta file, and it needs to download Dianomd which have thousands of errors. so I just skip this
./../../../../BRAKER/scripts/braker.pl --species=flang --genome=/home/fady/Code/04polish/flang_piloned.fasta --prot_seq=/home/fady/Code/00Fl201059/GCA_001292635.1_ASM129263v1_protein.faa -prg=gth --get2traingenes --trainFromGth --skipGetAnnoFromFasta --useexisting

#Making a fasta file with protein sequences of /home/fady/Code/05prediction/Augustus/braker/braker/augustus.hints.gtf
#it might have some command errors with braker inside running with python3, so I run it separately as the final step for fasta sequence 
/usr/bin/python3 /home/fady/Augustus/scripts/getAnnoFastaFromJoingenes.py -g /home/fady/Code/05prediction/Augustus/braker/braker/genome.fa -f /home/fady/Code/05prediction/Augustus/braker/braker/augustus.hints.gtf -o /home/fady/Code/05prediction/Augustus/braker/braker/augustus.hints 1> /home/fady/Code/05prediction/Augustus/braker/braker/getAnnoFasta.augustus.hints.stdout 2>/home/fady/Code/05prediction/Augustus/braker/braker/errors/getAnnoFastaJoingenes.augustus.hints.stderr
