#!/usr/bin/bash -l 
#SBATCH -p batch -N 1 -n 4 --mem 32gb --out logs/02_train.log --time 48:00:00
CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi

conda activate funannotate
mkdir -p annotate
INDIR=genomes
GENOME=A_fumigatus_SGAir0713.masked.fasta
OUTDIR=annotate/$(basename $GENOME .masked.fasta)
CDNA=evidence/FungiDB-53_AfumigatusAf293_AnnotatedTranscripts.fasta
LEFT=evidence/PRJNA376829_subsample_R1.fq.gz
RIGHT=evidence/PRJNA376829_subsample_R2.fq.gz
time funannotate train --species "Aspergillus fumigatus" --strain "SGAir0713" --max_intronlen 3000 --cpus $CPU \
	 --input $INDIR/$GENOME --trinity $CDNA --out $OUTDIR --left $LEFT --right $RIGHT
