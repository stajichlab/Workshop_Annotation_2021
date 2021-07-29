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
