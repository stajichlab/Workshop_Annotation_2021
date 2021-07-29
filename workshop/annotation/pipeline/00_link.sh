#!/usr/bin/bash
#SBATCH -p batch --time 0:30:00 -N 1 -n 1 --mem 2gb --out logs/00_link_files.log

mkdir -p genomes evidence
PREFIX=GCA_013396165.1_ASM1339616v1
IN=../data

if [ ! -f $IN/${PREFIX}_genomic.fna.gz ]; then
	pushd $IN
	bash download.sh
	popd
fi
if [ ! -f $IN/${PREFIX}_genomic.fna.gz ]; then
	echo "Cannot find $IN/${PREFIX}_genomic.fna.gz; downlaod failed?"
	exit
fi

gzip -dc $IN/${PREFIX}_genomic.fna.gz > genomes/Fusarium_globosum_NRRL_26131.sorted.fasta
perl -i -p -e 's/>JAAQPF010+(\d+)\.1\s+.+/>scf_$1/' genomes/Fusarium_globosum_NRRL_26131.sorted.fasta

gzip -dc $IN/${PREFIX}_cds_from_genomic.fna.gz > evidence/Fusarium_globosum_NRRL_26131.transcripts.fasta
