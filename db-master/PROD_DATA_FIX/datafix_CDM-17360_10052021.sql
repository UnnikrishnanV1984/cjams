-- CDM-17360 - Wrong maltreatment type
/*
-- Issue Description: 
   The case was originally assigned as a Neglect however the 181 is showing 
   that the maltreatment type is a sex abuse.
	
-- CPS-IR: 211020131004 - 303353dd-2def-4ef8-911c-8b02fa160501

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
where investigationallegationid 
	in (	'1071121c-5cd9-47fd-8362-ed20f520fec3',
			'cfc1f4f5-7425-421a-966d-559de08558ab'
		)
	and activeflag = 1;
	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	updatedby = 'CDM-17360',
	updatedon = now()		
where investigationallegationid 
	in (	'1071121c-5cd9-47fd-8362-ed20f520fec3',
			'cfc1f4f5-7425-421a-966d-559de08558ab'
		)
	and activeflag = 1;
