-- CDM-17387 - Added maltreatment
/*
-- Issue Description: 
	This case has a maltreatment type of sexual abuse which is not an allegation in the case 
	and is not marked on SDM. It was originally listed as 2 maltreatments for neglect 
	and 1 for a physical. Once sent for approval the second neglect changed to a maltreatment of sexual abuse.
	
-- CPS-IR: 211020132005 - 5fd469ac-0254-4ff2-a254-ce9fa4a61825

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
where investigationallegationid = '87d352a1-844f-4135-a8e1-30046fd6b431'
	and activeflag = 1;
	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	updatedby = 'CDM-17387',
	updatedon = now()		
where investigationallegationid = '87d352a1-844f-4135-a8e1-30046fd6b431'
	and activeflag = 1;

