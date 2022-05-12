use "./functions.sml";

fun assert (expected, actual) =
    if expected = actual then
        true
    else
        raise Fail "assert failure.";

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