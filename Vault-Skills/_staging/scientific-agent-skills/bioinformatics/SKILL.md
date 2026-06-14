---
name: bioinformatics
description: Use this skill whenever you need to analyze bioinformatics data including sequence analysis, single-cell RNA-seq, gene regulatory networks, variant annotation, and phylogenetic analysis.
source: K-Dense-AI/scientific-agent-skills (28,135★)
---

# Bioinformatics Analysis

## Overview
Bioinformatics skills for processing and analyzing biological sequence data, transcriptomics, genomics, and phylogenetics using established tools and Python libraries.

## Core Tools
- **Biopython** — sequence I/O, BLAST, Entrez, phylogenetic trees
- **Scanpy** — single-cell RNA-seq analysis
- **gget** — gene/transcript/protein search across 20+ databases
- **PyDESeq2** — differential expression analysis
- **cellxgene-census** — access to CZ CELLxGENE data

## Common Workflows

### 1. Sequence Analysis
```python
from Bio import SeqIO
for record in SeqIO.parse("sequences.fasta", "fasta"):
    print(record.id, len(record.seq))
```

### 2. Single-Cell RNA-seq
```python
import scanpy as sc
adata = sc.read_10x_h5("filtered_feature_bc_matrix.h5")
sc.pp.filter_cells(adata, min_genes=200)
sc.pp.normalize_total(adata, target_sum=1e4)
sc.tl.pca(adata)
sc.pl.pca(adata, color="louvain")
```

### 3. Phylogenetic Analysis
- Align sequences with MAFFT or MUSCLE
- Build trees using neighbor-joining or maximum likelihood
- Visualize with `ete3` or `Bio.Phylo`

## Reference
K-Dense-AI/scientific-agent-skills (28,135★)
