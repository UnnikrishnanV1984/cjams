-- CDM-27409-Overdue response timer issue & case connect error 
/*
-- Issue Description: 
    1. Remove the case connect between CPS AR # 221020283523 and service case # 221030031070.
	2. Remove the service case # 221030031070.
 
-- Resolution: Updated the servicecaseid to null in intakeservicerequest and updated activeflag to 0  in servicecase 

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

-------Please remove the case connect from AR case- 221020283523 -----------------------------------------

select 	servicecaseid, activeflag, *
from 	intakeservicerequest 
WHERE 	servicerequestnumber = '221020283523' and activeflag = 1;

update 	intakeservicerequest 
set		servicecaseid = NULL ,
		updatedby = 'CDM-27409',
		updatedon = now()
WHERE 	servicerequestnumber = '221020283523' and activeflag = 1;
	
select 	activeflag, *
from 	servicecase
where 	servicecaseid = 'dd1eb17b-ed6d-4591-ab61-9e229a501faa' and activeflag = 1;

--Remove the service case
update 	servicecase 
set 	activeflag = 0, 
		updatedby = 'CDM-27409', 
		updatedon = now() 
where 	servicecaseid = 'dd1eb17b-ed6d-4591-ab61-9e229a501faa' and activeflag = 1;

--Remove from ServicecaseDisposition
select 	* 
from 	servicecasedisposition
where 	servicecaseid = 'dd1eb17b-ed6d-4591-ab61-9e229a501faa' and activeflag = 1;

update 	servicecasedisposition 
set 	activeflag = 0, updatedby = 'CDM-27409', updatedon = now() 
where 	servicecaseid = 'dd1eb17b-ed6d-4591-ab61-9e229a501faa' and activeflag = 1;

--Remove from Routing
select 	* from cjams.routing 
where 	objectid = 'dd1eb17b-ed6d-4591-ab61-9e229a501faa' and activeflag = 1;

update 	cjams.routing 
set 	activeflag =0,  updatedby = 'CDM-27409', updatedon = now() 
where 	routingid ='3b4089f6-c680-4178-81be-0a551b71eb1a' and activeflag = 1;