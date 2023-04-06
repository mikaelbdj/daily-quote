(lang dune 3.6)

(name daily_quote)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Mikael B. Dahlsen-Jensen")

(maintainers "Mikael B. Dahlsen-Jensen")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name daily_quote)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml dune notty)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
