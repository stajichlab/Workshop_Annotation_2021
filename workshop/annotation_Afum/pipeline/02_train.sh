#!/usr/bin/bash -l 
#SBATCH -p batch -N 1 -n 4 --mem 32gb --out logs/02_train.log --time 48:00:00
CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi

conda activate funannotate
mkdir -p annotate
INDIR=genomes
GENOME=A_fumigatus_ISSF_21_Chr7.masked.fasta
OUTDIR=annotate/$(basename $GENOME .masked.fasta)
CDNA=evidence/FungiDB-53_AfumigatusAf293_AnnotatedTranscripts.fasta
time funannotate train --species "Aspergillus fumigatus" --strain "ISSF_21" --max_intronlen 3000 --cpus $CPU \
	 --input $INDIR/$GENOME --trinity $CDNA --out $OUTDIR
