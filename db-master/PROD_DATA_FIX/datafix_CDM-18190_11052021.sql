-- CDM-18190 - Partial Payment
/*
-- Issue Description:
	A partial payment generated and the Annual GAP Agreement was approved 10/18/2021.
   
-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Deployed Issue; was fixed & deployed on Prod 10/22
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Case ID: 3126425
-- Client ID: 3387251 (TYLEAH TANZYMORE) - eb123052-5c02-46f5-880c-288d32b5ec0e
-- GAP ID: 3008 - 2013-10-16 To 2030-05-14 - 679896eb-49a8-42a0-883d-8621fed7b8c8
-- Provider ID: 5041150 (Antionette Garrett)
-- GAP Agreement ID: 7f5cfb97-0deb-4452-a73d-0641ae8282ef
-- gapagreementrateid: 8fe1d072-1949-49b8-87de-6570c1f84282
*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '8fe1d072-1949-49b8-87de-6570c1f84282'
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-18190',
	updatedon = now()
where gapagreementrateid = '8fe1d072-1949-49b8-87de-6570c1f84282'
	and lower(status) = 'review' 
	and activeflag = 1 ;
