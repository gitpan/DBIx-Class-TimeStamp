use strict;
use warnings;

use DateTime;
use Time::HiRes;
use Time::Warp qw|to time|;
use Test::More tests => 3;

# Redefine "now" so that we can warp it.  
no warnings 'redefine';
local *DateTime::now = sub { shift->from_epoch( epoch => (scalar time), @_ ) };
use warnings 'redefine';

use lib qw(t/lib);
use DBIC::Test;

my $schema = DBIC::Test->init_schema;
my $row;

$row = $schema->resultset('DBIC::Test::Schema::TestDate')
    ->create({ display_name => 'test record' });

my $time = $row->t_updated;
ok $row->t_created, 'created timestamp';
is $row->t_updated, $row->t_created, 'update and create timestamp';

to(time + 60);

$row->display_name('test record again');
$row->update;

isnt $row->t_updated, $time, 'update timestamp';

