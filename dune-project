(lang dune 3.10)

(name eio_browser)

(generate_opam_files true)

(package
  (name eio_browser)
  (depends
    eio
    brr
    alcotest :with-test))