-- CDM-33054-Assistance Required with supervisory override
-- Issue Description: 
-- Need data fix to Delete the service case 231030150224 and remove the case connect from CPS case .
-- So user can proceed with intake override. 
-- Resolution: Updated the servicecaseid to null in intakeservicerequest and updated activeflag to 0  in servicecase 

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

-------Please remove the case connect from AR case- 231020734329 -----------------------------------------

select 	servicecaseid, activeflag, *
from 	intakeservicerequest 
WHERE 	servicerequestnumber = '231020734329' and activeflag = 1;

update 	intakeservicerequest 
set		servicecaseid = NULL ,
		updatedby = 'CDM-33054',
		updatedon = now()
WHERE 	servicerequestnumber = '231020734329' and activeflag = 1;
	
select 	activeflag, *
from 	servicecase
where 	servicecaseid = 'e04d63bb-ae30-44e1-a625-ad21a11bab0b' and activeflag = 1;

--Remove the service case
update 	servicecase 
set 	activeflag = 0, 
		updatedby = 'CDM-33054', 
		updatedon = now() 
where 	servicecaseid = 'e04d63bb-ae30-44e1-a625-ad21a11bab0b' and activeflag = 1;

--Remove from ServicecaseDisposition
select 	* 
from 	servicecasedisposition
where 	servicecaseid = 'e04d63bb-ae30-44e1-a625-ad21a11bab0b' and activeflag = 1;

update 	servicecasedisposition 
set 	activeflag = 0, updatedby = 'CDM-33054', updatedon = now() 
where 	servicecaseid = 'e04d63bb-ae30-44e1-a625-ad21a11bab0b' and activeflag = 1;

--Remove from Routing
select 	* from cjams.routing 
where 	objectid = 'e04d63bb-ae30-44e1-a625-ad21a11bab0b' and activeflag = 1;

update 	cjams.routing 
set 	activeflag =0,  updatedby = 'CDM-33054', updatedon = now() 
where 	routingid in ('fe3d09e5-0bc5-4ec8-a98b-dedd68f673de','5cdeceff-07be-460a-9342-3cb1c885c23e') and activeflag = 1;