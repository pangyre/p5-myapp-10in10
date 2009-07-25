package MyApp::Schema::PageView::View;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("view");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 10 },
  "page",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 10 },
  "agent",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "referer",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "ip",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 32,
  },
  "created",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->belongs_to("page", "MyApp::Schema::PageView::Page", { id => "page" });


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-06-23 21:36:34
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sr8c7VkpiV/7w9ELr8fjEg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
