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
};

sub _refresh {
    my ( $url, $options ) = @_;

    my $tmp = $options->{noqq} ? '%s' : '"%s"';

    return sprintf $tmp, $token->refresh($url);
}

1;
