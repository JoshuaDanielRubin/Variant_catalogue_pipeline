// Nextflow process
// Created by Solenne Correard in December 2021
// Owned by the Silent Genomes Project Activity 3 team
// Developped to build the IBVL, a background variant library

// Overview of the process goal and characteristics :
// List the individuals files (vcf) that have been generated and that will be merged to obtain the aggregated dataset

 // grep -f ${sample_assignments} ${pop_list} | cut -d ',' -f 2- | sed 's/\$/,/' | \
 // tr -d '\n' | tr ',' '\n' | sed 's/\$/_sorted_genotypes_setid.vcf.gz/' > sample_assignments_subset.txt
 // comm -12 <(sort ${var_type}_vcfs.txt) <(sort sample_assignments_subset.txt) > ${var_type}_vcfs_subset.txt


process list_vcfs_txt {

        publishDir "$params.outdir_ind/${assembly}/${batch}/${run}/${var_type}", mode: 'copy'
        
	input :
	val assembly
	val batch
	val run
        path sample_assignments
        path pop_list
	val var_type 

        output :
        file '*.txt'

        script:
	if(var_type == "MT") {	
		"""
                find $params.outdir_ind/${assembly}/${batch}/${run}/${var_type}/Sample/ -name "*_filtered_sites.vcf.gz" > MT_vcfs.txt
		"""
	} else if (var_type == "SNV") {
                """
                find $params.outdir_ind/${assembly}/${batch}/${run}/${var_type}/Sample/ -name "*.g.vcf.gz" > ${var_type}_vcfs.txt
                """
	} else if (var_type == "SV") {
                """
                find $params.outdir_ind/${assembly}/${batch}/${run}/${var_type}/Sample/paragraph/ \
                    -name "*.vcf.gz" > ${var_type}_vcfs.txt
                grep -f ${pop_list} ${sample_assignments} | cut -d ',' -f 2- | sed 's/\$/,/' | \
                tr -d '\n' | tr ',' '\n' | sed 's/\$/_sorted_genotypes_setid.vcf.gz/' > sample_assignments_subset.txt
                grep -f sample_assignments_subset.txt ${var_type}_vcfs.txt > ${var_type}_vcfs_subset.txt
		"""
        } else {
        	"""
                find $params.outdir_ind/${assembly}/${batch}/${run}/${var_type}/Sample/ -name "*.vcf.gz" > ${var_type}_vcfs.txt
        	"""
	}

}

