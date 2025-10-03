#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// this prints the input parameters


params
        Sample_MT_Step2_participant_data = Channel.fromPath("Subpopulations/Sample_MT_Step2_participant_data.tsv")
        Sample_list = Channel.fromPath("Subpopulations/Sample_list.txt")
        outdir_ind  = "/mnt/scratch/SILENT/Act3/Josh-scratch/subset_variant_aggregation/ind/"
        run = "run_test"
        batch = "batch_test"
        assembly    = 'GRCh38'
        var_type = "MT"
        sample_assignments = Channel.fromPath("Subpopulations/sample_assignments.csv")
        pop_list = Channel.fromPath("Subpopulations/pop_list.txt")

include {MT_Step2_participant_data} from "./modules/MT_Step2_participant_data.nf"

workflow {
    MT_Step2_participant_data(Sample_MT_Step2_participant_data, \
                              Sample_list, assembly, batch, run, \
                              sample_assignments, pop_list)
}
