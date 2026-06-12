# Vault-YouTube - Agent Instructions

This Obsidian vault holds YouTube transcripts (raw/) and analysis notes (notes/).

Input: .srt files in raw/, named `YYYY-MM-DD - Title [VIDEOID].en.srt`.

For each transcript with NO matching note in notes/ (match by VIDEOID in filename):

1. Read the transcript. Ignore srt timestamps and sequence numbers.
2. Create `notes/YYYY-MM-DD - Title [VIDEOID].md`.
3. Frontmatter: title, channel (if inferable), video_url (https://youtube.com/watch?v=VIDEOID), date, tags.
4. Sections, in this order:
   - `## Summary` - exactly 3 bullets.
   - `## Key Points` - the substance, with bolded **keywords**.
   - `## Notable Quotes` - max 3, only if genuinely notable.
   - `## Concepts` - list of [[wikilinked]] concepts.
5. For every important concept, ensure a stub note exists in `Concepts/`
   (2-3 lines) so videos sharing ideas connect in the graph view.
6. ==Highlight== the single biggest insight of the video.
7. Never modify or delete anything in raw/. Never delete notes.
8. If there are no unprocessed transcripts, say "nothing to do" and stop.
   Do not re-read old notes. Be concise; no filler.

<!-- MEMORY-LAYER v1 (machine-maintained memory; safe to reset _memory/ files anytime) -->
## Accumulated memory (auto-loaded every run)
@_memory/LEARNINGS.md
@_memory/INSIGHTS.md

## REFLECTION STEP (run at the END of every analysis run)
After writing notes and concept stubs (skip entirely if there was nothing to do):

1. **INSIGHTS.md** - update the recurring-concepts and channel-themes map:
   add or increment concepts that appeared today, add newly discovered
   cross-links between [[Concepts]]. Keep its existing headers. Max 150 lines.
2. **LEARNINGS.md** - append at most **1-3 new rules**, only if genuinely new
   and generalizable (naming conventions, recurring wikilink patterns,
   channel-specific gotchas):
   - Dedupe first: refine an existing similar rule in place instead of adding
     a duplicate. Never add a rule that contradicts an existing one - replace
     the old one and note the change.
   - Format: `- [YYYY-MM-DD] <imperative rule>`
   - Hard cap 100 lines. If adding would exceed it, do NOT add - put
     `> NEEDS CONSOLIDATION` at the top instead; the weekly job compacts it.
3. You may ONLY write to: _memory/, notes/, Concepts/. NEVER edit CLAUDE.md,
   _scripts/, or raw/.
4. Keep reflection terse - housekeeping, not analysis.

<!-- EXPLAIN-LAYER v1 (teaching style for chat + concept glossary rules) -->
## HOW TO ANSWER QUESTIONS IN THIS VAULT (interactive chat sessions)
When the user asks you questions in this vault (not during automated note runs),
follow this teaching style strictly:

1. **Fundamentals first.** Before using any technical term, financial metric,
   or jargon, explain it in one or two simple sentences, as if the reader has
   never seen it. Example: do NOT say "P/S 109x" without first explaining:
   "P/S means price-to-sales: the company's total market price divided by one
   year of its sales. P/S of 109 means you pay 109 dollars for every 1 dollar
   of yearly sales - extremely expensive."
2. **Then the context.** Connect the fundamentals to what the video actually
   said, step by step: basic idea -> what the creator claims -> the numbers.
3. **Then the implication.** End with what it means in practice for the user
   (one short paragraph). No filler, no hype, no vague conclusions.
4. **Language level: B2 English.** Short sentences. Common words. Define every
   abbreviation the first time. Keep Chinese key terms from transcripts in
   parentheses after the English term when helpful.
5. **Visuals for numbers.** If the answer compares 2+ numbers, companies, or
   options, ALWAYS offer or create a chart/table as a self-contained HTML file
   saved to `charts/` (e.g. `charts/2026-06-12-spacex-vs-amazon.html`):
   - Single .html file, no external dependencies (inline CSS/JS only),
     dark-mode friendly, opens in any browser.
   - Simple bar/line charts can be pure HTML/CSS; only use inline JS if needed.
   - After saving, tell the user the exact file path to open.
   - A markdown table inside the chat answer is also fine for small comparisons;
     use the HTML file when a visual chart genuinely helps.
6. Cite which note/video each claim comes from with a [[wikilink]].

## CONCEPT GLOSSARY RULES (automated note runs)
Automated analysis notes stay compact (do NOT add fundamentals sections to
notes). Instead, the Concepts/ folder is a growing B2-level glossary:

1. When a note needs a [[Concept]] that has no file yet in Concepts/, create it
   with this structure (10-20 lines max):
   - `# <Concept name>`
   - **What it is** - 2-3 simple B2-English sentences, from zero knowledge.
   - **Why it matters** - 1-2 sentences.
   - **Example** - one concrete example, ideally from the video that
     introduced it.
   - `## Seen in` - list of [[note wikilinks]] that reference it.
2. When a later note references an EXISTING concept, append that note's
   [[wikilink]] under its `## Seen in` list (one line). Do not rewrite the
   explanation unless it is wrong.
3. Concept stubs that already exist as 2-3 line placeholders: upgrade them to
   the full structure the next time a note references them.
4. This way explanations are written ONCE, reused forever, and every concept
   page shows all videos that touched it.
