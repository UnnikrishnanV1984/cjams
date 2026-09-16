-- CDM-17364 - Wrong maltreatment type
/*
-- Issue Description: 
   This case is assigned as a Neglect however the 181 is showing that it is assigned as a Sex abuse case
	
-- CPS-IR: 211020130715 - 1e3aa3db-7b32-42ff-9769-4d78927e149e

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
	in (	'00cc597f-3505-42dc-bf6c-decf83e21ffe',
			'6c78bbcd-f271-47ca-bc00-a5c85005231b',
			'b45625a8-d824-4330-bf39-b775fe10ed53'
		)
	and activeflag = 1;
	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	updatedby = 'CDM-17364',
	updatedon = now()		
where investigationallegationid 
	in (	'00cc597f-3505-42dc-bf6c-decf83e21ffe',
			'6c78bbcd-f271-47ca-bc00-a5c85005231b',
			'b45625a8-d824-4330-bf39-b775fe10ed53'
		)
	and activeflag = 1;
