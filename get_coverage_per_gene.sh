#!/bin/bash

####
# T.J.Blätte
# 2019
####
#
# Calculate the average on-target coverage per gene
#
# Args:
#   BED: Name of / Path to the target BED file
#        which was also passed to bpipe to
#        generate the *coverBED.txt files. Column 4
#        should contain feature IDs (gene names) for
#        which the average coverage is then calculated.
#
#   ...: For each sample, for which the average
#        per-gene coverage is to be calculated,
#        pass the respective *coverBED.txt file
#        generated by bpipe via BEDTools' coverage command. 
#        Column 5 should be the depth of coverage,
#        column 8 should be the fraction of the respective
#        BED entry (amplicon) with that coverage.
#
# Output:
#   $DIR/average_coverage_summary.tsv: containing all
#       of the collected and merged statistics.
#
####


BED=$1
GENES=$(cut -f4 "$BED" | sort | uniq | sed 's/\r//')

OUT='average_coverage_summary.tsv'


# print header
echo -n 'gene' > $OUT
for SAMPLE in "${@:2}"
do
    echo -ne "\t${SAMPLE}" >> $OUT
done
echo "" >> $OUT


# calc and print average per gene and sample coverage
for GENE in $GENES
do
    echo -n "$GENE" >> $OUT
    for SAMPLE in "${@:2}"
    do

        NUMBER_OF_AMPLICONS=$(grep -wF "$GENE" "$BED" | wc -l)
        AVERAGE_COVERAGE=$(grep -wF "$GENE" "$SAMPLE" | 
                awk -v N=$NUMBER_OF_AMPLICONS '{SUM=(SUM + ($5 * $8))} END {print SUM / N}')
        echo -ne "\t${AVERAGE_COVERAGE}" >> $OUT
    done
    
    echo "" >> $OUT

done