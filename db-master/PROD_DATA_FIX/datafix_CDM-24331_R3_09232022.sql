-- CDM-24331 - Duplicate removals
/*
-- Issue Description: Datafix to remove the Duplicate Removals
*/

-- 1)
-- Case ID: 3096915
-- Client ID: 1748697 (ANIYA LOMAX) - 0754c180-73a6-435a-96b0-580df0cfe1e8 
-- Delete removal 253095	91b15686-0eeb-4783-8ec5-91c02e369183
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253095
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253095
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253095
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253095
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253095
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253095
	and delete_sw = 'N' ;	
	

-- 2)
-- Case ID: 211030013069 
-- Client ID: 2111284 (DIAMOND BRITTANIE BENTON-HUNTER)	23f1b95b-49d9-45ee-90c6-2f1bf4e277dd 
-- Delete removal # 253312	19341373-e319-465d-9dff-7757d8bebdbb
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253312
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253312
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253312
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253312
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253312
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253312
	and delete_sw = 'N' ;	

-- 3)
-- Case ID: 211030008944
-- Client ID: 2152250 (KARMA LUCAS) - 79dd2867-85b5-4ebb-b81b-db53a633e813 
-- Delete removal # 252620	8bb7ab3c-4d6a-44d8-b8bd-13da149df7d6
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252620
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 252620
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252620
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252620
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252620
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 252620
	and delete_sw = 'N' ;	

-- 4)
-- Case ID: 3127840
-- Client ID: 2357423 (MASON TYLER GROB) - eb301471-fbd6-4694-b822-f731439daced
-- Delete removal # 253069	25f98df0-9044-44d4-9a08-ba2082088685
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253069
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253069
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253069
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253069
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253069
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253069
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'e25c9f60-4c52-478e-ab8e-0fe952235dc7'
	and personid = 'eb301471-fbd6-4694-b822-f731439daced'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-11-09 00:00:00',
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = 'e25c9f60-4c52-478e-ab8e-0fe952235dc7'
	and personid = 'eb301471-fbd6-4694-b822-f731439daced'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 5) 3176522
-- Case ID: 
-- Client ID: 2708572 (AMIR DULA) - 2bdaff4d-7304-4713-ab86-449cab376d5d
-- Delete removal # 251109	43af581d-9588-4e62-806e-6e89b001df3d
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251109
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 251109
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 251109
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 251109
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 251109
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 251109
	and delete_sw = 'N' ;	
	
-- 6)
-- Case ID: 3112284 
-- Client ID: 3507315 (MAKAYLA RACHELL LEE) - 1ae47da1-2647-4e26-abd6-9d7ee2ad1fef
-- Delete removal # 253014	19fac1d9-d4e1-481b-a1f1-a1985431bfa6
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253014
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253014
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253014
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253014
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253014
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253014
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '3fe56155-fb02-49f7-a916-d12ce8d28142'
	and personid = '1ae47da1-2647-4e26-abd6-9d7ee2ad1fef'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-11-01 00:00:00',
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = '3fe56155-fb02-49f7-a916-d12ce8d28142'
	and personid = '1ae47da1-2647-4e26-abd6-9d7ee2ad1fef'
	and programkey = 'OOH'
	and activeflag = 1 ;

-- 7)
-- Case ID: 211030011914
-- Client ID: 3543078 (MALIYAH DENNISON) - 69af427d-99da-469b-bbb7-8760af06ee36
-- Delete removal # 252985	6826e5fa-7b1b-402e-8d91-75859f1ed5a6
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252985
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 252985
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252985
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252985
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252985
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 252985
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '34bb226b-5ff1-4fb9-a24c-b36f9a5c24f7'
	and personid = '69af427d-99da-469b-bbb7-8760af06ee36'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-10-28 00:00:00',
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = '34bb226b-5ff1-4fb9-a24c-b36f9a5c24f7'
	and personid = '69af427d-99da-469b-bbb7-8760af06ee36'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 8)
