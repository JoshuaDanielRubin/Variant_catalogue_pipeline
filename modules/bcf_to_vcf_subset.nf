// Nextflow process
// Created by Solenne Correard in December 2021
// Owned by the Silent Genomes Project Activity 3 team
// Developed to build the IBVL, a background variant library

// Overview of the process goal and characteristics :
// SNV Calling. 
// Split the multiallelic variants (norm step) and transform the bcf into a vcf 
// Rename the variants and compress the vcf into a vcf.gz
// Index the compressed vcf

process bcf_to_vcf_subset {
	label 'conda_annotate'

	input :
	file bcf_file
        val assembly
        val batch
        val run
        file ref
        path sample_assignments
        path pop_list
        val subset

	output :
	path '*.vcf.gz'

	script :
	"""
        cut -d',' -f1 ${sample_assignments} > all_samples.txt
        grep -f all_samples.txt ${pop_list} > grep_res.txt
        grep -f grep_res.txt ${sample_assignments} > subset_assignments.txt
        cat subset_assignments.txt | cut -d ',' -f 2- | sed 's/\$/,/' | tr -d '\n' | tr ',' '\n' > sample_subset_list.txt
        bcftools view -S sample_subset_list.txt ${bcf_file} | gzip > subset.vcf.gz
	"""
}
