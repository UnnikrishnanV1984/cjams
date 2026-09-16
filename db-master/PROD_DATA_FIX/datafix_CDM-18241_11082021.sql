-- CDM-18241 - Rate Agreement Stuck in Review Status
/*
-- Issue Description:
   Supervisor not able to approve the new GAP rates, stuck in Review Status. 
	
-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Deployed Issue; was fixed & deployed on Prod 10/22
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Case ID: 3174087
-- Client ID: 2806261 (SHABAZZ ALI WATKINS) - 763b447d-6d85-4665-ac2e-3856393880c9
-- GAP ID: 1694 - 2011-05-31 To 2027-07-29 - 9172ead1-1803-4a30-86a8-d370c54b3a7c
-- Provider ID: 5042753 (Tomasina Degree)
-- GAP Agreement ID: 28cb8ac5-418d-4e62-b2f2-811337d65824 
-- gapagreementrateid: 927b508f-99e0-4de0-8041-ab0be8c32818

-- Case ID: 3150182
-- Client ID: 1945616 (NATHAN LONG) - 4d31cf2e-17f4-4ae5-b604-f2092abcd2e0 
-- GAP ID: 1320 - 2010-09-16 To 2025-02-16 - 8c98f9a6-f6e7-4f35-b244-9419e896c3c9  
-- Provider ID: 5042383 (Madeline Long)
-- GAP Agreement ID: 4bc97410-ade8-4fc6-bbd0-f7441642660a 
-- gapagreementrateid: 243cdc6d-cb0d-4943-982b-cebe93c83d0e

-- Case ID: 3164581
-- Client ID: 2341618 (MADISON WHEATLEY) - 661cfa3f-6fc9-49c7-a77a-628b19ad96dd 
-- GAP ID: 5314 - 2019-10-28 To 2026-02-17 - 5563f441-eff6-4fda-be8f-287f89501379
-- Provider ID: 5089414 (Robin Williams) 
-- GAP Agreement ID: d513b300-962b-45e0-8a09-d08aabe93332 
-- gapagreementrateid: 9af6fc67-cf3b-489a-9765-75187ddff08c

-- Case ID: 3171903
-- Client ID: 2560646 (JERMAI J C FLEMING) - b1b482f0-f005-4268-b79b-a63830a0bf8d 
-- GAP ID: 3021 - 2013-09-09 To 2026-12-04 - 855c0211-8e5c-4ea5-af28-8019398df516
-- Provider ID: 5053265 (Kendra Knight)
-- GAP Agreement ID: 5641c1c9-6276-4550-a8b3-864c0551485e 
-- gapagreementrateid: 02be5cc3-4831-4efa-9997-c973927ce05c

-- Case ID: 3194138
-- Client ID: 3418659 (DONTAY JONES) - 28360991-995e-4a59-a941-c5f1ce622521
-- GAP ID: 5002 - 2018-09-22 To 2029-06-13 - 6ef69f19-6baf-4796-b030-c7792de9d6da
-- Provider ID: 5091177 (Adrienne Nixon)
-- GAP Agreement ID: 2e6110a5-cd86-43b0-b9c0-d0dcbcb64635 
-- gapagreementrateid: 306c39b4-0390-4564-a606-0e7eade35ee9

-- Case ID: 3229800
-- Client ID: 3576944 (BLAKE ALLEN TOMAGO) - eda002d6-6339-4e95-a9f9-94deb8206c1f
-- GAP ID: 4615 - 2017-09-14 To 2031-09-11 - 29f05531-d0af-4195-9121-04ad3c274f9e
-- Provider ID: 5081773 (Jacqueline Propst)
-- GAP Agreement ID: eeb958ad-3377-4e29-95f3-332f8f51b3ec  
-- gapagreementrateid: bf99a958-60f1-498e-b3a1-966d99bd4a7e

*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid
	in (
			'927b508f-99e0-4de0-8041-ab0be8c32818',
			'243cdc6d-cb0d-4943-982b-cebe93c83d0e',
			'9af6fc67-cf3b-489a-9765-75187ddff08c',
			'02be5cc3-4831-4efa-9997-c973927ce05c',
			'306c39b4-0390-4564-a606-0e7eade35ee9',
			'bf99a958-60f1-498e-b3a1-966d99bd4a7e'
		)
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-18241',
	updatedon = now()
where gapagreementrateid
	in (
			'927b508f-99e0-4de0-8041-ab0be8c32818',
			'243cdc6d-cb0d-4943-982b-cebe93c83d0e',
			'9af6fc67-cf3b-489a-9765-75187ddff08c',
			'02be5cc3-4831-4efa-9997-c973927ce05c',
			'306c39b4-0390-4564-a606-0e7eade35ee9',
			'bf99a958-60f1-498e-b3a1-966d99bd4a7e'
		)
	and lower(status) = 'review' 
	and activeflag = 1 ;

