-- CDM-43163_Case_modification_to_Unsubstantiated
/*
-- Issue Description: 
User request change the Findings from Indicated to Unsubstantiated for the 9/14/09 Neglect case CW2576961 for Tirrell Johnson	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: User error 
-- Fix Provided: Datafix has been provided to change the Findings as Unsubstantiated for the 9/14/09 Neglect case CW2576961 for Tirrell Johnson
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Change the Overrride Finding as Unsubstantiated (CDM-43163)
/*
select overridefindingtypekey, oahearingdecision, updatedby, updatedon, *  
	from investigationallegationmaltreators
where investigationallegationmaltreatorsid  = 'eb160e84-29d8-4329-8503-698fa0647be3'	
	and activeflag = 1 ;
*/

update investigationallegationmaltreators
set overridefindingtypekey = 'UD',
	updatedby = 'CDM-43163', 
	updatedon = now()
where investigationallegationmaltreatorsid  = 'eb160e84-29d8-4329-8503-698fa0647be3'	
	and activeflag = 1 ;
	