class: Workflow
cwlVersion: v1.2
doc: 'Abstract CWL Automatically generated from the Galaxy workflow file: COVID-19:
  read pre-processing'
inputs:
  Forwards reads:
    format: data
    type: File
  Reverse reads:
    format: data
    type: File
outputs: {}
steps:
  2_Trim Galore:
    in:
      singlePaired|input_mate1: Forwards reads
      singlePaired|input_mate2: Reverse reads
    out:
    - trimmed_reads_pair1
    - trimmed_reads_pair2
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_trim_galore_trim_galore_0_4_3_1
      inputs:
        singlePaired|input_mate1:
          format: Any
          type: File
        singlePaired|input_mate2:
          format: Any
          type: File
      outputs:
        trimmed_reads_pair1:
          doc: input
          type: File
        trimmed_reads_pair2:
          doc: input
          type: File
  3_Map with BWA-MEM:
    in:
      fastq_input|fastq_input1: 2_Trim Galore/trimmed_reads_pair1
      fastq_input|fastq_input2: 2_Trim Galore/trimmed_reads_pair2
    out:
    - bam_output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_devteam_bwa_bwa_mem_0_7_17_1
      inputs:
        fastq_input|fastq_input1:
          format: Any
          type: File
        fastq_input|fastq_input2:
          format: Any
          type: File
      outputs:
        bam_output:
          doc: bam
          type: File
  4_Filter SAM or BAM, output SAM or BAM:
    in:
      input1: 3_Map with BWA-MEM/bam_output
    out:
    - output1
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_devteam_samtool_filter2_samtool_filter2_1_8+galaxy1
      inputs:
        input1:
          format: Any
          type: File
      outputs:
        output1:
          doc: sam
          type: File
  5_Samtools fastx:
    in:
      input: 4_Filter SAM or BAM, output SAM or BAM/output1
    out:
    - forward
    - reverse
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_samtools_fastx_samtools_fastx_1_9+galaxy1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        forward:
          doc: fasta
          type: File
        reverse:
          doc: fasta
          type: File

