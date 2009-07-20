use v6;
use Test;

plan 21;

# L<S02/Names/An identifier is composed of an alphabetic character>

{
    sub don't($x) { !$x }

    ok don't(0),    "don't() is a valid sub name (1)";
    ok !don't(1),   "don't() is a valid sub name (2)";

    my $a'b'c = 'foo';
    is $a'b'c, 'foo', "\$a'b'c is a valid variable name";

    eval_dies_ok  q[sub foo-($x) { ... }],
                 'foo- (trailing dash) is not an identifier';
    eval_dies_ok  q[sub foo'($x) { ... }],
                 "foo' (trailing hypen) is not an identifier";
    eval_dies_ok  q[sub foob'4($x) { ... }],
                 "foo4'b is not a valid identifer (not alphabetic after hypen)";
    eval_dies_ok  q[sub foob-4($x) { ... }],
                 "foo4-b is not a valid identifer (not alphabetic after dash)";
    eval_lives_ok q[sub foo4'b($x) { ... }],
                 "foo4'b is a valid identifer";
}

{
    # This confirms that '-' in a sub name is legal.
    my $subname = 'foo-bar';
    my $calls = 0;
    eval "sub $subname \{ \$calls++ \}";
    ok $! !~~ Exception, "can define $subname";
    eval_lives_ok "$subname()", "can call $subname";
    is $calls, 1, "$subname was called";
}

# RT #64656
#?rakudo skip 'RT #64656'
{
    my $subname = 'do-check';
    my $calls = 0;
    eval "sub $subname \{ \$calls++ \}";
    ok $! !~~ Exception, "can define $subname";
    #?rakudo 2 todo 'RT #64656'
    eval_lives_ok "$subname()", "can call $subname";
    is $calls, 1, "$subname was called";

    # check with a different keyword
    sub if'a($x);
    is if'a(5), 5, "if'a is a valid sub name";
}

#?rakudo skip 'RT #64656'
{
    my $subname = 'sub-check';
    my $calls = 0;
    eval "sub $subname \{ \$calls++ \}";
    ok $! !~~ Exception, "can define $subname";
    #?rakudo 2 todo 'RT #64656'
    eval_lives_ok "$subname()", "can call $subname";
    is $calls, 1, "$subname was called";
}

#?rakudo skip 'RT #64656'
{
    my $subname = 'method-check';
    my $calls = 0;
    eval "sub $subname \{ \$calls++ \}";
    ok $! !~~ Exception, "can define $subname";
    #?rakudo 2 todo 'RT #64656'
    eval_lives_ok "$subname()", "can call $subname";
    is $calls, 1, "$subname was called";
}

# vim: ft=perl6
