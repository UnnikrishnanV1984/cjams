-- CDM-16539 - Multiple active Removals - Baltimore City
/*
-- Issue Description: 
   Datafix to delete the duplicate active removals
    
-- Category/ Module: Child Removal (Case Management) 
-- Root cause: Data Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 1)
-- Case ID: 2021011907578 - Baltimore City
-- Client ID: 2373549 (RAVEN A BROWN) - 52d88812-91dd-4ce5-a58a-a32e5f8f6e9d
-- Removals 
-- 251970	2021-04-28 - e22d0049-c500-4166-996b-342bf3750f9a (Delete)
-- 251971	2021-04-28 - 252836f2-9629-43d1-a103-71d9d405586e

-- Delete removal # 251970 - No associated placements, NO IV-E and Active OOH 

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251970
	and rm.personid = '52d88812-91dd-4ce5-a58a-a32e5f8f6e9d'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 251970
	and rm.personid = '52d88812-91dd-4ce5-a58a-a32e5f8f6e9d'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;	


		
-- 2)
-- Case ID: 211030009550 - Baltimore City
-- Client ID: 2646328 (DEAYSHA CLARK) - cc661efe-4ae0-4038-ba92-2e67ae2fc551

-- Removals 
-- 252405	2021-07-18 - 5c7e409c-0a19-4dab-9a6a-b229ed5a7ce2 (Delete)
-- 252406	2021-07-18 - 1d05d21d-a715-48c6-9766-0591fb8600da

-- Delete removal # 252405 - No associated placements, NO IV-E and Active OOH 

	select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
		from intakeservreqchildremoval rm 
	where rm.removalid = 252405
		and rm.personid = 'cc661efe-4ae0-4038-ba92-2e67ae2fc551'
		and rm.activeflag = 1
		and ( select count(*)
				from routing ro 
			  where ro.eventcode  = 'CHRR'
				and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
				and ro.activeflag = 1
			) = 0 
		and ( select count(*)
				from placement pl 
			  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
				and pl.activeflag = 1
			) = 0;	

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252405
	and rm.personid = 'cc661efe-4ae0-4038-ba92-2e67ae2fc551'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;	



-- 3)
-- Case ID: 211030008257 - Baltimore City
-- Client ID: 2935311 (NICKIA COTTON) - 264ffbbf-b806-4b9b-9f57-e106c095469d

-- Removals 
-- 252092	2021-05-24 - f731da17-e86e-44d3-b81e-cc63404e3379 (Delete)
-- 252095	2021-05-23 - 94a954bb-f252-46ef-bf56-6952bc04ec12

-- Delete removal # 252092 - No associated placements, NO IV-E and Active OOH 

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252092
	and rm.personid = '264ffbbf-b806-4b9b-9f57-e106c095469d'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;	

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252092
	and rm.personid = '264ffbbf-b806-4b9b-9f57-e106c095469d'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;		
		
-- 4)
-- Case ID: 211030008282 - Baltimore City
-- Client ID: 3214260 (RAMANI T	TURNER) - 5c57c996-e757-475a-839c-962577f1598e

-- Removals 
-- 252147	2021-06-02 - eb1e18de-5524-40cf-a5d2-5cda5839b0dc
-- 252174	2021-06-02 - c7686158-4717-4059-8309-3f1409ef9558

-- Delete removal # 252147 - No associated placements, NO IV-E and Active OOH 

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252147
	and rm.personid = '5c57c996-e757-475a-839c-962577f1598e'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;	

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252147
	and rm.personid = '5c57c996-e757-475a-839c-962577f1598e'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;	


-- 5)
-- Case ID: 3199884	Baltimore City
-- Client ID: 3216708 (ZACHARY LYNN WHISLER) - 9c4e2120-c85d-4b95-845a-b57f31e65e4f 

-- Removals 
-- 252229	2021-06-14 00:00:00		66ac2d22-0b02-45a3-8ca5-6413cb5f6d6d (Delete)
-- 252239	2021-06-13 00:00:00		f13a75f4-496f-4c3e-8c5f-f92a3608ae6e

-- Delete removal # 252229 - No associated placements, NO IV-E and Active OOH 
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252229
	and rm.personid = '9c4e2120-c85d-4b95-845a-b57f31e65e4f'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252229
	and rm.personid = '9c4e2120-c85d-4b95-845a-b57f31e65e4f'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

		
-- 6)
-- Case ID: 3189660	Baltimore City
-- Client ID: 3217783 (JANAE AZORIA	BEY) - 0f9ab108-f0af-4977-8a4b-d406ab044b8c

-- Removals 
-- 251182	2020-11-05 00:00:00		b0ba0f95-1f04-4fa3-8fae-4343a2ae2f4e
-- 250875	2020-09-11 00:00:00		df24d2c3-3891-4456-b1f0-9c8bf02bd522 (Delete)


-- Delete removal # 250875 - No associated placements, NO IV-E and Active OOH 
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250875
	and rm.personid = '0f9ab108-f0af-4977-8a4b-d406ab044b8c'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now()
where rm.removalid = 250875
	and rm.personid = '0f9ab108-f0af-4977-8a4b-d406ab044b8c'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'df24d2c3-3891-4456-b1f0-9c8bf02bd522'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-16539',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'df24d2c3-3891-4456-b1f0-9c8bf02bd522'
	and ro.activeflag = 1 ;	


-- 7)
-- Case ID: 
-- Client ID: 3351885 (KAHLIA L	JAMES) - 3577eebc-9ecb-42b3-ae9c-ff26c8798d4c

-- Removals 
-- 251516	2021-01-27 00:00:00		e28aa40b-9d29-461e-8d6e-db00b06ac8a3 (Delete)
-- 251517	2021-01-27 00:00:00		02342ccf-9e5c-4551-bf43-886374b33047

-- Delete removal # 251516 - No associated placements, NO IV-E and Active OOH 
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251516
	and rm.personid = '3577eebc-9ecb-42b3-ae9c-ff26c8798d4c'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now()
where rm.removalid = 251516
	and rm.personid = '3577eebc-9ecb-42b3-ae9c-ff26c8798d4c'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'e28aa40b-9d29-461e-8d6e-db00b06ac8a3'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-16539',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'e28aa40b-9d29-461e-8d6e-db00b06ac8a3'
	and ro.activeflag = 1 ;	

-- 8)
-- Case ID: 3278198	Baltimore City
-- Client ID: 3380309 (SHANTE M	GRIFFIN) - 543de3de-7bc3-47bf-91c7-4d27d46c4a93

-- Removals 
-- 252394	2021-07-16 00:00:00		08e416c8-02f0-44e7-966d-0673666c698a (Delete)
-- 252430	2021-07-19 00:00:00		08e416c8-02f0-44e7-966d-0673666c698a

-- Delete removal # 252394 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252394
	and rm.personid = '543de3de-7bc3-47bf-91c7-4d27d46c4a93'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252394
	and rm.personid = '543de3de-7bc3-47bf-91c7-4d27d46c4a93'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;


-- 9)
-- Case ID: 3278198	Baltimore City
-- Client ID: 3380315 (TAAVON K	GRIFFIN) - da308b65-753c-4c00-aaed-0a31426af97a

-- Removals 
-- 252431	2021-07-19 00:00:00		829222d7-f58e-4c92-bca1-cb08dc519cee
-- 252393	2021-07-16 00:00:00		802e4329-1475-49e7-a409-87735f99da12 (Delete)
-- 

-- Delete removal # 252393 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252393
	and rm.personid = 'da308b65-753c-4c00-aaed-0a31426af97a'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252393
	and rm.personid = 'da308b65-753c-4c00-aaed-0a31426af97a'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;


-- 10)
-- Case ID: 3218214	Baltimore City
-- Client ID: 3440641 (DIAMOND BRAXTON) - 20e985ff-d8bb-4eb1-8496-8203309d863c

-- Removals 
-- 252264	2021-05-28 00:00:00		6bf92035-0253-46c0-bf57-2cbf0d2ffe34 (Delete)
-- 252309	2021-05-27 00:00:00		76fab922-1c02-4faf-b012-246df0d24936

-- Delete removal # 252264 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252264
	and rm.personid = '20e985ff-d8bb-4eb1-8496-8203309d863c'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252264
	and rm.personid = '20e985ff-d8bb-4eb1-8496-8203309d863c'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		

-- 11)
-- Case ID: 3122016	Baltimore City
-- Client ID: 3503420 (NIKERRA WATKINS) - 0c1e2d3e-9479-4861-890a-6867e38aff0e

-- Removals 
-- 250778	2020-08-21 00:00:00		6580afa6-a339-471a-a4f7-0620d55b560a (Delete)
-- 250779	2020-08-21 00:00:00		eb9ce07a-7504-4bfe-b008-95a9aef92e2f


-- Delete removal # 250778 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250778
	and rm.personid = '0c1e2d3e-9479-4861-890a-6867e38aff0e'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now()
where rm.removalid = 250778
	and rm.personid = '0c1e2d3e-9479-4861-890a-6867e38aff0e'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '6580afa6-a339-471a-a4f7-0620d55b560a'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-16539',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '6580afa6-a339-471a-a4f7-0620d55b560a'
	and ro.activeflag = 1 ;


-- 12)
-- Case ID: 3300213	& 3294252 Baltimore City 
-- Client ID: 3589614 (LE'VANTE	RICARDO	DIGGS) - 7dba9128-6b89-49fe-a490-9f0be268102f

-- Removals 
-- 250681							c887c037-053c-49a6-83c1-3715cff68aa0 (Delete)
-- 250727	2020-07-20 00:00:00		c39167af-fc29-4202-abb3-2c025bab1f11


-- Delete removal # 250727 - No associated placements and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250681
	and rm.personid = '7dba9128-6b89-49fe-a490-9f0be268102f'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 250681
	and rm.personid = '7dba9128-6b89-49fe-a490-9f0be268102f'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 250681
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16539'
where removal_id = 250681
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 250681
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16539'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 250681
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;		


-- 13)
-- Case ID: 2020025702987	Baltimore City
-- Client ID: 3666658 (GRACE HADASSAH WALLACE) - 6fb2a353-2c0a-49fb-890c-564dc065ef46 

-- Removals 
-- 250907	2020-09-11 00:00:00		5b7e4c94-e5d3-414e-be2b-66e8d2e41388 (Delete)
-- 250870	2020-09-11 00:00:00		3c4a73b4-8294-4486-9b8e-3b8b2924d3b7 (Delete)
-- 250871	2020-09-11 00:00:00		ccaa7690-9a08-4037-b20d-164c7e9df3fb (Delete)
-- Approved Closed
-- 250909	2020-09-11 00:00:00	2021-06-10 17:29:29	461ac95e-1d19-41f0-a227-d8e0d85b642f


-- Delete removal # 250907, 250870 & 250871 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid in (250907, 250870, 250871)
	and rm.personid = '6fb2a353-2c0a-49fb-890c-564dc065ef46'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid in (250907, 250870, 250871)
	and rm.personid = '6fb2a353-2c0a-49fb-890c-564dc065ef46'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;


-- 14)
-- Case ID: 3252051	Baltimore City
-- Client ID: 3779262 (AMELIE WILLIAMS) - 0854e52d-d983-4f9e-b768-cc905b5b09cc 

-- Removals 
-- 251219	2020-11-09 00:00:00		069dc9a8-faae-42c3-8b5f-9de9980e4b6c
-- 251218	2020-11-09 00:00:00		87f869a9-5395-4e64-bbd7-7e53ac2126e6 (Delete)


-- Delete removal # 251218 - No associated placements and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251218
	and rm.personid = '0854e52d-d983-4f9e-b768-cc905b5b09cc'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now()
where rm.removalid = 251218
	and rm.personid = '0854e52d-d983-4f9e-b768-cc905b5b09cc'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '87f869a9-5395-4e64-bbd7-7e53ac2126e6'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-16539',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '87f869a9-5395-4e64-bbd7-7e53ac2126e6'
	and ro.activeflag = 1 ;


select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 251218
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16539'
where removal_id = 251218
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251218
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16539'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251218
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;		



-- 15)
-- Case ID: 
-- Client ID: 3788125 (BRAZHYLE	NYQUEZ LEMORE) - 757b9252-6de4-4105-9b8e-597fc2b5117f 

-- Removals 
-- 250610	2020-07-20 00:00:00		7cdab138-7207-457c-ad6f-89cb7f8f4775 (Delete)
-- 250616	2020-07-21 00:00:00		537e1444-651f-4393-8040-549a99cb6f8b

-- Delete removal # 250610 - No associated placements and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250610
	and rm.personid = '757b9252-6de4-4105-9b8e-597fc2b5117f'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now()
where rm.removalid = 250610
	and rm.personid = '757b9252-6de4-4105-9b8e-597fc2b5117f'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '7cdab138-7207-457c-ad6f-89cb7f8f4775'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-16539',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '7cdab138-7207-457c-ad6f-89cb7f8f4775'
	and ro.activeflag = 1 ;

select removal_id, eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where eligibility_id = 10000624
	and delete_sw = 'N' ;

update tb_client_eligibility
set removal_id = 250616,
	start_dt = '2020-07-21'::date,
	update_ts = now(),
	update_user_id = 'CDM-16539'
where removal_id = 250610
	and delete_sw = 'N' ;


-- 16)
-- Case ID: 3199884	Baltimore City
-- Client ID: 3828287 (TIMOTHY J SCHNEIDER) - cf04db85-6526-4af3-b678-4525798a0c74

-- Removals 
-- 252230	2021-06-14 00:00:00		6efeadbb-fe00-4be2-bba7-96143177ee83 (Delete)
-- 252240	2021-06-13 00:00:00		ffceec4e-5702-40a1-aaff-cf9d5eb59e56

-- Delete removal # 252230 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252230
	and rm.personid = 'cf04db85-6526-4af3-b678-4525798a0c74'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252230
	and rm.personid = 'cf04db85-6526-4af3-b678-4525798a0c74'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;


-- 17)
-- Case ID: 2020019901874	Baltimore City
-- Client ID: 3916215 (ASHLEY ARANDA) - 19b430f9-4be5-4dac-b796-c2a0f5237f2e

-- Removals 
-- 250652	2020-07-06 00:00:00		07131220-1f4d-4fb6-8c93-349502d9e187 (delete)
-- 250583	2020-07-06 00:00:00		0cccab14-9cb2-4c94-8abb-92afe14c649a


-- Delete removal # 250652 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250652
	and rm.personid = '19b430f9-4be5-4dac-b796-c2a0f5237f2e'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 250652
	and rm.personid = '19b430f9-4be5-4dac-b796-c2a0f5237f2e'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;


-- 18)
-- Case ID: 211030008282	Baltimore City
-- Client ID: 4033329 (TAYLIN TURNER) - be6bac6d-1400-4709-aa3d-599f80331642 

-- Removals 
-- 252146	2021-06-02 00:00:00		e3daea90-2a06-4b46-a139-321686661769 (delete)
-- 252175	2021-06-02 00:00:00		8529c5c0-0e98-4e63-8b63-0ba1d25a8e28


-- Delete removal # 252146 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252146
	and rm.personid = 'be6bac6d-1400-4709-aa3d-599f80331642'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252146
	and rm.personid = 'be6bac6d-1400-4709-aa3d-599f80331642'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;


-- 19)
-- Case ID: 3278198	& 211020125306	Baltimore City 
-- Client ID: 4093154 (SEAVEN R	BOOTH) - f0f5e93a-7d9a-4184-9924-61bbd132b688

-- Removals 
-- 252396	2021-07-16 00:00:00		47bf0b3d-2af4-4e0d-ae79-16108c9e745a (delete)
-- 252433	2021-07-19 00:00:00		faeb124b-eaa8-472a-9151-6e79e0759c6a

-- Delete removal # 252396 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252396
	and rm.personid = 'f0f5e93a-7d9a-4184-9924-61bbd132b688'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252396
	and rm.personid = 'f0f5e93a-7d9a-4184-9924-61bbd132b688'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		


-- 20)
-- Case ID: 3279927	Baltimore City
-- Client ID: 4129716 (HAILEY R	MCDONALD) - 3e1f08d4-7ec4-4e68-bd1b-b573ff97451b

-- Removals 
-- 251054	2020-10-05 00:00:00		6d61fc3e-59de-47b3-8604-0c32cb63ac6c (delete)
-- 251063	2020-10-05 00:00:00		aac00c69-da70-4920-81aa-b83ba4ba851d

-- Delete removal # 251054 - No associated placements and NO IV-E 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251054
	and rm.personid = '3e1f08d4-7ec4-4e68-bd1b-b573ff97451b'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 251054
	and rm.personid = '3e1f08d4-7ec4-4e68-bd1b-b573ff97451b'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select startdate, enddate, programkey, updatedby, updatedon, activeflag 
	from personprogramarea 
where personprogramid = '8e8735d0-8345-4596-91a1-cf27a49aa891'
	and personid = '3e1f08d4-7ec4-4e68-bd1b-b573ff97451b'
	and programkey = 'OOH'
	and activeflag = 1 ;


update personprogramarea
set enddate = null, 
	updatedby = 'CDM-16539',
	updatedon = now() 		
where personprogramid = '8e8735d0-8345-4596-91a1-cf27a49aa891'
	and personid = '3e1f08d4-7ec4-4e68-bd1b-b573ff97451b'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '3266345c-2414-43b0-aae4-38e617373cde' -- Nullify End date 
	and personid = '3016d739-7562-4997-b893-7439b3385272'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set enddate = null, 
	updatedby = 'CDM-16539',
	updatedon = now() 		
where personprogramid = '3266345c-2414-43b0-aae4-38e617373cde' -- Nullify End date 
	and personid = '3016d739-7562-4997-b893-7439b3385272'
	and programkey = 'OOH'
	and activeflag = 1 ;



select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'eb942b0e-070c-4605-83a4-e279e4b415e5' -- delete
	and personid = '3016d739-7562-4997-b893-7439b3385272'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CDM-16539',
	updatedon = now() 		
where personprogramid = 'eb942b0e-070c-4605-83a4-e279e4b415e5' -- delete
	and personid = '3016d739-7562-4997-b893-7439b3385272'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- 21)
-- Case ID: 3307836	Baltimore City
-- Client ID: 4135066 (BRIELLE FLOYD) - 573e716c-4666-4578-bad1-d1876d014b7b

-- Removals 
-- 250940	2020-09-04 00:00:00		1bc1648d-7823-4e78-8b3d-a218fd055ad8 (Delete)
-- 250891	2020-09-04 00:00:00		7b2543ad-f9b2-421e-87f9-53143678a87d

-- Delete removal # 250940 - No associated placements and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250940
	and rm.personid = '573e716c-4666-4578-bad1-d1876d014b7b'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now()
where rm.removalid = 250940
	and rm.personid = '573e716c-4666-4578-bad1-d1876d014b7b'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '1bc1648d-7823-4e78-8b3d-a218fd055ad8'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-16539',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '1bc1648d-7823-4e78-8b3d-a218fd055ad8'
	and ro.activeflag = 1 ;


select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 250940
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16539'
where removal_id = 250940
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 250940
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16539'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 250940
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

-- 22)
-- Case ID: 211030008202 Baltimore City
-- Client ID: 4197069 (SENNAY C	ALEMAYEHU) - 9bde0feb-2380-4eb3-8bb8-495d2757404e

-- Removals 
-- 252088	2021-05-22 00:00:00		2863c3f6-72cd-4c6f-9cf7-7d9914dc0d8c (delete)
-- 252153	2021-05-22 00:00:00		10595958-ed66-4ce4-bdde-e3585cd1cfde


-- Delete removal # 252088 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252088
	and rm.personid = '9bde0feb-2380-4eb3-8bb8-495d2757404e'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252088
	and rm.personid = '9bde0feb-2380-4eb3-8bb8-495d2757404e'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;


-- 23)
-- Case ID: 211030008202 Baltimore City
-- Client ID: 4197073 (NOVIA ALEMAYEHU) - 893ad303-3086-48c1-97a6-99951d39ff8c

-- Removals 
-- 252087	2021-05-22 00:00:00		f03d4d53-d143-4c9b-885e-efccae537ce4 (delete)
-- 252152	2021-05-22 00:00:00		4ec616b7-b4ee-40ff-a183-411b5743d492


-- Delete removal # 252087 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252087
	and rm.personid = '893ad303-3086-48c1-97a6-99951d39ff8c'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252087
	and rm.personid = '893ad303-3086-48c1-97a6-99951d39ff8c'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		

-- 24)
-- Case ID: 
-- Client ID: 4197074 (ELIJAH AMED STEEL) - 52a0d341-6b98-40ef-9afd-18babb2b404d

-- Removals 
-- 252086	2021-05-22 00:00:00		89d6d728-68c4-4a95-ab20-5690a500765a (Delete)
-- 252207	2021-05-22 00:00:00		bbc0d53c-76ec-4332-bc6f-1fbb5eebcf28

-- Delete removal # 252086 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252086
	and rm.personid = '52a0d341-6b98-40ef-9afd-18babb2b404d'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252086
	and rm.personid = '52a0d341-6b98-40ef-9afd-18babb2b404d'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

-- 25)
-- Case ID: 
-- Client ID: 4225053 (NOAH	A SCHNEIDER) - 1b9f0a83-bc71-4bbe-8448-8b4fac4ded1b

-- Removals 
-- 252226	2021-06-14 00:00:00		66dc1d8f-1c94-43da-b6e5-8f64902fb204 (Delete)
-- 252241	2021-06-13 00:00:00		7e68c44d-58eb-4c22-b293-00018314f7a9


-- Delete removal # 252226 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252226
	and rm.personid = '1b9f0a83-bc71-4bbe-8448-8b4fac4ded1b'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252226
	and rm.personid = '1b9f0a83-bc71-4bbe-8448-8b4fac4ded1b'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;


-- 26)
-- Case ID: 211030008034 Baltimore City
-- Client ID: 4255540 (TRENDON LEON	PITTS) - c11b9743-f5f7-419d-bbfc-f4a8672ff242

-- Removals 
-- 252062	2021-05-16 00:00:00		1fddd406-c80c-4264-aad8-2643a5374dc2 (delete)
-- 252132	2021-05-16 00:00:00		e1b195a1-61d5-4914-a703-c0210ea510c0


-- Delete removal # 252062 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252062
	and rm.personid = 'c11b9743-f5f7-419d-bbfc-f4a8672ff242'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252062
	and rm.personid = 'c11b9743-f5f7-419d-bbfc-f4a8672ff242'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;


-- 27)
-- Case ID: 211030008034 Baltimore City
-- Client ID: 4255546 (AIDYN PITTS) - c9b1d952-5bbd-4c8a-a4d7-5a6d97da9135

-- Removals 
-- 252063	2021-05-16 00:00:00		bdb56f73-fb04-43c1-90ab-c96e297e6eb3 (Delete)
-- 252133	2021-05-16 00:00:00		e1e9edcc-8ab0-43fd-b46f-56676716a697


-- Delete removal # 252063 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252063
	and rm.personid = 'c9b1d952-5bbd-4c8a-a4d7-5a6d97da9135'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252063
	and rm.personid = 'c9b1d952-5bbd-4c8a-a4d7-5a6d97da9135'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

-- 28)
-- Case ID: 3307836	Baltimore City
-- Client ID: 4259449 (RIAHLIE AMIRA FLOYD) - dd99f006-f8ee-4c9d-81de-83e19f8d024c

-- Removals 
-- 250941	2020-09-04 00:00:00		4b0b44b4-2a5b-4757-aef1-95bdaa9276dc (Delete)
-- 250892	2020-09-04 00:00:00		35b6547f-3f81-4308-bdd6-5c6bff792f33


-- Delete removal # 250941 - No associated placements and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250941
	and rm.personid = 'dd99f006-f8ee-4c9d-81de-83e19f8d024c'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now()
where rm.removalid = 250941
	and rm.personid = 'dd99f006-f8ee-4c9d-81de-83e19f8d024c'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '4b0b44b4-2a5b-4757-aef1-95bdaa9276dc'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-16539',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '4b0b44b4-2a5b-4757-aef1-95bdaa9276dc'
	and ro.activeflag = 1 ;


select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 250941
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16539'
where removal_id = 250941
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 250941
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16539'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 250941
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

-- 29)
-- Case ID: 3267870	Baltimore City
-- Client ID: 4328503 (KENDELL YATES) - 545dcfe3-7a6a-42a7-96cb-7ab7da8abe5f 

-- Removals 
-- 252197	2021-06-10 00:00:00		2b6f3a6c-1f7b-4a87-a950-927770167e94 (Delete)
-- 252245	2021-06-10 00:00:00		0493d089-f762-4dd2-842a-c7707a894896 (Delete) App
-- 252246	2021-06-10 00:00:00		b3532678-b0f5-49a4-9871-3001cf9939d2 


-- Delete removal # 252197 & 252245 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252197
	and rm.personid = '545dcfe3-7a6a-42a7-96cb-7ab7da8abe5f'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252197
	and rm.personid = '545dcfe3-7a6a-42a7-96cb-7ab7da8abe5f'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252245
	and rm.personid = '545dcfe3-7a6a-42a7-96cb-7ab7da8abe5f'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now()
where rm.removalid = 252245
	and rm.personid = '545dcfe3-7a6a-42a7-96cb-7ab7da8abe5f'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '0493d089-f762-4dd2-842a-c7707a894896'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-16539',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '0493d089-f762-4dd2-842a-c7707a894896'
	and ro.activeflag = 1 ;	
	
	
-- 30)
-- Case ID: 211030008963 Baltimore City
-- Client ID: 4355438 (KINGSTON	T HARRIS) - 4b58ca8c-ce0c-4c37-bba2-90bb7d1c1434

-- Removals 
-- 252276	2021-06-23 00:00:00		f3f7e486-aa0e-4051-827f-c5a1dd51fe87 (Delete)
-- 252288	2021-06-24 00:00:00		7aae3810-dbd5-4bcd-b922-04af48403807

-- Delete removal # 252276 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252276
	and rm.personid = '4b58ca8c-ce0c-4c37-bba2-90bb7d1c1434'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252276
	and rm.personid = '4b58ca8c-ce0c-4c37-bba2-90bb7d1c1434'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		

	
-- 31)
-- Case ID: 3199884	Baltimore City
-- Client ID: 4379985 (ABIGAIL ROSALYN SCHNEIDER) - 24bf20e3-cd2d-47d3-9270-8260ee5a7ccb

-- Removals 
-- 252227	2021-06-14 00:00:00		a6508eda-ec12-4de9-8ee8-12acf82cc6a6 (Delete)
-- 252242	2021-06-13 00:00:00		fa31821c-3838-40da-b11f-4192c2a73095


-- Delete removal # 252227 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252227
	and rm.personid = '24bf20e3-cd2d-47d3-9270-8260ee5a7ccb'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252227
	and rm.personid = '24bf20e3-cd2d-47d3-9270-8260ee5a7ccb'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		

-- 32)
-- Case ID: 3302484	Baltimore City
-- Client ID: 4416551 (IAN RAYMOND) - abaa8a10-9781-41c0-a7b7-ef5165bb1cc6

-- Removals 
-- 250976	2020-09-05 00:00:00		e8ab456b-3f0b-406f-872f-71f4515b3c6b (Delete) App
-- 250977	2020-09-05 00:00:00		ff68e1df-ac06-4660-a5b2-80e96b143beb


-- Delete removal # 250976 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250976
	and rm.personid = 'abaa8a10-9781-41c0-a7b7-ef5165bb1cc6'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now()
where rm.removalid = 250976
	and rm.personid = 'abaa8a10-9781-41c0-a7b7-ef5165bb1cc6'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'e8ab456b-3f0b-406f-872f-71f4515b3c6b'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-16539',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'e8ab456b-3f0b-406f-872f-71f4515b3c6b'
	and ro.activeflag = 1 ;	

-- 33)
-- Case ID: 3304992	Baltimore City
-- Client ID: 4453830 (Jayson Snead-Johnson) -	a7adcbac-1cf3-42d6-bc4f-04be854dc10c 

-- Removals 
-- 250675	2020-08-03 00:00:00		43b0de13-b0d3-426e-bba9-78f4dbcbf9f4 (Delete)
-- 250956	2020-09-03 00:00:00		2dfde744-9254-4418-85d7-6b8ff5022813

-- Delete removal # 250675 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250675
	and rm.personid = 'a7adcbac-1cf3-42d6-bc4f-04be854dc10c'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 250675
	and rm.personid = 'a7adcbac-1cf3-42d6-bc4f-04be854dc10c'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		

-- 34
-- Case ID: 211030009208 & 211030009211	Baltimore City
-- Client ID: 4476504 (DAMON MCDONALD) - ccdf8639-66f5-4bc7-b20e-330aae574dd6

-- Removals 
-- 252408	2021-07-08 00:00:00		f22d0af4-97c8-4e9f-994d-ebf5532d1d64 (delete) App
-- 252338	2021-07-08 00:00:00		80225ebc-fc7b-4edd-a814-0754bada7f62 (delete)
-- 252412	2021-07-08 00:00:00		e4018c12-7b04-4c50-928a-d9417ecc20ae

-- Delete removal # 252408 & 252338 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252408
	and rm.personid = 'ccdf8639-66f5-4bc7-b20e-330aae574dd6'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now()
where rm.removalid = 252408
	and rm.personid = 'ccdf8639-66f5-4bc7-b20e-330aae574dd6'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'f22d0af4-97c8-4e9f-994d-ebf5532d1d64'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-16539',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'f22d0af4-97c8-4e9f-994d-ebf5532d1d64'
	and ro.activeflag = 1 ;	
	
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252338
	and rm.personid = 'ccdf8639-66f5-4bc7-b20e-330aae574dd6'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252338
	and rm.personid = 'ccdf8639-66f5-4bc7-b20e-330aae574dd6'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

-- 35)
-- Case ID: 211030009552	Baltimore City
-- Client ID: 4482652 (JUANITA M DELARGE) - 66fb4d95-03e9-452c-ba38-8323e8b3b48e 

-- Removals 
-- 252402	2021-07-15 00:00:00		ec4d1532-1ee8-4f1b-8ea0-6bc98e49fe4b (Delete)
-- 252413	2021-07-14 00:00:00		15d8bc40-be9e-48a4-8e8b-da81fe631774


-- Delete removal # 252402 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252402
	and rm.personid = '66fb4d95-03e9-452c-ba38-8323e8b3b48e'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252402
	and rm.personid = '66fb4d95-03e9-452c-ba38-8323e8b3b48e'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;


-- 36)
-- Case ID: 3295223	Baltimore City
-- Client ID: 4489734 (DONTE BROWN) - ff0a661b-fde0-437f-b031-ef978a5d1b1a

-- Removals 
-- 250529	2020-06-30 00:00:00		85af46b7-bf02-47e0-98ec-3f7360f1ea30 (delete)
-- 250577	2020-06-30 00:00:00		15a3987f-e3fb-4f40-9546-5fcefc52a562


-- Delete removal # 250529 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250529
	and rm.personid = 'ff0a661b-fde0-437f-b031-ef978a5d1b1a'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 250529
	and rm.personid = 'ff0a661b-fde0-437f-b031-ef978a5d1b1a'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

-- 37)
-- Case ID: 211030008534 Baltimore City
-- Client ID: 200019765	(Tyler Sellman-Traynham) - 7b9d0267-8709-4777-ae71-8ba8b9099f40

-- Removals 
-- 252158	2021-06-04 00:00:00		d897d568-b6b4-4a56-8d03-80924379438c
-- 252157	2021-06-04 00:00:00		062601a7-bcfa-4300-a656-294acbf28f9d (Delete)

-- Delete removal # 252157 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252157
	and rm.personid = '7b9d0267-8709-4777-ae71-8ba8b9099f40'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252157
	and rm.personid = '7b9d0267-8709-4777-ae71-8ba8b9099f40'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

-- 38)
-- Case ID: 2020020301915 & 3254698	Baltimore City
-- Client ID: 200023193 (Serenity Jackson) - 3016d739-7562-4997-b893-7439b3385272

-- Removals 
-- 250601	2020-07-22 00:00:00		38d14f09-6f15-4cd9-b6ef-745c32fdb538 (delete)
-- 250613	2020-07-22 00:00:00		27faa047-1120-4b2d-9069-efe7597f4f7d


-- Delete removal # 250601 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250601
	and rm.personid = '3016d739-7562-4997-b893-7439b3385272'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 250601
	and rm.personid = '3016d739-7562-4997-b893-7439b3385272'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '3266345c-2414-43b0-aae4-38e617373cde' -- Nullify End date 
	and personid = '3016d739-7562-4997-b893-7439b3385272'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set enddate = null, 
	updatedby = 'CDM-16539',
	updatedon = now() 		
where personprogramid = '3266345c-2414-43b0-aae4-38e617373cde' -- Nullify End date 
	and personid = '3016d739-7562-4997-b893-7439b3385272'
	and programkey = 'OOH'
	and activeflag = 1 ;

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'eb942b0e-070c-4605-83a4-e279e4b415e5' -- delete
	and personid = '3016d739-7562-4997-b893-7439b3385272'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CDM-16539',
	updatedon = now() 		
where personprogramid = 'eb942b0e-070c-4605-83a4-e279e4b415e5' -- delete
	and personid = '3016d739-7562-4997-b893-7439b3385272'
	and programkey = 'OOH'
	and activeflag = 1 ;


-- 39) 
-- Case ID: 3217328 & 2020024802861	Baltimore City
-- Client ID: 200146179 (Naeline Conway) -  26b1d8f4-e14e-4d95-a4f3-c9eecb61e915

-- Removals 
-- 250980	2020-09-25 00:00:00		7e972bdb-e02d-4448-b502-274e8bc50cb6 (Delete)
-- 251105	2020-09-24 00:00:00		47919fc1-4a39-4b09-bc42-4dc5dd8c7cc1


-- Delete removal # 250980 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250980
	and rm.personid = '26b1d8f4-e14e-4d95-a4f3-c9eecb61e915'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 250980
	and rm.personid = '26b1d8f4-e14e-4d95-a4f3-c9eecb61e915'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		

-- 40)
-- Case ID: 3228307	Baltimore City
-- Client ID: 200146463	(Kayden	Eagle) - 234a9576-8b58-41e4-9568-5a1553050008

-- Removals 
-- 251026	2020-09-02 00:00:00		72fe9c3c-1271-4979-b403-e22383caac52 (Delete)
-- 251040	2020-09-02 00:00:00		21121fea-60a2-434c-871f-8cf8b1b76d24

-- Delete removal # 251026 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251026
	and rm.personid = '234a9576-8b58-41e4-9568-5a1553050008'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 251026
	and rm.personid = '234a9576-8b58-41e4-9568-5a1553050008'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

-- 41)
-- Case ID: 2020031704151 Baltimore City
-- Client ID: 200148125	(Santa Garcia) - 80bf4319-bad7-4051-89e1-6053ecb99916

-- Removals 
-- 251213	2020-11-12 00:00:00		c811d454-9edd-4d73-ba93-8a2dfd98541f (Delete)
-- 251257	2020-11-13 00:00:00		1f4c9d19-ce9d-4517-ac0d-2dca0feb8dce


-- Delete removal # 251213 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251213
	and rm.personid = '80bf4319-bad7-4051-89e1-6053ecb99916'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 251213
	and rm.personid = '80bf4319-bad7-4051-89e1-6053ecb99916'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

-- 42)
-- Case ID: 211030009885 Baltimore City
-- Client ID: 200148290 (DA'MONTE THOMAS) - 3819ab22-dd9d-46ab-b412-bbdd92c3407b

-- Removals 
-- 252511	2021-08-04 00:00:00		73f1f1ed-1c45-422a-aa3d-cb32aa6ed9d7
-- 252502	2021-08-04 00:00:00		c8308b99-a402-4e28-a37b-d259f5d58db8 (Delete)


-- Delete removal # 252502 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252502
	and rm.personid = '3819ab22-dd9d-46ab-b412-bbdd92c3407b'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252502
	and rm.personid = '3819ab22-dd9d-46ab-b412-bbdd92c3407b'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		

-- 43)
-- Case ID: 2020025702987 Baltimore City
-- Client ID: 200149337 (Zion Wallace) - 3da63e42-7ac1-4b87-8f1c-1aaee8ae8c1f

-- Removals 
-- 250905	2020-09-11 00:00:00		492e8737-f9d3-441b-b107-1b4934a6874d (Delete) 
-- 250906	2020-09-11 00:00:00		dc6ca76c-bf84-4011-b05a-bad24a6d51c1 (Delete)
-- 250869	2020-09-11 00:00:00		a31a6323-7ef1-4411-84af-5a7f55c9d104 (Delete)


-- Delete removal # ?? - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid in ( 250905, 250906,250869 )
	and rm.personid = '3da63e42-7ac1-4b87-8f1c-1aaee8ae8c1f'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid in ( 250905, 250906,250869 )
	and rm.personid = '3da63e42-7ac1-4b87-8f1c-1aaee8ae8c1f'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

-- 44)
-- Case ID: 3198694	Baltimore City
-- Client ID: 200150075 (Jaiquan Clyburn) - 79241ab2-6813-43d3-998c-185422573a19

-- Removals 
-- 250938	2020-09-12 00:00:00		4001ec35-be1a-49f3-8986-014b3ab29867 (delete)
-- 250939	2020-09-12 00:00:00		caad2b2e-8210-431f-8f4b-e2474d776e8f

-- Delete removal # 250938 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250938
	and rm.personid = '79241ab2-6813-43d3-998c-185422573a19'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 250938
	and rm.personid = '79241ab2-6813-43d3-998c-185422573a19'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		

-- 45)
-- Case ID: 2020030203871 & 3271165 Baltimore City
-- Client ID: 200164964 (Pryda Montez Lamont Simmons) - e604033c-e1fc-4ff4-8246-e7bdd79deba0

-- Removals 
-- 251200	2020-11-06 00:00:00		6c691116-01ad-4b50-af93-b9c83191e337
-- 251194	2020-11-06 00:00:00		f450819c-b8d5-476a-8e09-b100aea828be (Delete)


-- Delete removal # 251194 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251194
	and rm.personid = 'e604033c-e1fc-4ff4-8246-e7bdd79deba0'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 251194
	and rm.personid = 'e604033c-e1fc-4ff4-8246-e7bdd79deba0'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

-- 46)
-- Case ID: 2020031404089 Baltimore City
-- Client ID: 200170193 (Kiana Brown) - 605e0f2e-c24c-47d7-a389-e9526cb4ded8

-- Removals 
-- 251613	2021-02-04 00:00:00		3797d0da-15cf-452e-a633-2d6ec13e2027 -- IV-E - Apporved - 1 LA & 1 Prov (LA Active)
-- 251402	2020-11-11 00:00:00		43cf8530-3675-41c6-94d9-feaec6315bce -- IV-E - Apporved - 2 LA & 1 Prov (all closed)

-- The 11/11/2020 should have been closed on 12/18/2020. then the 2/4/21 was a new removal
-----------------

-- Removal End date
select removaldate, exitdate, removalexitreason, returntime, updatedby, updatedon
	from cjams.intakeservreqchildremoval 
where intakeservreqchildremovalid = '43cf8530-3675-41c6-94d9-feaec6315bce'
	and activeflag = 1 ;

update cjams.intakeservreqchildremoval
set removalexitreason = 'REUNIF',
	exitdate = '2020-12-18 10:00:00',
	returntime = '2020-12-18 10:00:00',
	updatedby = 'CDM-16539',
	updatedon = now()
where intakeservreqchildremovalid = '43cf8530-3675-41c6-94d9-feaec6315bce'
	and activeflag = 1 ;
	
-- Out of range Placements associated with 43cf8530-3675-41c6-94d9-feaec6315bce
-- 1560108 nuiify 	
select alternateid, placementtypekey, altproviderid, intakeservreqchildremovalid, updatedby, updatedon 
	from placement
where alternateid = 1560108
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid = null,
	updatedon = now(), 
	updatedby = 'CDM-16539'
where alternateid = 1560108
	and activeflag = 1 ;


-- 1560814 link to 251613 (3797d0da-15cf-452e-a633-2d6ec13e2027)
select alternateid, placementtypekey, altproviderid, intakeservreqchildremovalid, updatedby, updatedon 
	from placement
where alternateid = 1560814
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid = '3797d0da-15cf-452e-a633-2d6ec13e2027',
	updatedon = now(), 
	updatedby = 'CDM-16539'
where alternateid = 1560814
	and activeflag = 1 ;



-- 47)
-- Case ID: 2021012307617 Baltimore City
-- Client ID: 200660293 (sean white) - e95a8d63-24a1-4dde-9d8e-94a80b12e785

-- Removals 
-- 252012	2021-05-01 00:00:00		76dd9ca5-5c14-426d-83cc-0922eee27eb5 (Delete)
-- 252014	2021-05-01 00:00:00		139966e9-27c3-4a7d-9567-d6acecd6ff44


-- Delete removal # 252012 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252012
	and rm.personid = 'e95a8d63-24a1-4dde-9d8e-94a80b12e785'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252012
	and rm.personid = 'e95a8d63-24a1-4dde-9d8e-94a80b12e785'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		

-- 48)
-- Case ID: 3218214 Baltimore City
-- Client ID: 200670931 (Kayllen S Dunbar) - 684cf03f-c48b-4988-8c2a-95a5b78e8046

-- Removals 
-- 252265	2021-05-28 00:00:00		3146c3bb-e128-480b-8b9f-2d8374429b93 (Delete)
-- 252317	2021-05-27 00:00:00		253ca95d-61c3-4311-b568-dbefe36392c0


-- Delete removal # 252265 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252265
	and rm.personid = '684cf03f-c48b-4988-8c2a-95a5b78e8046'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252265
	and rm.personid = '684cf03f-c48b-4988-8c2a-95a5b78e8046'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

-- 49)
-- Case ID: 211030008533 Baltimore City
-- Client ID: 200671606 (Alyssa Marr-Gavin) - a629178a-5328-44fa-83aa-2de47680199a

-- Removals 
-- 252266	2021-05-29 00:00:00		a77a89f6-9220-4685-8f30-b3d7d6d0f6d7 (Delete)
-- 252267	2021-05-29 00:00:00		68e0519d-a672-415e-a2ef-aa5b708f3e6b

-- Delete removal # 252266 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252266
	and rm.personid = 'a629178a-5328-44fa-83aa-2de47680199a'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252266
	and rm.personid = 'a629178a-5328-44fa-83aa-2de47680199a'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

-- 50)
-- Case ID: 3239230 Baltimore City
-- Client ID: 200770264	(Malakai A Devaughn) - d9edb7c4-a469-4d45-a24b-74580a6dfd9d

-- Removals 
-- 252211	2021-06-06 00:00:00		7627850d-df70-4eb2-8d23-bbf78378d71e (Delete)
-- 252212	2021-06-06 00:00:00		087b3a83-2841-4e45-9156-ee06b4f46e00


-- Delete removal # 252211 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252211
	and rm.personid = 'd9edb7c4-a469-4d45-a24b-74580a6dfd9d'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252211
	and rm.personid = 'd9edb7c4-a469-4d45-a24b-74580a6dfd9d'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;


-- 51)
-- Case ID: 211030008940 Baltimore City
-- Client ID: 200772429 (Zainab Kehinde) - e08a1c94-e18c-48e6-87dc-ceee8d868907

-- Removals 
-- 252271	2021-06-13 00:00:00		aa4df494-9222-435a-9a0b-3545675eae03 (Delete)
-- 252292	2021-06-13 00:00:00		422e0cea-4e95-4698-8685-9298c8376b73


-- Delete removal # 252271 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252271
	and rm.personid = 'e08a1c94-e18c-48e6-87dc-ceee8d868907'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252271
	and rm.personid = 'e08a1c94-e18c-48e6-87dc-ceee8d868907'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;


-- 52)
-- Case ID: 3199884 Baltimore City
-- Client ID: 200772446 (Danielle Carol	Schneider) - 64b5e755-fc7e-4830-876f-6dfc3e192474 

-- Removals 
-- 252228	2021-06-14 00:00:00		39bde33d-2cc5-4e1b-b6bb-6a4d38ac63de (Delete)
-- 252243	2021-06-13 00:00:00		89bc9530-53dd-4cc5-91f3-299e218e4c64


-- Delete removal # 252228 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252228
	and rm.personid = '64b5e755-fc7e-4830-876f-6dfc3e192474'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252228
	and rm.personid = '64b5e755-fc7e-4830-876f-6dfc3e192474'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;


-- 53)
-- Case ID: 211030008963 Baltimore City
-- Client ID: 200775620 (Keyontae Harris) -	2e543c3d-50a1-41ff-b614-c5b1a7cfd064

-- Removals 
-- 252275	2021-06-23 00:00:00		ec2d2bd6-8da2-4854-ae2a-56d45b089e73 (Delete)
-- 252289	2021-06-24 00:00:00		65bf8233-7171-4e3f-b1f8-01c98125d7f3


-- Delete removal # 252275 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252275
	and rm.personid = '2e543c3d-50a1-41ff-b614-c5b1a7cfd064'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252275
	and rm.personid = '2e543c3d-50a1-41ff-b614-c5b1a7cfd064'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

-- New as of 09/13/2021

-- 54)
-- Case ID: 211030009550 Baltimore City
-- Client ID: 2646328 (DEAYSHA CLARK) -	cc661efe-4ae0-4038-ba92-2e67ae2fc551

-- Removals 
-- 252405	2021-07-18 00:00:00		5c7e409c-0a19-4dab-9a6a-b229ed5a7ce2 (Delete) - App
-- 252406	2021-07-18 00:00:00		1d05d21d-a715-48c6-9766-0591fb8600da


-- Delete removal # 252405 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252405
	and rm.personid = 'cc661efe-4ae0-4038-ba92-2e67ae2fc551'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now()
where rm.removalid = 252405
	and rm.personid = 'cc661efe-4ae0-4038-ba92-2e67ae2fc551'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '5c7e409c-0a19-4dab-9a6a-b229ed5a7ce2'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-16539',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '5c7e409c-0a19-4dab-9a6a-b229ed5a7ce2'
	and ro.activeflag = 1 ;	


-- 55)
-- Case ID: 3244739	Baltimore City
-- Client ID: 3764702 (JOSLEN M	BUTLER) - 27ca549d-45ad-485e-ada2-b0b5d74cab48

-- Removals 
-- 252662	2021-08-30 00:00:00		21cbaf3e-c65d-48ab-b7d5-250c6b59158f
-- 252650	2021-08-30 00:00:00		5e45881f-c31f-4eeb-9582-61720987ab9f (Delete)


-- Delete removal # 252650 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252650
	and rm.personid = '27ca549d-45ad-485e-ada2-b0b5d74cab48'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252650
	and rm.personid = '27ca549d-45ad-485e-ada2-b0b5d74cab48'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

-- 56)
-- Case ID: 3270921 Baltimore City
-- Client ID: 4010335 (ZAYLEN DEAVER) - 228085d1-959a-4fa5-aa70-ac651fd283f9

-- Removals 
-- 252507	2021-08-06 00:00:00		6fd15547-f02c-448d-ab27-851dbf669ea6 (Delete)
-- 252574	2021-08-05 00:00:00		86867d67-550d-45fe-bc1c-b42e2fa2148f


-- Delete removal # 252507 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252507
	and rm.personid = '228085d1-959a-4fa5-aa70-ac651fd283f9'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252507
	and rm.personid = '228085d1-959a-4fa5-aa70-ac651fd283f9'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;


-- 57)
-- Case ID: 3270921 Baltimore City
-- Client ID: 4010338 (ZYAIRE A	DEAVER) - 7b8106bc-daf3-42dd-9812-6e2626290b78

-- Removals 
-- 252508	2021-08-06 00:00:00		f58b66c2-2b7c-4495-a8c2-633bf88795c3 (Delete)
-- 252573	2021-08-05 00:00:00		d497da5d-ceba-4d6c-b2aa-e5d264b6517d


-- Delete removal # 252508 - No associated placements, NO IV-E and Active OOH 
-----------------
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252508
	and rm.personid = '7b8106bc-daf3-42dd-9812-6e2626290b78'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-16539',
	rm.updatedon = now() 		
where rm.removalid = 252508
	and rm.personid = '7b8106bc-daf3-42dd-9812-6e2626290b78'
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;


