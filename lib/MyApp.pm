package MyApp;
use strict;
use warnings;
use Catalyst::Runtime 5.80;

use parent qw( Catalyst );
use Catalyst qw(
                Unicode
                ConfigLoader
                Static::Simple
                );

our $VERSION = '0.01';

__PACKAGE__->config
    ( name => "10 Example Catalyst Models, v$VERSION",
      setup_components => { except => qr,[^:\w], },
      static => {
          include_path => [ __PACKAGE__->path_to('root', 'static') ],
      },
     );

__PACKAGE__->setup();

1;

__END__

=head1 NAME

MyApp - 10 Catalyst Models in 10 Days.

=head1 SYNOPSIS

    # Find out how your dependencies look-
    perl Makefile.PL

    # Run the app-
    script/myapp_server.pl -r -d -p 3000
    # Then visit http://localhost:3000 in your browser

=head1 DESCRIPTION

This is the code and demo-application laid out in the series of articles I<10 Catalyst Models in 10 Days>, L<http://sedition.com/a/2733>.

=head1 TODO

Clean up acronyms and abbreviations in the articles.

Walk through with an eye for tainting. Just turn it on?

Pod for everything. This might be a pipe-dream. The articles took long enough.

Tests for everything. This might be a crack-fantasy. This isn't production code.

Incorporate articles into the app so it's self-contained. Pros: it's self-contained. Cons: it's difficult and it robs Sedition.com of traffic earned by doing this whole thing.

=head1 AUTHOR

Copyright (E<copy>) 2009 Ashley Pond V, PangyreSoft, L<http://pangyresoft.com>.

=head1 LICENSE

This library is free software, you can redistribute it and modify it under the same terms as Perl.

=head1 DISCLAIMER OF WARRANTY

Because this software is licensed free of charge, there is no warranty for the software, to the extent permitted by applicable law. Except when otherwise stated in writing the copyright holders or other parties provide the software "as is" without warranty of any kind, either expressed or implied, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose. The entire risk as to the quality and performance of the software is with you. Should the software prove defective, you assume the cost of all necessary servicing, repair, or correction.

In no event unless required by applicable law or agreed to in writing will any copyright holder, or any other party who may modify and/or redistribute the software as permitted by the above licence, be liable to you for damages, including any general, special, incidental, or consequential damages arising out of the use or inability to use the software (including but not limited to loss of data or data being rendered inaccurate or losses sustained by you or third parties or a failure of the software to operate with any other software), even if such holder or other party has been advised of the possibility of such damages.

=cut
