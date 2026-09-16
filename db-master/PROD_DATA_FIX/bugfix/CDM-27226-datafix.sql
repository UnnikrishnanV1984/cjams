/*
-- Issue Description: 
-- CDM-27226: Changing from an AR to an IR - Reasons not populating
-- Category/ Module: Service Purchase Authorization (Case Management) 
-- Root cause: isAr column has false for this intake service id case 7d4a4856-0ce2-48cf-b9ce-d84f982b556b
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

select 	isar, isir, * 
from 	intakeservicerequestsdm 
where 	intakeserviceid = '7d4a4856-0ce2-48cf-b9ce-d84f982b556b';

update 	intakeservicerequestsdm 
set 	isar = true,
		updatedby = 'CDM-27226',
		updatedon = now()
where 	intakeserviceid = '7d4a4856-0ce2-48cf-b9ce-d84f982b556b';