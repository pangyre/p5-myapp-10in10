package MyApp::Model::RandomNumber;
use strict;
use warnings;
use parent 'Catalyst::Model';
use Carp;

sub generate {
    my ( $self, $args ) = @_;
    $args ||= {};
    ref($args) eq 'HASH' or croak "Arguments must be a hash reference";
    my $upper = delete $args->{upper_bound};
    my $lower = delete $args->{lower_bound}
        if $upper; # Both or neither.
    my $integer = delete $args->{integer}
        if $upper; # Only works if bounds are set.

    croak "Unsupported args or combination of args", join(", ", %{$args})
        if keys %{$args};

    # Reasonable defaults if not set by client.
    $upper ||= 1;
    $lower ||= 0;

    $upper > $lower
        or croak "upper_bound is not greater than lower_bound";

    if ( $integer )
    {
        return _generate_integer( $lower, $upper );
    }
    else
    {
        return rand( $upper - $lower ) + $lower;
    }
}

sub _generate_integer {
    my ( $min, $max ) = @_;
    my $uri = URI->new("http://www.random.org/integers/");
    $uri->query_form(
                     num => 1,
                     min => $min,
                     max => $max,
                     base => 10,
                     col => 1,
                     "format" => "plain",
                     rnd => "new",
                     );

    my $ua = LWP::UserAgent->new;
    my $r = $ua->get($uri);
    $r->is_success or croak join("\n",
                                 $uri,
                                 $r->status_line,
                                 $r->as_string);
    chomp( my $number = $r->content );
    return $number;
}

1;
