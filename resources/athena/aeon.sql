create schema if not exists aeon;

drop table if exists aeon.users;
create external table aeon.users (
  id          string,
  user        string,
  password    string
)
row format serde
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
stored as inputformat
  'org.apache.hadoop.mapred.TextInputFormat'
outputformat
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
location
  's3://skilbjo-data/datalake/aeon/users'
tblproperties (
  "skip.header.line.count"="1"
);
