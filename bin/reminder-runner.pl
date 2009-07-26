#!/usr/bin/env perl
use strict;
use warnings;
use TheSchwartz;
use Path::Class::File;
use File::Spec;
use YAML ();
use MyApp::Job::Reminder;

my $self = Path::Class::File->new( File::Spec->rel2abs( $0 ) );
my $app_dir = $self->parent->parent;
my $config_file = Path::Class::File->new($app_dir, "myapp.yml" );

# A bit of custom config riding/hacking to use the application's
# config for the DB.
my $config_data = YAML::LoadFile( $config_file );
my $args = $config_data->{"Model::TheSchwartz"}->{args};
$args->{databases}->[0]->{dsn} =~ s/__path_to\(([^)]+)\)__/ _path_to($1)  /e;

my $client = TheSchwartz->new(%{$args});

$client->can_do("MyApp::Job::Reminder");

$client->work();

sub _path_to {
    Path::Class::File->new($app_dir,+shift);
}
