package Web::Linkable;

use Dancer2 appname => 'Web';
use RefreshURL;

my $asset = 'Web::Assets';

hook before_template_render => sub {
    my ($stash) = @_;

    my $token = RefreshURL->new(name => 'web');

    $stash->{refresh} = sub { $token->refresh(@_) };
};

1;
