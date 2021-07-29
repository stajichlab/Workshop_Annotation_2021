## 2021 3rd Generation Genomics Africa Workshop

Ths module focuses on Euakryotic genome annotation with a focus on fungi.

To checkout a copy of the code for this project you can do this on the cmdline
`git clone https://github.com/stajichlab/Workshop_Annotation_2021.git`

Now you can go into a folder
```
cd Workshop_Annotation_2021
cd workshop
ls
```

The workshop will focus on running several tools on the
1. Assembly of a genome using spades

```
cd assembly/ISSF_21_Chr7
more assemble.sh
```
This is the script to run a spades assembly with some toy data.
```
#!/usr/bin/bash -l
#SBATCH -p batch -N 1 -n 8 --mem 32gb --out spades_assemble.log
i
CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi
module load spades/3.13.0


spades.py -1 ISSF_21_Chr_7_1.fq.gz -2 ISSF_21_Chr_7_2.fq.gz -s ISSF_21_Chr_7_single.fq.gz -t $CPU --careful -o ISSF_21_Chr_7
```

2.  Reset and go back to initial folder - assuming you checked out in your home directory
`cd ~/Workshop_Annotation_2021`

3. Going do annotation of existing genomes.

We will use code that is in the checked out repository.
Also available here to browse on web.
https://github.com/stajichlab/Workshop_Annotation_2021/tree/main/workshop/annotation_Afum/

## Setup and repeat mask

```
cd ~/Workshop_Annotation_2021/workshop/annotation_Afum
sbatch pipeline/00_link.sh
sbatch pipeline/01_repeat_mask.sh
```
Wait for it to finish.

Check out files in the `logs` directory

## Training

We could run training by aligning existing RNASeq.  I have staged some of this data on the cluster
```
/home/jstajich/data/Afumigatus/PRJNA376829_subsample_R1.fq.gz
/home/jstajich/data/Afumigatus/PRJNA376829_subsample_R2.fq.gz
```
But the assembly and training will take ~8hrs I expect.

## Prediction of genes
```
sbatch pipeline/03_predict.sh
```

## Functional annotation`

```
sbatch pipeline/04_annotate.sh
```
