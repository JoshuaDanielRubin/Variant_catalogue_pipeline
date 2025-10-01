#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// this prints the input parameters


params
        outdir_ind  = "/mnt/scratch/SILENT/Act3/Josh-scratch/subset_variant_aggregation/Variant_catalogue_pipeline/Subpopulations/ind"
        run = "test_run"
        batch = "test_batch"
        assembly    = 'GRCh38'
        var_type = "SV"
        sample_assignments = Channel.fromPath("Subpopulations/sample_assignments.csv")
        pop_list = Channel.fromPath("Subpopulations/pop_list.txt")

include {list_vcfs_txt} from "./modules/list_vcfs_txt.nf"

workflow {
    list_vcfs_txt(assembly, batch, run, sample_assignments, pop_list, var_type)
}
