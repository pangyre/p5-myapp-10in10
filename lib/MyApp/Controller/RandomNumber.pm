package MyApp::Controller::RandomNumber;
use strict;
use warnings;
use parent 'Catalyst::Controller';

sub index :Path Args(0) {
    my ( $self, $c ) = @_;
    my $number = $c->model("RandomNumber")->generate;
    $c->response->body($number);
}

sub d6 :Local Args(0) {
    my ( $self, $c ) = @_;
    my $number = $c->model("RandomNumber")
        ->generate({ lower_bound => 1,
                     upper_bound => 6,
                     integer => 1
                     });
    $c->response->body($number);
}


1;
