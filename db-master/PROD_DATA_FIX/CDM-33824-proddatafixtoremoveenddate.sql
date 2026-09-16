/*
   Issue Description: CDM-33824
   Category/ Module  : Prod data fix to Remove removal end date
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



 --2023-07-12 11:28:00	ADRE
 update cjams.intakeservreqchildremoval
set exitdate = NULL,
	removalexitreason = NULL,
	updatedby = 'CDM-33824',
	updatedon = now()
	where intakeservreqchildremovalid ='407cf78f-d704-407c-9520-7d79a762e1e8'
	and activeflag = 1 ;

-- 2023-07-12
update cjams.personprogramarea 
set enddate = NULL, 
	updatedby = 'CDM-33824',
	updatedon = now()
where personprogramid = '87c69ab6-fc10-489f-8e66-fcf6e533bfb4'
	and activeflag = 1 ;

-- 2023-07-12
update cjams.tb_client_eligibility
set end_dt = NULL,
	update_user_id = 'CDM-33824',
	update_ts = now()
where removal_id =  252690
	and delete_sw = 'N' ;



update adoptionagreement set activeflag = 0, updatedby = 'CDM-33824', updatedon = now()
where adoptionagreementid in ('40d477b2-77ee-4747-8972-88dd815bc7d5',
'c68529ca-e165-4d5d-b3c3-696198b618a3') and activeflag = 1;

update adoptionagreementraterevision set activeflag = 0, updatedby = 'CDM-33824', updatedon = now()
where adoptionagreementid in ('40d477b2-77ee-4747-8972-88dd815bc7d5',
'c68529ca-e165-4d5d-b3c3-696198b618a3') and activeflag = 1;
