/*
   Issue Description: CDM-33269
   Category/ Module  :  child removal and placement enddate nullify
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   */

update intakeservreqchildremoval
 set exitdate = Null,
 updatedby ='CDM-33269' ,
 updatedon =now() 
 where removalid in ('196351','196350');

 update personprogramarea set enddate =null,updatedby ='CDM-33269' ,
 updatedon =now()  where personprogramid in ('2cbe62b4-1471-4e7e-bc2a-33b34c941ac8','8ca8dcc8-ea55-490e-9c43-c271542ae022');
 
update tb_client_eligibility
set end_dt = null,
	update_user_id = 'CDM-33269',
	update_ts = now()
where removal_id in ('196351','196350')
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;

-- 2023-07-21 00:00:00  08:00
update placement set enddatetime = null, endtime = null, updatedon = now(), updatedby = 'CDM-33269' where placementid in ('fb5facba-cf09-4398-bef9-e94aed760a7e','cd174c18-1ace-4bdc-8573-7c62c8e05aed') and activeflag = 1;
-- 2021-07-06 00:00:00	10:00
update placementrevision set exitdate = null, exittime = null, updatedon = now(), updatedby = 'CDM-33269' where placementid in ('fb5facba-cf09-4398-bef9-e94aed760a7e','cd174c18-1ace-4bdc-8573-7c62c8e05aed') and activeflag = 1;

-- validation table
update tb_placement_validation set placement_exit_dt = null, update_user_id = 'CDM-33269', update_ts = now() where placement_id  in (1572754, 1572753);



