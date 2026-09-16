
/*
   Issue Description: CDM-20221
   Category/ Module  : Placement records update
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cjams.placement set startdatetime ='2019-02-28 00:00:00.000', updatedby  ='CDM-20221', updatedon  =now()

where placementid  ='f78fc83c-0c8e-4ab0-8edb-01a85b05a339';


update cjams.placementrevision set entrydate ='2019-02-28 00:00:00.000', updatedby  ='CDM-20221', updatedon  =now()

where placementid  ='f78fc83c-0c8e-4ab0-8edb-01a85b05a339' and activeflag  =1;

select * from tb_placement_validation where placement_id  ='1141712'; --no record found 

update cjams.tb_placement_validation set placement_entry_dt  ='2019-02-28 00:00:00.000', update_ts =now(), update_user_id ='CDM-20221'

where placement_id ='333361';


INSERT INTO cjams.tb_placement_validation (placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date)
VALUES(nextval('sq_placement_validation'::regclass), 333361, '2019-02-28', NULL, '1750', NULL, 'CDM-20221', 'CDM-20221', 'N', '2019-02-28', '2019-03-31', now(), now(), NULL, NULL);
