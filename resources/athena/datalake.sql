create schema if not exists datalake;

drop table if exists datalake.markets;
create external table datalake.markets (
  dataset          string,
  ticker           string,
  description      string,
  asset_type       string,
  location         string,
  capitalization   string,
  investment_style string
)
row format serde
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
stored as inputformat
  'org.apache.hadoop.mapred.TextInputFormat'
outputformat
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
location
  's3://skilbjo-data/datalake/markets-etl/markets'
tblproperties (
  "skip.header.line.count"="1"
);

drop table if exists datalake.portfolio;
create external table datalake.portfolio (
  user              string,
  dataset           string,
  ticker            string,
  quantity          string,
  cost_per_share    string
)
row format serde
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
stored as inputformat
  'org.apache.hadoop.mapred.TextInputFormat'
outputformat
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
location
  's3://skilbjo-data/datalake/markets-etl/portfolio'
tblproperties (
  "skip.header.line.count"="1"
);

drop table if exists datalake.currency;
create external table datalake.currency (
  dataset         string,
  ticker          string,
  currency        string,
  rate            double,
  high            double,
  low             double
)
partitioned by (
  date date
)
row format serde
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
stored as inputformat
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
outputformat
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
location
  's3://skilbjo-data/datalake/markets-etl/currency'
;

drop table if exists datalake.economics;
create external table datalake.economics (
  value           double,
  dataset         string,
  ticker          string
)
partitioned by (
  date date
)
row format serde
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
stored as inputformat
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
outputformat
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
location
  's3://skilbjo-data/datalake/markets-etl/economics'
;

drop table if exists datalake.equities;
create external table datalake.equities (
  open            double,
  adj_volume      double,
  adj_close       double,
  ticker          string,
  adj_low         double,
  ex_dividend     double,
  close           double,
  volume          double,
  high            double,
  adj_high        double,
  split_ratio     double,
  low             double,
  adj_open        double,
  dataset         string
)
partitioned by (
  date date
)
row format serde
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
stored as inputformat
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
outputformat
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
location
  's3://skilbjo-data/datalake/markets-etl/equities'
;

drop table if exists datalake.interest_rates;
create external table datalake.interest_rates (
  key             string,
  value           double,
  dataset         string,
  ticker          string
)
partitioned by (
  date date
)
row format serde
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
stored as inputformat
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
outputformat
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
location
  's3://skilbjo-data/datalake/markets-etl/interest_rates'
;

drop table if exists datalake.real_estate;
create external table datalake.real_estate (
  value           string,
  area_category   string,
  indicator_code  string,
  area            string,
  dataset         string,
  ticker          string
)
partitioned by (
  date date
)
row format serde
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
stored as inputformat
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
outputformat
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
location
  's3://skilbjo-data/datalake/markets-etl/real_estate'
;
