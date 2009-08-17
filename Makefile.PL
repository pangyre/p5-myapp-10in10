#!/usr/bin/env perl
use inc::Module::Install;
use lib qw(inc);
use Devel::CheckLib;

# This doesn't seem stable or correct on my box. SQLite is fine. LibXML isn't.
#check_lib_or_exit(
#    lib => [qw( sqlite3 libxml2 )]
#);

name "MyApp";
all_from "lib/MyApp.pm";

requires "Catalyst::Runtime" => "5.80004";
requires "Catalyst::Devel";
requires "Catalyst::Plugin::ConfigLoader";
requires "Catalyst::Plugin::Unicode";
requires "Catalyst::Plugin::Static::Simple";
requires "Catalyst::Action::RenderView";
requires "parent";
requires "Path::Class";
requires "YAML";
requires "JSON::XS";
requires "Astro::MoonPhase";
requires "Date::Manip";
requires "Finance::Quote";
requires "URI::Amazon::APA";
requires "HTML::Entities";
requires "LWP::UserAgent";
requires "File::ReadBackwards";
requires "IO::File";
requires "Email::Valid";
requires "Digest::MD5";
requires "IO::CaptureOutput";
requires "XML::LibXML";
requires "XML::LibXML::XPathContext";
requires "DBD::SQLite";
requires "Catalyst::Model::DBIC::Schema";
requires "Catalyst::Model::Adaptor";
requires "Template::Alloy";
requires "Catalyst::View::TT::Alloy";
requires "Catalyst::View::JSON";
requires "DBIx::Class";
requires "DBIx::Class::Schema";
requires "DBIx::Class::Schema::Loader";
requires "SQL::Translator" => 0.08;      # For $schema->deploy support.
requires "File::Path" => 2;

# New/extended stuff
requires "MooseX::Types::Path::Class";

# build_requires "Devel::CheckLib";
#require Devel::CheckLib;
#check_lib_or_exit( lib => 'libxml2' );
#check_lib_or_exit( lib => 'sqlite3' );

catalyst;

install_script glob("script/*.pl");
auto_install;
WriteAll;

__END__

TheSchwartz::Schema should not be in revision. It should be packaged
and unpacked side-by-side.

Create the etc dir in here?

Deal with 5.10 req in log?

Make "requires" into "recommends?"
