---
name: literature-review
description: Use this skill whenever you need to conduct comprehensive, systematic literature reviews using multiple academic databases (PubMed, arXiv, bioRxiv, Semantic Scholar). Creates formatted markdown and PDF output with verified citations.
source: K-Dense-AI/scientific-agent-skills (28,135★)
---

# Literature Review

## Overview
Conduct systematic, comprehensive literature reviews following rigorous academic methodology. Search multiple literature databases, synthesize findings thematically, verify all citations for accuracy, and generate professional output documents.

## When to Use This Skill
- Conducting a systematic literature review for research or publication
- Synthesizing current knowledge on a specific topic across multiple sources  
- Performing meta-analysis or scoping reviews
- Writing the literature review section of a research paper or thesis
- Identifying research gaps and future directions

## Core Workflow

### Phase 1: Planning and Scoping
1. **Define Research Question**: Use PICO framework (Population, Intervention, Comparison, Outcome) for clinical/biomedical reviews
2. **Establish Scope and Objectives**: Define clear research questions, determine review type, set boundaries
3. **Develop Search Strategy**: Identify main concepts, list synonyms, plan Boolean operators, select complementary databases
4. **Set Inclusion/Exclusion Criteria**: Date range, language, publication types, study designs

### Phase 2: Systematic Literature Search
1. **Multi-Database Search**: Search PubMed, arXiv, bioRxiv, Semantic Scholar, and domain-specific databases
2. **Document Search Parameters**: Record database, date searched, search string, and results count
3. **Export and Aggregate Results**: Combine results, deduplicate by DOI

### Phase 3: Screening and Selection
1. Deduplicate results
2. Title screening against criteria
3. Abstract screening with documented exclusions
4. Full-text screening with documented reasons
5. Create PRISMA-style flow diagram

### Phase 4: Data Extraction and Quality Assessment
- Extract study metadata, design, sample size, findings, limitations
- Assess quality using Cochrane ROB (RCTs), Newcastle-Ottawa (observational), AMSTAR 2 (reviews)

### Phase 5: Synthesis and Analysis
- Organize by themes (not study-by-study summaries)
- Compare and contrast approaches and results
- Identify consensus areas and controversies
- Write critical analysis and discussion

### Phase 6: Citation Verification
- Verify all DOIs resolve correctly
- Retrieve metadata from CrossRef
- Format citations consistently (APA, Nature, Vancouver, etc.)

## Pitfalls
- Search too narrow → miss relevant studies; too broad → unmanageable results
- Skipping citation verification leads to broken references
- Presenting study-by-study summaries instead of thematic synthesis
- Not documenting inclusion/exclusion decisions for reproducibility

## Reference
K-Dense-AI/scientific-agent-skills (28,135★) — 147 scientific and research skills
