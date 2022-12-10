package Web::Linkable;

use Dancer2 appname => 'Web';

use RefreshURL;
use TagAttrs;
use URI::Escape qw(uri_escape);
use Web::Content;

my $asset   = 'Web::Assets';
my $content = Web::Content->new;
my $token   = RefreshURL->new( name => 'web' );

hook before_template_render => sub {
    my ($stash) = @_;
    $stash->{refresh} = \&_refresh;
    $stash->{proxy}{img} = \&_proxy_image;
};

sub _refresh {
    my ( $url, $options ) = @_;

    my $tmp = $options->{noqq} ? '%s' : '"%s"';

    return sprintf $tmp, $token->refresh($url);
}

sub _proxy_image {
    my $page = shift;
    my ( $attrs, $args ) = attrs shift;
    sprintf '<img src=%s%s>', _refresh("/fp/$page"), $attrs;
}

1;
