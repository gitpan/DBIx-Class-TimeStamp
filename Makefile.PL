use inc::Module::Install;

name 'DBIx-Class-TimeStamp';
all_from 'lib/DBIx/Class/TimeStamp.pm';

requires 'DateTime';
requires 'DBIx::Class';
requires 'DBIx::Class::DynamicDefault';

build_requires 'DateTime::Format::SQLite';
build_requires 'DateTime::Format::MySQL';

build_requires 'Class::Accessor::Grouped';
build_requires 'Time::HiRes';
build_requires 'Time::Warp';

postamble(<<"EOM") if $Module::Install::AUTHOR;
t/sql/test.sqlite.sql: t/lib/DBIC/Test/Schema.pm t/lib/DBIC/Test/Schema/*.pm
\t\$(MKPATH) t/sql
\t\$(PERL) t/generate_schema.pl > \$@

manifest : t/sql/test.sqlite.sql
EOM

auto_install;
WriteAll;
