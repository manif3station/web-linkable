package Web::Linkable;

use Dancer2 appname => 'Web';
use Web::Assets;

my $asset = 'Web::Assets';

hook before_template_render => sub {
    my ($stash) = @_;

    my $class = __PACKAGE__;

    $stash->{img_tag}     = sub { $class->img(@_) };
    $stash->{a_tag}       = sub { $class->a(@_) };
    $stash->{picture_tag} = sub { $class->picture(@_) };
};

sub tag {
    my ( $class, $tag, \%attrs ) = @_;
    return if !$tag || !%attrs;
    return sprintf "<%s %s>", $tag, $asset->stringify_attrs(%attrs);
}

sub img {
    my ( $class, $url, \%attrs ) = @_;
    return if !$url;
    $attrs{src} = $url;
    $class->tag( img => \%attrs );
}

sub a {
    my ( $class, $url, \%attrs ) = @_;
    return if !$url;
    $attrs{href} = $url;
    $class->tag( a => \%attrs );
}

sub source {
    my ( $class, $url, \%attrs ) = @_;
    return if !$url;
    $attrs{srcset} = $url;
    $attrs{media}  = "(max-width: $attrs->{size}px)" if $attrs->{size};
    $class->tag( source => \%attrs );
}

sub picture {
    my ( $class, $url, \%attrs ) = @_;
    my @parts = ('<picture>');

    while ( my ( $n, $u ) = each $attrs->{size}->%* ) {
        push @parts, $class->source( $u, { size => $n } );
    }

    push @parts, $class->source($url), $class->img( $url, alt => $attrs{alt} );

    return join "\n", @parts, '</picture>';
}

1;
