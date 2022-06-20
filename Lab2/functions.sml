(*1*)
fun is_older (date1 : int * int * int, date2: int * int * int) =
  if
    #1 date1 < #1 date2
  orelse
    #1 date1 = #1 date2 andalso #2 date1 < #2 date2
  orelse
    #1 date1 = #1 date2 andalso #2 date1 = #2 date2 andalso #3 date1 < #3 date2
  then true
  else false;

(*2*)
fun number_in_month ([], month) = 0
  | number_in_month (((x : int * int * int)::xs), month) =
    (if #2 x = month then 1 else 0) + number_in_month (xs, month);

(*3*)
fun number_in_months (dates, []) = 0
  | number_in_months (dates, x::xs) = number_in_month (dates, x) + number_in_months (dates, xs);

(*4*)
fun dates_in_month ([], month) = []
  | dates_in_month ((x : int * int * int)::xs, month) =
    (if #2 x = month then [x] else []) @ dates_in_month (xs, month);

(*5*)
fun dates_in_months (dates, []) = []
  | dates_in_months (dates, (x : int)::xs) = dates_in_month (dates, x) @ dates_in_months (dates, xs);

(*6*)
fun get_nth ([], _) = ""
  | get_nth ((x : string)::xs, n) = if n = 1 then x else get_nth (xs, n - 1);

val month_names = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "Septemper",
  "October",
  "November",
  "December"
];

(*7*)
fun date_to_string (date : int * int * int) =
  get_nth (month_names, #2 date) ^ " " ^ Int.toString (#3 date) ^ ", " ^ Int.toString (#1 date);

(*8*)
fun number_before_reaching_sum (_, []) = 0 
  | number_before_reaching_sum (sum, (x::xs)) =
  if x < sum then 1 + number_before_reaching_sum (sum - x, xs) else 0;

(*9*)
fun what_month (day) =
  if day > 0 andalso day < 366 then
    number_before_reaching_sum (day, [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]) + 1
  else ~1;

(*10*)
fun month_range (day1, day2) =
  if day1 <= day2 then
    what_month (day1) :: month_range (day1 + 1, day2)
  else [];

(*11*)
fun oldest_date [] = NONE
  | oldest_date [x] = SOME x
  | oldest_date (x::y::xs) = if is_older (x, y) then oldest_date (x::xs) else oldest_date (y::xs);