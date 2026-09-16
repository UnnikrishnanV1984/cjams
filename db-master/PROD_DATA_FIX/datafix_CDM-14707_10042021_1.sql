-- CDM-14707 - Appeal modification
/*
-- Issue Description: 
    User request to change the maltreatment from sex abuse to neglect. 
	Got the confirmation from Stephanie to change the maltreatment type to Neglect.
	
	During an appeal the Department modified the finding for this case
	to Unsubstantiated Neglect. 
	   
    CPS IR: CW2924631 - 528b1f63-16ef-408b-9718-e6c90e184998
    
-- Category/ Module: CPS-IR  (Investigation Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Neglect (Old value 19233c90-707c-482c-93c8-b33738685fc6	Sexual Abuse )
-- e11fc4b5-1edf-4f17-af54-b536bbf6df31	Neglect
select allegationid, "name", updatedby, updatedon
	from investigationallegation
where investigationallegationid = '585f177a-f506-4724-94a9-8c4d718f75be'
	and activeflag = 1 ;

update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	"name" = 'Neglect',
	updatedby = 'CDM-14707_1',
	updatedon = now()		
where investigationallegationid = '585f177a-f506-4724-94a9-8c4d718f75be'
	and activeflag = 1 ;
