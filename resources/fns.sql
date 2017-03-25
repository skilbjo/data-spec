-- Note, need to install postgresql-contrib on the server for the following
create extension tablefunc;

create or replace function crosstabcode (tablename varchar, rowc varchar, colc varchar, cellc varchar, celldatatype varchar) returns varchar language plpgsql as $$
declare
    dynsql1 varchar;
    dynsql2 varchar;
    columnlist varchar;
begin
    -- 1. retrieve list of column names.
    dynsql1 = 'select string_agg(distinct '||colc||'||'' '||celldatatype||''','','' order by '||colc||'||'' '||celldatatype||''') from '||tablename||';';
    execute dynsql1 into columnlist;
    -- 2. set up the crosstab query
    dynsql2 = 'select * from crosstab (
 ''select '||rowc||','||colc||','||cellc||' from '||tablename||' group by 1,2 order by 1,2'',
 ''select distinct '||colc||' from '||tablename||' order by 1''
 )
 as ct (
 '||rowc||' varchar,'||columnlist||'
 );';
    return dynsql2;
end
$$ ;

select crosstabcode('dw.log','date','device','count(*)','text'); ;
