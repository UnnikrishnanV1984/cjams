-- CDM-22874 - Adoption Case permanency button
/*
-- Issue Description: 
   Adoption is finalized and permanency sent to supervisor approval 
   and child's name is no longer visible to proceed with the adoption planning case.
   
-- Case ID: 3211279 - 116e5c1f-b363-4b1d-b131-3039e4d39415
-- Client ID: 3249894 (ERSKINE TROUBLEFIELD) - 8b5e9a5c-d1e3-4d07-b276-09c48e505124
-- intakeservicerequestactorid: fcaac4da-1fb7-42bc-8a4b-647c88b0168a - CHILD
-- permanencyplanid = e80b855d-efab-47be-bd08-a0572a6eeafb
   
-- Category/ Module: Permanency Plan (Case Management)
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- update intakeservicerequestactorid as fcaac4da-1fb7-42bc-8a4b-647c88b0168a - CHILD
select permanencyplanid, intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = 'e80b855d-efab-47be-bd08-a0572a6eeafb'
	and activeflag = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = 'fcaac4da-1fb7-42bc-8a4b-647c88b0168a',
	updatedby = 'CDM-22874',
	updatedon = now()
where permanencyplanid = 'e80b855d-efab-47be-bd08-a0572a6eeafb'
	and activeflag = 1 ;
