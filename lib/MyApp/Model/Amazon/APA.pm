package MyApp::Model::Amazon::APA;
use strict;
use warnings;
use parent 'Catalyst::Model';
use URI::Amazon::APA;
use LWP::UserAgent;
use XML::LibXML;
use XML::LibXML::XPathContext;
use HTML::Entities qw( encode_entities );
use Carp;

sub covers_for_title {
    my $self = shift;
    my $title = shift || croak "You must provide a title string";
    my $mode = shift || $self->{search_index}
        || croak "You must provide a mode, e.g., Book";
    my $uri = URI::Amazon::APA->new($self->{service_uri});
    $uri->query_form(
                     Service       => $self->{service},
                     Operation     => $self->{operation},
                     AssociateTag  => $self->{associate_tag},
                     ResponseGroup => $self->{response_group},
                     Title         => encode_entities($title),
                     SearchIndex   => $mode,
                     );

    $uri->sign( %{ $self->{signature} } );

    my $ua = LWP::UserAgent->new;
    my $r = $ua->get($uri);
    $r->is_success or die "Could not get $uri: ", $r->status_line;

    my $doc = XML::LibXML->new->parse_string($r->decoded_content);
    my $xc = XML::LibXML::XPathContext->new($doc);
    $xc->registerNs('amzn', $doc->getDocumentElement->namespaceURI);

    if ( $r->is_success )
    {
        return map { $_->textContent }
            $xc->findnodes('//amzn:MediumImage/amzn:URL');
    }
    elsif ( my @error = $xc->findnodes('//amzn:Error') )
    {
        my $error = join("", map { $_->textContent } @error );
        die $error, "\n";
    }
    else
    {
        croak("Unexpected error in ", __PACKAGE__,
              " request to ",
              encode_entities($uri), "\n\n",
              encode_entities($r->as_string)
              );
    }
}

1;

