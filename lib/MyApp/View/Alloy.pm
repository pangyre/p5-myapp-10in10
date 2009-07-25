package MyApp::View::Alloy;
use strict;
use warnings;
no warnings "uninitialized";
use parent "Catalyst::View::TT::Alloy";

__PACKAGE__->config
    (
     ENCODING => 'UTF-8',
     TEMPLATE_EXTENSION => ".tt",
     CATALYST_VAR => "c", # Default but let's be explicit.
     FILTERS => {
         price => sub {
             my $text = reverse $_[0];
             $text =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/g;
             return scalar reverse $text;
         },
     },
     );

1;
