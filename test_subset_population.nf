#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// this prints the input parameters


params
        run                             = ""
        batch                           = ""
        reads                           = ""
        assembly                        = 'GRCh38'
        reference                       = "/mnt/scratch/SILENT/Act3/Josh-scratch/subset_variant_aggregation/tmp/dummy.fa"
        glnexus_out = Channel.fromPath("Subpopulations/yoruba_3_chr22.vcf.gz")
        sample_assignments = Channel.fromPath("Subpopulations/sample_assignments.csv")
        pop_list = Channel.fromPath("Subpopulations/pop_list.txt")
        subset = true

include {bcf_to_vcf_subset} from "./modules/bcf_to_vcf_subset.nf"

workflow {
    bcf_to_vcf_subset(glnexus_out, assembly, batch, run, reference, sample_assignments, pop_list, subset)
}
