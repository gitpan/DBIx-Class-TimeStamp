use inc::Module::Install;

name 'DBIx-Class-TimeStamp';
all_from 'lib/DBIx/Class/TimeStamp.pm';

requires 'DateTime';
requires 'DBIx::Class';

build_requires 'DateTime::Format::MySQL';
build_requires 'Class::Accessor::Grouped';
build_requires 'Time::HiRes';
build_requires 'Time::Warp';

auto_install;
WriteAll;

