//file to contain pipeline configuration of AMPLICON pipeline


// VARIANT FILTER SCRIPT
FILTER="filter_amplicon_wFlankingSeq.sh"

// KNOWN SEQUENCES
REF="${NGS}/refgenome/GATK/ucsc.hg19.fasta" //also includes unplaced/unlocalized contigs and alternative haplotypes
DBSNP="${NGS}/known_sites/hg19/dbsnp_138.hg19.vcf"
GOLD_STANDARD_1000G_INDELS="${NGS}/known_sites/hg19/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf"
PHASE1_1000G_INDELS="${NGS}/known_sites/hg19/1000G_phase1.indels.hg19.sites.vcf"

// TARGET SEQUENCES FOR COVERAGE CALC
CELGENE="${NGS}/known_sites/Celgene_Kyle_Halo_121713_Regions.bed"
EXON_TARGET=CELGENE