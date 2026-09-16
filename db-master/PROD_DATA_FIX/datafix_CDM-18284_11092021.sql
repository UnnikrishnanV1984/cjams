-- CDM-18284 - GAP Renewal
/*
-- Issue Description:
	Supervisor not able to approve the new GAP rate. 
	Once she hits approve, the approval does not stay. 
	
-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Deployed Issue; was fixed & deployed on Prod 10/22
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Case ID: 3193679 
-- Client ID: 3158975 (CALVIN FAULKNER) - 007ae3ad-27e2-460c-aea2-e794ec977f9c
-- GAP ID: 2630 - 2012-12-17 To 2028-05-02 - 60e68e46-a46e-4a72-8eca-dbd2c437845b
-- Provider ID: 5057445 (Gena Thomas)
-- GAP Agreement ID: b188770c-d7a8-4407-83d8-a622c2d8d8b9 
-- gapagreementrateid: 9630e3a2-24f6-45eb-8f85-f8a405bfee10
*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '9630e3a2-24f6-45eb-8f85-f8a405bfee10'
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-18284',
	updatedon = now()
where gapagreementrateid = '9630e3a2-24f6-45eb-8f85-f8a405bfee10'
	and lower(status) = 'review' 
	and activeflag = 1 ;
