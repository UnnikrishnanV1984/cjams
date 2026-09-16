-- CDM-17026 - Stuck case
/*
-- Issue Description: 
   Case 20200260035414 remains on the CPS Milestone report for AACo.......showing 369 days old. 
   Case does not come up when searched- shows No Record Found. PLEASE delete
   
-- CPS-IR 20200260035414
    
-- Category/ Module: CPS-IR  (Investigation Management) 
-- Root cause: Audit column was missed in the prior datafix. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Old Values CDM-4282	2020-09-16 12:32:25
select actiontype, servicerequestnumber, activeflag, updatedby, updatedon
	from cjams.intakeservicerequest 
where servicerequestnumber = 20200260035414
	and activeflag = 0 ;
	
update cjams.intakeservicerequest 
set updatedby = 'CDM-17026',
	updatedon = now()
where servicerequestnumber = 20200260035414
	and activeflag = 0 ;
