#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// this prints the input parameters

params

gvcf_dir = Channel.fromPath("Subpopulations/")
sample_assignments = Channel.fromPath("Subpopulations/sample_assignments.csv")
pop_list = Channel.fromPath("Subpopulations/pop_list.txt")

include {list_vcfs_txt_subset} from "./modules/list_vcfs_txt_subset.nf"

workflow {
    list_vcfs_txt_subset(gvcf_dir,sample_assignments,pop_list)
}
