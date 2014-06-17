let read_lines name : string list =
  let ic = open_in name in
  let try_read () =
    try Some (input_line ic) with End_of_file -> None in
  let rec loop acc = match try_read () with
    | Some s -> loop (s :: acc)
    | None -> close_in ic; List.rev acc in
  loop []

type labelPixels = { label: int; pixels: int array }
let slurp_file file =
  List.tl (read_lines file)
  |> List.map (fun line -> Str.split (Str.regexp ",") line )
  |> List.map (fun numline -> List.map (fun (x:string) -> int_of_string x) numline)
  |> List.map (fun line ->
    { label= List.hd line;
      pixels= Array.of_list @@ List.tl line })
  |> Array.of_list

let trainingset = slurp_file "./trainingsample.csv"

let array_fold_left2 f acc a1 a2 =
  let open Array in
  let len = length a1 in
  let rec iter acc i =
    if i = len then acc
    else
      let v1 = unsafe_get a1 i in
      let v2 = unsafe_get a2 i in
      iter (f acc v1 v2) (i+1)
  in
  iter acc 0

let distance p1 p2 =
  let sum = ref 0 in
  for i = 0 to Array.length p1 - 1 do
    let d = p1.(i) - p2.(i) in
    sum := !sum + d * d
  done;
  !sum

let classify (pixels: int array) =
  fst (
    Array.fold_left (fun ((min_label, min_dist) as min) (x : labelPixels) ->
      let dist = distance pixels x.pixels in
      if dist < min_dist then (x.label, dist) else min)
      (max_int, max_int) (* a tiny hack *)
      trainingset
  )

let validationsample = slurp_file "./validationsample.csv"

let num_correct =
  Array.fold_left (fun sum p -> sum + if classify p.pixels = p.label then 1 else 0) 0 validationsample

let _ =
  Printf.printf "Percentage correct:%f\n"
  @@ float_of_int num_correct /. float_of_int (Array.length validationsample) *.100.0
