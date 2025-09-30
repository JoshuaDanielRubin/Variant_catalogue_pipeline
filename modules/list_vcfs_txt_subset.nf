// Nextflow process
// Created by Solenne Correard in December 2021
// Owned by the Silent Genomes Project Activity 3 team
// Developed to build the IBVL, a background variant library

// Overview of the process goal and characteristics :
// List the individuals files (vcf) that have been generated and that will be merged to obtain the aggregated dataset
// Subset by list of populations if requested

process list_vcfs_txt_subset {

        publishDir "/mnt/scratch/SILENT/Act3/Josh-scratch/subset_variant_aggregation/tmp", mode: 'copy'
        
	input :
        path gvcf_dir
        path sample_assignments
        path pop_list

        output :
        file '*.txt'

        script:
                """
                find -L $gvcf_dir -name "*.g.vcf.gz" -printf "%f\n" > SNV_vcfs.txt
                cut -d',' -f1 sample_assignments.csv > all_pops.txt                
                grep -f all_pops.txt ${pop_list} > grep_res.txt
                grep -f grep_res.txt sample_assignments.csv > subset_assignments.txt
                cat subset_assignments.txt | cut -d ',' -f 2- | sed 's/\$/,/' | tr -d '\n' | tr ',' '\n' | sed 's/\$/.g.vcf.gz/' > intermediate3.txt
                comm -12 <(sort SNV_vcfs.txt) <(sort intermediate3.txt) > SNV_vcfs_subset.txt
                """
}

