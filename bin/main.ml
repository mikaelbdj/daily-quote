open Notty
open Lib

let parse_color = 
  function 
  | "red" -> Some A.(fg red)
  | "black" -> Some A.(fg black)
  | "green" -> Some A.(fg green)
  | "yellow" -> Some A.(fg yellow)
  | "blue" -> Some A.(fg blue)
  | "magenta" -> Some A.(fg magenta)
  | "cyan" -> Some A.(fg cyan)
  | "white" -> Some A.(fg white)
  | "lightblack" -> Some A.(fg lightblack)
  | "lightred" -> Some A.(fg lightred)
  | "lightgreen" -> Some A.(fg lightgreen)
  | "lightyellow" -> Some A.(fg lightyellow)
  | "lightblue" -> Some A.(fg lightblue)
  | "lightmagenta" -> Some A.(fg lightmagenta)
  | "lightcyan" -> Some A.(fg lightcyan)
  | "lightwhite" -> Some A.(fg lightwhite)
  | _ -> None
  
let default_h_offset = 10
let default_box_attr = A.(fg blue)
let default_box_width = 40

let () =
  let input_csv = ref "" in 
  let h_offset = ref default_h_offset in 
  let box_color_attr = ref default_box_attr in 
  let box_width = ref default_box_width in
  let daily = ref true in 
  let usage_msg = "dailyquote [-color] [-offset] [-width] [-daily] <file.csv>" in

  let set_file file = 
    if not (Sys.file_exists file) then 
      raise @@ Arg.Bad "File not found";
    if not (String.ends_with file ~suffix:".csv") then
      raise @@ Arg.Bad "Not a .csv file";
    input_csv := file
    in
  let set_color color = 
    match parse_color color with
    | None -> raise @@ Arg.Bad "Not a recognized color"
    | Some attr -> box_color_attr := attr
  in 

  let speclist = 
    [("-color", Arg.String set_color, "Set the color of the box (default: blue)");
     ("-offset", Arg.Set_int h_offset, Printf.sprintf "Set the horizontal offset of the box (default: %d)" default_h_offset);
     ("-width", Arg.Set_int box_width, Printf.sprintf "Set the width of the box (default: %d)" default_box_width);
     ("-daily", Arg.Bool (fun b -> daily := b), "Set whether the quote is daily or random each time (default: true)")] in 

  Arg.parse speclist set_file usage_msg;


  let seconds = (Unix.localtime (Unix.time())).tm_sec in 
  let day = (Unix.localtime (Unix.time())).tm_yday in
  if !daily then Random.init day else Random.init seconds;

  let quote_csv = Csv.load !input_csv in 
  let row = (Random.int @@ Csv.lines quote_csv - 2) + 1 in 
  
  let quote_array = Csv.to_array quote_csv in 
  let daily_quote = quote_array.(row) in 
  let quote = daily_quote.(0) in 
  let author = daily_quote.(1) in 
  
  let quote_img = Quote.generate_quote_image quote author !box_color_attr !h_offset !box_width in 
  I.(quote_img <-> Draw.blank <-> Draw.blank) |> Notty_unix.output_image