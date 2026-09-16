-- CDM-19834 - Cannot complete new rate
/*
-- Issue Description: 
   User request to update the GAP rate as $950 for 12/06/2021 to 12/05/2022 
   (Current wrong  correct rate amount should be $868

-- Provider ID: 5020093	(Cynthia Denise Harrison)
-- Case ID: 3098861
-- Client ID: 3382583 (KEITH E HARRISON) - e0b416bb-6dbe-4c27-871b-eb20413bf4a4
-- GAP ID: 3110 - 2013-12-06 To 2029-12-26 - 4af3bb23-09bd-4c20-8ada-f1d9720371ce
-- GAP Rate: 12/06/2021 To 12/05/2022 - $887 (gapagreementrateid: '5ea7c119-f233-48d9-b673-062a7063ae33')
    
-- Category/ Module: GAP (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the amount on approved GAP rates.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Update GAP Rate & Rate Revision
select paymentamout, startdate, enddate, status, updatedby, updatedon 
	from gapagreementrate  
where gapagreementrateid = '5ea7c119-f233-48d9-b673-062a7063ae33'
	and activeflag = 1 ;

update gapagreementrate  
set paymentamout = 950.00,
	status = 'Approved',
	updatedon = now(), 
	updatedby = 'CDM-19834'
where gapagreementrateid = '5ea7c119-f233-48d9-b673-062a7063ae33'
	and activeflag = 1 ;

select paymentamt, approvaldate, approvalstatustypekey, activeflag, updatedby, updatedon
	from gapratesrevision
where gaprateid = '5ea7c119-f233-48d9-b673-062a7063ae33' ;

update gapratesrevision
set paymentamt = 950.00,
	approvalstatustypekey = '3047',
	approvaldate = now(), 
	updatedon = now(), 
	updatedby = 'CDM-19834'
where gaprateid = '5ea7c119-f233-48d9-b673-062a7063ae33' ;
	