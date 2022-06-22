use "./functions.sml";

fun assert (expected, actual) =
    if expected = actual then
        true
    else
        raise Fail "assert failure.";

(*1*)
assert(only_capitals(["ABC", "Abc", "abc", "aBC"]), ["ABC", "Abc"]);
assert(only_capitals(["foo", "abc", "abc", "aBC"]), []);

(*2*)
assert(longest_string1(["ABC", "Abc", "abc", "aBC"]), "ABC");
assert(longest_string1([]), "");

(*3*)
assert(longest_string2(["ABC", "Abc", "abc", "aBC"]), "aBC");
assert(longest_string2([]), "");

(*4*)
assert(longest_string3(["ABC", "Abc", "abc", "aBC"]), "ABC");
assert(longest_string3([]), "");
assert(longest_string4(["ABC", "Abc", "abc", "aBC"]), "aBC");
assert(longest_string4([]), "");

(*5*)
assert(longest_capitalized(["ABC", "Abc", "AAAA", "abc", "aBC"]), "AAAA");
assert(longest_capitalized([]), "");

(*6*)
assert(rev_string("ABC"), "CBA");
assert(rev_string(""), "");

(*7*)
assert(first_answer (fn x => if String.size (x) > 3 then SOME x else NONE) ["abc", "ab", "", "abcd"], "abcd");

(*8*)
assert(all_answers (fn x => if String.size (x) > 3 then SOME [x] else NONE) ["abc", "fooo", "ab", "", "abcd"], NONE);

(*9*)
assert(count_wildcards(TupleP [Wildcard, Wildcard, TupleP [Wildcard]]), 3);
assert(count_wildcards(TupleP [Wildcard, Wildcard, TupleP [Wildcard, Wildcard]]), 4);

assert(count_wild_and_variable_lengths(TupleP [Wildcard, Wildcard, TupleP [Wildcard]]), 3);
assert(count_wild_and_variable_lengths(TupleP [Wildcard, Variable "foo"]), 4);

assert(count_some_var("foo", TupleP [Wildcard, Variable "foo", TupleP [Variable "foo"]]), 2);
assert(count_some_var("foo", Wildcard), 0);

(*10*)
assert(check_pat(TupleP [Wildcard, Wildcard, TupleP [Wildcard]]), true);
assert(check_pat(TupleP [Variable "foo", Variable "baz"]), true);
assert(check_pat(TupleP [Variable "foo", Variable "baz", TupleP [Variable "foo"]]), false);