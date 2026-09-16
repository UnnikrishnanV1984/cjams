-- CDM-44248_Case_modification_to_Unsubstantiated
/*
 Issue Description: User request change the Findings from Indicated to Unsubstantiated for both Alleged Maltreators in CPS-IR #221020187190.   
 Category/ Module: Intake/Investigation Findings 
 Root cause: User error and requested for a data fix to change the Findings from Indicated to Unsubstantiated for both Alleged Maltreators in CPS-IR #221020187190.  
 Fix Provided: Datafix has been provided to change the Findings as Unsubstantiated for the CPS-IR #221020187190
 Regression Impacts:N/A
 Reason why no related code fix: User error and data fix should resolve it.
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Change the Overrride Finding as Unsubstantiated (CDM-44248)

update investigationallegationmaltreators
set overridefindingtypekey = 'UD',
	updatedby = 'CDM-44248', 
	updatedon = now()
where investigationallegationmaltreatorsid  in ('32365d1b-a871-440e-a058-490c2824c6fb','ed4d4305-ed4d-4943-9396-65949910d13a')	
	and activeflag = 1 ;
	