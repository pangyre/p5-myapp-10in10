use TheSchwartz;
use File::Spec;
use File::Find::Rule;
use YAML ();
my $self = Path::Class::File->new( File::Spec->rel2abs( $0 ) );
my $app_dir =  $self->parent->parent;
my $config_file = Path::Class::File->new($app_dir, "myapp.yml" );
my $config_data = YAML::LoadFile( $config_file );

my $args = $config_data->{"Model::TheSchwartz"}->{args};
my $debug = !! $args->{verbose};

my $client = TheSchwartz->new(%{$args});

$client->can_do("MyApp::Job::Reminder");

while (1) {
    $client->work();
    sleep 30;
}