-- Case ID: 211030011292
-- Client ID: 3545554 (KASHA N WILLIAMS-LAWSON) - 46c32cbe-19bf-401b-bbf5-5e40497a48f4
-- Delete removal # 252848	fdbde50f-5d93-4818-85f7-c7bb21e99993
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252848
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 252848
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252848
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252848
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252848
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 252848
	and delete_sw = 'N' ;	
	

-- 9)
-- Case ID: 3228934
-- Client ID: 3758840 (KENNETH WISE) - 12855caf-efc8-453f-88b0-37c5b50d4e7a
-- Delete removal # 252979	892f78dd-169b-46c9-b7d0-009897708058
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252979
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 252979
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252979
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252979
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252979
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 252979
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'fa3b0140-e417-4583-9ca5-066c28d55d3b'
	and personid = '12855caf-efc8-453f-88b0-37c5b50d4e7a'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-10-26 00:00:00',
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = 'fa3b0140-e417-4583-9ca5-066c28d55d3b'
	and personid = '12855caf-efc8-453f-88b0-37c5b50d4e7a'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 10)
-- Case ID: 3266667
-- Client ID: 3926838 (AYLAH RAEL LEEMYERS) - 01a1fc9f-e549-4f01-a390-715e9ea5b26a
-- Delete removal # 252750	1d9b1716-b020-4f0f-80e8-f52d00240dee
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252750
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 252750
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252750
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252750
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252750
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 252750
	and delete_sw = 'N' ;	


-- 11)
-- Case ID: 211030012118
-- Client ID: 4029406 (HUNTER L HAYDEN) - e77d91c6-bd53-4b6c-9f7b-0eb3c7315e05
-- Delete removal # 253037	825d36a7-0715-4df9-9ffd-5884d72f8f28
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253037
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253037
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253037
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253037
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253037
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253037
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '172701da-9049-4384-abaf-35b2dfb89eae'
	and personid = 'e77d91c6-bd53-4b6c-9f7b-0eb3c7315e05'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-11-02 00:00:00',
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = '172701da-9049-4384-abaf-35b2dfb89eae'
	and personid = 'e77d91c6-bd53-4b6c-9f7b-0eb3c7315e05'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 12)
-- Case ID: 211030012997
-- Client ID: 4148973 (KEVIN A ROBBINS) - 08d710f9-6a10-44ce-a852-f8816f235aaa
-- Delete removal # 253289	f0d7c7c2-8629-4f6d-8ee6-1863885cdf48
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253289
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253289
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253289
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253289
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253289
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253289
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '0ffc3c56-2236-4c2f-ba22-5b1acd3b072a'
	and personid = '08d710f9-6a10-44ce-a852-f8816f235aaa'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-12-15 00:00:00',
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = '0ffc3c56-2236-4c2f-ba22-5b1acd3b072a'
	and personid = '08d710f9-6a10-44ce-a852-f8816f235aaa'
	and programkey = 'OOH'
	and activeflag = 1 ;

-- 13)
-- Case ID: 
-- Client ID: 4327395 (ZALIA M LEE-ANDERSON) - 00f62c71-32bd-45be-a742-e7338b26009f
-- Delete removal # 252931	3b5efc93-cc72-47b6-914a-0fea0be936ac
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252931
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 252931
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252931
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252931
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252931
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 252931
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '45986e76-d8f1-4ee2-85c7-97b997300dd0'
	and personid = '00f62c71-32bd-45be-a742-e7338b26009f'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-10-04 00:00:00',
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = '45986e76-d8f1-4ee2-85c7-97b997300dd0'
	and personid = '00f62c71-32bd-45be-a742-e7338b26009f'
	and programkey = 'OOH'
	and activeflag = 1 ;


