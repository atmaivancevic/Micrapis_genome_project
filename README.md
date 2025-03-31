# Micrapis_genome_project

### Analysis scripts used in:
"De novo genome assemblies of the dwarf honey bee subgenus Micrapis: Apis andreniformis and Apis florea" (2025) Atma Ivancevic*, Madison Sankovitz*, Holly Allen, Olivia Joyner, Edward B. Chuong+, Samuel Ramsey+

\*co-first authors  
\+co-last authors

---

### Programs used:

- **Dorado** v0.7.2 https://github.com/nanoporetech/dorado  
- **Flye** v2.9.5 https://github.com/fenderglass/Flye  
- **Medaka** v2.0.0 https://github.com/nanoporetech/medaka  
- **Pilon** v1.24 https://github.com/broadinstitute/pilon  
- **BBMap/BBDuk** v38.05 https://sourceforge.net/projects/bbmap  
- **BWA-MEM** v0.7.15 https://github.com/lh3/bwa  
- **Samtools** v1.16.1 http://www.htslib.org/  
- **QUAST** v5.2.0 https://github.com/ablab/quast  
- **BUSCO** v5.7.1 https://busco.ezlab.org/  
- **Meryl** v1.4.1 & **Merqury** v1.3 https://github.com/marbl/merqury  
- **RepeatMasker** v4.1.7 https://www.repeatmasker.org/  
- **Tandem Repeats Finder** v4.0.9 https://tandem.bu.edu/trf/trf.html  
- **VSEARCH** v2.14.1 https://github.com/torognes/vsearch  
- **Pychopper** v2.5.0 https://github.com/nanoporetech/pychopper  
- **Minimap2** v2.22 https://github.com/lh3/minimap2  
- **HISAT2** v2.1.0 https://daehwankimlab.github.io/hisat2/  
- **BRAKER3** https://github.com/Gaius-Augustus/BRAKER  
- **StringTie2** https://github.com/gpertea/stringtie  
- **GffRead** https://github.com/gpertea/gffread  
- **DIAMOND** https://github.com/bbuchfink/diamond  

---

### Genome assembly and polishing workflow:

1. **ONT basecalling + demultiplexing**  
   1) [dorado_basecall_and_demux.sh](genome_assembly/dorado_basecall_and_demux.sh)

2. **Assembly**  
   1) [flye_assembly.sh](genome_assembly/flye_assembly.sh)  
   2) [medaka_polish.sh](genome_assembly/medaka_polish.sh)  
   3) [pilon_polish.sh](genome_assembly/pilon_polish.sh)

3. **Short-read preprocessing and mapping**  
   1) [bbduk_trim_genome.sh](genome_assembly/bbduk_trim_genome.sh)  
   2) [bwa_mem_align.sh](genome_assembly/bwa_mem_align.sh)  
   3) [samtools_sort_index.sh](genome_assembly/samtools_sort_index.sh)

4. **Contig filtering and contamination screening**  
   1) [vsearch_filter_contigs.sh](genome_assembly/vsearch_filter_contigs.sh)  
   2) [fcs_adaptor.sh](genome_assembly/fcs_adaptor.sh)  
   3) [fcs_gx.sh](genome_assembly/fcs_gx.sh)

5. **Assembly QC**  
   1) [quast_report.sh](genome_assembly/quast_report.sh)  
   2) [busco_genome.sh](genome_assembly/busco_genome.sh)  
   3) [meryl_merqury.sh](genome_assembly/meryl_merqury.sh)

---

### Transcriptome assembly and annotation workflow:

1. **ONT cDNA processing**  
   1) [dorado_basecall_cDNA.sh](transcriptome_assembly/dorado_basecall_cDNA.sh)  
   2) [pychopper_trim.sh](transcriptome_assembly/pychopper_trim.sh)  
   3) [nanostat_cDNA_summary.sh](transcriptome_assembly/nanostat_cDNA_summary.sh)

2. **Illumina RNA-seq processing**  
   1) [bbduk_trim_rnaseq.sh](transcriptome_assembly/bbduk_trim_rnaseq.sh)  
   2) [hisat2_index_align.sh](transcriptome_assembly/hisat2_index_align.sh)  
   3) [samtools_merge.sh](transcriptome_assembly/samtools_merge.sh)

3. **Transcript assembly and gene prediction**  
   1) [stringtie_assemble.sh](transcriptome_assembly/stringtie_assemble.sh)  
   2) [braker3_annotation.sh](transcriptome_assembly/braker3_annotation.sh)  
   3) [diamond_align_orthodb.sh](transcriptome_assembly/diamond_align_orthodb.sh)  
   4) [gffread_filter.sh](transcriptome_assembly/gffread_filter.sh)  
   5) [busco_proteome.sh](transcriptome_assembly/busco_proteome.sh)

---

### Notes:

- All software was run with default settings unless otherwise shown.  
- Protein homology for BRAKER3 was provided using OrthoDB v12 Arthropoda dataset located here:
  [https://bioinf.uni-greifswald.de/bioinf/partitioned_odb12](https://bioinf.uni-greifswald.de/bioinf/partitioned_odb12)

---

### Raw and processed data are publicly available in the following repositories:

#### NCBI BioProject:
_Apis andreniformis_  
Genome sequencing and assembly: NCBI BioProject [PRJNA1217036](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA1217036)  
Transcriptome sequencing: NCBI BioProject [PRJNA1217108](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA1217108)

_Apis florea_  
Genome sequencing and assembly: NCBI BioProject [PRJNA1217041](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA1217041)  
Transcriptome sequencing: NCBI BioProject [PRJNA1217110](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA1217110)

#### GenBank:
_Apis andreniformis_ assembly ASM4859352v1: [GCA_048593525.1](https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_048593525.1/)  
_Apis florea_ assembly ASM4859348v1: [GCA_048593485.1](https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_048593485.1/)

#### Zenodo:
Gene annotations generated by BRAKER3 are available on [Zenodo](https://doi.org/10.5281/zenodo.15048194).
