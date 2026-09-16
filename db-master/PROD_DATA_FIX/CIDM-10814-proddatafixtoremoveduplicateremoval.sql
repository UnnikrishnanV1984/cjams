/*
   Issue Description: CIDM-10814
   Category/ Module  : Prod data fix to Remove duplicate child removal 
   Root cause:  
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update intakeservreqchildremoval set activeflag = 0, updatedby = 'CIDM-10814',
updatedon = now() where intakeservreqchildremovalid = '9350c61d-6081-495a-b8f1-b37898250e8a' and removalid = '355877' and activeflag =1;

update intakeservreqchildremoval_history set activeflag = 0, updatedby = 'CIDM-10814',
updatedon = now() where intakeservreqchildremovalid = '9350c61d-6081-495a-b8f1-b37898250e8a' and removalid = '355877' and activeflag =1;

update routing set activeflag = 0, updatedby = 'CIDM-10814',
updatedon = now() where objectid = '9350c61d-6081-495a-b8f1-b37898250e8a' and activeflag =1; 

update placement  set activeflag = 0, updatedby = 'CIDM-10814', updatedon = now()
where intakeservreqchildremovalid = '9350c61d-6081-495a-b8f1-b37898250e8a' and placementid = '828d5533-eb5c-4657-8de5-79b3c8e08fb8' and activeflag = 1;


update placementrevision  set activeflag = 0, updatedby = 'CIDM-10814', updatedon = now()
where placementid = '828d5533-eb5c-4657-8de5-79b3c8e08fb8' and activeflag = 1;

update livingarrangement  set activeflag = 0, updatedby = 'CIDM-10814', updatedon = now()
where placementid = '828d5533-eb5c-4657-8de5-79b3c8e08fb8' and activeflag = 1;

update routing set activeflag = 0, updatedby = 'CIDM-10814',
updatedon = now() where objectid = '828d5533-eb5c-4657-8de5-79b3c8e08fb8' and activeflag =1; 

update     tb_client_eligibility
set delete_sw = 'Y',update_user_id = 'CIDM-10814',
update_ts = now()
where  removal_id = 355877 and delete_sw  = 'N' ;