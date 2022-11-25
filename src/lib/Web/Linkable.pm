package Web::Linkable;

use Dancer2 appname => 'Web';
use RefreshURL;
use Web::Content;

my $asset   = 'Web::Assets';
my $content = Web::Content->new;
my $token   = RefreshURL->new( name => 'web' );

hook before_template_render => sub {
    my ($stash) = @_;
    $stash->{refresh} = \&_refresh;
    $stash->{alink}   = \&_alink;
};

sub _refresh {
    my ( $url, $options ) = @_;

    my $tmp = $options->{noqq} ? '%s' : '"%s"';

    return sprintf $tmp, $token->refresh($url);
}

sub _alink {
    my ($name) = @_;
    my $nav = $content->get("page.nav.$name")
      or return;

    my ( $display, $href, $alt, $match ) =
      map { $_ // '' } @$nav{qw( display href alt match)};

    $match->{$href} = 1;

    my $current_page = request->path;

    my $alink = qq{<a href="$href"};

    $alink .= qq{ alt="$alt"}           if $alt;
    $alink .= qq{ class="current-page"} if $match->{$current_page};

    return $alink . ">$display</a>";
}

1;
