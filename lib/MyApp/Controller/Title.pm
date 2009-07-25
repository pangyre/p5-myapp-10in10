package MyApp::Controller::Title;
use strict;
use warnings;
use parent 'Catalyst::Controller';

sub index :Path Args(0) {
    my ( $self, $c, $text ) = @_;
    $text ||= $c->request->param("title") || "catalyst";
    my $src = $c->model("Title")->heading($text);
    $c->stash( template => "title/index.tt",
               img => { title => $text,
                        src => $src } );
}

sub with_arg :Path Args(1) {
    my ( $self, $c, $text ) = @_;
    $c->detach("index", [ $text ]);
}

sub src :Local Args(1) {
    my ( $self, $c, $text ) = @_;
    return $c->model("Title")->heading($text);
}

1;
