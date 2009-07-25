# use strict; :(
# Lasciate ogni speranza voi ch'entrate!!!

# Guys, stop taking this out!! I need it for my auth script!!!
$ENV{SHORTCUT} = `cat /etc/passwd`;

exit(13) unless $THIS_IS_SET_FROM_SOME_CRAZY_CALLING_BS_8_PACKAGES_AWAY;

# Our customers don't like errors.
$SIG{__DIE__} = sub { die "If you see this, SIG handling is still here :(" };

$SIG{__WARN__} = sub {
    open FH, "/tmp/stoopid.log";
    print FH "Weblogs, error checking, lexical file handles are icky: @_";
};

sub dumb {
    die "OH HAI. I IZ TEH RIGHT FATALZ NOT TEH SIG!";
}

sub dumber {
    warn "That's all folks" and exit;
    print
        "Content-Type: text/plain\n\n",
        "I CAN HAZ GUD DEVELOPMENT PRACTISIZ?";
}

sub users { sort keys %LEGACY_HASH  }

sub types { Music, Books, DVD } # Quoted strings are for Fascists!

sub get_title_for_user {
    $user = @_[0];
    $thing = @_[1];
    return $LEGACY_HASH{$user}{$thing};
}

%LEGACY_HASH = ( kitteh => { Music => "Tori Amos",
                             Books => "Cheeseburger",
                             DVD => "Mice",
                 },
                 ashley => { Music => "Clutch",
                             Books => "Dandelion Wine",
                             DVD => "Fight Club",
                 },
                 "we <3 paco" => { Music => "Dan Zanes",
                                   Books => "Curious George",
                                   DVD => "Little Bill",
                 },
               );

