-- CDM-31640 - GAP payment stoppped
/*
-- Issue Description: 
	No provider payment generated for April 2023 on both children. 
    No suspension and withhold payment for Provider.

-- Case ID: 3109455
-- Provider ID: 5012370 (Shaneaka T Jones) - Local Department Home

-- Client ID: 4337142 (JAMIRAH HALEY) - 0542c544-1ac2-45ca-936b-e37426424357
-- GAP ID: 1006184
-- permanencyplanid ID: b18e99bc-7f79-4e91-8c95-be1cf723d591
0	1c310e8a-45ec-4de8-aed5-86593b9bedb7	bf3b26de-8bef-4d21-a173-5792a411f775	CHILD
1	d1ba460d-1cdc-4587-9116-5d206f51ea21	bf3b26de-8bef-4d21-a173-5792a411f775	OTHCHNH

-- Client ID: 4447578 (JANIYAH HALEY) - bca7dc36-4213-4adc-8e10-727a9a1dcf81
-- GAP ID: 1006200
-- permanencyplanid ID: 3a34e4b7-e1cc-4e29-8cf1-91c81c85fce5
0	e411ec60-96e9-4c3e-83a3-3d3f314e1e3d	99d0c973-bee1-432a-858c-409beca2be41	OTHERCHILD
1	b36ebb3b-b520-46b3-a463-30fc4e8d2a24	99d0c973-bee1-432a-858c-409beca2be41	OTHCHNH
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Fix Provided: Datafix has been promoted to resolve the data discrepancy (update active intakeservicerequestactorid in permanencyplan table)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 4337142 (JAMIRAH HALEY) - 0542c544-1ac2-45ca-936b-e37426424357
-- permanencyplanid ID: b18e99bc-7f79-4e91-8c95-be1cf723d591
-- 0	1c310e8a-45ec-4de8-aed5-86593b9bedb7	bf3b26de-8bef-4d21-a173-5792a411f775	CHILD
-- 1	d1ba460d-1cdc-4587-9116-5d206f51ea21	bf3b26de-8bef-4d21-a173-5792a411f775	OTHCHNH

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = 'b18e99bc-7f79-4e91-8c95-be1cf723d591'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = 'd1ba460d-1cdc-4587-9116-5d206f51ea21',
	updatedby = 'CDM-31640',
	updatedon = now()
where permanencyplanid = 'b18e99bc-7f79-4e91-8c95-be1cf723d591'
	and activeflag  = 1 ;
	
-- To Trigger Under Over 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where gaprateid = '048060f4-95a3-471b-ba6b-ba0ce025d302' ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-31640',
	updatedon = now()
where gaprateid = '048060f4-95a3-471b-ba6b-ba0ce025d302' ;

-- Client ID: 4447578 (JANIYAH HALEY) - bca7dc36-4213-4adc-8e10-727a9a1dcf81
-- permanencyplanid ID: 3a34e4b7-e1cc-4e29-8cf1-91c81c85fce5
-- 0	e411ec60-96e9-4c3e-83a3-3d3f314e1e3d	99d0c973-bee1-432a-858c-409beca2be41	OTHERCHILD
-- 1	b36ebb3b-b520-46b3-a463-30fc4e8d2a24	99d0c973-bee1-432a-858c-409beca2be41	OTHCHNH

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = '3a34e4b7-e1cc-4e29-8cf1-91c81c85fce5'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = 'b36ebb3b-b520-46b3-a463-30fc4e8d2a24',
	updatedby = 'CDM-31640',
	updatedon = now()
where permanencyplanid = '3a34e4b7-e1cc-4e29-8cf1-91c81c85fce5'
	and activeflag  = 1 ;
	
-- To Trigger Under Over 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where gaprateid = '720550bd-0cde-41dc-bd41-057e23f9645a' ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-31640',
	updatedon = now()
where gaprateid = '720550bd-0cde-41dc-bd41-057e23f9645a' ;