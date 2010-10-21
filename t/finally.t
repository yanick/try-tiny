#!/usr/bin/perl

use strict;
#use warnings;

use Test::More tests => 12;

BEGIN { use_ok 'Try::Tiny' };

try {
	my $a = 1+1;
} catch {
	fail('Cannot go into catch block because we did not throw an exception')
} finally {
	pass('Moved into finally from try');
};

try {
	die('Die');
} catch {
	ok($_ =~ /Die/, 'Error text as expected');
	pass('Into catch block as we died in try');
} finally {
	pass('Moved into finally from catch');
};

try {
	die('Die');
} finally {
	pass('Moved into finally from catch');
} catch {
	ok($_ =~ /Die/, 'Error text as expected');
};

try {
	die('Die');
} finally {
	pass('Moved into finally block when try throws an exception and we have no catch block');
};

try {
  die('Die');
} finally {
  pass('First finally clause run');
} finally {
  pass('Second finally clause run');
};

try {
  # do not die
} finally {
  if (@_) {
    fail("errors reported: @_");
  } else {
    pass("no error reported") ;
  }
};

try {
  die("Die\n");
} finally {
  is_deeply(\@_, [ "Die\n" ], "finally got passed the exception");
};

1;
