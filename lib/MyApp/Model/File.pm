package MyApp::Model::File;
use strict;
use warnings;
use parent "Catalyst::Model";
use Moose;
use MooseX::Types::Path::Class;
use Cwd;

has root =>
    is       => "ro",
    isa      => "Path::Class::Dir",
    required => 1,
    coerce   => 1,
    ;

sub get : method {
    my $self = shift;
    my $path = Cwd::abs_path(shift);
    my $file = Path::Class::File->new( $self->root, $path );
    -r $file or confess qq{File "$file" is unreadable or non-existent};
    return $file;
}

sub slurp : method {
    +shift->get(+shift)->slurp;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

MyApp::Model::File - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=cut
