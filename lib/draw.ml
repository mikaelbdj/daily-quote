open Notty

let blank = I.(string A.empty " ")

let split_string_properly_to_lines (str : string) (width : int) = 
  let words = String.split_on_char ' ' str in

  let rec whitespace n = 
    assert (n >= 0);
    match n with 
    | 0 -> ""
    | n -> whitespace (n - 1) ^ " " in

  let lines, first_line, _ = List.fold_left (fun (lines, current_line, count) word -> 
    let new_count = count + 1 + String.length word in
    if new_count <= width then 
      (lines, word :: current_line, new_count) 
    else
      (List.rev current_line :: lines, [word], 3 + String.length word)
    ) ([], [], 2)  words in
  let all_lines_list = List.rev first_line :: lines in 
  let all_lines = List.map (List.fold_left (fun acc c -> acc ^ " " ^ c) "") all_lines_list in 
  List.map (fun line -> line ^ whitespace (width - String.length line)) all_lines


let text_box (content : string) (content_attr : A.t) (box_attr : A.t) (content_width : int) =
  let top_left = "\u{0250c}" in 
  let top_right = "\u{02510}" in 
  let bot_left = "\u{02514}" in 
  let bot_right = "\u{02518}" in 
  let left = "\u{2502}" in
  let right = "\u{2502}" in 

  let rec line n = match n with
    | 0 -> ""
    | n -> line (n-1) ^ "\u{2500}"
  in

  let lines = split_string_properly_to_lines content content_width in
  let image_lines = List.map (fun line -> I.(string box_attr left <|> string content_attr line <|> string box_attr right)) lines in 
  let body = I.(List.fold_left (<->) (I.empty) (List.rev image_lines)) in

  let top = I.(string box_attr (top_left ^ line content_width ^ top_right)) in
  let bot = I.(string box_attr (bot_left ^ line content_width ^ bot_right)) in
  I.(top <-> body <-> bot)


