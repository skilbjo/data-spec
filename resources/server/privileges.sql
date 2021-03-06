-- Privileges
begin;
  revoke all on all tables in schema public from public;
  revoke connect on database production from public;

  grant all privileges on all tables in schema public, dw, aeon to skilbjo;
  grant all privileges on database production to skilbjo;

  grant all privileges on database production to robot_etl;
  grant usage on schema dw, aeon to robot_etl;
  grant all privileges on all tables in schema public, dw, aeon to robot_etl;

  alter default privileges for user ro_robot_etl in schema public, dw, aeon grant select on tables to ro_robot_etl;
  grant connect on database production to ro_robot_etl;
  grant usage on schema dw, aeon to ro_robot_etl;
  grant select on all tables in schema dw, aeon to ro_robot_etl;

commit;
