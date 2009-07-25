package MyApp::Model::RandomQuote;
use strict;
use warnings;
use parent 'Catalyst::Model';

# The do block makes sure $/ can't escape its scope.
my @Quotes = do { local $/ = "\n\n"; <DATA> } ;

sub get_one : method {
    $Quotes[rand @Quotes];
}

sub get_all : method {
    wantarray ? @Quotes : [ @Quotes ];
}

1;

__DATA__
A house can have integrity, just like a person, and just as seldom.

One can’t love man without hating most of the creatures who pretend to
bear his name.

There is a stage of worship which makes the worshipper himself an
object of reverence.

You know how people long to be eternal. But they die with every day
that passes. When you meet them, they’re not what you met last. In any
given hour, they kill some part of themselves. They change, they deny,
they contradict—and they call it growth. At the end there’s nothing
left, nothing unreversed or unbetrayed; as if there had never been an
entity, only a succession of adjectives fading in and out on an
unformed mass.

Show me your achievement—and the knowledge will give me courage for mine.

She could not have reached this white serenity except as the sum of
all the colors, of all the violence she had known.

They talked quietly, with a feeling of companionship such as that of
an old married couple; as if he had possessed her body, and the wonder
of it had long since been consumed, and nothing remained but an
untroubled intimacy.

…the person who loves everybody and feels at home everywhere is the
true hater of mankind. He expects nothing of men, so no form of
depravity can outrage him.

I have come here to say that I do not recognize anyone’s right to one
minute of my life… It had to be said. The world is perishing from an
orgy of self-sacrificing.

A leash is only a rope with a noose on both ends.

To say “I love you” one must know first how to say the “I.”

I can accept anything, except what seems to be the easiest for most
people: the half-way, the almost, the just-about, the in-between.

It stands to reason that where there’s sacrifice, there’s someone
collecting sacrificial offerings. Where there’s service, there’s
someone being served. The man who speaks to you of sacrifice, speaks
of slaves and masters. And intends to be the master.
