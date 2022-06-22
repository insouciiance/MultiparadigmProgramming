(*1*)
fun only_capitals(strings : string list) =
    List.filter (fn str => Char.isUpper(String.sub(str, 0))) strings


(*2*)
fun longest_string1(strings : string list) =
    List.foldl (fn(x, y) => if (String.size (x) > String.size (y)) then x else y) "" strings;


(*3*)
fun longest_string2(strings : string list) =
    List.foldl (fn(x, y) => if (String.size (x) >= String.size (y)) then x else y) "" strings;


(*4*)
fun longest_string_helper(predicate : int * int -> bool) =
    List.foldl (fn(x, y) => if predicate (String.size (x), String.size (y)) then x else y) ""

val longest_string3 = longest_string_helper (fn(x, y) => if (x > y) then true else false)
val longest_string4 = longest_string_helper (fn(x, y) => if (x >= y) then true else false)


(*5*)
val longest_capitalized = longest_string1 o only_capitals


(*6*)
val rev_string = String.implode o List.rev o  String.explode


(*7*)
exception NoAnswer

fun first_answer(func : 'a -> 'b option) (lst : 'a list) =
    case lst of
    [] => raise NoAnswer
  | x::xs => case func(x) of
        NONE=> first_answer func xs
      | SOME value => value


(*8*)
fun all_answers (func : 'a -> ''b list option) (lst : 'a list) =
    let 
        val concat = List.foldl (fn(x, acc) => (case func(x) of SOME value => value @ acc | None => raise Fail "" ))
    in
    case lst of
        [] => SOME []
      | _ => if List.exists (fn x => func(x) = NONE) lst then NONE else SOME (concat [] lst)
    end


datatype pattern = 
    Wildcard
  | Variable of string
  | UnitP
	| ConstP of int
	| TupleP of pattern list
	| ConstructorP of string * pattern

datatype valu = 
    Const of int
  | Unit
  | Tuple of valu list
  | Constructor of string * valu


fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end


(*9*)
val count_wildcards = g (fn _ => 1) (fn _ => 0)


val count_wild_and_variable_lengths = g (fn _ => 1) (fn x => String.size x)


fun count_some_var (str, p) = g (fn _ => 0) (fn s => if str = s then 1 else 0) p;


(*10*)
fun check_pat pat =
  let
    fun list_has_repeats x = List.exists (fn y => x = y)

    fun get_strings x = 
      case x of
        Variable v => [v]
      | TupleP ps => List.concat (List.map get_strings ps)
      | _ => []

    fun check_uniqueness lst =
      case lst of
        [] => true
      | x::xs => if list_has_repeats x xs then false else check_uniqueness (xs)
  in
    check_uniqueness (get_strings pat)
  end
