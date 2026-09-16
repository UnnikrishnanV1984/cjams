-- CDM-17276 - GAP Agreement will not allow approval
/*
-- Issue Description: 
   The GAP subsidy agreement is in review status. I have tried multiple times to approve it.
   
-- Case ID: 3252018 - 4af429c7-580c-42c9-b366-c9f148952b70
-- Client ID: 3128184 (HAYDEN Lee STIEKMAN) - 152e42af-91e4-486c-a781-79d57db8f42b
-- GAP ID: 1005805 - 2021-07-23 To 2031-03-22 - 8467196c-5ee0-43b8-ae2a-886b3cf6d1e6
-- Provider ID: 6002806	(SHARON GRADY) 
-- Permanency Plan ID: 8a8d1ee7-13d4-4ed7-a3f6-6be24e32387f
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan -> intakeservicerequestactorid
-- 2666963f-54d0-4930-a79b-417fb6750ee1	- CHILD - Active
-- af1c6993-c01e-4196-9177-524bbe99e0c2	- OTHERCHILD - Inactive (current)

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = '8a8d1ee7-13d4-4ed7-a3f6-6be24e32387f'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = '2666963f-54d0-4930-a79b-417fb6750ee1',
	updatedby = 'CDM-17276',
	updatedon = now()
where permanencyplanid = '8a8d1ee7-13d4-4ed7-a3f6-6be24e32387f'
	and activeflag  = 1 ;
	