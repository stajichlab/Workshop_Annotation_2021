#!/usr/bin/bash -l
#SBATCH -p batch -N 1 -n 16 --mem 16gb --out logs/01_mask.log --time 24:00:00

conda activate funannotate
CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi
INDIR=genomes
GENOME=A_fumigatus_ISSF_21_Chr7.sorted.fasta
time funannotate mask -m tantan --cpus $CPU -i $INDIR/$GENOME -o $INDIR/$(basename $GENOME .sorted.fasta).masked.fasta
