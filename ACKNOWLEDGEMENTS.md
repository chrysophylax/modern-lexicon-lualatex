# Acknowledgements

## Wiktionary

Sixty sample entries in `lexicon.csv` (the English blends `tablebase` through `Tealiban`) were pulled from [Wiktionary](https://en.wiktionary.org/) — specifically [Category:English blends](https://en.wiktionary.org/wiki/Category:English_blends) — including their definitions, parts of speech, and IPA transcriptions where available.

The pathological page-breaking test entry `set` was likewise built from [Wiktionary's *set* page](https://en.wiktionary.org/wiki/set): all 97 top-level English senses (verb, noun, adjective) and 426 derived terms with their first definitions, used as example lines.

The non-Latin script showcase entries were pulled the same way: 39 Greek nouns (`φα` onward, from [Category:Greek nouns](https://en.wiktionary.org/wiki/Category:Greek_nouns)) and 40 Bulgarian lemmas (`раб` onward, from [Category:Bulgarian lemmas](https://en.wiktionary.org/wiki/Category:Bulgarian_lemmas)), with their English-side definitions, parts of speech, and IPA where available.

Wiktionary content is available under the [Creative Commons Attribution-ShareAlike License (CC BY-SA)](https://creativecommons.org/licenses/by-sa/4.0/). These entries are used here **only as test data to validate the typesetting pipeline**; they are not part of any released dictionary content. If they were ever to be published, proper attribution and share-alike licensing of the affected entries would be required.

## Fonts

The `fonts/` directory vendors:

- [Gentium](https://software.sil.org/gentium/) (version 7.000) — main text font, covering the Latin, Greek and Cyrillic headword scripts — SIL Open Font License (OFL), Version 1.1 (see `fonts/OFL-Gentium.txt`)
- [Charis SIL](https://software.sil.org/charis/) — used for IPA transcriptions only — SIL Open Font License (OFL), Version 1.1

Required as a system font:

- [DejaVu Sans](https://dejavu-fonts.github.io/) — supplies the `◈` (U+25C8) example marker — DejaVu Fonts License (Bitstream Vera / Arev derived)
