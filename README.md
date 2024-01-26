eio_browser
-----------

A browser backend for Eio, extracted from [this
PR](https://github.com/ocaml-multicore/eio/pull/405). Watch out for a properly
supported Javascript/browser library for Eio in the [ocaml-multicore](https://github.com/ocaml-multicore)
organisation at some point.

```ocaml
let () =
  let counter = get_element "counter" in
  let text = get_element "text" in
  let output = get_element "output" in
  let main =
    Eio_browser.run @@ fun () ->
    Fiber.both (fun () ->
        (* A little text editor *)
        while true do
          let ev = Eio_browser.next_event Ev.keyup (El.as_target text) in
          let target = Jv.get (Ev.to_jv ev) "target" in
          let text = Jv.get target "value" |> Jv.to_jstr in
          El.set_children output [ El.txt text ]
        done
      )
      (fun () ->
         (* A little timer counting up *)
         let i = ref 0 in
         while true do
           Eio_browser.Timeout.sleep ~ms:1000;
           incr i;
           El.set_children counter [ El.txt' (string_of_int !i ^ "s")]
         done
      )
  in
  Fut.await main (fun _ -> Console.log [ Jstr.v "Done" ])
```

## Tests

To run the tests you need to first run `dune runtest` then open
`_build/default/test/index.html` in a browser.