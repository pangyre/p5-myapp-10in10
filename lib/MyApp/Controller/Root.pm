package MyApp::Controller::Root;
use strict;
use warnings;
use parent 'Catalyst::Controller';
use List::Util "first";
use IO::Scalar;

__PACKAGE__->config->{namespace} = '';

sub auto :Private {
    my ( $self, $c ) = @_;

    # ->process is called by default. We did not specify an action so
    # this will call MyApp::Controller::ViewTrack->process
    $c->forward($c->controller("ViewTrack"))
        if $self->{viewtrack_enabled};

    return 1;
}

sub index :Path Args(0) {}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub render : ActionClass('RenderView') {}

sub end :Private {
    my ( $self, $c ) = @_;

    # If we get this error, the PageView DB is not there.
    if ( grep { /no such table/i } @{$c->error} )
    {
        $c->model("PageView")->schema->deploy;
        # Clear this (and possibly other!) errors.
        # DB will be there next request.
        $c->clear_errors();
    }
    $c->forward("render");
}

1;
