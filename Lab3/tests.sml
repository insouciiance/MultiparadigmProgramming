use "./functions.sml";

fun assert (expected, actual) =
    if expected = actual then
        true
    else
        raise Fail "assert failure.";

(*1*)
assert (
    [
        {first="Fred", last="Smith", middle="W"},
        {first="Fredrick", last="Smith", middle="W"},
        {first="Freddie", last="Smith", middle="W"},
        {first="F", last="Smith", middle="W"}
    ], similar_names(
        [
            ["Fred","Fredrick"],
            ["Elizabeth","Betty"],
            ["Freddie","Fred","F"]
        ], {first="Fred", middle="W", last="Smith"}));

(*2*)
assert (8, officiate(
    [
        (Spades, Jack),
        (Spades, Ace),
        (Clubs, Ace),
        (Hearts, Num(2))
    ],
    [
        Draw,
        Discard(Spades, Jack),
        Draw,
        Draw,
        Draw,
        Discard (Hearts, Num(2))
    ], 30));

assert (6, officiate(
    [
        (Spades, Jack),
        (Spades, Ace),
        (Clubs, Ace),
        (Hearts, Num(2))
    ],
    [
        Draw,
        Discard(Spades, Jack),
        Draw,
        Draw,
        Draw,
        Discard (Hearts, Num(2))
    ], 20));

assert (3, officiate(
    [
        (Spades, Jack),
        (Spades, Ace),
        (Diamonds, Ace),
        (Diamonds, Num(2))
    ],
    [
        Draw,
        Discard(Spades, Jack),
        Draw,
        Draw,
        Draw,
        Discard(Hearts, Num(2))
    ], 20))