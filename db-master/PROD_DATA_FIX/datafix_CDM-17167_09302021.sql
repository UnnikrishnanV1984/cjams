-- CDM-17167 - Mistake
/*
-- Issue Description: 
    Please re-set this specific case finding - undo the "indicated-unnamed" finding 
	and return to the original name of maltreator of Ann Roeder. 
	(I was demonstrating this function to Poornima & didn't realize it would automatically save).

-- Category/ Module: CPS-IR  (Investigation Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- CPS-IR 2021057085544 - 01308981-73cf-4e5e-b002-597249731227
-- Unnamed Unnamed
-- 200793504, 200793507, 200793508

-- Client ID: 200139339 (Ann Roeder)- 1d6b3250-0e7a-4a27-8c69-4feddf567930

-- Dummy Clients
-- 200793504 (unnamed unnamed) - 123e497a-2e48-401f-b894-cea444db04cc - Other
-- 200793507 (unnamed unnamed) - 3edf1bb0-7232-41ee-9434-bd0cefd6830c - Other
-- 200793508 (unnamed unnamed) - acc2e7db-d0df-4457-86bd-3af44db23ecc - Alleged Maltreator
*/

-- Remove (Unnamed Unnamed)
select activeflag, personid, intakeservicerequestpersontypekey,	intakeservicerequestactorid, updatedby, updatedon
	from intakeservicerequestactor 
where intakeserviceid = '01308981-73cf-4e5e-b002-597249731227'
	and activeflag = 1
	and personid in (	'123e497a-2e48-401f-b894-cea444db04cc',
						'3edf1bb0-7232-41ee-9434-bd0cefd6830c',
						'acc2e7db-d0df-4457-86bd-3af44db23ecc'
					) ;
					
update intakeservicerequestactor				
set activeflag = 0,
	updatedby = 'CDM-17167',
	updatedon = now()	
where intakeserviceid = '01308981-73cf-4e5e-b002-597249731227'
	and activeflag = 1
	and personid in (	'123e497a-2e48-401f-b894-cea444db04cc',
						'3edf1bb0-7232-41ee-9434-bd0cefd6830c',
						'acc2e7db-d0df-4457-86bd-3af44db23ecc'
					) ;
					

-- Update Alleged Maltreator Roles
-- unnamed unnamed - activeflag = 0
select personid, activeflag, intakeserviceid, intakeservicerequestpersontypekey, updatedby, updatedon 
	from intakeservicerequestactor 
where intakeservicerequestactorid = 'c19ae3e2-2eb1-4cad-a9cf-fb3fc591fdd3' ;

update intakeservicerequestactor				
set activeflag = 0,
	updatedby = 'CDM-17167',
	updatedon = now()	
where intakeservicerequestactorid = 'c19ae3e2-2eb1-4cad-a9cf-fb3fc591fdd3' ;

-- Ann Roeder 
-- AM - activeflag = 1
select personid, activeflag, intakeserviceid, intakeservicerequestpersontypekey, updatedby, updatedon 
	from intakeservicerequestactor 
where intakeservicerequestactorid = 'b87b7834-08b6-494b-b5b8-c499898bfde9' ;

update intakeservicerequestactor				
set activeflag = 1,
	updatedby = 'CDM-17167',
	updatedon = now()	
where intakeservicerequestactorid = 'b87b7834-08b6-494b-b5b8-c499898bfde9' ;

-- RELATIVE - activeflag = 0
select personid, activeflag, intakeserviceid, intakeservicerequestpersontypekey, updatedby, updatedon 
	from intakeservicerequestactor 
where intakeservicerequestactorid = '106ae9be-3ea8-4271-9733-acd1107941de' ;

update intakeservicerequestactor				
set activeflag = 0,
	updatedby = 'CDM-17167',
	updatedon = now()	
where intakeservicerequestactorid = '106ae9be-3ea8-4271-9733-acd1107941de' ;	


-- Update Alleged Maltreator Actor ID
-- update intakeservicerequestactorid = 'b87b7834-08b6-494b-b5b8-c499898bfde9'
select investigationallegationmaltreatorsid, intakeservicerequestactorid, activeflag, updatedby, updatedon 
	from investigationallegationmaltreators
where investigationallegationmaltreatorsid
	in (	'1e4da77f-8d60-44a3-a52d-8caef8ecfaf1',
			'2c4f82b0-e7df-48f0-9ece-7418a64b88f6',
			'2f307723-b55e-42a3-a7e5-419510ce1a5e',
			'37352927-4fb9-41d0-9666-a6a8ff4cac07',
			'd6a43613-4778-449e-9443-062b8080fb43',
			'e8635d58-0f2c-4bc5-9169-f12f44562805'
		) ;

update investigationallegationmaltreators
set intakeservicerequestactorid = 'b87b7834-08b6-494b-b5b8-c499898bfde9',
	updatedby = 'CDM-17167',
	updatedon = now()	
where investigationallegationmaltreatorsid
	in (	'1e4da77f-8d60-44a3-a52d-8caef8ecfaf1',
			'2c4f82b0-e7df-48f0-9ece-7418a64b88f6',
			'2f307723-b55e-42a3-a7e5-419510ce1a5e',
			'37352927-4fb9-41d0-9666-a6a8ff4cac07',
			'd6a43613-4778-449e-9443-062b8080fb43',
			'e8635d58-0f2c-4bc5-9169-f12f44562805'
		) ;
		
-- Delete Dummy Clients
-- 200793504 (unnamed unnamed) - 123e497a-2e48-401f-b894-cea444db04cc - Other
-- 200793507 (unnamed unnamed) - 3edf1bb0-7232-41ee-9434-bd0cefd6830c - Other
-- 200793508 (unnamed unnamed) - acc2e7db-d0df-4457-86bd-3af44db23ecc - Alleged Maltreator

select personid, cjamspid, firstname, lastname, updatedby, updatedon 
	from person 
where activeflag = 1
	and personid in (	'123e497a-2e48-401f-b894-cea444db04cc',
						'3edf1bb0-7232-41ee-9434-bd0cefd6830c',
						'acc2e7db-d0df-4457-86bd-3af44db23ecc'
					);

update person
set activeflag = 0,
	updatedby = 'CDM-17167',
	updatedon = now()	
where activeflag = 1
	and personid in (	'123e497a-2e48-401f-b894-cea444db04cc',
						'3edf1bb0-7232-41ee-9434-bd0cefd6830c',
						'acc2e7db-d0df-4457-86bd-3af44db23ecc'
					);

