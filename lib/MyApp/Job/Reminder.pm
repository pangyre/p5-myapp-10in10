package MyApp::Job::Reminder;
use strict;
use warnings;
no warnings "uninitialized";
use parent qw( TheSchwartz::Worker );
use TheSchwartz::Job;
use MIME::Lite;
use Sys::Hostname "hostname";

sub work {
    my $class = shift;
    my TheSchwartz::Job $job = shift;

    open my $f, ">>", "/tmp/10in10.log" or die $!;
    print $f $job->{email}, $/;
    close $f;
    return 1;

    my $msg = MIME::Lite
        ->new(
              From    => 'bit-bucket@' . hostname(),
              To      => $job->{email},
              Subject => "Something important!",
              Type    => "text/plain",
              Data    => "This is your reminder to visit again."
             );

    #print $msg->as_string, "\n";
    $msg->send;
    $job->completed();
}

# From our parent class we can override these-
sub keep_exit_status_for { 60 * 60 * 24 * 1 }
sub max_retries { 3 }
sub retry_delay { 30 }
sub grab_for { 60 * 3 }

1;

__END__

=head1 NAME

MyApp::Job::Reminder - a subclass of L&lt;TheSchwartz::Worker&gt;.

=head1 SYNPOSIS

=head1 METHODS

=over 4

Nothing yet.

=back

=head1 HOW TO RUN THE JOBS

One liner that detaches... with Daemon helper. -MWhatever?

=head1 TROUBLESHOOTING

    The jobs tables are: C&lt;error&gt;, C&lt;exitstatus&gt;, C&lt;funcmap&gt;, C&lt;job&gt;, and C&lt;note&gt;.

Dump errors:

    echo &quot;use MyApp; select * from error;&quot; | mysql
 # Last error-
    echo &quot;use MyApp; select * from error order by error_time desc limit 1;&quot; | mysql

=cut

