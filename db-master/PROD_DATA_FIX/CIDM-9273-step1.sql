--CIDM-9273


-- tb_ive_component_status table parimary key.
-- Step 1: Setting the current value to max value in the _iss table plus 500.
SELECT setval('seq_tb_ive_component_status', (select max(ive_component_status_id)+500 from tb_ive_component_status), true);  

-- Step 2: Upating duplicate records primary key. 261672 records updated. 523344 total.
with  updated_rows as ( select * from (
select
row_number () over ( partition by ive_component_status_id order by create_ts  asc)  as rownum
,*
from tb_ive_component_status
where ive_component_status_id in (
select ive_component_status_id  from tb_ive_component_status
group by 1 having count(1) > 1
)
) a where rownum > 1
)
update tb_ive_component_status b set ive_component_status_id = nextval('seq_tb_ive_component_status')::integer, update_user_id = 'primary_key_update',update_ts =now()
from updated_rows a where b.ive_component_status_id = a.ive_component_status_id and b.create_ts = a.create_ts
;



-- Step 1: Setting the current value to max value in the _iss table plus 500.
SELECT setval('SQ_AFS_INTERFACES', (select max(afs_interface_record_id)+500 from tb_afs_interfaces_iss), true);  

-- Step 2: Update the duplciate records with new unique id. 757562 records updated.
with  updated_rowsiss as ( select * from (
select
row_number () over ( partition by afs_interface_record_id order by create_ts  asc)  as rownum
,*
from tb_afs_interfaces_iss
where afs_interface_record_id in (
select afs_interface_record_id  from tb_afs_interfaces_iss
group by 1 having count(1) > 1
)
) a where rownum > 1
)
update tb_afs_interfaces_iss b set afs_interface_record_id = nextval('SQ_AFS_INTERFACES')::integer, update_user_id = 'pk_updt',update_ts =now()
from updated_rowsiss a where b.afs_interface_record_id = a.afs_interface_record_id and b.create_ts = a.create_ts and coalesce(a.account_type,'NULL') = coalesce(b.account_type,'NULL')
;



