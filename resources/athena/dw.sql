create schema if not exists dw;

drop table if exists dw.markets_dim;
create external table dw.markets_dim (
  dataset     string,
  ticker      string,
  description string
)
row format serde
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
stored as inputformat
  'org.apache.hadoop.mapred.TextInputFormat'
outputformat
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
location
  's3://skilbjo-data/datalake/markets-etl/markets_dim'
tblproperties (
  "skip.header.line.count"="1"
);

drop table if exists dw.portfolio_dim;
create external table dw.portfolio_dim (
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
  's3://skilbjo-data/datalake/markets-etl/portfolio_dim'
tblproperties (
  "skip.header.line.count"="1"
);


drop table if exists dw.currency_fact;
create external table dw.currency_fact (
  date            string,
  rate            string,
  high_est        string,
  low_est         string,
  dataset         string,
  ticker          string,
  currency        string
)
partitioned by (
  s3uploaddate date
)
row format serde
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
stored as inputformat
  'org.apache.hadoop.mapred.TextInputFormat'
outputformat
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
location
  's3://skilbjo-data/datalake/markets-etl/currency_fact'
tblproperties (
  "skip.header.line.count"="1"
);

drop table if exists dw.economics_fact;
create external table dw.economics_fact (
  date            string,
  value           string,
  dataset         string,
  ticker          string
)
partitioned by (
  s3uploaddate date
)
row format serde
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
stored as inputformat
  'org.apache.hadoop.mapred.TextInputFormat'
outputformat
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
location
  's3://skilbjo-data/datalake/markets-etl/economics_fact'
tblproperties (
  "skip.header.line.count"="1"
);

drop table if exists dw.equities_fact;
create external table dw.equities_fact (
  open            string,
  date            string,
  adj_volume      string,
  adj_close       string,
  ticker          string,
  adj_low         string,
  ex_dividend     string,
  close           string,
  volume          string,
  high            string,
  adj_high        string,
  split_ratio     string,
  low             string,
  adj_open        string,
  dataset         string
)
partitioned by (
  s3uploaddate date
)
row format serde
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
stored as inputformat
  'org.apache.hadoop.mapred.TextInputFormat'
outputformat
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
location
  's3://skilbjo-data/datalake/markets-etl/equities_fact'
tblproperties (
  "skip.header.line.count"="1"
);

drop table if exists dw.interest_rates_fact;
create external table dw.interest_rates_fact (
  key             string,
  value           string,
  dataset         string,
  ticker          string,
  date            string
)
partitioned by (
  s3uploaddate date
)
row format serde
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
stored as inputformat
  'org.apache.hadoop.mapred.TextInputFormat'
outputformat
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
location
  's3://skilbjo-data/datalake/markets-etl/interest_rates_fact'
tblproperties (
  "skip.header.line.count"="1"
);

drop table if exists dw.real_estate_fact;
create external table dw.real_estate_fact (
  date            string,
  value           string,
  area_category   string,
  indicator_code  string,
  area            string,
  dataset         string,
  ticker          string
)
partitioned by (
  s3uploaddate date
)
row format serde
  'org.apache.hadoop.hive.serde2.OpenCSVSerde'
stored as inputformat
  'org.apache.hadoop.mapred.TextInputFormat'
outputformat
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
location
  's3://skilbjo-data/datalake/markets-etl/real_estate_fact'
tblproperties (
  "skip.header.line.count"="1"
);

msck repair table dw.currency_fact;
msck repair table dw.economics_fact;
msck repair table dw.equities_fact;
msck repair table dw.interest_rates_fact;
msck repair table dw.real_estate_fact;

with _markets as (
  select
    dataset,
    ticker,
    description
  from
    dw.markets_dim
)
select *
from _markets

with _portfolio as (
  select
    dataset,
    ticker,
    cast(quantity as decimal(10,4))      as quantity,
    cast(cost_per_share as decimal(6,2)) as cost_per_share
  from
    dw.portfolio_dim
)
select *
from _portfolio

with _currency as (
  select
    dataset,
    ticker,
    currency,
    cast(date as date)               as date,
    cast(rate as decimal(24,14))     as rate,
    cast(high_est as decimal(24,14)) as high_est,
    cast(low_est as decimal(24,14))  as low_est
  from
    dw.currency_fact
)
select *
from _currency

with _economics as (
  select
    dataset,
    ticker,
    cast(date as date)               as date,
    cast(value as decimal(10,2))     as value
  from
    dw.economics_fact
)
select *
from _economics

with _equities as (
  select
    dataset,
    ticker,
    cast(date as date)                 as date,
    cast(open as decimal(10,2))        as open,
    cast(close as decimal(10,2))       as close,
    cast(low as decimal(10,2))         as low,
    cast(high as decimal(10,2))        as high,
    cast(volume as decimal(20,2))      as volume,
    cast(split_ratio as decimal(10,2)) as split_ratio,
    cast(adj_open as decimal(10,2))    as adj_open,
    cast(adj_close as decimal(10,2))   as adj_close,
    cast(adj_low as decimal(10,2))     as adj_low,
    cast(adj_volume as decimal(20,2))  as adj_volume,
    cast(ex_dividend as decimal(10,2)) as ex_dividend
  from
    dw.equities_fact
)
select *
from _equities

with _interest_rates as (
  select
    dataset,
    ticker,
    cast(date as date)           as date,
    key,
    cast(value as decimal(10,2)) as value
  from
    dw.interest_rates_fact
)
select *
from _interest_rates

with _real_estate as (
  select
    dataset,
    ticker,
    cast(date as date)               as date,
    cast(value as decimal(10,2))     as value,
    area_category   text,
    indicator_code  text,
    area            text
  from
    dw.real_estate_fact
)
select *
from _real_estate
