-- CDM-32777 - CLONE - Child Removal and OOH dates Discrepancies (Data Fix)
/*
-- Issue Description: 
   To fix Child Removal, OOH and IV-E dates Discrepancies 
 	
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Application code had a flaw in the logic for updating OOH & IV-E dates upon Child Removal date changes. 
-- Fix Provided: Datafix has been promoted to fix Child Removal and OOH dates Discrepancies (Failed cases from CDM-30786). 
--			 	 Code fix has been promoted with CIDM-6945 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 1701170	MELANIE	RUCKER - f8d158aa-9ab7-4415-ae1a-b80389a7b1c4
-- OOH	2022-02-20 To Open - 7d9966c4-236a-47c0-af56-9a84806edbf0
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '7d9966c4-236a-47c0-af56-9a84806edbf0'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '7d9966c4-236a-47c0-af56-9a84806edbf0'
	and activeflag = 1
	and programkey = 'OOH' ;

-- Client ID: 4144218 (AMARI SHAWN LOPEZ) - 49b53d54-522b-41c7-9439-ad8d81a3bc08
-- OOH	2022-12-15 To 2023-04-28 - ead9522f-3b21-4685-a3ce-fbe3603d2ce2
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'ead9522f-3b21-4685-a3ce-fbe3603d2ce2'
	-- and activeflag = 0
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 1,
	entityid = '221030034566',
	objectid = '1da5cc02-8cb7-4e97-aff7-f9914737f10b',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'ead9522f-3b21-4685-a3ce-fbe3603d2ce2'
	-- and activeflag = 0
	and programkey = 'OOH' ;


-- Client ID: 4312370 (ALINA L CAMPOVERDE ALTAMIRANO) - 06e2d2b7-1a53-464c-b23b-e625a45add86
-- OOH	2021-07-22 To Open ee33baf0-d91d-4a36-800f-19dead89b157
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'ee33baf0-d91d-4a36-800f-19dead89b157'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'ee33baf0-d91d-4a36-800f-19dead89b157'
	and activeflag = 1
	and programkey = 'OOH' ;


-- Client ID: 4312428 (JORDANTHOMAS ORELLANABLANCO) - 09393d73-c65c-42a1-b245-b98769719308
-- OOH	2021-07-22 To Open - decb6d2c-204a-4e40-94fd-4c00d9afd6a2
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'decb6d2c-204a-4e40-94fd-4c00d9afd6a2'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'decb6d2c-204a-4e40-94fd-4c00d9afd6a2'
	and activeflag = 1
	and programkey = 'OOH' ;


-- Client ID: 4483657 (ERIC	GREEN) e055e4d1-8597-4f2e-b75c-add9dd31eebe
-- OOH	2021-09-14 To 2021-10-15 - dec2b59a-9479-4716-9a48-516031c38244
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'dec2b59a-9479-4716-9a48-516031c38244'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'dec2b59a-9479-4716-9a48-516031c38244'
	and activeflag = 1
	and programkey = 'OOH' ;

-- Client ID: 200772958 (Faith R Spicer) - dc2a08bf-9245-46fe-bde4-9702b9569f94
-- OOH	2021-10-19 To Open - 8c51b0df-91ac-4486-af12-db9b9e4d1221
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '8c51b0df-91ac-4486-af12-db9b9e4d1221'
	-- and activeflag = 0
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 1,
	entityid = '3159615',
	objectid = 'a708d87c-7203-4fc5-80d7-ea5eff4254ca',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '8c51b0df-91ac-4486-af12-db9b9e4d1221'
	-- and activeflag = 0
	and programkey = 'OOH' ;
	
-- Client ID: 200785665	(Kamari	Green) - 6ed06944-cd18-410c-8d75-5cf710acbbb7
-- OOH	2021-09-16 To 2021-10-15 - 03ef185a-d010-4bfb-b7c1-2bf4e12dafd6
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '03ef185a-d010-4bfb-b7c1-2bf4e12dafd6'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '03ef185a-d010-4bfb-b7c1-2bf4e12dafd6'
	and activeflag = 1
	and programkey = 'OOH' ;


-- Client ID: 200786007	(Shane Orellana Blanco) - 0b10f2c8-cf92-4983-ac1a-7d54e1af3598
-- OOH	2021-07-22 To Open - 12469fb9-7dd5-42d2-9b69-4155bbe5f06e
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '12469fb9-7dd5-42d2-9b69-4155bbe5f06e'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '12469fb9-7dd5-42d2-9b69-4155bbe5f06e'
	and activeflag = 1
	and programkey = 'OOH' ;


-- Client ID: 200848095	(Marionna Morales) - 8a1647fd-7dec-4f23-a90b-46deac4f225a
-- OOH	2022-01-10 To 2022-02-11 - aa4565e1-f92d-4fad-a5cc-9aec870c4644
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'aa4565e1-f92d-4fad-a5cc-9aec870c4644'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'aa4565e1-f92d-4fad-a5cc-9aec870c4644'
	and activeflag = 1
	and programkey = 'OOH' ;

-- Client ID: 200994789 (Kaileal Woodson) - 57cd1084-e2c9-4a21-868d-df3215e3dd85
-- OOH	2022-12-15 To Open - 6530dad7-4197-465f-a2cb-7058c50cff07
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '6530dad7-4197-465f-a2cb-7058c50cff07'
	-- and activeflag = 0
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 1,
	entityid = '221030034566',
	objectid = '1da5cc02-8cb7-4e97-aff7-f9914737f10b',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '6530dad7-4197-465f-a2cb-7058c50cff07'
	-- and activeflag = 0
	and programkey = 'OOH' ;


-- Client ID: 200994790 (Skylar Lopez) - 31c30f5f-24fb-45b5-881f-307a68ab6673
-- OOH	2022-12-15 To Open - 691be20b-255d-405b-9786-39d04838b653
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '691be20b-255d-405b-9786-39d04838b653'
	-- and activeflag = 0
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 1,
	entityid = '221030034566',
	objectid = '1da5cc02-8cb7-4e97-aff7-f9914737f10b',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '691be20b-255d-405b-9786-39d04838b653'
	-- and activeflag = 0
	and programkey = 'OOH' ;


-- Client ID: 200994806	(Messiah Hill) - 102eae04-2b3a-45c0-b1ac-f1019bd5ae2b
-- OOH	2022-12-15T o 2022-12-20 - 3452a12f-4620-4f4a-a9fc-7f9e55382965
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '3452a12f-4620-4f4a-a9fc-7f9e55382965'
	-- and activeflag = 0
	and programkey = 'OOH' ;

update personprogramarea
set startdate = '2023-03-09 00:00:00',
	enddate = null,
	activeflag = 1,
	entityid = '221030034463',
	objectid = '494feed3-4156-4f71-90fd-d5d9c34f8c9c',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '3452a12f-4620-4f4a-a9fc-7f9e55382965'
	-- and activeflag = 0
	and programkey = 'OOH' ;

-- Client ID: 200994811	(Tamari Mays) - 97201441-092f-4dee-836c-628296fd885b
-- OOH	2022-12-15 To 2023-03-10 - df36b67c-b17a-4a30-94bb-7ce6c96a2337
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'df36b67c-b17a-4a30-94bb-7ce6c96a2337'
	-- and activeflag = 0
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 1,
	entityid = '221030034463',
	objectid = '494feed3-4156-4f71-90fd-d5d9c34f8c9c',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'df36b67c-b17a-4a30-94bb-7ce6c96a2337'
	-- and activeflag = 0
	and programkey = 'OOH' ;


-- Client ID: 1679679 (RYHEEM R	BROWN) - a12dcdc1-92cf-45bd-989e-a30a118a73cf
-- OOH	2021-03-22 to open - d74b446c-4add-4119-81e7-0f24411ef01a	servicecase	1eb7688e-4052-4f38-91b9-7e5626c2bfe8	3123997	
-- 69138	2004-02-27 To 2004-03-01 - b1df691c-3aae-4bed-ba09-0eeb0e60cee3	3125844
-- b1df691c-3aae-4bed-ba09-0eeb0e60cee3	3125844
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'd74b446c-4add-4119-81e7-0f24411ef01a'
	-- and activeflag = 0
	and programkey = 'OOH' ;

update personprogramarea
set startdate = '2004-02-27 00:00:00',	
	enddate = '2004-03-01 00:00:00',
	activeflag = 1,
	entityid = '3125844',
	objectid = 'b1df691c-3aae-4bed-ba09-0eeb0e60cee3',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'd74b446c-4add-4119-81e7-0f24411ef01a'
	-- and activeflag = 0
	and programkey = 'OOH' ;


-- Client ID: 1697611 (DAQUAN BATTLE) - 99d12c40-664c-45c6-8803-bcee042fa209
-- update enddate '2006-05-12 00:00:00'
-- OOH	2002-05-09 00:00:00	2002-05-10 00:00:00	eeeaf24f-e7e3-4c8a-b6dc-8fb56a7e8aa5
-- Delete 
-- OOH	2002-05-10 00:00:00	2002-07-01 00:00:00	798d83de-8882-4867-a0d1-bfc7683157ad	
-- Delete 
-- OOH	2015-04-13 12:04:00	2022-11-02 11:11:00	6a2b8956-34a2-401e-aa76-b968a5e7eb89	

select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'eeeaf24f-e7e3-4c8a-b6dc-8fb56a7e8aa5'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set enddate = '2006-05-12 00:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'eeeaf24f-e7e3-4c8a-b6dc-8fb56a7e8aa5'
	and activeflag = 1
	and programkey = 'OOH' ;
	
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid in ('798d83de-8882-4867-a0d1-bfc7683157ad', '6a2b8956-34a2-401e-aa76-b968a5e7eb89')
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid in ('798d83de-8882-4867-a0d1-bfc7683157ad', '6a2b8956-34a2-401e-aa76-b968a5e7eb89')
	and activeflag = 1
	and programkey = 'OOH' ;
	
	
-- Client ID: 1710630 (TYONNA MEDLIN) - b51bfb4f-0d1c-4eb9-ab63-a580ccb093cc
-- OOH	2020-01-08 00:00:00	2020-06-26 06:51:56	97aaeadc-425f-46d8-9798-e4ebcb37abc8
-- Update end date '2020-06-17 09:00:00'
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '97aaeadc-425f-46d8-9798-e4ebcb37abc8'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set enddate = '2020-06-17 09:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '97aaeadc-425f-46d8-9798-e4ebcb37abc8'
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Update Service Case ID	
-- 998ad595-0b22-4cfb-a1be-081655f491aa	3164455
select servicecaseid, activeflag, updatedby, updatedon
	from actor
where actorid = 'd702c217-864c-485d-a444-5f946c930e86'
	and activeflag = 1 ;

update actor
set servicecaseid = '998ad595-0b22-4cfb-a1be-081655f491aa',
	updatedby = 'CDM-32777',
	updatedon = now()
where actorid = 'd702c217-864c-485d-a444-5f946c930e86'
	and activeflag = 1 ;

select servicecaseid, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where actorid = 'd702c217-864c-485d-a444-5f946c930e86'
	and intakeservicerequestactorid = '56600a59-4c46-4a0d-9b6e-34c724b48123'
	and activeflag = 1 ;

update intakeservicerequestactor
set servicecaseid = '998ad595-0b22-4cfb-a1be-081655f491aa',
	updatedby = 'CDM-32777',
	updatedon = now()
where actorid = 'd702c217-864c-485d-a444-5f946c930e86'
	and intakeservicerequestactorid = '56600a59-4c46-4a0d-9b6e-34c724b48123'
	and activeflag = 1 ;	
	
	
-- Client ID: 1767899 (MIRACLE WASHINGTON) - 92bcdcf2-2f4f-4d66-8fa3-38fc0c04e4e8
-- Update end date '2020-07-23 00:00:00'
-- OOH	2020-02-22 00:00:00	2020-10-27 16:09:49	17bd8e56-a15a-463d-b8ec-ba04b0390c82
-- Delete 
-- OOH	2023-02-21 00:00:00		a1a77a02-4850-4618-8328-07204dc5b7b9
-- 32da963d-9a0f-4937-91b4-5205b39f46dc	3122010

select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '17bd8e56-a15a-463d-b8ec-ba04b0390c82'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set enddate = '2020-07-23 00:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '17bd8e56-a15a-463d-b8ec-ba04b0390c82'
	and activeflag = 1
	and programkey = 'OOH' ;

select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'a1a77a02-4850-4618-8328-07204dc5b7b9'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'a1a77a02-4850-4618-8328-07204dc5b7b9'
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 1882479	TIONA	SHAWNTRY	WILLIAMS	1c8696e5-b538-4680-b217-41bfbb38ec73
-- OOH	2007-05-04 00:00:00	2007-05-07 00:00:00	794de74e-c91a-4b63-9b6c-197424c8e1ae
-- 2006-05-10 00:00:00	2007-11-05 00:00:00
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '794de74e-c91a-4b63-9b6c-197424c8e1ae'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set startdate = '2006-05-10 00:00:00',
	enddate = '2007-11-05 00:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '794de74e-c91a-4b63-9b6c-197424c8e1ae'
	and activeflag = 1
	and programkey = 'OOH' ;


-- Client ID: 1929507	KALEB	JAS	YORK	5a36d6bc-186e-482c-9168-ca9248075dad
-- OOH	2023-03-01 00:00:00		cefda33f-6cc2-4196-bb67-0a83d93ad16b
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'cefda33f-6cc2-4196-bb67-0a83d93ad16b'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'cefda33f-6cc2-4196-bb67-0a83d93ad16b'
	and activeflag = 1
	and programkey = 'OOH' ;

	
-- Client ID: 2011708	GEONBRE	G	CHESTER	5b40c2fd-839b-4ac9-ac40-5a52a04c6a1f
-- OOH	2021-11-06 00:00:00		8137bec2-aeb7-45f0-b683-e540d86659ae
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '8137bec2-aeb7-45f0-b683-e540d86659ae'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '8137bec2-aeb7-45f0-b683-e540d86659ae'
	and activeflag = 1
	and programkey = 'OOH' ;	
	
-- Client ID: 2123282	JENNIFER		HILL	b8103333-3b1a-457c-a122-c7c51fb92ea5
-- OOH	2008-07-21 00:00:00	2008-07-23 00:00:00	0040854f-5b75-4726-b019-c0059b576b7f
-- Update end date '2008-07-25 00:00:00'
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '0040854f-5b75-4726-b019-c0059b576b7f'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set enddate = '2008-07-25 00:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '0040854f-5b75-4726-b019-c0059b576b7f'
	and activeflag = 1
	and programkey = 'OOH' ;
	
	
-- Client ID: 2155720	NATHIN	WILLIAM	SCHROTH	ad9feb77-7a4f-4efa-b6df-e2d9b1fb2411
-- Delete 
-- OOH	2020-06-05 12:06:00		28f0e081-1fc8-4f61-9151-18269c192a7a
-- Update start date '2020-06-05 00:00:00'
-- OOH	2020-06-07 00:00:00	2023-05-19 00:00:00	4fe5b658-a4b6-4577-b17a-ef6532684851
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '28f0e081-1fc8-4f61-9151-18269c192a7a'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '28f0e081-1fc8-4f61-9151-18269c192a7a'
	and activeflag = 1
	and programkey = 'OOH' ;
	
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '4fe5b658-a4b6-4577-b17a-ef6532684851'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set startdate = '2020-06-05 00:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '4fe5b658-a4b6-4577-b17a-ef6532684851'
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 2355444	MARVIN		KIRBY	b1b29bc0-5628-4ace-b11c-0e280ec945a7
-- Delete 
-- OOH	2021-03-15 00:00:00	2021-06-11 12:42:21	4faba9d9-0999-4aee-a019-3427bac1ae87
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '4faba9d9-0999-4aee-a019-3427bac1ae87'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '4faba9d9-0999-4aee-a019-3427bac1ae87'
	and activeflag = 1
	and programkey = 'OOH' ;
	

-- Client ID: 2529805	CHRIS		WOLFERMAN	499e3b12-e6f0-4272-8cee-650cf241a905
-- OOH	2022-11-27 12:11:00		f03e0672-abb8-425c-bf37-df140fa9d217
-- update end date '2023-05-24 09:00:00'
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'f03e0672-abb8-425c-bf37-df140fa9d217'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set enddate = '2023-05-24 09:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'f03e0672-abb8-425c-bf37-df140fa9d217'
	and activeflag = 1
	and programkey = 'OOH' ;

-- Client ID: 2878868	JORDAN		RYAN	0ba96902-6156-4f02-926a-ac5dfc5b923e
-- OOH	2021-09-01 00:00:00		3afe51e9-dafe-48a3-9547-b43302612ee9
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '3afe51e9-dafe-48a3-9547-b43302612ee9'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '3afe51e9-dafe-48a3-9547-b43302612ee9'
	and activeflag = 1
	and programkey = 'OOH' ;

-- Client ID: 3012265	NICHOLAS	CHARLES	GISINER	3d268eea-789a-4451-b5e1-7d065bc79588
-- OOH	2021-10-06 12:10:00	2022-09-09 09:09:00	38eada1c-9646-49c4-854e-c904bfa029a9
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '38eada1c-9646-49c4-854e-c904bfa029a9'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '38eada1c-9646-49c4-854e-c904bfa029a9'
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 3147496	KRISTIN		JEFFERIES	48a94dad-da70-4b44-bb2f-14e3967c02cc
-- Delete 
-- OOH	2012-09-06 00:00:00	2012-10-31 00:00:00	6ccce7ec-4117-47c8-b9b2-a75cb61ef1a1
-- OOH	2020-06-03 00:00:00	2022-03-18 00:00:00	448f08d2-0f00-487a-a9ce-e8e9595d4943
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid in ( '6ccce7ec-4117-47c8-b9b2-a75cb61ef1a1', '448f08d2-0f00-487a-a9ce-e8e9595d4943')
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid in ( '6ccce7ec-4117-47c8-b9b2-a75cb61ef1a1', '448f08d2-0f00-487a-a9ce-e8e9595d4943')
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 3357897	LYDELL	KAREEM	CRAIG	3e579292-b15d-431b-9037-7a34d330cf3a
-- Delete 
-- 252234	2021-05-28 00:00:00	2021-06-04 15:22:00	1	99a3f2bb-546f-4ab8-b2da-cc961dc58592	3118538	1455df02-1587-43e4-a225-0e56c637818a
-- OOH	2021-05-28 00:00:00	2021-06-04 00:00:00	78333fb7-9a94-4ba6-ace9-e688e53ba719

select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '78333fb7-9a94-4ba6-ace9-e688e53ba719'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '78333fb7-9a94-4ba6-ace9-e688e53ba719'
	and activeflag = 1
	and programkey = 'OOH' ;
	
select removalid, activeflag, updatedby, updatedon
	from intakeservreqchildremoval
where removalid = 252234
	and activeflag = 1 ;
	
update intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where removalid = 252234
	and activeflag = 1 ;
	
select eligibility_id, delete_sw, update_ts, update_user_id
	from tb_client_eligibility
where removal_id = 252234
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-32777'
where removal_id = 252234
	and delete_sw = 'N' ;
	
-- Client ID: 3430533	ARIEL		MARTIN	69a9c4f4-31b6-4de3-af07-6044ea5d106b
-- OOH	2023-02-01 12:02:00		c4a72439-68e2-429c-9592-20e5d6ad6242
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'c4a72439-68e2-429c-9592-20e5d6ad6242'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'c4a72439-68e2-429c-9592-20e5d6ad6242'
	and activeflag = 1
	and programkey = 'OOH' ;
	
	
-- Client ID: 3442281	RAYLYNN	TAYLOR	RYAN	17a1e662-8c47-41d3-b2d4-afa234d1063b
-- OOH	2021-09-01 00:00:00		2e64358d-1d92-4b22-902b-d88866016387
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '2e64358d-1d92-4b22-902b-d88866016387'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '2e64358d-1d92-4b22-902b-d88866016387'
	and activeflag = 1
	and programkey = 'OOH' ;		
	
	
-- Client ID: 3445411	JOSHUA		STEWARD	1d791289-c6bf-4983-a895-8e7d6bfe1fbb
-- OOH	2020-02-05 00:00:00	2020-10-26 00:00:00	45e8bcf2-ac76-4b2c-8941-0d221ba2e16b
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '45e8bcf2-ac76-4b2c-8941-0d221ba2e16b'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '45e8bcf2-ac76-4b2c-8941-0d221ba2e16b'
	and activeflag = 1
	and programkey = 'OOH' ;		
	
-- Client ID: 3592727	JENNA		JENNINGS	3866860d-64db-43d4-8836-10e3029584b1
-- OOH	2023-04-20 12:04:00		847e4986-3973-4b28-8ff1-1e9739746dd9
-- Update start date '2023-01-13 00:00:00'
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '847e4986-3973-4b28-8ff1-1e9739746dd9'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set startdate = '2023-01-13 00:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '847e4986-3973-4b28-8ff1-1e9739746dd9'
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 3692935	CHANCE		THOMPSON	4d354f6c-59b0-4c06-a940-b5638950e79a
-- OOH	2021-04-19 12:04:00		fa1ddb57-99d0-45c4-8517-a8aa5da8c60e
-- Update End date '2023-06-27 00:00:00'
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'fa1ddb57-99d0-45c4-8517-a8aa5da8c60e'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set enddate = '2023-06-27 00:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'fa1ddb57-99d0-45c4-8517-a8aa5da8c60e'
	and activeflag = 1 ;
	
-- Client ID: 3766582	AYDEN	SANTANA	JOHNSON	903f25ed-cd77-4d61-a78b-71778ca92bc5
-- OOH	2022-05-06 12:05:00		e56d3372-9cf4-4404-9cca-5cf842d19489
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'e56d3372-9cf4-4404-9cca-5cf842d19489'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'e56d3372-9cf4-4404-9cca-5cf842d19489'
	and activeflag = 1
	and programkey = 'OOH' ;	
	
	
-- Client ID: 3790018	MISYAH	MARIO	HAMMOND	4c1c97ee-6c38-4ad7-8491-b106d9c3deef
-- OOH	2022-03-30 00:00:00	2022-03-30 00:00:00	26f29fd2-8e35-4c8c-b9bb-1b9cdde27b43
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '26f29fd2-8e35-4c8c-b9bb-1b9cdde27b43'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '26f29fd2-8e35-4c8c-b9bb-1b9cdde27b43'
	and activeflag = 1
	and programkey = 'OOH' ;	
	
-- Client ID: 3804076	CHRISTIAN		MUHUMMAD	936579aa-b39d-4b2d-bca5-4141692ab4f3
-- OOH	2022-07-17 12:07:00		9e670394-ad34-474c-a4fc-61af872bc2a1
-- Update End date '2023-04-07 17:30:00'
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '9e670394-ad34-474c-a4fc-61af872bc2a1'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set enddate = '2023-04-07 17:30:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '9e670394-ad34-474c-a4fc-61af872bc2a1'
	and activeflag = 1 ;
	
	
-- Client ID: 3928830	NALA	DARLIN	EDMONDS	4ca90b59-9aff-4299-98b5-ead131983959
-- OOH	2020-09-14 12:09:00		38ab041e-106d-4fa0-b49c-aad5556b3aac
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '38ab041e-106d-4fa0-b49c-aad5556b3aac'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '38ab041e-106d-4fa0-b49c-aad5556b3aac'
	and activeflag = 1
	and programkey = 'OOH' ;	

-- 3928830	NALA	DARLIN	EDMONDS	4ca90b59-9aff-4299-98b5-ead131983959
-- OOH	2020-09-14 00:00:00	2022-03-09 00:00:00	aa20f857-5688-4e51-af28-408ab4c8425b
-- update End date as '2023-03-09 00:00:00'
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'aa20f857-5688-4e51-af28-408ab4c8425b'
	and activeflag = 1
	and programkey = 'OOH' ;
	

update personprogramarea
set enddate = '2023-03-09 00:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'aa20f857-5688-4e51-af28-408ab4c8425b'
	and activeflag = 1 ;


-- Client ID: 3997260	JORDYN		CONANT	e289561c-5c71-4929-b9a1-094d1f85f9dd
-- OOH	2016-09-15 00:00:00	2020-10-13 00:00:00	7f9b557d-8c8d-43cf-9687-f8d2cd3c65f6
-- Update End date '2020-07-13 00:00:00'
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '7f9b557d-8c8d-43cf-9687-f8d2cd3c65f6'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set enddate = '2020-07-13 00:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '7f9b557d-8c8d-43cf-9687-f8d2cd3c65f6'
	and activeflag = 1	;
	
	
-- Client ID: 4061069	BAILY		MCDANIEL	6e6e3485-6328-4911-bc14-7a1aae0f263e
-- OOH	2020-06-25 00:00:00	2021-08-06 00:00:00	eade1d01-df1c-4fa6-aa14-5176ef3f93d4	
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'eade1d01-df1c-4fa6-aa14-5176ef3f93d4'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'eade1d01-df1c-4fa6-aa14-5176ef3f93d4'
	and activeflag = 1
	and programkey = 'OOH' ;		
	
-- Client ID: 4067081	BROOKE	M	HEDDINGER	3d1f69d9-9133-4817-b4cc-336d48fdad0c
-- OOH	2017-09-03 12:09:00		dc230e79-29f4-4987-9816-333455dd0588
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'dc230e79-29f4-4987-9816-333455dd0588'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'dc230e79-29f4-4987-9816-333455dd0588'
	and activeflag = 1
	and programkey = 'OOH' ;	
	

-- Client ID: 4070822	VANESSA	CATRINA	CHILES	99751eed-d282-4c7d-bdc7-1cb70a0d69a1	
-- OOH	2020-11-13 00:00:00	2022-05-31 19:56:54	c18bdf34-39dc-4344-9eb4-718a6edf4867
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'c18bdf34-39dc-4344-9eb4-718a6edf4867'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'c18bdf34-39dc-4344-9eb4-718a6edf4867'
	and activeflag = 1
	and programkey = 'OOH' ;	
	
-- Client ID: 4081631	ANYA		ZEPEDA	00765531-f370-4848-88de-0cf6cfe79c55	
-- OOH	2020-10-19 12:10:00		99de133f-abb5-412a-ab4e-d5fddc8d4634
-- Update End date '2023-05-02 09:00:00'	
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '99de133f-abb5-412a-ab4e-d5fddc8d4634'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set enddate = '2023-05-02 09:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '99de133f-abb5-412a-ab4e-d5fddc8d4634'
	and activeflag = 1	;	
	
-- Client ID: 4081690	AUBRIELLA		MONDESIR	5a19404f-2fe8-4b9b-b7a2-f452c44f9d4b	
-- OOH	2021-03-17 00:00:00	2021-09-21 00:00:00	65bd033c-4335-4136-a4cc-63af2b776bc1

-- 253017	2021-03-17 00:00:00	2021-09-21 14:50:00	1	3236080	1e4d77ee-6013-4cf6-a2c2-7cdad1abcaa8
-- update removalid as dcbb76b1-a466-46e3-8705-faaee9260d3e

select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '65bd033c-4335-4136-a4cc-63af2b776bc1'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '65bd033c-4335-4136-a4cc-63af2b776bc1'
	and activeflag = 1
	and programkey = 'OOH' ;
	
select removalid, activeflag, updatedby, updatedon
	from intakeservreqchildremoval
where removalid = 253017
	and activeflag = 1 ;
	
update intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where removalid = 253017
	and activeflag = 1 ;
	
select eligibility_id, delete_sw, update_ts, update_user_id
	from tb_client_eligibility
where removal_id = 253017
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-32777'
where removal_id = 253017
	and delete_sw = 'N' ;
	
select alternateid, altproviderid, intakeservreqchildremovalid, updatedby, updatedon
	from placement
where intakeservreqchildremovalid = '1e4d77ee-6013-4cf6-a2c2-7cdad1abcaa8'
	and activeflag = 1 ;
	
update placement
set intakeservreqchildremovalid = 'dcbb76b1-a466-46e3-8705-faaee9260d3e', 	
	updatedby = 'CDM-32777',
	updatedon = now()
where intakeservreqchildremovalid = '1e4d77ee-6013-4cf6-a2c2-7cdad1abcaa8'
	and activeflag = 1 ;

-- Client ID: 4084394	KYRON	MALIK	WILKERSON	4ebe08f4-6c9e-47e8-88b4-7e602870769f
-- OOH	2021-10-18 00:00:00		9b98808e-ff32-4370-9555-440fe0397415
-- OOH	2021-10-22 00:00:00		412daf24-f8a4-4c73-8a00-1032612e33be
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid in ('9b98808e-ff32-4370-9555-440fe0397415', '412daf24-f8a4-4c73-8a00-1032612e33be')
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid in ('9b98808e-ff32-4370-9555-440fe0397415', '412daf24-f8a4-4c73-8a00-1032612e33be')
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 4085589	JAMES		BRICE	b8a63c0f-fbb6-4b49-ab93-3dc634958175
-- OOH	2019-11-20 00:00:00		6f29fd35-49ef-49d8-90d6-c663da236381	1	servicecase	3109600
-- Update end date as '2019-11-20 00:00:00'
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '6f29fd35-49ef-49d8-90d6-c663da236381'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set enddate = '2019-11-20 00:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '6f29fd35-49ef-49d8-90d6-c663da236381'
	and activeflag = 1	;
	
-- Client ID: 4095026	ARIEL	E	RIDEOUT	9050996d-03ea-4df9-b140-ed4f2b61c1d4
-- OOH	2020-05-29 00:00:00	2021-02-25 00:00:00	bb2c60e5-0e6d-47c7-8391-1adba42ac9f3	
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'bb2c60e5-0e6d-47c7-8391-1adba42ac9f3'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'bb2c60e5-0e6d-47c7-8391-1adba42ac9f3'
	and activeflag = 1
	and programkey = 'OOH' ;	
	
-- Client ID: 4145715	RAVEN		MOSES	75b502c0-f934-4f20-9173-2ee1a6b6255b
-- OOH	2022-03-23 00:00:00		67e93b56-8da9-41dc-8fc3-1827f14c71b1	
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '67e93b56-8da9-41dc-8fc3-1827f14c71b1'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '67e93b56-8da9-41dc-8fc3-1827f14c71b1'
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 4150324	ARIEL		DURON	89aa9cd5-8fcc-4fb4-ba30-3e8c777d99ee
-- OOH	2020-09-03 00:00:00		723f0629-4afb-4ac7-bdd7-b2fa76b0b2c7
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '723f0629-4afb-4ac7-bdd7-b2fa76b0b2c7'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '723f0629-4afb-4ac7-bdd7-b2fa76b0b2c7'
	and activeflag = 1
	and programkey = 'OOH' ;	

-- Client ID: 4154837	COLT	Samuel Harman	KELLY	27618c30-22f1-4fc4-8559-02668c3f6087
-- OOH	2020-02-20 00:00:00	2020-08-18 00:00:00	8d832f3e-3e6e-48bf-a624-828271af6630	
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '8d832f3e-3e6e-48bf-a624-828271af6630'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '8d832f3e-3e6e-48bf-a624-828271af6630'
	and activeflag = 1
	and programkey = 'OOH' ;

-- Client ID: 4178586	ISAAC		ZEPEDA	6eb38ca8-59a6-42db-bf28-133b6d332034
-- OOH	2020-10-19 12:10:00		27733a1e-4a84-4333-a201-50eb671e9a9f	1	servicecase	3256702
-- Update end date as '2023-05-02 09:00:00'
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '27733a1e-4a84-4333-a201-50eb671e9a9f'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set enddate = '2023-05-02 09:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '27733a1e-4a84-4333-a201-50eb671e9a9f'
	and activeflag = 1	;
	
-- Client ID: 4260162	LACIE	JADE RANAE	MCDANIEL	25b443b5-4d41-4dee-8599-fc61e47de7ce
-- OOH	2020-06-25 00:00:00	2021-08-06 00:00:00	1ffa0f39-6355-40fa-b47e-5888f9db166e	
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '1ffa0f39-6355-40fa-b47e-5888f9db166e'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '1ffa0f39-6355-40fa-b47e-5888f9db166e'
	and activeflag = 1
	and programkey = 'OOH' ;

-- Client ID: 4303700	SAHVERE		CURRY	46167f13-6b11-43a9-8103-ff2beb987934
-- OOH	2022-12-05 12:12:00	2022-12-07 06:12:00	d983a1b4-a0f2-49bf-88a0-8030c9f532bb
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'd983a1b4-a0f2-49bf-88a0-8030c9f532bb'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'd983a1b4-a0f2-49bf-88a0-8030c9f532bb'
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 4342741	SAKIRA		MATTHEWS	ce34c46a-0526-4edd-a406-d067aee66c19
-- OOH	2021-12-01 00:00:00		8c716529-d6fa-4992-a262-9122092e0de2	
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '8c716529-d6fa-4992-a262-9122092e0de2'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '8c716529-d6fa-4992-a262-9122092e0de2'
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 4455639	KANYIA	A	JOHNSON	265f828f-b1d6-49ef-a69d-e9cd92dd9c5e
-- OOH	2022-02-01 00:00:00		55396088-fb71-448a-b2fb-df92f9a3b7ff	
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '55396088-fb71-448a-b2fb-df92f9a3b7ff'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '55396088-fb71-448a-b2fb-df92f9a3b7ff'
	and activeflag = 1
	and programkey = 'OOH' ;

-- Client ID: 4477139	VICTORIA	M	HUMES	71d8e42c-9e6e-42b8-b1ed-9a7ed4d7d556
-- OOH	2020-06-09 00:00:00		af841eb1-5b29-4ed3-b235-0175f265d7ae
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'af841eb1-5b29-4ed3-b235-0175f265d7ae'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'af841eb1-5b29-4ed3-b235-0175f265d7ae'
	and activeflag = 1
	and programkey = 'OOH' ;

-- Client ID: 4488139	TYONNA	T	SLAUGHTER	ee95382e-95aa-4478-9667-5b84225f202c
-- OOH	2022-01-18 12:01:00		36b8839e-e882-486a-b89e-f183d1c1f62a
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '36b8839e-e882-486a-b89e-f183d1c1f62a'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '36b8839e-e882-486a-b89e-f183d1c1f62a'
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 4491815	COURTNEY		HACK	ae0c7da2-6d48-47b5-ad9a-d68170d40fef
-- OOH	2020-10-30 12:10:00	2023-06-14 00:00:00	bd98828e-a161-4479-8917-b06e4baa96ee	
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'bd98828e-a161-4479-8917-b06e4baa96ee'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'bd98828e-a161-4479-8917-b06e4baa96ee'
	and activeflag = 1
	and programkey = 'OOH' ;

-- Client ID: 4494259	ADRIAN	A	OKENE	90f910f3-02d8-4d65-87e6-3588e50500c6
-- OOH	2020-07-06 00:00:00	2020-12-04 00:00:00	b86e70df-ecd8-4029-9800-2eb8041f38ea
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'b86e70df-ecd8-4029-9800-2eb8041f38ea'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'b86e70df-ecd8-4029-9800-2eb8041f38ea'
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 10718015	ANTWONE		YOUNG	49e7e63c-0a99-406f-a116-1c002f7ab4c9
-- OOH	2020-09-17 12:09:00		5822b77d-330e-42d5-a82d-d30955d421d0
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '5822b77d-330e-42d5-a82d-d30955d421d0'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '5822b77d-330e-42d5-a82d-d30955d421d0'
	and activeflag = 1
	and programkey = 'OOH' ;	
	
-- Client ID: 200012757	Azariah 		Wingfield	ceb4f858-d8ea-4d41-9e09-5c7ef00f6df8
-- OOH	2020-06-19 00:00:00	2021-08-26 00:00:00	fb9584c8-62c2-4f68-928f-7764565a422d	
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'fb9584c8-62c2-4f68-928f-7764565a422d'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'fb9584c8-62c2-4f68-928f-7764565a422d'
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 200020378	RAHMEEK	K	STEWART	3937ea0a-0902-4719-a670-99ff9e620c81
-- OOH	2020-07-20 00:00:00	2021-09-21 00:00:00	4e77cc75-7a25-48cd-a646-e730bc1b2576	
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '4e77cc75-7a25-48cd-a646-e730bc1b2576'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '4e77cc75-7a25-48cd-a646-e730bc1b2576'
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 200139306	Keandre		McClain	22d572b7-2ec8-49b1-bbdd-fff34c09571d
-- OOH	2022-08-01 12:08:00		80a4d365-0057-4e2e-9aed-1767e34c41ae	
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '80a4d365-0057-4e2e-9aed-1767e34c41ae'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '80a4d365-0057-4e2e-9aed-1767e34c41ae'
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 200159016	Michael 	Daniel	Barnes	5af39e8e-58cb-4be1-9da8-00e43c67923d
-- OOH	2020-11-13 00:00:00	2021-10-30 00:00:00	014cdc39-ac18-4d56-b0de-b0e850ce1960	
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '014cdc39-ac18-4d56-b0de-b0e850ce1960'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '014cdc39-ac18-4d56-b0de-b0e850ce1960'
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 200159018	Jasmine		Barnes	824a01ae-070e-45a1-9292-b73448e917d2
-- OOH	2020-11-13 12:11:00	2021-10-30 11:10:00	a0edab5c-d31d-4a31-a1bc-cf38de4b6502	
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = 'a0edab5c-d31d-4a31-a1bc-cf38de4b6502'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = 'a0edab5c-d31d-4a31-a1bc-cf38de4b6502'
	and activeflag = 1
	and programkey = 'OOH' ;

-- Client ID: 200165796	Leo		Johnson	8031a64d-7535-4742-83af-041b77860a0a
-- OOH	2022-05-06 12:05:00		4d9cb4a4-5ef6-4341-a3fd-f7161d85f315
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '4d9cb4a4-5ef6-4341-a3fd-f7161d85f315'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '4d9cb4a4-5ef6-4341-a3fd-f7161d85f315'
	and activeflag = 1
	and programkey = 'OOH' ;
	
-- Client ID: 200179386	Brayden		Ulmer	c3dce0a1-d936-4ba0-a1cf-ca29abfec268
-- OOH	2021-01-04 12:01:00		7c0a7daf-bb47-4448-94c0-b2e523c4ce32
-- Update end date as '2023-05-23 09:00:00'
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '7c0a7daf-bb47-4448-94c0-b2e523c4ce32'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set enddate = '2023-05-23 09:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '7c0a7daf-bb47-4448-94c0-b2e523c4ce32'
	and activeflag = 1	;	
	
	
-- Update Service Case ID	
-- 45477341-a98d-457f-ae41-c95847f37ea7	3243421
select servicecaseid, activeflag, updatedby, updatedon
	from actor
where actorid = '65abb5d5-9779-4191-a07f-37b39fc0605e'
	and activeflag = 1 ;

update actor
set servicecaseid = '45477341-a98d-457f-ae41-c95847f37ea7',
	updatedby = 'CDM-32777',
	updatedon = now()
where actorid = '65abb5d5-9779-4191-a07f-37b39fc0605e'
	and activeflag = 1 ;

select servicecaseid, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where actorid = '65abb5d5-9779-4191-a07f-37b39fc0605e'
	and intakeservicerequestactorid = 'bd3afd61-c938-4796-830f-497445dab5d6'
	and activeflag = 1 ;

update intakeservicerequestactor
set servicecaseid = '45477341-a98d-457f-ae41-c95847f37ea7',
	updatedby = 'CDM-32777',
	updatedon = now()
where actorid = '65abb5d5-9779-4191-a07f-37b39fc0605e'
	and intakeservicerequestactorid = 'bd3afd61-c938-4796-830f-497445dab5d6'
	and activeflag = 1 ;		
	
-- Client ID: 200645080	Amira	K	Roberts	2692c6de-c6d2-44e7-baf6-d496162599ec
-- OOH	2021-10-29 12:10:00		1cce2d5a-8bcf-48c2-8bb4-4dd815c5dd67
-- Update end date as '2023-04-20 13:00:00'
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '1cce2d5a-8bcf-48c2-8bb4-4dd815c5dd67'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set enddate = '2023-04-20 13:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '1cce2d5a-8bcf-48c2-8bb4-4dd815c5dd67'
	and activeflag = 1	;		
	
	
-- Client ID: 200660376	Mindris	Eunice	Sosa Arita	76ddb381-33f2-4d76-bb3d-369611580813
-- 1d4984f0-aad3-4234-a4cc-c040178b683f	2021013007794
select servicecaseid, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where actorid = '45a23200-2d81-427e-9bb2-6c54bc58b03a'
	and intakeservicerequestactorid = 'a0dacd83-897e-4931-adfa-d289e54a39ab'
	and activeflag = 1 ;	
	
update intakeservicerequestactor
set servicecaseid = '1d4984f0-aad3-4234-a4cc-c040178b683f',
	updatedby = 'CDM-32777',
	updatedon = now()
where actorid = '45a23200-2d81-427e-9bb2-6c54bc58b03a'
	and intakeservicerequestactorid = 'a0dacd83-897e-4931-adfa-d289e54a39ab'
	and activeflag = 1 ;	
	
-- Client ID: 200673299	Dontae 		Simpson	2f1eddf6-269e-4f0b-8b76-935850b9d03a
-- OOH	2021-06-06 00:00:00		97426154-b4b7-421f-a789-e6989d4e89b3
-- Update start date as '2021-06-09 00:00:00'
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '97426154-b4b7-421f-a789-e6989d4e89b3'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set startdate = '2021-06-09 00:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '97426154-b4b7-421f-a789-e6989d4e89b3'
	and activeflag = 1	;		
	

-- Client ID: 200770263	Hezeki	J	Devaughn	f430f920-069a-4340-af4f-98217ee97fa6
-- OOH	2021-06-16 00:00:00		8e162bdf-7a4c-40e5-81d5-6971a474cdd8
-- Update start date as '2021-06-06 00:00:00'
select personprogramid, programkey, startdate, enddate, objecttypekey, objectid, entityid, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid = '8e162bdf-7a4c-40e5-81d5-6971a474cdd8'
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set startdate = '2021-06-06 00:00:00',
--	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid = '8e162bdf-7a4c-40e5-81d5-6971a474cdd8'
	and activeflag = 1	;
	
-- Client ID: 200874879	KAMORE		MARTIN	304845fa-892f-42db-bc7d-7848ce4d3f2c
-- OOH	2022-03-08 00:00:00	2022-04-13 00:00:00	5cb69bc6-483b-480e-bc69-2d1a3cf4f662
-- OOH	2022-03-11 00:00:00	2022-04-13 00:00:00	993bbb85-a457-4628-8365-ba4fff1c38ce
-- OOH	2023-02-01 00:00:00		520fb42a-8bde-4ee6-afe4-579d5e2ea242
select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personprogramid in ('5cb69bc6-483b-480e-bc69-2d1a3cf4f662', '993bbb85-a457-4628-8365-ba4fff1c38ce',
		'520fb42a-8bde-4ee6-afe4-579d5e2ea242')	
	and activeflag = 1
	and programkey = 'OOH' ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-32777',
	updatedon = now()
where personprogramid in ('5cb69bc6-483b-480e-bc69-2d1a3cf4f662', '993bbb85-a457-4628-8365-ba4fff1c38ce',
		'520fb42a-8bde-4ee6-afe4-579d5e2ea242')	
	and activeflag = 1
	and programkey = 'OOH' ;

delete from cjams.personprogramarea where insertedby = 'CDM-32777' ;
	
/*
-- Client ID: 200994806	Messiah		Hill	102eae04-2b3a-45c0-b1ac-f1019bd5ae2b

INSERT INTO cjams.personprogramarea
	( 	personprogramid, personid, startdate, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		programkey, subprogramkey, objecttypekey, objectid, entityid, datatransferflag, sourcetype	
	)
values
	( 	cjams.gen_random_uuid(), '102eae04-2b3a-45c0-b1ac-f1019bd5ae2b', '2023-03-09 00:00:00', 
		now(), 'CDM-32777', now(), 'CDM-32777', '1', 
		'OOH', 'NA', 'servicecase', '494feed3-4156-4f71-90fd-d5d9c34f8c9c', '221030034463', 'A', 'CW' 
	);
*/