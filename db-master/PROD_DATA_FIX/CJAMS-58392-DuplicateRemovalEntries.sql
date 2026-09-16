/*
Issue Description:3251994:Frank McGough from the state contacted me and asked to create the ticket to correct this error.
Category/Module: Bug
Root cause: user could not abe to delete child removal records, they can only create.
Fix provided: DB queries  update intakeservreqchildremoval, intakeservicerequestactor table.
Data/Code fix ticket#: CJAMS-58392
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Roor
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update intakeservreqchildremoval
set activeflag = 0, updatedby = 'CJAMS-58392', updatedon  = now()
where  intakeservreqchildremovalid = '2dfeab9d-5cce-45b9-a430-ccf4e3001e6c' and activeflag =1;

update intakeservreqchildremoval_history
set activeflag = 0, updatedby = 'CJAMS-58392', updatedon  = now()
where  intakeservreqchildremovalid = '2dfeab9d-5cce-45b9-a430-ccf4e3001e6c' and activeflag =1;

--routing 
update routing
set activeflag = 0, updatedby = 'CJAMS-58392', updatedon  = now()
where routingid in ('2dfd1c38-1129-46eb-a4a1-4a5cad0ef5b0','46e55caa-50d7-47c6-a57a-4f97a7c40acf') and activeflag =1;
--tb_client_eligibility 
update tb_client_eligibility
set update_ts = now(),update_user_id  = 'CJAMS-58392', delete_sw = 'Y'
 where eligibility_id = 10130170 and delete_sw = 'N';


  
--add new requirement
--personprogramarea
update personprogramarea 
set activeflag = 0, updatedby = 'CJAMS-58392', updatedon  = now()
where personprogramid = 'b19d91ab-40e8-4fee-9e8b-21c8452d3962' and activeflag =1;
--placement
update placement 
set exitreasontypekey = null, exittypekey = 'CIPS',updatedby = 'CJAMS-58392', updatedon  = now()
where placementid = '0cd66d9c-7001-4269-a27f-d9e2e4101c96' and activeflag =1;

--placementrevision
update placementrevision
set exitreasontypkey  = null, exittypekey = 'CIPS',updatedby = 'CJAMS-58392', updatedon  = now()
where placementrevisionid = '63755cf5-d1dc-4a40-ac9b-5abc3614d171' and activeflag =1; 

