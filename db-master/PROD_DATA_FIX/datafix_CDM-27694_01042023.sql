-- CDM-27694 - No GAP payment generated
/*
-- Issue Description: 
	The GAP was completed on Kaiden Brown and the payments have not been generated.

-- Case ID: 3163902 - a946147c-676a-4ae7-bf1c-402e3e2e0fe4
-- Client ID: 4256853 (KAIDEN AMIR BROWN) - 8df8b134-22f6-493a-922f-b9f8b29b3149
-- GAP ID: 1006346 - 2022-10-21 To 2036-06-04 - f751365c-f07a-4380-a904-2f2e375bb8a2
-- Provider ID: 6003352	(JOAN M LEAZER) 
-- permanencyplanid: e1655097-0900-4bf8-8033-8d8934c71ef6
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Fix Provided: Datafix has been promoted to resolve the data discrepancy (update active intakeservicerequestactorid in permanencyplan table)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP permanencyplan
-- 0	016c3886-7fee-41f0-8ec0-8b75a58766b4	c1072b83-3dc5-49be-9273-800d89cac5db	LG
-- 1	9afa88b1-2a52-4907-8260-9115efcfe22a	c1072b83-3dc5-49be-9273-800d89cac5db	CHILD

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = 'e1655097-0900-4bf8-8033-8d8934c71ef6'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = '9afa88b1-2a52-4907-8260-9115efcfe22a',
	updatedby = 'CDM-27694',
	updatedon = now()
where permanencyplanid = 'e1655097-0900-4bf8-8033-8d8934c71ef6'
	and activeflag  = 1 ;
	
-- To Trigger Under Over 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where gaprateid = '4694f0d0-21eb-479a-b228-dde1c2134ab6' ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-27694',
	updatedon = now()
where gaprateid = '4694f0d0-21eb-479a-b228-dde1c2134ab6' ;
