-- CDM-20787 - GAP Payments
/*
-- Issue Description: 
   GAP payments did not generate for the new Guardian, Kimberly Morris #6005100. The child is Brandon James. 
   Datafix to Remove the GAP Suspension.
   
-- Case ID: 3149765
-- Client ID: 1794282 (BRANDON D JAMES) - 8c8c8933-9012-469b-88d5-6df22e420e9a
-- GAP ID: 1129 - 2009-11-03 To 2025-02-08 - 77c9f20f-9219-486f-8c24-d09cec8edd70
-- Provider ID: 6005100	(Kimberly Morris)

-- Category/ Module: GAP (Case Management) 
-- Root cause: Veera is working on the code fix
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

select gapsuspensionid, startdate, enddate, activeflag, updatedby, updatedon 
    from cjams.gapsuspension 
where gapsuspensionid = 'cef23c17-c179-4225-8603-2cfa5787078a'
	and activeflag = 1 ;
	
update cjams.gapsuspension  
set enddate = startdate,
	updatedon = now(), 
	updatedby = 'CDM-20787'
where gapsuspensionid = 'cef23c17-c179-4225-8603-2cfa5787078a'
	and activeflag = 1 ;
	
select gapsuspensionrevisionid, startdate, enddate, approvaldate, approvalstatustypekey, updatedby, updatedon 
	from gapsuspensionrevision
where suspensionid = 'cef23c17-c179-4225-8603-2cfa5787078a' ;
	
update cjams.gapsuspensionrevision  
set enddate = startdate,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-20787'
where suspensionid = 'cef23c17-c179-4225-8603-2cfa5787078a' ;