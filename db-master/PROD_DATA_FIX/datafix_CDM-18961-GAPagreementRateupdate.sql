-- CDM-18961 - Rate override
/*
-- Issue Description: 
   Please override the rate for Arnyah Saunders. 
   The correct rate amount should be $868


*/


-- 29.33	Approved
update gapagreementrate  
set paymentamout = 892.00,
	status = 'Approved',
	updatedon = now(), 
	updatedby = 'CDM-18961'
where gapagreementrateid = '06c6c852-e4a9-48f5-8e49-bb864bfbfe1a'
	and gapagreementid = '91683dd2-e80e-4112-854b-0a579e33c72e'
	and activeflag = 1 ;

-- 29.33	Approved
update gapratesrevision
set paymentamt = 892.00,
	approvalstatustypekey = '3047',
	approvaldate = now(), 
	updatedon = now(), 
	updatedby = 'CDM-18961'
where gaprateid = '06c6c852-e4a9-48f5-8e49-bb864bfbfe1a' and activeflag = 1 ;