#!/usr/bin/bash
#SBATCH -p batch --time 0:30:00 -N 1 -n 1 --mem 2gb --out logs/00_link_files.log

mkdir -p evidence
pushd evidence
URL=https://fungidb.org/common/downloads/release-53/AfumigatusAf293/fasta/data/FungiDB-53_AfumigatusAf293_AnnotatedProteins.fasta

if [ ! -f $(basename $URL) ]; then
	curl -O $URL
fi

URL=https://fungidb.org/common/downloads/release-53/AfumigatusAf293/fasta/data/FungiDB-53_AfumigatusAf293_AnnotatedTranscripts.fasta
if [ ! -f $(basename $URL) ]; then
        curl -O $URL
fi
popd

pushd genomes
URL=https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/005/768/625/GCA_005768625.2_ASM576862v2/GCA_005768625.2_ASM576862v2_genomic.fna.gz
if [ ! -f $(basename $URL) ]; then
        curl -O $URL
fi
gzip -dc GCA_005768625.2_ASM576862v2_genomic.fna.gz | perl -p -e 's/>VBRB010+(\d+)\.1.+/>scf_$1/' > A_fumigatus_SGAir0713.sorted.fasta
line=$(grep -n ">CM016889.1" A_fumigatus_SGAir0713.sorted.fasta | cut -d: -f1)
line=$(expr $line - 1 )

head -n $line A_fumigatus_SGAir0713.sorted.fasta > A_fumigatus_SGAir0713.trunc.fasta
mv A_fumigatus_SGAir0713.trunc.fasta A_fumigatus_SGAir0713.sorted.fasta

