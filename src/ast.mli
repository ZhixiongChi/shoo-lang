type size =
  Fixed of int
| Param of string

type typ =
Void
| Int
| Float
| Bool
| String
| Func of functyp
| Struct of string
| Array of typ

and functyp = {
    recursive : bool;
    param_typs : typ list;
    return_typ : typ;
}

type op = 
  Add 
| Sub 
| Mult 
| Div 
| Equal
| Mod
| Neq 
| Less 
| Leq 
| Greater
| Geq 
| And 
| Or

type uop = 
  Neg 
| Not

type pop = 
| Dec 
| Inc

type bind = typ * string

type newable =
  NArray of typ * expr
| NStruct of string

and expr =
  IntLit of int
| FloatLit of float
| StrLit of string
| BoolLit of bool
| ArrayLit of expr list
| Id of string
| Binop of expr * op * expr
| Unop of uop * expr
| Pop of expr * pop 
| Assign of expr * expr
| FCall of string * expr list
| FExpr of fexpr
| StructInit of (string * expr) list
| Destruct of string list * expr
| ArrayAccess of string * expr
| Dot of expr * string
| New of newable

and fexpr = {
    recursive : bool; 
    name : string;
    typ : typ;
    params: bind list;
    body : stmt list
}

and stmt =
  Expr of expr
| VDecl of typ * string * expr option
| Return of expr
| FDecl of string * (typ * string) list * typ * stmt list * bool
| If of expr * stmt list * stmt list
| ForLoop of (stmt option) * (expr option) * (expr option) * stmt list
| StructDef of string * (typ * string * expr option) list
| EnhancedFor of typ * string * expr * stmt list

type program = stmt list
