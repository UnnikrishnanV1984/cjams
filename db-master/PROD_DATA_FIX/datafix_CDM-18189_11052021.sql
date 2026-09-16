-- CDM-18189 - Partial payment
/*
-- Issue Description:
	A partial payment generated and the Annual GAP Agreement was approved 10/13/2021.
   
-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Deployed Issue; was fixed & deployed on Prod 10/22
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Case ID: 3188855
-- Client ID: 2287142 (MUHANNA A SALAAM) - 318dc2b1-efb7-46e4-b424-a679c08c9aac
-- GAP ID: 3553 - 2014-07-10 To 2026-06-16 - a01f64fd-a3a3-4951-bb6c-89b1be09ced9
-- Provider ID: 5061601 (Candace Treadway)
-- GAP Agreement ID: b25f8001-348f-4da6-b6de-4c98c71cabf1 
-- gapagreementrateid: e7dfc816-ca48-45d0-8584-ee07701b02fc
*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = 'e7dfc816-ca48-45d0-8584-ee07701b02fc'
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-18189',
	updatedon = now()
where gapagreementrateid = 'e7dfc816-ca48-45d0-8584-ee07701b02fc'
	and lower(status) = 'review' 
	and activeflag = 1 ;
