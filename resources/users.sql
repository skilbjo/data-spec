-- production=# \du
                                   -- List of roles
 -- Role name |                         Attributes                         | Member of
-- -----------+------------------------------------------------------------+-----------
 -- postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 -- robot_etl | Superuser                                                  | {}
 -- skilbjo   | Superuser, Create role, Create DB                          | {}

-- Users

begin;

  create user ro_robot_etl with password '[secret pass here]';
  create user robot_etl with password '[secret pass here]';

commit;
