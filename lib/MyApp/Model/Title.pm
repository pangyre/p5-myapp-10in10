package MyApp::Model::Title;
use strict;
use warnings;
use parent 'Catalyst::Model';
use Imager ();
use Digest::MD5 qw(md5_hex);
use File::Path qw( make_path );
use Path::Class;
use Encode;

__PACKAGE__->config( heading_size => 40 );

sub heading {
    my $self = shift;
    my $text = shift;
    my $refresh = shift;
    my $dir = Path::Class::Dir->new( md5_hex($text) =~ /(\w{8})/g );
    ( my $img_name = $text ) =~ s/\W+/_/g;

    $self->{title_face} or die "Set a TrueType(tm) title_face for this model";
    my $ttf = Path::Class::File->new($self->{title_face});
    -r $ttf or die "$ttf is not readable";

    $self->{file_root} or die "Set a file_root visible to your web paths";
    my $file_root = Path::Class::Dir->new($self->{file_root});
    -w $file_root or die "$file_root is not writeable by application";

    $self->{web_dir} or die "Set a web_dir inside and relative to your file_root";
    my $web_dir = Path::Class::Dir->new($self->{web_dir});

    my $file_path = Path::Class::File->new($file_root,$dir,$img_name.".png");
    my $web_path = Path::Class::File->new($web_dir,$dir,$img_name.".png");
    return $web_path if -e $file_path and not $refresh;

    my $face = Imager::Font->new(file => $ttf,
                                 type => 'ft2',
                                 index => 0,
                                 size => $self->{heading_size});

    my $bbox = $face->bounding_box(string => Encode::decode_utf8($text));

    my $img = Imager->new(xsize => $bbox->total_width,
                          ysize => $bbox->text_height,
                          color => 'white');

    $img->box(filled => 1, color => 'white');

    $img->string(font => $face,
                 text => Encode::decode_utf8($text),
                 x => 0,
                 y => 0,
                 size => $self->{heading_size},
                 color => "black",
                 aa => 1,
                 align => 0 );

    make_path($file_path->dir,
              {
               verbose => 0,
               mode => 0755,
              })
        unless -e $file_path->dir;

    $img->write(file => $file_path->stringify)
        or die "Could not write image ", $img->errstr;

    return $web_path;
}

1;
