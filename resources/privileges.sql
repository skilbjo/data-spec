-- production=# \du
                                   -- List of roles
 -- Role name |                         Attributes                         | Member of
-- -----------+------------------------------------------------------------+-----------
 -- postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 -- robot_etl | Superuser                                                  | {}
 -- skilbjo   | Superuser, Create role, Create DB                          | {}

begin;
  revoke all on all tables in schema public from public;
  revoke connect on database production from public;

  grant all privileges on database production to skilbjo;
  grant all privileges on database production to robot_etl;

  grant all privileges on all tables in schema public, dw to skilbjo;
  grant all privileges on all tables in schema public, dw to robot_etl;

  create user ro_robot_etl with password '[secret pass here]';
  alter default privileges for user ro_robot_etl in schema public, dw grant select on tables to ro_robot_etl;

  grant connect on database production to ro_robot_etl;
  grant select on all tables in schema production to ro_robot_etl;

commit;
