package MyApp::Controller::Src;
use strict;
use warnings;
use parent 'Catalyst::Controller';

sub index :Path {
    my ( $self, $c ) = @_;
    unless ( $self->{enabled} )
    {
        $c->response->body(<<"MessageInAhereDoc");
Set "enabled" for this package in config to use the source browser. E.g.-
<pre>Controller::Src:
  enabled: 1</pre>
MessageInAhereDoc
        $c->detach();
    }
    $c->stash
        ( disallowed_file => '\b(?:\.svn|[#~]|etc|img/title|blib|inc|myapp_local|t|script)\b',
          disallowed_dir => '[.#~]|/\b(?:etc|img/title|blib|inc|t|script|static)\b'
        );
}

sub view :Path Args(1) {
    my ( $self, $c, $file ) = @_;
    ( my $path = $c->path_to($file) ) =~ s/[^[:print:]]+//g;
    die "No such file..." unless -f $path;
    die "No way, sucka!" if $path =~ /myapp_local/;
    $c->response->content_type("text/plain; charset=utf-8");
    $c->response->body( scalar $path->slurp );
}

1;
