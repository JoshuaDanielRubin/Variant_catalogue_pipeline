#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// this prints the input parameters


params
        outdir_ind  = "/mnt/scratch/SILENT/Act3/Josh-scratch/subset_variant_aggregation/ind/"
        run = "run_test"
        batch = "batch_test"
        assembly    = 'GRCh38'
        var_type = "MT"
        sample_assignments = Channel.fromPath("Subpopulations/sample_assignments.csv")
        pop_list = Channel.fromPath("Subpopulations/pop_list.txt")

include {subset_vcf_list} from "./modules/subset_vcf_list.nf"

workflow {
    subset_vcf_list(sample_list, assembly, batch, run, sample_assignments, pop_list, var_type)
}
