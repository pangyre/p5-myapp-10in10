package __iHAZaSAD; # Namespace for isolation.
no warnings;
use lib "./legacy/lib";

my $legacy_lib = "legacy-lib.pl";

# Save some important things.
my $_exit = \*CORE::GLOBAL::exit;
my %_sig = %SIG;
my %_env = %ENV;

# Neuter this so the legacy code can't use it.
*CORE::GLOBAL::exit = sub { 0 };
@ENV{qw( PATH HOME SHELL USER )} = () x 4;

# Do the filthy, messy deed.
require $legacy_lib;

# Put things back where they belong.
*CORE::GLOBAL::exit = $_exit;
%SIG = %_sig;
%ENV = %_env;


# Back to regular space --------------------------------
package MyApp::Model::Legacy;
use strict;
use parent "Catalyst::Model";
use Carp ();
use IO::CaptureOutput qw(capture);
our $AUTOLOAD;

sub AUTOLOAD {
    my $called_sub = $AUTOLOAD;

    ( my $sub_name = $called_sub ) =~ s/\A.+:://;
    my $legacy_function = \&{"__iHAZaSAD::" . $sub_name};
    {
        no strict "refs";
        *$called_sub = sub {
            # We don't need or want "$self," we're just wrapping
            # legacy-lib.pl's exported functions from an OO call.
            my ( $self, @args ) = @_;
            defined &$legacy_function
                or Carp::croak("$legacy_lib has no $sub_name function");

            my ( @return, $return, $out, $err );
            if ( not defined wantarray )
            {
                capture { $legacy_function->(@args) } \$out, \$err;
                Carp::carp($err) if $err;
                return;
            }
            elsif ( wantarray )
            {
                @return = capture { $legacy_function->(@args) } \$out, \$err;
                Carp::carp($err) if $err;
                return @return ?
                    @return : $out;
            }
            else
            {
                $return = capture { $legacy_function->(@args) } \$out, \$err;
                Carp::carp($err) if $err;
                return $out ?
                    $out : $return;
            }
        };
    }
    goto &{$called_sub};
}

sub DESTROY { 1 }

sub get_variable {
    my ( $self, $variable ) = @_;
    no strict;
    ${"__iHAZaSAD::$variable"};
}

sub get_hash_value {
    my ( $self, $variable ) = @_;
    # Don't autovivify.
    exists $__iHAZaSAD::LEGACY_HASH{$variable} ?
        $__iHAZaSAD::LEGACY_HASH{$variable} : undef;
}

1;
