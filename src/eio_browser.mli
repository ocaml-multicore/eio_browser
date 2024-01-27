module Timeout : sig
  val sleep : ms:int -> unit
  (** Non-blocking timeout that waits for [ms] millseconds. *)
end

val await : 'a Fut.t -> 'a
(** [await fut] blocks on the promise [fut] and allows other fibers to do work. *)

val next_event : 'a Brr.Ev.type' -> Brr.Ev.target -> 'a Brr.Ev.t
(** [next_event typ target] blocks until an event of type [typ] arrives
    on the [target]. *)

(** {1 Main loop} *)

val run : (unit -> 'a) -> 'a Fut.t
(** [run main] runs [main] whose result is returned as a promise. *)

val global_switch : unit -> Eio.Switch.t
(** [global_switch ()] will give you an Eio switch that wraps the main function
    passed to {! run}. This is somewhat bad practice in terms of Eio's
    recommendations for using a switch. However, the programming model in
    the browser is different. *)
