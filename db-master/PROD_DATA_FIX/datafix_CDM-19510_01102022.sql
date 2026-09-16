-- CDM-19510 - Supervisor Approval
/*
-- Issue Description: 
	User request to change the GAP Annual Review date as 12/20/2021 
    for Client name LISSA ALEM and JEREMIAH DORSEY-SH'MAAD

-- Case ID: 3080101
-- Provider ID: 5095638 (Jair  Dorsey)

-- Client ID: 3627370 (JEREMIAH DORSEY-SH'MAAD) - 7284fef2-9f29-46f1-bd12-e502e6cd02b4
-- GAP ID: 1005615 - 12/10/2020 To 09/12/2034 - 9284a2b8-c57a-41f6-aaf4-e608848c3dc1

-- Client ID: 3989655 (LISSA ALEM)- 11df0f11-8dfb-4df7-9385-37378bfa393b
-- GAP ID: 1005616 - 12/10/2020 To 03/13/2036 - 3cd6bdcd-96c1-4a62-800a-841f74d706f2

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Annual Review date as 12/20/2021  (old value is 12/28/2021)
select gapannualreviewid, gapid, reviewdate, effectivedate, updatedby, updatedon 
   from gapannualreview
where gapannualreviewid 
		in ( '98f2a69a-2746-4dd8-8a28-7c4c7ce65ee2',
			 '968b723c-7485-44de-8274-f75a0d309bf0'
			)
	and activeflag = 1 ;


update gapannualreview 
set reviewdate = '2021-12-20 05:00:00',
	effectivedate = '2021-12-20 10:51:59',
	updatedby = 'CDM-19510',
	updatedon = now()
where gapannualreviewid = '968b723c-7485-44de-8274-f75a0d309bf0'
	and activeflag = 1 ;


update gapannualreview 
set reviewdate = '2021-12-20 05:00:00',
	effectivedate = '2021-12-20 10:52:54',
	updatedby = 'CDM-19510',
	updatedon = now()
where gapannualreviewid = '98f2a69a-2746-4dd8-8a28-7c4c7ce65ee2'
	and activeflag = 1 ;

