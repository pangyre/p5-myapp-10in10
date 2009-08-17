package MyApp::Controller::File;
use strict;
use warnings;
use parent 'Catalyst::Controller';

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $name = "/README";
    my $content = $c->model("File")->slurp($name);
    $c->response->body($content);
}

1;

__END__

=head1 NAME

MyApp::Controller::File - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut
