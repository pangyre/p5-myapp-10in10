package MyApp::Controller::Stock;
use strict;
use warnings;
use parent 'Catalyst::Controller';

sub index :Path :Args(0) {}

sub ajax :Local {
    my ( $self, $c ) = @_;
    my @stocks = $c->request->param("stocks") =~ /(\w+)/g;
    $c->log->debug("Fetching stocks: " . join(", ", @stocks));
    my %raw_quotes = $c->model("StockQuote")->fetch("usa", @stocks);
    my $quotes = _normalize_hash(%raw_quotes);
    $c->stash( results => [ values %{$quotes} ] );
    $c->detach( $c->view("JSON") );
}

sub _normalize_hash {
    my %funky_hash = @_;
    my %hash;
    for my $compound_key ( keys %funky_hash )
    {
        my ( $name, $key ) = split /$;/, $compound_key;
        next unless $name =~ /\w/;
        $hash{$name}{$key} = $funky_hash{$compound_key};
    }
    return \%hash;
}

1;