-- 14)
-- Case ID: 3220667
-- Client ID: 4342744 (SAKINA MATTHEWS) - d8d3f37b-1514-4748-8cf4-0b294ece81f0
-- Delete removal # 253176	a7a1246d-8503-47a1-9902-72d3f901a14e
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253176
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253176
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253176
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253176
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253176
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253176
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '80490bea-ce1e-49fb-8032-71df14124048'
	and personid = 'd8d3f37b-1514-4748-8cf4-0b294ece81f0'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-11-27 00:00:00',
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = '80490bea-ce1e-49fb-8032-71df14124048'
	and personid = 'd8d3f37b-1514-4748-8cf4-0b294ece81f0'
	and programkey = 'OOH'
	and activeflag = 1 ;

-- 15)
-- Case ID: 3302996
-- Client ID: 4425659 (KAILYNN INGRAM) - badf3a7f-50d3-48e3-a6df-e0df99f6123f
-- Delete removal # 253227	1b87a084-6bd4-4194-9d96-ae0dc734b949
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253227
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253227
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253227
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253227
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253227
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253227
	and delete_sw = 'N' ;	

-- 16)
-- Case ID: 3307082
-- Client ID: 4483252 (WESLEY ANTONIO WILLIAMSON) - a32e78b5-f255-42b7-884c-7a1093ef9a18
-- Delete removal # 250416	4ba9a191-8bc0-40c0-a34f-aee359194c2e
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250416
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 250416
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 250416
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 250416
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 250416
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 250416
	and delete_sw = 'N' ;	


-- 17)
-- Case ID: 2020020201896
-- Client ID: 200022312 (TRYSTAN DAMIAN	LOUIA) - 9ca740b1-fef5-4382-ae6a-5c38c5250c70
-- Delete removal # 252125	40b964b2-849b-4d3d-a2f9-6dc8236766d6
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252125
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 252125
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252125
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252125
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252125
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 252125
	and delete_sw = 'N' ;	
	
-- 18)
-- Case ID: 3278693
-- Client ID: 200138661 (CAYLEB WHIPP) - 70425313-f91f-493c-a475-d2a1f1d66f25
-- Delete removal # 250734	3c65a134-ed04-4543-a3b3-7b3043cf8207
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250734
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 250734
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 250734
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 250734
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 250734
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 250734
	and delete_sw = 'N' ;	


-- 19)
-- Case ID: 211030009843
-- Client ID: 200299949 (Malae Williams) - ed39c0a7-9e3d-4970-819a-ba4f0dedcc42 
-- Delete removal # 252495	3018d576-d956-41c0-97a8-b59aa4e69f33
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252495
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 252495
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252495
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252495
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252495
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 252495
	and delete_sw = 'N' ;	
	

-- 20)
-- Case ID: 211030009843
-- Client ID: 200309427 (Zyaire	Harden Williams) - ef4a25ac-0669-4f5b-9270-84c1b6fc8936
-- Delete removal # 252496	3d9d03d7-26cc-4b17-b45f-005fce7a0879
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252496
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 252496
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252496
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252496
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252496
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 252496
	and delete_sw = 'N' ;	

-- 21)
-- Case ID: 211030011195
-- Client ID: 200405086 (IVORY GREEN) - bd1bfab8-d9f9-45a5-a2ec-d7da0469fe02
-- Delete removal # 253060	282d9ee7-2359-4399-b59e-9cb5840c616f
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253060
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253060
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253060
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253060
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253060
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253060
	and delete_sw = 'N' ;	
	
-- 22)
-- Case ID: 2021012507693
-- Client ID: 200412969 (DIAMOND ALSTON) - 74dd1d8b-1a25-40ac-b59b-e7dc3be3e0dd
-- Delete removal # 252310	4ac63a7c-ab3c-4b41-8cca-1b3e62e25571
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252310
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 252310
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252310
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252310
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252310
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 252310
	and delete_sw = 'N' ;	

