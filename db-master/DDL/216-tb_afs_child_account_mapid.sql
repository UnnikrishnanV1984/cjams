drop table if exists tb_afs_child_account_mapid;

create table tb_afs_child_account_mapid (
mapid uuid NOT NULL DEFAULT gen_random_uuid(),
cjamspid bigint,
childaccountid bigint,
create_ts timestamp without time zone,
create_user_id varchar(20)
);