drop schema logs cascade;

create schema logs;

drop table if exists logs.s3;

create external table logs.s3 (
  bucket_owner              string,
  bucket                    string,
  datetime                  string,
  ip                        string,
  requestor_id              string,
  arn                       string,
  request_id                string,
  operation                 string,
  key                       string,
  request_uri_operation     string,
  request_uri_key           string,
  http_method               string,
  http_status               string,
  error_code                string,
  bytes_sent                string,
  object_size               string,
  total_time                string,
  turn_around_time          string,
  referer                   string,
  user_agent                string,
  version_id                string
)
partitioned by (
  s3uploaddate              date
)
row format serde
  'org.apache.hadoop.hive.serde2.RegexSerDe'
with serdeproperties (
  'input.regex' = '([^ ]*) ([^ ]*) \\[(.*?)\\] ([^ ]*) ([^ ]*:([0-9]+):.*[^ ]) ([^ ]*) ([^ ]*) ([^ ]*) \\\"([^ ]*) ([^ ]*) (- |[^ ]*)\\\" (-|[0-9]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) (\"[^\"]*\") ([^ ]*)$'
)
location
  's3://skilbjo-data/logs/s3'
tblproperties (
  "skip.header.line.count"="0"
);

msck repair table logs.s3;
