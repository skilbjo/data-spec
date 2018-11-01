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
  's3://skilbjo-data/datalake/markets-etl/portfolio_dim'
tblproperties (
  "skip.header.line.count"="1"
);


drop table if exists dw.currency_fact;
create external table dw.currency_fact (
  date            string,
  rate            string,
  high            string,
  low             string,
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
