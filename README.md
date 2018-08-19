## dw-spec

### what
Personal datawarehouse ERD. Applies to these projects:
- <http://github.com/skilbjo/markets-etl>
- <https://github.com/skilbjo/router-logs>

<img src='dev-resources/img/erd.png' width=900 />

### sample queries

```sql
select
  date_parse(s3.datetime,'%d/%b/%Y:%H:%i:%S +%f'),
  *
from logs.s3
limit 10
```
