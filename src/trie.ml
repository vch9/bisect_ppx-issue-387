(* The [Suffix] module is for internal use only (not exported). It is used to
   provide some operations on substrings, but more specifically on substrings
   that are suffixes of the base strings. *)
module Suffix = struct
  (* The [Suffix] module does not declare a specific type. It could use
     [type t = { base: string; start: int}] but this would cause boxing and
     thus allocation. Instead, the functions of the [Suffix] module receive two
     parameters: the base string and the starting offset.

     All the functions in this module assume that the offset is not negative.
     This assumption is correct for all the uses below. *)

  let to_string base offset = String.(sub base offset (length base - offset))

  let out base offset = offset >= String.length base

  (* note: we only ever compare two suffixes starting from the same offset *)
  let equal s1 s2 offset =
    let length = String.length s1 in
    if length <> String.length s2 then
      (* suffixes can't be equal if lengths are different *)
      false
    else if s1 == s2 then true
    else
      let rec aux offset =
        if offset >= length then (* we have reached the end *)
          true
        else if String.unsafe_get s1 offset <> String.unsafe_get s2 offset then
          false
        else aux (offset + 1)
      in
      aux offset
end
