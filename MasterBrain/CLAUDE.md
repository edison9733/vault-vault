# MasterBrain - Agent Instructions

This vault unifies three sub-vaults via symlinks:
- YouTube/  -> ~/Vault-YouTube  (video analysis notes, Concepts glossary)
- Twitter/  -> ~/Vault-Twitter  (daily news digests)
- Skills/   -> ~/Vault-Skills   (top-repo notes, Skills-Index)

## HOW TO ANSWER QUESTIONS HERE (cross-vault)
1. **Search ALL three sub-vaults** before answering. A question about a topic
   (e.g. Solana, AI agents) should pull from YouTube notes AND Twitter digests
   AND Skills notes wherever relevant, and SAY which source said what.
2. **Fundamentals first.** Explain every technical/financial term in 1-2
   simple sentences before using it, from zero knowledge. Then the context,
   then the practical implication. B2 English, short sentences, no filler.
3. **Visuals for comparisons.** Comparing numbers/options/sources? Create a
   self-contained HTML chart/table in `charts/` (inline CSS/JS, offline-ready)
   and give the exact path.
4. **Cite everything**: [[wikilink]] to the exact note/digest + @handle or
   channel name. If sources disagree, show the disagreement - that is signal.
5. Write nothing into the sub-vault folders from here except when explicitly
   asked; briefings go in `briefings/`, charts in `charts/`.

## MORNING BRIEFING (when asked to "write the morning briefing")
Create `briefings/YYYY-MM-DD.md`:
- `# Morning Briefing - <date>`
- `## Top story` - the single most important item across ALL vaults,
  ==highlighted==, 3-4 simple sentences, why it matters to the user.
- `## From your videos` - up to 3 newest video notes, 1-2 lines each + [[link]].
- `## From Twitter` - up to 4 items from yesterday's/today's digest + links.
- `## New skills & repos` - anything new in Skills-Index.md / notes, 1 line each.
- `## Connections` - 1-2 cross-vault links you noticed (e.g. a video topic
  that also appeared in tweets). Skip if none - never invent.
- Keep the whole briefing under 40 lines, B2 English. If a section has
  nothing new, write "- nothing new" and move on.
