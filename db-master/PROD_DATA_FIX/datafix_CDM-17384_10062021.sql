-- CDM-17384 - Investigation Maltreatment Type Incorrect
/*
-- Issue Description: 
	In this case, the maltreatment type should only be the Neglect and not sexual abuse. 
	The maltreatment for Sexual Abuse is a defect due to the SDM pathway does not indicate 
	anywhere that sexual abuse is part of this case.
	
-- CPS-IR: 211020140074 - 0fbc1d75-d07b-4338-aef6-57007332cf6e

-- Category/ Module: CPS-IR  (Investigation Management) 
-- Root cause: This error occurred due to the wrong datafix was promoted with CDM-14707 
	           for the allegation table. That fix was reverted on 10/04 evening. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- e11fc4b5-1edf-4f17-af54-b536bbf6df31 - Neglect	   (New)
-- 19233c90-707c-482c-93c8-b33738685fc6 - Sexual Abuse (Current)

select investigationallegationid, allegationid, "name", updatedby, updatedon
	from investigationallegation
where investigationallegationid = 'cbc46fe2-24bf-4e19-a68b-a72d758dc0c5'
	and activeflag = 1;
	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	updatedby = 'CDM-17384',
	updatedon = now()		
where investigationallegationid = 'cbc46fe2-24bf-4e19-a68b-a72d758dc0c5'
	and activeflag = 1;

