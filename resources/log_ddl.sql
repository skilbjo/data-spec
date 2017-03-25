begin;
  drop table if exists dw.log;
  drop table if exists dw.log_staging;

  create table dw.log_staging (
    id              serial,
    date            date,
    time            time,
    device          text,
    syslog_tag      text,
    program         text,
    log             text
  );

  create table dw.log (
    id              serial,
    date            date,
    time            time,
    device          text,
    syslog_tag      text,
    program         text,
    log             text
  );
commit;
