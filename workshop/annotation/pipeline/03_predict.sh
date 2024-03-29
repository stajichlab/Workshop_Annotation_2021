#!/usr/bin/bash -l 
#SBATCH -p batch -N 1 -n 8 --mem 32gb --out logs/03_predict.log --time 48:00:00
CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi

conda activate funannotate
mkdir -p annotate
#export AUGUSTUS_CONFIG_PATH=$(realpath lib/augustus/config)
LOCUSPREF=FGLOB1v2 # this is based on what was in NCBI
INDIR=genomes
GENOME=Fusarium_globosum_NRRL_26131.masked.fasta
OUTDIR=annotate/$(basename $GENOME .masked.fasta)
BUSCODB=dikarya # would change this to closest taxon group in BUSCO download set 
# https://busco.ezlab.org/  https://busco-data.ezlab.org/v4/data/lineages/
# funannotate also installs these with  these commands for example
# funannotate setup -b fungi 
# funannotate setup -b dikarya

# note that normally you woudl want to use swissprot or uniprot but will take more time
# since there will be more proteins, for this tutorial we are using the already prediceted
# annotation from this species
PEP=evidence/Fusarium_globosum_NRRL_26131.transcripts.fasta


#CDNA=evidence/Fusarium_globosum_NRRL_26131.transcripts.fasta
# if you ddidn't run train you can specify transcript with adding this option
# --transcript_evidence $CDNA

# note if you install genemark http://topaz.gatech.edu/GeneMark/license_download.cgi
export PATH=/home/jstajich/shared/src/gmes_linux_64:$PATH
if [ ! -f $HOME/.gm_key ]; then
	rsync -a /home/jstajich/shared/src/gm_key_64 $HOME/.gm_key
fi


time funannotate predict --species "Fusarium globosum" --strain "NRRL 26131" --max_intronlen 3000 --cpus $CPU \
	 --input $INDIR/$GENOME --out $OUTDIR --name $LOCUSPREF --genemark_mode ES \
	--busco_db $BUSCODB
