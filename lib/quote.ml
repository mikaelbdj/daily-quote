open Notty

let width = 40

let text_attr = A.(fg white ++ st bold ++ st italic)
let rec gen_h_offset = 
  function
  | 0 -> I.empty
  | n -> I.(Draw.blank <|> gen_h_offset (n-1))

let generate_quote_image quote author box_attr h_offset = 
  let quote_img = Draw.text_box quote text_attr box_attr width in
  let format_author = "   \u{02500}\u{02500}" ^ author in 
  let author_attr = A.(box_attr ++ st bold) in
  let author_img = I.(string author_attr format_author) in 
  I.(gen_h_offset h_offset <|> (quote_img <-> author_img))
