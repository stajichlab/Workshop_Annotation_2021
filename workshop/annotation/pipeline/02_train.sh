#!/usr/bin/bash -l 
#SBATCH -p batch -N 1 -n 4 --mem 32gb --out logs/02_train.log --time 48:00:00
CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi

conda activate funannotate
mkdir -p annotate
INDIR=genomes
GENOME=Fusarium_globosum_NRRL_26131.masked.fasta
OUTDIR=annotate/$(basename $GENOME .masked.fasta)
CDNA=evidence/Fusarium_globosum_NRRL_26131.transcripts.fasta
time funannotate train --species "Fusarium globosum" --strain "NRRL 26131" --max_intronlen 3000 --cpus $CPU \
	 --input $INDIR/$GENOME --trinity $CDNA --out $OUTDIR
