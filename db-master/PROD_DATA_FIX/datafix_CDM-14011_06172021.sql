-- CDM-14011 - Payment are not showing processed in payments tab - v1
/*
-- Issue Description: 
   The GAP payment is missing starting Jan 31th 2021 srevices. 
   
-- Case ID: 3245434
-- Client ID: 1827366 (TAEON K DENT) - facb6b52-4b67-48ce-b19f-f00ec0105287
-- GAP ID: 5131 - 2019-01-31 To 2024-04-13 - de8a7330-895c-4657-a5c0-d9754fedc6fa
-- Provider ID: 5083599	(Elliott Blue)
-- PP ID: 4cfa8a20-5b07-4163-9204-726101ddc1de
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan
-- Actor ID: 0f5e8140-98b4-4465-807a-93fcb7080112 - active flag 0
-- New Actor ID: 093e937b-c276-4482-b988-c1afd45914d5 (update)

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
from cjams.permanencyplan
where permanencyplanid = '4cfa8a20-5b07-4163-9204-726101ddc1de'
and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = '093e937b-c276-4482-b988-c1afd45914d5',
updatedby = 'CDM-14011',
updatedon = now()
where permanencyplanid = '4cfa8a20-5b07-4163-9204-726101ddc1de'
and activeflag  = 1 ;
	
-- To Trigger Under Over -- 2021-01-31 To 2022-01-30
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
from cjams.gapratesrevision
where guardiansubsidyid = 'de8a7330-895c-4657-a5c0-d9754fedc6fa'
and activeflag = 1 ;

update cjams.gapratesrevision
set approvaldate = now(),
updatedby = 'CDM-14011',
updatedon = now()
where guardiansubsidyid = 'de8a7330-895c-4657-a5c0-d9754fedc6fa'
and activeflag = 1 ;

