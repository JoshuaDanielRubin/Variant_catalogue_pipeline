#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// this prints the input parameters


params
        outdir_ind  = "/mnt/scratch/SILENT/Act3/Josh-scratch/subset_variant_aggregation/Variant_catalogue_pipeline/Subpopulations/ind/"
        run = "test_batch"
        batch = "test_run"
        assembly    = 'GRCh38'
        reference   = Channel.fromPath("/mnt/common/DATABASES/REFERENCES/GRCh38/GENOME/1000G/GRCh38_full_analysis_set_plus_decoy_hla.fa")
        glnexus_out = Channel.fromPath("Subpopulations/yoruba_3_chr22.vcf.gz")
        sample_assignments = Channel.fromPath("Subpopulations/sample_assignments_SNV.csv")
        pop_list = Channel.fromPath("Subpopulations/pop_list.txt")

include {bcf_to_vcf} from "./modules/bcf_to_vcf.nf"

workflow {
    bcf_to_vcf(glnexus_out, assembly, batch, run, reference, sample_assignments, pop_list)
}
