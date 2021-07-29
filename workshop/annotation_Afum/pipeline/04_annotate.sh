#!/usr/bin/bash -l 
#SBATCH -p batch -N 1 -n 16 --mem 24gb --out logs/04_annotate.log --time 48:00:00
CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi

conda activate funannotate
LOCUSPREF=SGAir0713
INDIR=genomes
GENOME=A_fumigatus_SGAir0713.masked.fasta
OUTDIR=annotate/$(basename $GENOME .masked.fasta)
BUSCODB=ascomycota
time funannotate annotate --species "Aspergillus fumigatus" --strain "SGAir0713" --cpus $CPU \
	 --input  $OUTDIR --name $LOCUSPREF   --busco_db $BUSCODB

