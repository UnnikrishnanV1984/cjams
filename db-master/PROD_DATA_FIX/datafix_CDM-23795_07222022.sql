-- CDM-23795 - Gap subsidy payment issue
/*
-- Issue Description: 
   Gap payment did not generate from 5-13-22 thur 05-31-22. 
   Provider was only paid from 05-1-22 thur 05-05-22.
   
-- Case ID: 3219633 - 73b64506-1d77-4647-a13f-138377a054b7
-- Client ID: 3882204 (CZARINA HICKS) - 5ca522f2-3aeb-41c1-b83e-8af85889bbf8
-- GAP ID: 1006052 - 2022-05-05 To 2033-08-07 - 0a6d36a3-92fd-478e-86ec-926f3f0dde7e
-- Provider ID: 5037263 (Carla Singleton) 
-- PP ID: 509f092e-a494-4209-853f-fa0032c9105b
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan
-- 1	3d6e6a0e-f073-4d3f-a819-f9da70c14601	CHILD    - active
-- 0	1f6442e8-7c28-4453-ba4b-3b06442fb683	RELATIVE - current Inactive
select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = '509f092e-a494-4209-853f-fa0032c9105b'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = '3d6e6a0e-f073-4d3f-a819-f9da70c14601',
	updatedby = 'CDM-23795',
	updatedon = now()
where permanencyplanid = '509f092e-a494-4209-853f-fa0032c9105b'
	and activeflag  = 1 ;
	
-- To Trigger Under Over 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where gaprateid = '1b65b34b-b622-4b80-87be-dd375961096f' ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-23795',
	updatedon = now()
where gaprateid = '1b65b34b-b622-4b80-87be-dd375961096f' ;
