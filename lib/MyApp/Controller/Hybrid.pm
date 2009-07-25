package MyApp::Controller::Hybrid;
use strict;
use warnings;
use parent 'Catalyst::Controller';

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $type = $c->request->param("type");
    my $user = $c->request->param("user");

    s/[^[:print:]]|\A\s+|\s+\z//g for $type, $user;

    $c->detach() unless $type and $user;

    my $title = eval {
        $c->model("Legacy")->get_title_for_user($user => $type);
    };

    $c->detach() unless $title;

    my @src = $c->model("Amazon::APA")
        ->covers_for_title($title, $type);

    my $index = $c->model("RandomNumber")
        ->generate({ lower_bound => 1,
                     upper_bound => scalar(@src),
                     integer => 1
                   });

    my $img = $src[$index-1];

    $c->stash( img => $img,
               search_title => $title,
               user => $user );
}

sub show_shortcut :Local {
    my ( $self, $c ) = @_;
    $c->response->content_type("text/plain");
    my $huge_security_risk = $c->engine->env->{SHORTCUT} || "Nopers! All good.";
    $c->response->body(<<"Body");
If you can see the passwd file below, we are fscked.
----------------------------------------------------
$huge_security_risk
Body
}

sub call_dumb :Local {
    my ( $self, $c ) = @_;
    $c->model("Legacy")->dumb;
}

sub call_dumber :Local {
    my ( $self, $c ) = @_;
    my $printed_headers_and_html = $c->model("Legacy")->dumber;
    my ( $headers, $html ) = split /\r?\n\r?\n/, $printed_headers_and_html, 2;
    # Discard headers, they're legacy nonsense.
    $c->response->body( $html );
}

1;
