#!/usr/bin/bash -l
#SBATCH -p batch -N 1 -n 8 --mem 32gb --out spades_assemble.log

CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi
module load spades/3.13.0


spades.py -1 ISSF_21_Chr_7_1.fq.gz -2 ISSF_21_Chr_7_2.fq.gz -s ISSF_21_Chr_7_single.fq.gz -t $CPU --careful -o ISSF_21_Chr_7
