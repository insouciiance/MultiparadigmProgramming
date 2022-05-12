(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2;

(* put your solutions for problem 1 here *)

fun all_except_option(str : string, lst : string list) =
   let
      fun tail_traverse([]) = []
        | tail_traverse(x::xs) =
            if same_string(str, x) then tail_traverse (xs) else ([x] @ tail_traverse (xs))
      val result = tail_traverse(lst)
   in
      if result <> lst then SOME result else NONE
   end

fun get_substitutions1([], _) = []
  | get_substitutions1((s::xs), str : string) =
         (case all_except_option (str, s) of
            SOME sublist => sublist
          | NONE =>  []) @ get_substitutions1 (xs, str);

fun get_substitutions2(lst, str : string) =
   let
      fun tail_traverse([]) = []
        | tail_traverse((s::xs)) =
         (case all_except_option (str, s) of
            SOME sublist => sublist
          | NONE =>  []) @ tail_traverse (xs);
   in
      tail_traverse (lst)
   end;

fun similar_names(lst, { first : string, middle : string, last : string }) =
   let
      fun tail_traverse([]) = []
        | tail_traverse(x::xs) =
            [{ first = x, middle = middle, last = last }] @ tail_traverse (xs)
   in
      [{first = first, middle = middle, last = last}] @ tail_traverse (get_substitutions1 (lst, first))
   end;

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades;
datatype rank = Jack | Queen | King | Ace | Num of int; 
type card = suit * rank;

datatype color = Red | Black;
datatype move = Discard of card | Draw;

exception IllegalMove;

(* put your solutions for problem 2 here *)
fun card_color(suit, _) =
   case suit of
      (Spades | Diamonds) => Black
    | (Hearts | Clubs) => Red;
   
fun card_value(_, rank) : int =
   case rank of
      Ace => 11
    | Num n => n
    | _ => 10

fun remove_card(cards : card list, c : card, e) =
   let
      fun tail_traverse([]) = []
        | tail_traverse(x::xs) =
            if c = x then xs else ([x] @ tail_traverse (xs))
      val result = tail_traverse (cards)
   in
      if result <> cards then result else raise e
   end

fun all_same_color([]) = true
  | all_same_color([x]) = true
  | all_same_color(x::y::xs) = (card_color (x) = card_color (y)) andalso all_same_color ([y] @ xs)

fun sum_cards(lst : card list) =
   let
      fun tail_traverse([]) = 0
        | tail_traverse(x::xs) =
            card_value (x) + tail_traverse (xs)
      val result = tail_traverse (lst)
   in
      result
   end

fun score(lst : card list, goal : int) =
   let
      val cards_sum = sum_cards (lst)
      val preliminaryScore = if cards_sum <= goal then (goal - cards_sum) else (3 * (cards_sum - goal))
   in
      if all_same_color(lst) then (preliminaryScore div 2) else preliminaryScore
   end

fun officiate(cards : card list, moves : move list, goal : int) =
   let
      fun process_move(cards : card list, hand : card list, moves : move list) =
         case moves of
            [] => score (hand, goal)
          | (m::ms) => case m of
               Draw => (case cards of
                  [] => score (hand, goal)
                | (c::cs) => if sum_cards ([c] @ hand) > goal
                              then score([c] @ hand, goal)
                              else process_move (cs, [c] @ hand, ms))
             | Discard card => case hand of
                  [] => raise IllegalMove
                | _ => process_move (cards, remove_card (hand, card, IllegalMove), ms)
   in
      process_move (cards, [], moves)
   end;
