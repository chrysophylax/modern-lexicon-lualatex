# Dictionary Sample

A (NOT YET) print-ready dictionary built with **LuaLaTeX**. Entries live in `lexicon.csv` and are parsed at compile time by a Lua CSV engine.
Abbreviations live in `abbreviations.csv` as a three column CSV. You may have to run `lualatex` twice when building this project.

Example words are pulled from either programatically generated sources, Wikipedia's Wiktionary project or just mad writing by me. 

All project-written _code_ is released under https://creativecommons.org/publicdomain/zero/1.0/ ; the impressum's copyright claim is a placeholder only and has no legal meaning.

## Project layout

| File | Role |
|---|---|
| `dictionary.tex` | The document: page design (geometry, fonts, grid, running-head layout), front matter, `\builddictionary{lexicon.csv}` call. |
| `dictionary-tools.sty` | Typesetting machinery: entry/sense/example/letter macros, running-head mark classes, engine loader, config setters. |
| `dictionary-tools.lua` | The engine: CSV parsing, definition/label/sense formatting, custom collation, index keys. Emits the macros defined in the `.sty` (the contract is documented in both file headers). |
| `lexicon.csv` | The entries (see *CSV format*). |
| `sortorder.txt` | Optional collation alphabet (see *Sort order*). |
| `dictionary-abbreviations.sty` | Styling for the abbreviations table. |
| `dictionary-abbreivations.lua` | Parses 3-column CSV for abbreviations table. |
| `abbreviations.csv` | your csv of abbreviations! Three columns. Simple. |

## Building

Compile with LuaLaTeX (plain `pdflatex`/`xelatex` will not work — the parser relies on `\directlua`):

```sh
lualatex dictionary.tex
```

## CSV format (`lexicon.csv`)

```csv
Word,IPA,POS,Definition,Examples
acumen,əˈkjuː.mən,n & f,"The ability to make good judgments...",business ~: shrewd judgment in commercial dealings;
```

| Column | Required | Notes |
|---|---|---|
| `Word` | yes | Headword. Lowercase unless a proper noun. |
| `IPA` | yes | Raw IPA transcription (not LaTeX-escaped). May be empty — no brackets are printed then. |
| `POS` | yes | Part of speech, e.g. `n`, `adj`, `v`. |
| `Definition` | yes | Quote the field (`"..."`) if it contains commas; use `""` for literal quotes. See *Definition markup* below. |
| `Examples` | no | Semicolon-separated pairs: `expression: definition;expression 2: definition;`. Split on the *first* colon. Use `~` as a placeholder for the headword — automatically mapped to a swung dash. An item **without** a colon is not a new example — it continues the previous definition and is rejoined with `;`, so example definitions may safely contain semicolons (but not colons). |

### Definition markup

- **Multiple senses** are numbered inline: `1. first sense 2. second sense` (1–2 digits, e.g. `12.`). Sense numbers are automatically emboldened when preceded by whitespace or at field start.
- **Usage labels** in parentheses — `(UK, slang, derog.)`, `(figuratively)` — are automatically italicized, but *only* in expansion-initial position: at the very start of a sole unnumbered definition, or right after a full stop (which includes right after a sense number). Parentheticals in running text stay upright.

## Sort order (`sortorder.txt`)

Optional file listing every sortable "letter" separated by commas and/or blanks (both work). Letters may be multi-character digraphs (`Ll`, `Ch`) or diacritics (`Č`), so languages that collate these separately are handled; matching is case-insensitive and headline letters print exactly as written in the file. When present:

- entries are sorted by this custom collation (characters not listed sort last),
- each letter opens a **new page** with a large headline letter,
- the back index follows the same collation (via generated makeindex sort keys).

Without the file, entries flow in CSV order with no letter pages.

A different filename can be set in the preamble: `\dictsortorderfile{my-alphabet.txt}`.

## Page breaking policy

Print dictionaries never let an entry dribble onto the next page — but they also never push a giant entry to a fresh page (that would leave a hole). This project follows the same graded policy, keyed off a sense-split threshold (characters of raw definition, default `600` in `dictionary-tools.lua`, tunable from the preamble via `\dictsensethreshold{600}`):

1. **Normal entries** (≤ threshold): headword + definition + all examples form one unbreakable block. If it doesn't fit the current column, the whole block moves to the next column/page and the previous column runs short (accepted grid trade-off; expect underfull `\vbox` warnings with `\flushbottom`).
2. **Large entries** (> threshold): the *sense-level fallback*. The headword plus sense `1.` stay one unbreakable block (the headword can never be orphaned); every further numbered sense is its own unbreakable paragraph, with breaks allowed **between** senses. The first example is glued to the entry; further examples may break freely (each example line itself stays whole).
3. **Multi-page entries**: when a page begins in the middle of a still-open entry, the running head automatically gains a continuation note — `word — word2  (set, cont.)` — the classic *cont.* marker. This is driven by a kernel mark class (`dictcont`, LaTeX 2022+ `\NewMarkClass`) set at entry start and cleared at entry end; no manual tagging needed.

The pathological test case is the `set` entry in `lexicon.csv` (97 senses, 426 derived-term examples, pulled from Wiktionary).

## Encoding: UTF-8 only

The CSV **must be saved as UTF-8 (without BOM)**. The IPA column and the example marker rely on multi-byte Unicode characters; any other encoding (Latin-1, Windows-1252) will produce garbled phonetics or break the Lua parser. Configure your editor/spreadsheet export accordingly.

## Requirements

LaTeX packages (all included in TeX Live / MiKTeX):

- `geometry`
- `fontspec`
- `xcolor`
- `microtype`
- `imakeidx`
- `fancyhdr`

System fonts:
- **Gentium** — main text font
- **Charis SIL** — main IPA text font
- **Dejavu Serif** — main fallback font
- **DejaVu Sans** — supplies only the `◈` (U+25C8) example marker
