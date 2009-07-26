#!/usr/bin/env perl
use strict;
use warnings;
use Path::Class::File;
use File::Spec;

my $self = Path::Class::File->new( File::Spec->rel2abs( $0 ) );
my $app_dir = $self->parent->parent;

my $database = Path::Class::File->new( $app_dir,
                                       "etc",
                                       "theschwartz.sqlt" );

my $schema = Path::Class::File->new( $app_dir,
                                     "etc",
                                     "theschwartz-sqlite-schema.sql" );

$database->remove if -e $database;

0 == system("sqlite3 $database < $schema")
    or die "Couldn't load schema into db: sqlite3 $database < $schema";

