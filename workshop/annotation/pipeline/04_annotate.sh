#!/usr/bin/bash -l 
#SBATCH -p batch -N 1 -n 16 --mem 24gb --out logs/04_annotate.log --time 48:00:00
CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi

conda activate funannotate
LOCUSPREF=FGLOB1v2 # this is based on what was in NCBI
INDIR=genomes
GENOME=Fusarium_globosum_NRRL_26131.masked.fasta
OUTDIR=annotate/$(basename $GENOME .masked.fasta)
BUSCODB=ascomycota
time funannotate annotate --species "Fusarium globosum" --strain "NRRL 26131" --cpus $CPU \
	 --input  $OUTDIR --name $LOCUSPREF   --busco_db $BUSCODB

