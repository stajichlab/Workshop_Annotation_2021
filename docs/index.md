## 2021 3rd Generation Genomics Africa Workshop

This module focuses on Eukaryotic genome annotation with a focus on fungi.

A basic presentation on annotation steps is available on [this link](resource/presentation_1.pdf).

## Follow along

To checkout a copy of the code for this project you can do this on the cmdline

```
git clone https://github.com/stajichlab/Workshop_Annotation_2021.git
```

Now you can go into a folder
```
cd Workshop_Annotation_2021
cd workshop
ls
```

The workshop will focus on running several tools on the

## Assembly of a genome using spades

```
cd assembly/ISSF_21_Chr7
more assemble.sh
```
This is the script to run a spades assembly with some toy data.
```
#!/usr/bin/bash -l
#SBATCH -p batch -N 1 -n 8 --mem 32gb --out spades_assemble.log

CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi
module load spades/3.13.0


spades.py -1 ISSF_21_Chr_7_1.fq.gz -2 ISSF_21_Chr_7_2.fq.gz -s ISSF_21_Chr_7_single.fq.gz -t $CPU --careful -o ISSF_21_Chr_7
```

## Reset and go back to initial folder - assuming you checked out in your home directory
`cd ~/Workshop_Annotation_2021`

## Annotation of an assembled genome.

We will use [Funannotate](https://github.com/nextgenusfs/funannotate/) or [funannotate readthedocs](https://funannotate.readthedocs.io/en/latest/). https://doi.org/10.5281/zenodo.1134477

We will use code that is in the checked out repository.

Also available here to browse on web.
https://github.com/stajichlab/Workshop_Annotation_2021/tree/main/workshop/annotation_Afum/

See the pipeline folder for scripts which will run on the CGIAR cluster.

## Setup and repeat mask

First script downloads an unannotate genome from NCBI and gets some supporting files for annotation - proteins and Transcripts from a reference strain in the FungiDB database.

```
cd ~/Workshop_Annotation_2021/workshop/annotation_Afum
sbatch pipeline/00_link.sh
sbatch pipeline/01_repeat_mask.sh
```
Wait for it to finish.

Check out info in the `logs` directory to see if any errors

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

Take a look at what is in annotation folder.
`/home/jstajich/Workshop_Annotation_2021/workshop/annotation_Afum/annotate/A_fumigatus_SGAir0713` also has results on the CGIAR cluster

## Functional annotation`

```
sbatch pipeline/04_annotate.sh
```
