package MyApp::Model::MoonPhase;
use strict;
use warnings;
use parent 'Catalyst::Model';
use Astro::MoonPhase ();
use Date::Manip qw( ParseDate ParseDateString UnixDate );
use Carp;

sub phase {
    my ( $self, $raw_timish ) = @_;
    Astro::MoonPhase::phase( _helper_time($raw_timish) );
}

sub illumination {
    [ +shift->phase(@_) ]->[1]
}

sub age {
    [ +shift->phase(@_) ]->[2]
}

sub is_waxing {
    +shift->age(@_) < ( 29.53 / 2 );
}

sub is_waning {
    ! +shift->is_waxing(@_);
}

sub is_gibbous {
    +shift->illlumination(@_) > .5;
}

sub _helper_time {
    my $raw_date = shift || time();
    # If it's not a YYYY looking thing, call it an epoch stamp.
    my $parsed = $raw_date =~ /^(?!19|20)\d{9,10}$/ ?
        ParseDate( ParseDateString("epoch $raw_date") )
        :
        ParseDate($raw_date);
    my $time = eval { UnixDate($parsed,"%s") };
    croak "Sorry, bad date: $@; got $parsed parsing $raw_date" if $@;
    return $time;
}

1;

__END__
