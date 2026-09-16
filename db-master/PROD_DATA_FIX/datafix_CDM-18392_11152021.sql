-- CDM-18392 - GAP Agreement stuck in review
/*
-- Issue Description: 
   The provider has not been paid since 2020! She received C&G in January 2021.
   
-- Case ID: 3185135 - joy.iregbu@maryland.gov (Sup: monet.brown@maryland.gov)
-- Client ID: 4169078 (AMONIA BRADSHAW) - 5d4681bd-a3fa-40ee-a24a-351db0bd9dfd
-- GAP ID: 2021-01-07 To 2033-05-21  - 0cc1340d-bc84-46b6-ad58-567cc91620db
-- Provider ID: 5093783	(Lasheena Smith)
-- Permanency Plan ID: fe778193-6983-49e2-a9c8-5a647c1b755a
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan -> intakeservicerequestactorid
-- 1	bd90c6a0-2924-4ee5-be9a-d474ff33734a	CHILD
-- 0	87d5a540-4786-451f-b5bf-0d713c3b8b5a	AV


select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = 'fe778193-6983-49e2-a9c8-5a647c1b755a'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = 'bd90c6a0-2924-4ee5-be9a-d474ff33734a',
	updatedby = 'CDM-18392',
	updatedon = now()
where permanencyplanid = 'fe778193-6983-49e2-a9c8-5a647c1b755a'
	and activeflag  = 1 ;

