#!/bash/bin

#set path enviroment
export AUGUSTUS_CONFIG_PATH=/home/fady/Augustus/config/
export PATH=$PATH:/home/fady/Augustus/bin:/home/fady/Augustus/scripts

#run augustus 
augustus --strand=both --species=fusarium_graminearum /home/fady/Code/04polish/flang_piloned.fasta > abinito.gff