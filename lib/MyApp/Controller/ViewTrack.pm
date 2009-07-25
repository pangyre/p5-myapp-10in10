package MyApp::Controller::ViewTrack;
use strict;
use warnings;
use parent 'Catalyst::Controller';

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $pages = $c->model("PageView::Page")->search();
    $c->stash( pages => $pages );
}

sub process :Private {
    my ( $self, $c ) = @_;
    my $uri = $c->request->uri;

    my $page = $c->model("PageView::Page")
        ->find_or_create({ path => $uri->path });

    $page->query($uri->query) if $uri->query;
    $page->update();

    my $view = $c->model("PageView::View")
        ->create({ page => $page,
                   agent => $c->request->user_agent || "",
                   referer => $c->request->referer || "",
                   ip => $c->request->address || "",
                   created => \"DATETIME('NOW')", # SQLite syntax
                 });

    $view->update();
}

1;
