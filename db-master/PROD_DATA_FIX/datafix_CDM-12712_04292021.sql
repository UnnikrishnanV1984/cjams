-- CDM-12712 - UNABLE TO CORRECT RATE
/*
-- Issue Description: 
	User request to correct the GAP rate amount for mulan wilson. 
	Incorrect amount entered as $902, correct amount should be $887 for 9/14/20-9/13/21 agreement.
	
	Case ID: 3242272
	Client ID: 4121116 (MULAN WILSON)
    GAP ID: 1005551 - 2020-09-14 to 2037-11-22 - bee17080-0f83-4528-986d-6e25ed53c648
    
-- Category/ Module: GAP (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the approved GAP rates.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Datafix Reuest to change the Monthly GAP rate as $887.00 (current vlaue is $902.00)
select startdate, enddate, paymentamout, updatedby, updatedon, status
	from gapagreementrate  
where gapagreementrateid  = 'daaad5fd-d2dd-4874-81fa-52436256cd78'
	and activeflag = 1 ;

update gapagreementrate  
set paymentamout = 887.00,
	updatedon = now(), 
	updatedby = 'CDM-12712'
where gapagreementrateid  = 'daaad5fd-d2dd-4874-81fa-52436256cd78'
	and activeflag = 1 ;

select ratestartdate, rateenddate, paymentamt, approvaldate, approvalstatustypekey, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = 'daaad5fd-d2dd-4874-81fa-52436256cd78'
	and gapratesrevisionid = '72f8e402-9382-4aba-be25-b902c7b94b69'
	and activeflag  = 1	;
	
update gapratesrevision
set paymentamt = 887.00,
	approvaldate = now(), 
	updatedon = now(), 
	updatedby = 'CDM-12712'
where gaprateid = 'daaad5fd-d2dd-4874-81fa-52436256cd78'
	and gapratesrevisionid = '72f8e402-9382-4aba-be25-b902c7b94b69'
	and activeflag  = 1	;

