use "functions.sml";

fun assert (expected, actual) =
    if expected = actual then
        true
    else
        raise Fail "assert failure.";

val dates = [
    (1986, 5, 26),
    (2019, 6, 12),
    (1770, 12, 5),
    (1950, 1, 8),
    (2007, 3, 19),
    (1822, 5, 2),
    (1999, 12, 31),
    (2000, 1, 1),
    (1492, 8, 24),
    (2004, 7, 30)
];

(*1*)
assert (false, is_older ((2022, 2, 3), (2022, 2, 3)));
assert (true, is_older ((1990, 8, 3), (1990, 9, 12)));
assert (false, is_older ((1789, 12, 4), (1788, 9, 15)));

(*2*)
assert (2, number_in_month (dates, 1));
assert (1, number_in_month (dates, 7));
assert (0, number_in_month (dates, 9));

(*3*)
assert (3, number_in_months (dates, [1, 2, 3]));
assert (2, number_in_months (dates, [10, 11, 12]));
assert (10, number_in_months (dates, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));

(*4*)
assert ([], dates_in_month (dates, 11));
assert ([(2007, 3, 19)], dates_in_month (dates, 3));
assert ([(1950, 1, 8), (2000, 1, 1)], dates_in_month (dates, 1));

(*5*)
assert ([], dates_in_months (dates, [9, 10, 11]));
assert ([(1950, 1, 8), (2000, 1, 1), (1986, 5, 26), (1822, 5, 2)], dates_in_months (dates, [1, 4, 5]));
assert ([(2004, 7, 30)], dates_in_months (dates, [7]));

(*6*)
assert ("April", get_nth (month_names, 4));
assert ("June", get_nth (month_names, 6));
assert ("December", get_nth (month_names, 12));

(*7*)
assert ("December 5, 2020", date_to_string ((2020, 12, 5)));
assert ("July 12, 1872", date_to_string ((1872, 7, 12)));
assert ("October 8, 1234", date_to_string ((1234, 10, 8)));

(*8*)
assert (5, number_before_reaching_sum (11, [3, 2, 5, 0, 0, 100, 23, 1]));
assert (2, number_before_reaching_sum (30, [16, 12, 9, 12, 1]));
assert (0, number_before_reaching_sum (100, [160, 12, 9, 12, 1]));

(*9*)
assert (1, what_month (31));
assert (5, what_month (140));
assert (11, what_month (334));

(*10*)
assert ([1, 1, 1, 1, 1], month_range (1, 5));
assert ([], month_range (101, 100));
assert ([11, 11, 12, 12], month_range (333, 336));

(*11*)
assert (SOME (1492, 8, 24), oldest_date (dates));
assert (NONE, oldest_date ([]));