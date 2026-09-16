-- CDM-33197 - GAP subsidy didn't generate payment
/*
-- Issue Description: 
	GAP subsidy was opened (Delvine Gentry) but did not generate payment. 
	C&G granted 03/15/23.

-- Case ID:3241959 - 085d4929-f8dd-4c79-9feb-29716e48b604
-- Client ID: 3678146 (DELVINE MARKELL GENTRY) - aec8cb6d-17ae-4f48-8224-635a905d3b1a
-- GAP ID: 1009919 - 2032-06-27 To 2023-03-15 - a586e297-350e-4fc3-85d9-a64fe8c3e8eb
-- Provider ID: 5095687	(Bianca Thompson) 

-- permanencyplanid : 6d42f23c-1e4b-4841-a9ac-bd84f2ed924c
-- intakeservicerequestactorid:
-- 1	d20f60a9-60a2-4a26-adba-1b7ffb6d925e	CHILD
-- 0	d3d0d3d5-5e53-4ca0-b674-7281408fc958	AV

   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. 
--                  Dev team is working on the permenamt soultion for this issue with CIDM-7525
-- Fix Provided: Datafix has been promoted to resolve the data discrepancy (update active intakeservicerequestactorid in permanencyplan table)
--				 and trigger finance under/over batch.	
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- permanencyplanid : 6d42f23c-1e4b-4841-a9ac-bd84f2ed924c
-- intakeservicerequestactorid:
-- 1	d20f60a9-60a2-4a26-adba-1b7ffb6d925e	CHILD
-- 0	d3d0d3d5-5e53-4ca0-b674-7281408fc958	AV

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = '6d42f23c-1e4b-4841-a9ac-bd84f2ed924c'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = 'd20f60a9-60a2-4a26-adba-1b7ffb6d925e',
	updatedby = 'CDM-33197',
	updatedon = now()
where permanencyplanid = '6d42f23c-1e4b-4841-a9ac-bd84f2ed924c'
	and activeflag  = 1 ;
	
-- To Trigger Under Over 
select providerid, ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where gaprateid = 'aa3d2fba-6ce6-4a2a-a409-42080c49574c' ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-33197',
	updatedon = now()
where gaprateid = 'aa3d2fba-6ce6-4a2a-a409-42080c49574c' ;
