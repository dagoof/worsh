open Opium.Std

let dbname = "wash.db"

let u_db = Data.user_init dbname

let p_db = Data.pack_init dbname

let base_user ~name =
    { Data.email = Printf.sprintf "%s@example.com" name
    ; name
    }

let base_pack ~user ~caption =
    { Data.user
    ; caption
    ; images = []
    ; plates = 0
    ; bowls = 0
    ; pots = 0
    ; pans = 0
    }

let echo = get "/" begin fun req ->
    `String "hello"
    |> respond'
end

let packs = get "/packs" begin fun req ->
    let packs = Data.pack_get p_db in
    `Json ( Ezjsonm.list Data.json_of_pack packs )
    |> respond'
end


let store_pack = get "/store/:user/:caption" begin fun req ->
    let user = base_user ( param req "user" ) in
    let pack = base_pack user ( param req "caption" ) in
    Data.pack_save p_db pack;
    `String ( Printf.sprintf "Stored %s" user.name )
    |> respond'
end


let () =
    App.empty
    |> echo
    |> packs
    |> store_pack
    |> App.run_command
