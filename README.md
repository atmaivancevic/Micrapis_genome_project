# Micrapis_genome_project

Scripts and workflows used in
"De novo genome assemblies of the dwarf honey bee subgenus _Micrapis_: _Apis andreniformis_ and _Apis florea_" (2025) Atma Ivancevic*, Madison Sankovitz*, Holly Allen, Olivia Joyner, Edward B. Chuong+, Samuel Ramsey+

\*co-first authors  
\+co-last authors

---

### Programs Used

- **Dorado** v0.7.2 https://github.com/nanoporetech/dorado
- **NanoStat** v1.6.0 https://github.com/wdecoster/nanostat 
- **Flye** v2.9.5 https://github.com/fenderglass/Flye  
- **Medaka** v2.0.0 https://github.com/nanoporetech/medaka  
- **BBMap/BBDuk** v38.05 https://sourceforge.net/projects/bbmap  
- **BWA-MEM** v0.7.5 https://github.com/lh3/bwa
- **Samtools** v1.16.1 http://www.htslib.org/
- **Pilon** v1.24 https://github.com/broadinstitute/pilon  
- **VSEARCH** v2.14.1 https://github.com/torognes/vsearch 
- **QUAST** v5.2.0 https://github.com/ablab/quast  
- **BUSCO** v5.7.1 https://busco.ezlab.org/  
- **Meryl** v1.4.1 https://github.com/marbl/meryl
- **Merqury** v1.3 https://github.com/marbl/merqury  
- **RepeatMasker** v4.1.7 https://www.repeatmasker.org/
- **FCS** v0.5.4 https://github.com/ncbi/fcs  
- **Pychopper** v2.5.0 https://github.com/epi2me-labs/pychopper
- **Minimap2** v2.22 https://github.com/lh3/minimap2  
- **HISAT2** v2.1.0 https://github.com/DaehwanKimLab/hisat2
- **BRAKER3** https://github.com/Gaius-Augustus/BRAKER 

---

### Genome Assembly and Polishing Workflow

1. **ONT basecalling and demultiplexing**  
   1) [dorado_basecall.sbatch](genome_assembly/dorado_basecall.sbatch)
   2) [dorado_demux.sbatch](genome_assembly/dorado_demux.sbatch)
   3) [nanostat.sbatch](genome_assembly/nanostat.sbatch)

2. **Assembly**  
   1) [flye_assembly.sbatch](genome_assembly/flye_assembly.sbatch)  
   2) [medaka_consensus.sbatch](genome_assembly/medaka_consensus.sbatch)  

3. **Illumina preprocessing and mapping**  
   1) [bbduk_trim.sbatch](genome_assembly/bbduk_trim.sbatch)  
   2) [bwa_mem_align.sbatch](genome_assembly/bwa_mem_align.sbatch)  

4. **Assembly polishing and filtering**
   1) [pilon_polish.sbatch](genome_assembly/pilon_polish.sbatch) 
   1) [vsearch_filter.sbatch](genome_assembly/vsearch_filter.sbatch)  

5. **Quality assessment**  
   1) [quast_report.sbatch](genome_assembly/quast_report.sbatch)  
   2) [busco_genome.sbatch](genome_assembly/busco_genome.sbatch)  
   3) [meryl_count.sbatch](genome_assembly/meryl_count.sbatch)
   4) [merqury_kmers.sbatch](genome_assembly/merqury_kmers.sbatch)

6. **Repeat annotation**
   1) [repeatmasker.sbatch](genome_assembly/repeatmasker.sbatch)  

7. **Contamination screening**
   1) [fcs_adaptor.sbatch](genome_assembly/fcs_adaptor.sbatch)  
   2) [fcs_gx.sbatch](genome_assembly/fcs_gx.sbatch)

---

### Transcriptome Assembly and Annotation Workflow

1. **ONT cDNA processing**  
   1) [dorado_basecall_cDNA.sbatch](transcriptome_assembly/dorado_basecall_cDNA.sbatch)
   2) [dorado_demux_cDNA.sbatch](transcriptome_assembly/dorado_demux_cDNA.sbatch)  
   3) [pychopper_trim.sbatch](transcriptome_assembly/pychopper_trim.sbatch)  
   4) [nanostat_cDNA.sbatch](transcriptome_assembly/nanostat_cDNA.sbatch)
   5) [minimap2_align_cDNA.sbatch](transcriptome_assembly/minimap2_align_cDNA.sbatch)

2. **Illumina RNA-seq processing**  
   1) [bbduk_trim.sbatch](transcriptome_assembly/bbduk_trim.sbatch)  
   2) [hisat2_align.sbatch](transcriptome_assembly/hisat2_align.sbatch)  
   3) [samtools_merge.sbatch](transcriptome_assembly/samtools_merge.sbatch)

3. **Transcript assembly and gene prediction**  
   1) [braker3_annotation.sbatch](transcriptome_assembly/braker3_annotation.sbatch)  
  
4. **Quality assessment**  
   1) [busco_proteome.sbatch](transcriptome_assembly/busco_proteome.sbatch)

---

### Notes

- All software was run with default settings unless otherwise indicated.
- RepeatMasker v4.1.7 was configured with Tandem Repeats Finder v4.0.9 (https://tandem.bu.edu/trf/trf.html), RMBlast v2.14.0 (www.repeatmasker.org/rmblast), and Dfam Database v3.8 (https://www.dfam.org/releases/Dfam_3.8/families/FamDB/).
- Protein homology for BRAKER3 was provided using OrthoDB v12 Arthropoda dataset (https://bioinf.uni-greifswald.de/bioinf/partitioned_odb12).

---

### Raw & Processed Data Links

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
Gene annotations generated by BRAKER3 are available on [Zenodo](https://doi.org/10.5281/zenodo.15048194)
