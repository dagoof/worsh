type user =
    { name : string
    ; email : string
    }
and pack =
    { user : user
    ; caption : string
    ; images : string list
    ; plates : int
    ; bowls : int
    ; pots : int
    ; pans : int
    }
with orm

let json_of_user user =
    let open Ezjsonm in
    dict
    [ "name", string user.name
    ; "email", string user.email
    ]

let json_of_pack pack =
    let open Ezjsonm in
    dict
    [ "user", json_of_user pack.user
    ; "caption", string pack.caption
    ; "images", ( list string ) pack.images
    ; "plates", int pack.plates
    ; "bowls", int pack.bowls
    ; "pots", int pack.pots
    ; "pans", int pack.pans
    ]
