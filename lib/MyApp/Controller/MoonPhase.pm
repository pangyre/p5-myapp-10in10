package MyApp::Controller::MoonPhase;
use strict;
use warnings;
use parent 'Catalyst::Controller';

sub index :Path Args(0) {
    my ( $self, $c ) = @_;
    $c->detach("with_arg", ["now"]);
}

sub with_arg :Path Args(1) {
    my ( $self, $c, $when ) = @_;
    $when ||= "now";
    $c->response->content_type("text/plain; charset=utf-8");
    my $phase = sprintf("The moon $when: %.1f%% full and %s.",
                        $c->model("MoonPhase")->illumination($when) * 100,
                        $c->model("MoonPhase")->is_waxing($when) ? "waxing" : "waning",
                        );
    $c->response->body( $phase );
}

1;