-- 23)
-- Case ID: 211030012118
-- Client ID: 200671448	(Braxton Williams) - 49adfae5-a15d-4fe8-b097-48788e7b1f3e
-- Delete removal # 253036	4bafa876-5634-46be-976c-529ddf51fa96
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253036
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253036
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253036
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253036
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253036
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253036
	and delete_sw = 'N' ;	

-- 24)
-- Case ID: 3159615
-- Client ID: 200772958 (Faith R Spicer) - dc2a08bf-9245-46fe-bde4-9702b9569f94
-- Delete removal # 252952	82b11343-e41e-480d-9917-58c5e777b679
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252952
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 252952
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252952
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252952
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252952
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 252952
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '8c51b0df-91ac-4486-af12-db9b9e4d1221'
	and personid = 'dc2a08bf-9245-46fe-bde4-9702b9569f94'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-10-19 00:00:00',
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = '8c51b0df-91ac-4486-af12-db9b9e4d1221'
	and personid = 'dc2a08bf-9245-46fe-bde4-9702b9569f94'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- Delete duplicate 
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '55cc708f-d8ca-4d21-9165-f5d9b7fb4fd5'
	and personid = 'dc2a08bf-9245-46fe-bde4-9702b9569f94'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = '55cc708f-d8ca-4d21-9165-f5d9b7fb4fd5'
	and personid = 'dc2a08bf-9245-46fe-bde4-9702b9569f94'
	and programkey = 'OOH'
	and activeflag = 1 ;	
	

-- 25)
-- Case ID: 3278292
-- Client ID: 200774907 (Gracelyn Caldwell) - 33672016-840b-42c5-b74e-a2b9e891f158
-- Delete removal # 253168	a07b4bb8-9c23-4ff6-9f89-ad0578d2d6e9
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253168
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253168
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253168
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253168
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253168
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253168
	and delete_sw = 'N' ;	
	
-- 26)
-- Case ID: 211030012115	
-- Client ID: 200809309 (Zion Owens) - 	ab485320-0567-423f-8167-df179af8c7d4
-- Delete removal # 253048	ae066034-8966-4fec-acb4-5f7620353711
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253048
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253048
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253048
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253048
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253048
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253048
	and delete_sw = 'N' ;	
	
-- 27)
-- Case ID: 211030012115
-- Client ID: 200809311 (Saniyah Mullen) - 8c89797f-89cd-419b-b33a-931471a75012
-- Delete removal # 253038	3686edd1-24c5-41fc-821d-caa0108998bf
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253038
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253038
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253038
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253038
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253038
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253038
	and delete_sw = 'N' ;	
	
-- 28)
-- Case ID: 211030011378
-- Client ID: 200813290 (Jacinta Brito Bernal) - ab7cbd4c-930e-4975-ab5c-072a7e9a0e96 
-- Delete removal # 252874	1e4d14b0-9b12-475b-a9c9-2b17125a96a2
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252874
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 252874
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252874
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252874
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252874
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 252874
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '8bf5a601-8f60-4246-9cc8-e43f1f97a499'
	and personid = 'ab7cbd4c-930e-4975-ab5c-072a7e9a0e96'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-10-05 00:00:00',
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = '8bf5a601-8f60-4246-9cc8-e43f1f97a499'
	and personid = 'ab7cbd4c-930e-4975-ab5c-072a7e9a0e96'
	and programkey = 'OOH'
	and activeflag = 1 ;


