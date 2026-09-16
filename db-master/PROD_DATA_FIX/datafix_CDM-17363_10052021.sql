-- CDM-17363 - Sexual Abuse Maltreatment Listed Mistakenly
/*
-- Issue Description: 
   Sexual Abuse Maltreatment was listed as an allegation for the alleged maltreator 
   under the case involving Dacia Tiller (211020130346). 
   This allegation was not associated with the current allegations in this case 
   and there was no way to correct this allegation before submitting the case.
	
-- CPS-IR: 211020130346 - 13b4943a-ac41-4322-b943-a1fbe401fc52

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
	in (	'01d78ac4-8a6a-4cda-8e2e-4e74818157af',
			'8c6664f1-3084-4046-babd-5fdae8aaa5a0',
			'9b6392c2-ad14-45bf-bdba-d469a03ef10c',
			'a0a7d57c-7711-47d3-a5e0-3d41edd1c2be',
			'dee72453-2467-4100-ac75-08dcc1a38737'
		)
	and activeflag = 1;
	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	updatedby = 'CDM-17363',
	updatedon = now()		
where investigationallegationid 
	in (	'01d78ac4-8a6a-4cda-8e2e-4e74818157af',
			'8c6664f1-3084-4046-babd-5fdae8aaa5a0',
			'9b6392c2-ad14-45bf-bdba-d469a03ef10c',
			'a0a7d57c-7711-47d3-a5e0-3d41edd1c2be',
			'dee72453-2467-4100-ac75-08dcc1a38737'
		)
	and activeflag = 1;


-- Delete 
select investigationfindingid, activeflag, updatedby, updatedon 
	from investigationfinding   
where investigationfindingid = 'fca906bb-670c-4791-9e32-5ad7cbf12718' 
	and activeflag = 1;

update investigationfinding
set activeflag = 0,
	updatedby = 'CDM-17363',
	updatedon = now()
where investigationfindingid = 'fca906bb-670c-4791-9e32-5ad7cbf12718' 
	and activeflag = 1;

select investigationallegationid, activeflag, updatedby, updatedon
	from investigationallegation
where investigationallegationid = '01d78ac4-8a6a-4cda-8e2e-4e74818157af'
	and activeflag = 1;

update investigationallegation
set activeflag = 0,
	updatedby = 'CDM-17363',
	updatedon = now()
where investigationallegationid = '01d78ac4-8a6a-4cda-8e2e-4e74818157af'
	and activeflag = 1;

select investigationallegationmaltreatorsid, activeflag, updatedby, updatedon 
	from investigationallegationmaltreators
where investigationallegationid = '01d78ac4-8a6a-4cda-8e2e-4e74818157af'
	and activeflag = 1;
	
update investigationallegationmaltreators
set activeflag = 0,
	updatedby = 'CDM-17363',
	updatedon = now()
where investigationallegationid = '01d78ac4-8a6a-4cda-8e2e-4e74818157af'
	and activeflag = 1;
	