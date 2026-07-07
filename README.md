# Dictionary Sample

A print-ready dictionary built with **LuaLaTeX**. Entries live in `lexicon.csv` and are parsed at compile time by an embedded Lua CSV engine in `dictionary.tex`.

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
| `IPA` | yes | Raw IPA transcription (not LaTeX-escaped). |
| `POS` | yes | Part of speech, e.g. `n`, `adj`, `v`. |
| `Definition` | yes | Quote the field (`"..."`) if it contains commas; use `""` for literal quotes. |
| `Examples` | no | Semicolon-separated pairs: `expression: definition;expression 2: definition;`. Split on the *first* colon. Use `~` as a placeholder for the headword. |

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
- `luacode`

System fonts:

- **Charis SIL** — main text font
- **DejaVu Sans** — supplies the `◈` (U+25C8) example marker missing from Charis SIL
