-- CDM-33355 - Change Finding
/*
-- Issue Description: 
	User request change the Findings from Indicated to Unsubstantiated for CPS-IR Case # 20200294043795.
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: User error 
-- Fix Provided: Datafix has been provided to change the Findings as Unsubstantiated for CPS-IR Case # 20200294043795.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Change the Overrride Finding as Unsubstantiated (CDM-33355)
	
select overridefindingtypekey, oahearingdecision, updatedby, updatedon, *  
	from investigationallegationmaltreators
where investigationallegationmaltreatorsid  = 'c617e8e4-266c-40e2-811b-8677fa713a2f'	
	and activeflag = 1 ;


update investigationallegationmaltreators
set overridefindingtypekey = 'UD',
	-- oahearingdecision = 'ID',
	updatedby = 'CDM-33355', 
	updatedon = now()
where investigationallegationmaltreatorsid  = 'c617e8e4-266c-40e2-811b-8677fa713a2f'	
	and activeflag = 1 ;
