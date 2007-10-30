BEGIN TRANSACTION;
CREATE TABLE test_datetime (
  pk1 INTEGER PRIMARY KEY NOT NULL,
  display_name varchar(128) NOT NULL,
  t_created datetime NOT NULL,
  t_updated datetime NOT NULL
);
CREATE TABLE test_time (
  pk1 INTEGER PRIMARY KEY NOT NULL,
  display_name varchar(128) NOT NULL,
  t_created timestamp NOT NULL,
  t_updated timestamp NOT NULL
);
CREATE TABLE test (
  pk1 INTEGER PRIMARY KEY NOT NULL,
  display_name varchar(128) NOT NULL,
  t_created datetime NOT NULL,
  t_updated datetime NOT NULL
);
CREATE TABLE test_accessor (
  pk1 INTEGER PRIMARY KEY NOT NULL,
  display_name varchar(128) NOT NULL,
  t_created datetime NOT NULL,
  t_updated datetime NOT NULL
);

CREATE TABLE test_date (
  pk1 INTEGER PRIMARY KEY NOT NULL,
  display_name varchar(128) NOT NULL,
  t_created date NOT NULL,
  t_updated date NOT NULL
);
COMMIT;
