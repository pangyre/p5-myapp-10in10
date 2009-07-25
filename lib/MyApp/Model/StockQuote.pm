package MyApp::Model::StockQuote;
use strict;
use warnings;
use parent 'Catalyst::Model::Adaptor';
__PACKAGE__->config( class => 'Finance::Quote' );

sub prepare_arguments {
    my ( $self, $c ) = @_;
    return $self->{args};
}

sub mangle_arguments {
    my ( $self, $args ) = @_;
    return @{$args||[]}; # Now the args are a plain list.
}

1;
