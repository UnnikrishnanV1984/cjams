-- CDM-23596 - GAP payment not sent
/*
-- Issue Description: 
	Worker was notified by finance office that a payment was not issued 
	for Alexander Neville. Worker went into case to check status. 

	Alexander has an approved GAP rate through 1/2023. 
	I need assistance in determining why this payment was not issued.

-- Case ID: 3179051 - d0fbfe88-104e-41c2-9df5-e32edf8cfc94
-- Client ID: 2768123 (ALEXANDER P NEVILLE) - a7484a39-d3ba-48f1-838e-de18b759461e
-- GAP ID: 1005391 - 2020-01-23 To 2030-08-21 -	4f825a0c-b23f-4ec6-99e7-c58d611622f6
-- Provider ID: 5093386 (Stacy Green)   
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan
-- 1	46e8dc9f-7200-447e-9ed8-cb82b2928295	OTHCHNH	- active
-- 0	e08e718a-6ade-448a-a49b-4471ee38b1cc	AV		- current Inactive
select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = 'e8271b01-8875-4992-8a42-a05a57196086'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = '46e8dc9f-7200-447e-9ed8-cb82b2928295',
	updatedby = 'CDM-23596',
	updatedon = now()
where permanencyplanid = 'e8271b01-8875-4992-8a42-a05a57196086'
	and activeflag  = 1 ;
	
-- To Trigger Under Over 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where gaprateid = 'cb4c6c02-e4ed-4cf3-8f20-ccc2b36f307a' ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-23596',
	updatedon = now()
where gaprateid = 'cb4c6c02-e4ed-4cf3-8f20-ccc2b36f307a' ;
