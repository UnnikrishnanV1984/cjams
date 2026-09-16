-- CDM-18016 - Non generated payment
/*
-- Issue Description:
	Case is in Review status but was approved for the annual agreement 
	on October 21, 2021 for the Guardianship Agreement payments to continue 
	for Alexander Oxendine. The payment has not generated. 
   
-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Deployed Issue; was fixed & deployed on Prod 10/22
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Case ID: 3175750
-- Client ID: 2679981 (ALEXANDER J OXENDINE) - 62d31a69-ef16-43ba-8971-02018e4a8fbd
-- GAP ID: 1919 - 2011-09-15 TO 2025-04-26 - 3fb45357-e1b2-4b66-af6a-b3a1ddb2e8d3
-- Provider ID: 5047785	(Kathleen Nugent)
-- GAP Agreement ID: 1ce2a16b-ccdb-404b-b736-ed250dc122b2 
-- gapagreementrateid: 266d0dee-4613-4e0a-be67-2ef4d5a18566

*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '266d0dee-4613-4e0a-be67-2ef4d5a18566'
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-18016',
	updatedon = now()
where gapagreementrateid = '266d0dee-4613-4e0a-be67-2ef4d5a18566'
	and lower(status) = 'review' 
	and activeflag = 1 ;
