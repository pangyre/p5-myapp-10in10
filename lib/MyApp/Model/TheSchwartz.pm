package MyApp::Model::TheSchwartz;
use parent "Catalyst::Model::Adaptor";
__PACKAGE__->config( class => "TheSchwartz" );

sub mangle_arguments { %{$_[1]} }

1;

__END__

=head1 TABLE CREATION SQL

=head2 SQLite flavor

 BEGIN TRANSACTION;
 CREATE TABLE error (
   error_time INTEGER NOT NULL,
   jobid BIGINT NOT NULL,
   message VARCHAR(255) NOT NULL,
   funcid INT NOT NULL
 );
 CREATE TABLE exitstatus (
   jobid INTEGER PRIMARY KEY NOT NULL,
   funcid INT NOT NULL,
   status SMALLINT NOT NULL,
   completion_time INTEGER NOT NULL,
   delete_after INTEGER NOT NULL
 );
 CREATE TABLE funcmap (
   funcid SERIAL NOT NULL,
   funcname VARCHAR(255) NOT NULL
 );
 CREATE TABLE job (
   jobid SERIAL NOT NULL,
   funcid INT NOT NULL,
   arg blob NOT NULL,
   uniqkey VARCHAR(255) NOT NULL,
   insert_time INTEGER NOT NULL,
   run_after INTEGER NOT NULL,
   grabbed_until INTEGER NOT NULL,
   priority SMALLINT NOT NULL,
   coalesce VARCHAR(255) NOT NULL
 );
 CREATE TABLE note (
   jobid BIGINT NOT NULL,
   notekey VARCHAR(255) NOT NULL,
   value blob NOT NULL,
   PRIMARY KEY (jobid, notekey)
 );
 CREATE UNIQUE INDEX funcname_unique_funcmap ON funcmap (funcname);
 CREATE UNIQUE INDEX funcid_uniqkey_unique_job ON job (funcid, uniqkey);
 COMMIT;

=cut
