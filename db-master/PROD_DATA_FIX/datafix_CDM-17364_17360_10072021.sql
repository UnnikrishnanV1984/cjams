-- 2nd Fix for Wrong maltreatment type
/*
-- Issue Description: 
   This case is assigned as a Neglect however the 181 is showing that it is assigned as a Sex abuse case

-- CDM-17360 
-- CPS-IR: 211020131004 - 303353dd-2def-4ef8-911c-8b02fa160501
	
-- CDM-17364	
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

-- CDM-17360 
-- CPS-IR: 211020131004 - 303353dd-2def-4ef8-911c-8b02fa160501
select investigationallegationid, allegationid, "name", updatedby, updatedon
	from investigationallegation
where investigationallegationid 
	in (	'a41e8c67-d0f3-476a-90fd-9fb73b951b22',
			'ae1a9ad7-05f9-4e0a-8b8c-0aed6c21d009'
		)
	and activeflag = 1;
	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	updatedby = 'CDM-17360_1',
	updatedon = now()		
where investigationallegationid 
	in (	'a41e8c67-d0f3-476a-90fd-9fb73b951b22',
			'ae1a9ad7-05f9-4e0a-8b8c-0aed6c21d009'
		)
	and activeflag = 1;


-- CDM-17364	
-- CPS-IR: 211020130715 - 1e3aa3db-7b32-42ff-9769-4d78927e149e
select investigationallegationid, allegationid, "name", updatedby, updatedon
	from investigationallegation
where investigationallegationid 
	in (	'01bacf37-9e17-46de-a073-e7b7bc180cd5',
			'aaaa139c-aa3e-41fe-ab17-1baf44d408fb',
			'b4886d95-f26a-4fd8-acc3-306ab55e4f29'
		)
	and activeflag = 1;
	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	updatedby = 'CDM-17364_1',
	updatedon = now()		
where investigationallegationid 
	in (	'01bacf37-9e17-46de-a073-e7b7bc180cd5',
			'aaaa139c-aa3e-41fe-ab17-1baf44d408fb',
			'b4886d95-f26a-4fd8-acc3-306ab55e4f29'
		)
	and activeflag = 1;
