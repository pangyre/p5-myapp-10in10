package MyApp::Controller::Visit;
use strict;
use warnings;
use parent 'Catalyst::Controller';

__PACKAGE__->config( rows => 30 );

sub auto :Private { $_[1]->stash( template => "visit/index.tt" ) }

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( rx => $c->model("Log")->rx );
}

sub last :Local {
    my ( $self, $c, $rows ) = @_;
    $rows ||= $self->{rows};
    my @match = $c->model("Log")
        ->search({},
                 {
                   order_by => "backwards",
                   rows => $rows,
                 });
    $c->stash( matches => \@match );
}

sub not_ok :Local {
    my ( $self, $c, $rows ) = @_;
    $rows ||= $self->{rows};
    my @match = $c->model("Log")
        ->search({ status => { "!~" => qr/^[23]/ } },
                 { rows => $rows });
    $c->stash( matches => \@match );
}

sub status :Local Args(1) {
    my ( $self, $c, $status ) = @_;

    my @match = $c->model("Log")
        ->search({ status => $status });
    $c->stash( matches => \@match );
}

sub ext :Local {
    my ( $self, $c, $ext, $rows ) = @_;
    $rows ||= $self->{rows};
    my @match = $c->model("Log")
        ->search({ request => { '=~' => qr/\.\Q$ext\E\z/ } },
                 { rows => $rows ,
                   order_by => "backwards"
               });
    $c->stash( matches => \@match );
}

sub robots :Local Args(0) {
    my ( $self, $c ) = @_;
    my $match = $c->model("Log")
        ->search({ status => 200,
                   agent => { "=~" => qr/(?:ro)?bot\b/ },
                 });
    $c->stash( matches => $match );
}

1;

__END__
