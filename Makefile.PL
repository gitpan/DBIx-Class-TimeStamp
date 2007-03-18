use inc::Module::Install;

name 'DBIx-Class-TimeStamp';
all_from 'lib/DBIx/Class/TimeStamp.pm';

requires 'DateTime';
requires 'DBIx::Class';

build_requires 'DBD::SQLite';
build_requires 'SQL::Translator';

auto_install;
WriteAll;

