/*
   Issue Description: CDM-35973
   Category/ Module  : duplicate record in child removal history Needs To Be Deleted
   Root cause: User request to delete the duplicate child record from child removal history, 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select * from intakeservreqchildremoval 
where servicecaseid ='6d165e6e-5d46-4dbb-a6c7-2d59c9722942' 
and intakeservreqchildremovalid ='ee8687db-aa77-4f1c-8d91-721004b827c1';

update intakeservreqchildremoval 
set activeflag ='0', updatedby ='CDM-35973', updatedon =now()
where intakeservreqchildremovalid ='ee8687db-aa77-4f1c-8d91-721004b827c1' and activeflag ='1';

select activeflag,* from intakeservreqchildremoval_history 
where servicecaseid ='6d165e6e-5d46-4dbb-a6c7-2d59c9722942' 
and intakeservreqchildremovalid ='ee8687db-aa77-4f1c-8d91-721004b827c1';

update intakeservreqchildremoval_history 
set activeflag ='0', updatedby ='CDM-35973', updatedon =now()
where intakeservreqchildremovalid ='ee8687db-aa77-4f1c-8d91-721004b827c1' and activeflag ='1';

select * from routing where objectid ='ee8687db-aa77-4f1c-8d91-721004b827c1';

update routing 
set activeflag ='0', updatedby ='CDM-35973', updatedon =now()
where objectid ='ee8687db-aa77-4f1c-8d91-721004b827c1' and activeflag ='1';

select activeflag,* from personprogramarea where entityid ='221030014332';

update personprogramarea
set activeflag =0, updatedby ='CDM-35973', updatedon =now() 
where personprogramid ='f60649da-3d80-4a34-a497-63caf0e63f1b' and activeflag=1;

select activeflag,intakeservreqchildremovalid,* from placement 
where intakeservreqchildremovalid ='ee8687db-aa77-4f1c-8d91-721004b827c1';

select intakeservreqchildremovalid,activeflag,* from placement where servicecaseid ='6d165e6e-5d46-4dbb-a6c7-2d59c9722942';

update placement
set intakeservreqchildremovalid ='0e37523a-966e-4520-9894-99ff7b0037dd', updatedby ='CDM-35973', updatedon =now()
where intakeservreqchildremovalid ='ee8687db-aa77-4f1c-8d91-721004b827c1' and activeflag ='1';

select returndate,exitdate,activeflag,* from intakeservreqchildremoval 
where servicecaseid ='6d165e6e-5d46-4dbb-a6c7-2d59c9722942' 
and intakeservreqchildremovalid ='0e37523a-966e-4520-9894-99ff7b0037dd';

update intakeservreqchildremoval 
set exitdate =null, updatedby ='CDM-35973', updatedon =now()
where intakeservreqchildremovalid ='0e37523a-966e-4520-9894-99ff7b0037dd' and activeflag =1;

select programkey, startdate, enddate, updatedby, updatedon, *
	from cjams.personprogramarea 
where personprogramid = '774f21e0-5081-401c-9621-2640a4f8f717'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-35973',
	updatedon = now()
where personprogramid = '774f21e0-5081-401c-9621-2640a4f8f717'
	and activeflag = 1 ;

select removal_id, * from tb_client_eligibility;

-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  254323
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-35973',
	update_ts = now()
where removal_id =  254323
	and delete_sw = 'N' ;