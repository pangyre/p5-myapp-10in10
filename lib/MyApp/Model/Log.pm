package MyApp::Model::Log;
use parent "Catalyst::Model";
use File::ReadBackwards;
use IO::File;
use Carp;
use Moose;
no warnings "uninitialized";
use feature "switch";

has "log" => 
    is => "rw",
    isa => "Str";

has "rx" =>
    is => "ro",
    isa => "Regexp";

my %ops = map {; $_ => 1 } qw( !~ =~ == != ne );

sub search {
    my ( $self, $params, $opts ) = @_;
    my ( $io, $read_method );
    if ( $opts->{order_by} eq "backwards" )
    {
        $io = File::ReadBackwards->new( $self->log );
        $read_method = "readline";
    }
    else
    {
        $io = IO::File->new( $self->log, "r" );
        $read_method = "getline";
    }
    $io || croak "Couldn't open '", $self->log, "' for reading: $!";

    my @match;

  LINE:
    while ( my $line = $io->$read_method )
    {
        last LINE if $opts->{rows} and @match >= $opts->{rows};
        $line =~ $self->rx;
        my $keep;
        for my $key ( keys %{$params} )
        {
            croak "No such key '$key': $line`" unless exists $+{$key};
            if ( ref $params->{$key} )
            {
                my ( $op, $target ) = %{ $params->{$key} };
                croak "Op '$op' not allowed" unless $ops{$op};
                my $keep;
                given ($op) {
                    when ('=~') {
                        $keep =  $+{$key} =~ /$target/;
                    }
                    when ('!~') {
                        $keep =  $+{$key} !~ /$target/;
                    }
                    default {
                        $keep = eval "$+{$key} $op $target";
                    }
                }
                next LINE unless $keep;
            }
            else
            {
                my $target = $params->{$key};
                next LINE unless eval "$+{$key} eq $target";
            }
        }
        push @match, { %+ };
    }
    return wantarray ? @match : \@match;
}

__PACKAGE__->meta->make_immutable;

1;