-- 29)
-- Case ID: 211030011520
-- Client ID: 200818792 (Tay'shawn Lee) - 3768733e-2b1d-42d9-a969-0acda9188b5f
-- Delete removal # 252923	1d6f07aa-4278-44b2-8786-0beb95e0bf70
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252923
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 252923
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252923
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252923
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252923
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 252923
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'f56dcf15-3282-4711-807a-7fff93ed94bb'
	and personid = '3768733e-2b1d-42d9-a969-0acda9188b5f'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-10-13 00:00:00',
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = 'f56dcf15-3282-4711-807a-7fff93ed94bb'
	and personid = '3768733e-2b1d-42d9-a969-0acda9188b5f'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
	
-- 30)
-- Case ID: 211030011520
-- Client ID: 200818797 (Tre Lee) - 7d7611c5-f201-418b-ae77-dd5f2f70c435
-- Delete removal # 252922	22a12e8f-9252-4137-bb72-68c39d421e4c
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252922
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 252922
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252922
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252922
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252922
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 252922
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '86bc0d43-047b-462a-8c21-76d3ed988405'
	and personid = '7d7611c5-f201-418b-ae77-dd5f2f70c435'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-10-13 00:00:00',
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = '86bc0d43-047b-462a-8c21-76d3ed988405'
	and personid = '7d7611c5-f201-418b-ae77-dd5f2f70c435'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 31)
-- Case ID: 3122284
-- Client ID: 200827461 (Sabreon Lee Jones) - 615dab84-837a-4e76-b8d1-b62b5d7437e9
-- Delete removal # 253039	4a707265-450c-4e03-bbb0-9a5b2f653bf6
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253039
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253039
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253039
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253039
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253039
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253039
	and delete_sw = 'N' ;	


-- 32)
-- Case ID: 211030012660
-- Client ID: 200839712 (Ezekiel Brooks) - a4dfc506-ba66-4b19-b21b-42f8128f1d5a
-- Delete removal # 253325	0ce64e49-dae3-4819-a036-671e7fb637c1
-- IV-E and Active OOH  - No associated placements


select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253325
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253325
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253325
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253325
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253325
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253325
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '1b01f3f6-bdbe-4eb2-a22c-eacadb9d0b9e'
	and personid = 'a4dfc506-ba66-4b19-b21b-42f8128f1d5a'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-12-08 00:00:00',
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = '1b01f3f6-bdbe-4eb2-a22c-eacadb9d0b9e'
	and personid = 'a4dfc506-ba66-4b19-b21b-42f8128f1d5a'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 33)
-- Case ID: 3257225
-- Client ID: 200841759 (Janiyah Corina	Gunn) - 0a5d33d8-ca6d-4ea2-9f81-9ac721e408bd
-- Delete removal # 253226	0068a5b8-d0ae-44f8-9338-c19e4bd53e04
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253226
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 253226
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253226
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253226
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253226
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 253226
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'b9ffe4a5-dde0-4610-9617-d7d9e86802be'
	and personid = '0a5d33d8-ca6d-4ea2-9f81-9ac721e408bd'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-12-07 00:00:00',
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = 'b9ffe4a5-dde0-4610-9617-d7d9e86802be'
	and personid = '0a5d33d8-ca6d-4ea2-9f81-9ac721e408bd'
	and programkey = 'OOH'
	and activeflag = 1 ;

-- 34)
-- Case ID: 211030011592
-- Client ID: 200816272 (Skylar Gaithers) - 2d1ccafd-9ba4-47d4-88ab-7112198abcd1
-- Delete removal # 252934	586565a8-499b-4cdc-8634-95665eebe892
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252934
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
	rm.updatedby = 'CDM-24331_R3',
	rm.updatedon = now()
where rm.removalid = 252934
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
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252934
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R3',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252934
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252934
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R3'
where removal_id = 252934
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'ed5aeea4-df43-40a6-905a-05634fcd9341'
	and personid = '2d1ccafd-9ba4-47d4-88ab-7112198abcd1'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-10-04 00:00:00',
	updatedby = 'CDM-24331_R3',
	updatedon = now() 		
where personprogramid = 'ed5aeea4-df43-40a6-905a-05634fcd9341'
	and personid = '2d1ccafd-9ba4-47d4-88ab-7112198abcd1'
	and programkey = 'OOH'
	and activeflag = 1 ;
