package TagAttrs;

use strict;
use warnings;
use Exporter 'import';

our @EXPORT = qw(attrs);

sub attrs {
    my ($args) = @_;

    my ( %args, @attrs );

    while ( my ( $key, $val ) = each %$args ) {
        next if !defined $val;

        if ( $key =~ m/^_(.+)/ ) {
            $args{$1} = $args->{$key};
        }
        else {
            push @attrs, sprintf '%s="%s"', $key, $val;
        }
    }

    my $attrs = !@attrs ? '' : ' ' . join ' ', @attrs;

    return wantarray ? ( $attrs, \%args ) : { attrs => $attrs, args => \%args };
}

1;
