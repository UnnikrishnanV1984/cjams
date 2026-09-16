-- CDM-13302 - Rate override
/*
-- Issue Description: 
   Please override the rate for Arnyah Saunders. 
   The correct rate amount should be $868

-- Case ID: 3207125 
-- Client ID: 3300349 (ARNYAH SANDERS) - 69e23194-f17a-4b30-92a0-3fa2e26431ad
-- Provider ID: 5057146	(Tawanada Murphy)
-- GAP ID: 3811 - 04/21/2015 to 08/11/2021 - b50f6573-769c-4601-8814-7abbcd7ec26a
-- GAP Rate: f2388704-868b-4cd7-a979-08ea1b1146f2 - 2021-04-21 to 2021-08-11 - $795
    
-- Category/ Module: GAP (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the approved GAP rates.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Update GAP Rate & Rate Revision
select paymentamout, startdate, enddate, status, updatedby, updatedon 
	from gapagreementrate  
where gapagreementrateid = 'f2388704-868b-4cd7-a979-08ea1b1146f2'
	and gapagreementid = '8d651a47-cb09-4b63-84c5-2571dfe7266f'
	and activeflag = 1 ;

update gapagreementrate  
set paymentamout = 868.00,
	status = 'Approved',
	updatedon = now(), 
	updatedby = 'CDM-13302'
where gapagreementrateid = 'f2388704-868b-4cd7-a979-08ea1b1146f2'
	and gapagreementid = '8d651a47-cb09-4b63-84c5-2571dfe7266f'
	and activeflag = 1 ;

select paymentamt, approvaldate, approvalstatustypekey, activeflag, updatedby, updatedon
	from gapratesrevision
where gaprateid = 'f2388704-868b-4cd7-a979-08ea1b1146f2' ;

	
update gapratesrevision
set paymentamt = 868.00,
	approvalstatustypekey = '3047',
	approvaldate = now(), 
	updatedon = now(), 
	updatedby = 'CDM-13302'
where gaprateid = 'f2388704-868b-4cd7-a979-08ea1b1146f2' ;

	