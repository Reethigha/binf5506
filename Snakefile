SRA = "SRR1972739"
REF_ID = "AF086833.2"
RESULTS_FOLDER = "results/"
RAW_DIR=f"{RESULTS_FOLDER}/raw"
ALIGNED_DIR=f"{RESULTS_FOLDER}/aligned"
VARIANT_DIR=f"{RESULTS_FOLDER}/variants"
ANNOTATED_DIR=f"{RESULTS_FOLDER}/annotated"
QC_DIR=f"{RESULTS_FOLDER}/qc"
SNPEFF_DIR=f"{RESULTS_FOLDER}/snpEff"
SNPEFF_DATA_DIR=f"{SNPEFF_DIR}/data/reference_db"
 
rule all:
    input: 
        f"{RAW_DIR}/reference.fasta"
 
rule create_dirs:
    output:
        marker = "results/.dirs_created"
    shell:
        """
        mkdir -p {RESULTS_FOLDER} {RAW_DIR} {ALIGNED_DIR} {VARIANT_DIR} {ANNOTATED_DIR} {QC_DIR} {SNPEFF_DATA_DIR}
        touch {output.marker}
        """
 
rule download_reference:
    input:
        marker = rules.create_dirs.output.marker
    output:
        ref = f"{RAW_DIR}/reference.fasta"
    shell:
        """
        echo Downloading reference genome...
        efetch -db nucleotide -id {REF_ID} -format fasta > {RAW_DIR}/reference.fasta
        echo Downloaded reference genome!
        """