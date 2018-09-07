drop schema s3_inventory cascade;
create schema s3_inventory;

drop table if exists s3_inventory.skilbjo_logs;
create external table s3_inventory.skilbjo_logs (
  bucket              string,
  key                 string,
  size                bigint,
  last_modified       timestamp,
  storage_class       string,
  e_tag               string,
  is_multipart_upload boolean,
  replication_status  string,
  encryption_status   string
)
partitioned by (
  dt       string
)
row format serde
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
stored as inputformat
  'org.apache.hadoop.hive.ql.io.SymlinkTextInputFormat'
outputformat
  'org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat'
location
  's3://skilbjo-data/datalake/s3_inventory/skilbjo-logs/skilbjo-logs/hive'
tblproperties (
  'has_encrypted_data'='true'
);

msck repair table s3_inventory.skilbjo_logs;
