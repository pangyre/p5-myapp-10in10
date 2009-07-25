package MyApp::Controller::RandomQuote;
use strict;
use warnings;
use parent 'Catalyst::Controller';

sub index :Path Args(0) {
    my ( $self, $c ) = @_;
    $c->detach("quote");
}

sub quote :Local Args(0) {
    my ( $self, $c ) = @_;
    my $quote = $c->model("RandomQuote")->get_one;
    $c->response->content_type("text/html; charset=utf-8");
    $c->response->body($quote);
}

use CGI qw( ol li );
sub show_all :Local Args(0) {
    my ( $self, $c ) = @_;
    my @quotes = $c->model("RandomQuote")->get_all;
    $c->response->content_type("text/html; charset=utf-8");
    $c->response->body( ol( li( \@quotes ) ) );
}

1;
