open Buffet6

type (+'a, 'k) witness =
  | Bytes : (_, [ rd | wr ] Bytes.t) witness
  | String : (_, rd String.t) witness
  | Bigstring : (_, [ rd | wr | async] Bigstring.t) witness

let string : (rd as 'a, 'a String.t) witness = String
let bytes : ([ rd | wr] as 'a, 'a Bytes.t) witness = Bytes
let bigstring : ([ rd | wr | async] as 'a, 'a Bigstring.t) witness = Bigstring

let get : type k. ([> rd], k) witness -> k -> int -> char =
  fun w b s -> match w with
    | String -> String.get b s
    | Bytes -> Bytes.get b s
    | Bigstring -> Bigstring.get b s

let unsafe_get : type k. ([> rd], k) witness -> k -> int -> char =
  fun w b s -> match w with
    | String -> String.unsafe_get b s
    | Bytes -> Bytes.unsafe_get b s
    | Bigstring -> Bigstring.unsafe_get b s

let set : type k. ([> wr], k) witness -> k -> int -> char -> unit =
  fun w b s off -> match w with
    | Bytes -> Bytes.set b s off
    | Bigstring -> Bigstring.set b s off
    | String -> invalid_arg "read string"

let unsafe_set : type k. ([> wr], k) witness -> k -> int -> char -> unit =
  fun w b s off -> match w with
    | Bytes -> Bytes.unsafe_set b s off
    | Bigstring -> Bigstring.unsafe_set b s off
    | String -> invalid_arg "read string"
