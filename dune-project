(lang dune 3.6)

(name daily_quote)

(generate_opam_files true)

(source
 (github mikaelbdj/daily-quote))

(authors "Mikael B. Dahlsen-Jensen")

(maintainers "Mikael B. Dahlsen-Jensen")

(license GPL-3.0-only)

(documentation https://github.com/mikaelbdj/daily-quote)

(package
 (name daily_quote)
 (synopsis "Daily pretty-printed quotes")
 (description "Daily pretty-printed quotes")
 (depends ocaml dune notty csv)
 (tags
  (quote pretty print daily terminal)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
