
alter table servicecasedisposition add column if not exists supervisorcomment character varying;
alter table servicecasedisposition add column if not exists reopenreasonkey character varying(10);