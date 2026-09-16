-- CDM-36385 - Remove end date
/*
-- Category/ Module: Child Removal 
-- Root cause: User Error
-- Fix Provided: Datafix has been done to remove the Child End Date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Removal
select removalid, returndate, returntime, removaldate, exitdate, removalexitreason, returntransts, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 299057
	and activeflag = 1;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	returntransts = NULL,
	updatedby = 'CDM-36385',
	updatedon = now()
where removalid = 299057
	and activeflag = 1 ;

-- Update
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea where personid = '8b40103b-2630-47b8-8cc6-fd0d283ad216' 
	and personprogramid = 'b0b28916-e044-4ff7-9a73-27a1dd4385da'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-36385',
	updatedon = now()
where personid = '8b40103b-2630-47b8-8cc6-fd0d283ad216'  and personprogramid = 'b0b28916-e044-4ff7-9a73-27a1dd4385da'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  299057
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-36385',
	update_ts = now()
where removal_id =  299057
	and delete_sw = 'N';


/*
-- Category/ Module: Child Removal 
-- Root cause: User Error
-- Fix Provided: Datafix has been done to Delete the Child
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--
select removalid,exitdate,activeflag,intakeservreqchildremovalid,* from Intakeservreqchildremoval where personid = 'db9af72e-aa25-4ea1-9805-31d67590841f' and activeflag=1 and removalid =299487;

UPDATE intakeservreqchildremoval SET activeflag=0,updatedby='CDM-36385',updatedon=now() WHERE intakeservreqchildremovalid = '603b9169-309f-450e-9589-317582db965e' and removalid =299487 and activeflag=1;

--
select * from routing WHERE objectid='99d27cd7-2e64-4a9d-b316-44865f67cce2';

UPDATE cjams.routing SET  activeflag = 0 , updatedon = now(), updatedby = 'CDM-36385'
WHERE objectid='99d27cd7-2e64-4a9d-b316-44865f67cce2';

--
select enddate from personprogramarea where personprogramid = '61ad40b6-fd22-44d4-8a38-40e41fc72e65';

UPDATE personprogramarea 
SET activeflag = 0
	, updatedby ='CDM-36385'
	, updatedon = now() 
WHERE personprogramid='61ad40b6-fd22-44d4-8a38-40e41fc72e65'::uuid;

--
select delete_sw from tb_client_eligibility where case_id = 3123930 and eligibility_id=10069541;

UPDATE cjams.tb_client_eligibility
SET delete_sw = 'Y'
	, update_user_id = 'CDM-36385'
	, update_ts = now()
WHERE eligibility_id=10069541 and case_id = 3123930;

--
select activeflag from intakeservreqchildremoval_history where intakeservreqchildremovalhistoryid = '8b722ad9-6d49-4e0a-a19c-e068f7d21572' and intakeservreqchildremovalid ='603b9169-309f-450e-9589-317582db965e' and activeflag = 1;

update cjams.intakeservreqchildremoval_history set activeflag =0, updatedby ='CDM-36385', updatedon = now() where intakeservreqchildremovalhistoryid = '8b722ad9-6d49-4e0a-a19c-e068f7d21572' and intakeservreqchildremovalid ='603b9169-309f-450e-9589-317582db965e' and activeflag = 1;