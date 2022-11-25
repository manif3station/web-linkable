package RefreshURL;

use Moo;

extends 'Random::Token';

sub refresh {
    my ($self, $url) = @_;
    my $token = $self->fetch or return $url;

    if ($url =~ m/\?/) {
        return $url . "&refresh=$token";
    }
    elsif ($url =~ m/\#/) {
        my ($url, $tail) = split /#/, $url;
        return $self->refresh($url) . "#$tail";
    }
    else {
        return $url . "?refresh=$token";
    }
}

1;
