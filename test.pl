#!/usr/bin/perl

use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;
use English qw(-no_match_vars);

plan tests => 2;

my $src = <<'RAW_CODE';
use warnings FATAL => 'all';

printf('%s:%d', substr($ENV{X}, 4), 1 + "0 $ENV{X}");
RAW_CODE

my $path_to_file = './raw_code.pl';

my ($output, $code) = do_test($src, $path_to_file);

ok $output eq 'true:1';
ok $code == 0;

sub do_test {
    my ($src, $path_to_file) = @ARG;

    open my $fh, '>', $path_to_file;
    print {$fh} $src if $fh;

    my $output = qx{X="    true" perl -X $path_to_file};

    unlink $path_to_file;

    return $output, $CHILD_ERROR >> 8;
}

