package MyApp::Controller::Cover;
use strict;
use warnings;
use parent 'Catalyst::Controller';
use HTML::Entities qw( encode_entities );

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body('Matched MyApp::Controller::Cover in Cover.');
}

sub search: Local Args(1) {
    my ( $self, $c, $title ) = @_;

    my $mode = $c->request->param("mode") || "Books";

    my @covers = eval { $c->model("Amazon::APA")->covers_for_title($title, $mode) };
    $c->detach("error", [$@]) if $@;
    my $safe_title = encode_entities($title);
    my $images = join("\n",
                      map { qq{<img src="$_" alt="$safe_title"/>} }
                      @covers );

    $images ||= "No images found searching on \x{201C}$safe_title\x{201D}";

    $c->response->content_type("text/html; charset=utf-8");

    $c->response->body(<<"SomeHTML");
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
<head>
<title>Covers!</title>
<style type="text/css" media="screen">
  img { margin: 25px; border: 1px solid #aaa; }
</style>
</head>
<body>
  <p>$images</p>
</body>
</html>
SomeHTML
}

sub error :Private {
    my ( $self, $c, $error ) = @_;
    $c->response->content_type("text/html; charset=utf-8");
    $c->response->body("<pre>$error</pre>");
}

1;
