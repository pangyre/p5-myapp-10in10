package MyApp::Schema::PageView::Page;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("page");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 10 },
  "path",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "query",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("path", ["path"]);
__PACKAGE__->has_many(
  "views",
  "MyApp::Schema::PageView::View",
  { "foreign.page" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-06-23 21:36:34
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sxMMvDKvfO0MJ1cztjyH8A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
