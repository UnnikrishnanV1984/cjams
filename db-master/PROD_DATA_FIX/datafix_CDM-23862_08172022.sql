-- CDM-23862 - Duplicate Investigation
/*
-- Issue Description: 
   The CPS AR Case 221020235197 is having wrong CPS-IR program assignment and CPS-AR program assignment start dates are wrong
 
-- Category/ Module: Child Removals (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 200933967 (Marcy Garcia) - d94932a3-3473-48b2-9d06-c8a33d831c1b
-- Delete
-- CPS-IR 2022-07-18 To Current - d6c8f2f2-e8da-4c1d-8f4a-98d7b653384c

select entityid, startdate, enddate, programkey, subprogramkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'd6c8f2f2-e8da-4c1d-8f4a-98d7b653384c' 
	and activeflag = 1 ;

update personprogramarea
set startdate = enddate,
	activeflag = 0, 
	updatedby = 'CDM-23862',
	updatedon = now() 		
where personprogramid = 'd6c8f2f2-e8da-4c1d-8f4a-98d7b653384c' 
	and activeflag = 1 ;

-- Update Start Date as 2022-07-18 and Entityid = 221020235197
-- CPS-AR 2022-07-19 To Current - e7d6759a-f173-4947-b11f-0f6c65e80994

select entityid, startdate, enddate, programkey, subprogramkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'e7d6759a-f173-4947-b11f-0f6c65e80994'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-18 18:37:25',
	entityid = '221020235197', 
	updatedby = 'CDM-23862',
	updatedon = now() 		
where personprogramid = 'e7d6759a-f173-4947-b11f-0f6c65e80994' 
	and activeflag = 1 ;

-- Update Start Date as 2022-07-18 and Entityid = 221020235197
-- Client ID: 200934925 (Goulder David 	Sanjuar) - df3bf337-9feb-46de-afd7-2a5690d7f21d
-- CPS-AR 2022-07-21 To Current - e823f66b-0d7c-4e38-b1ae-19784b5fc057

select entityid, startdate, enddate, programkey, subprogramkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'e823f66b-0d7c-4e38-b1ae-19784b5fc057'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-18 19:24:30',
	entityid = '221020235197', 
	updatedby = 'CDM-23862',
	updatedon = now() 		
where personprogramid = 'e823f66b-0d7c-4e38-b1ae-19784b5fc057' 
	and activeflag = 1 ;

-- Update Start Date as 2022-07-18 and Entityid = 221020235197
-- Client ID: 200934924 (Marvin	Arron Deleon) -	c9246449-eafc-49e5-a528-a3ee72eb1448
-- CPS-AR 2022-07-21 To Current - f1fbacc8-98a1-4d9d-8ff3-f20daab2b7a5

select entityid, startdate, enddate, programkey, subprogramkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'f1fbacc8-98a1-4d9d-8ff3-f20daab2b7a5'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-18 19:23:14',
	entityid = '221020235197', 
	updatedby = 'CDM-23862',
	updatedon = now() 		
where personprogramid = 'f1fbacc8-98a1-4d9d-8ff3-f20daab2b7a5' 
	and activeflag = 1 ;
