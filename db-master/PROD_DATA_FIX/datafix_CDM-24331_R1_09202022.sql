-- CDM-24331 - Duplicate removals
/*
-- Issue Description: 
    Datafix to remove the Duplicate Removals
*/

-- 1)
-- Case ID: 3126614
-- Client ID: 2495774 (DYLAN SAMUEL EDWARDS) - 924b56f7-c23b-4531-ad5d-2b76f7fe5719
-- Delete removal # 254365 - 36da4567-9fac-4f40-b087-e1c90a050326
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254365
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254365
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
						where removalid = 254365
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254365
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254365
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254365
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '71946ddf-e383-4f18-af2d-684c495cc74e'
	and personid = '924b56f7-c23b-4531-ad5d-2b76f7fe5719'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-17 00:00:00',
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = 'f867dc49-59e0-4a21-9a45-b447646c43ad'
	and personid = '924b56f7-c23b-4531-ad5d-2b76f7fe5719'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 2)
-- Case ID: 3226907
-- Client ID: 3105220 (JOHN PAUL GALLAGI) -	2982dd8c-1a95-43bf-a958-a1c48b11f95a
-- Delete removal # 254416	e96b83b5-f102-44ca-bbec-5544a947bbab
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254416
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254416
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
						where removalid = 254416
					  )			
	and ro.activeflag = 1 ;	
	

	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254416
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254416
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254416
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '71946ddf-e383-4f18-af2d-684c495cc74e'
	and personid = '2982dd8c-1a95-43bf-a958-a1c48b11f95a'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-28 00:00:00',
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = '3cc7f19e-1b0d-4d54-a571-9165e054ec83'
	and personid = '2982dd8c-1a95-43bf-a958-a1c48b11f95a'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- 3)
-- Case ID: 3266217
-- Client ID: 3348096 (KEITH WEBER) - f962a8e3-e53a-403b-a82f-f3f67defaea7
-- Delete removal # 254064	f89b237c-4139-41ee-b9e7-8fdab3dcbae1
-- IV-E and Active OOH  - No associated placements


select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254064
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254064
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
						where removalid = 254064
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254064
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254064
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254064
	and delete_sw = 'N' ;	


-- 4)
-- Case ID: 3266217
-- Client ID: 3354346 (VICTORIA LUZELLE SPRAGGINS) - 3a150e6a-4873-40b2-af26-250f086e7bc1
-- Delete removal # 253936	cf60c9e9-72cd-4481-9076-f243691e2e17
-- No associated placements, IV-E and Active OOH

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253936
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 253936
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
		

-- 5)
-- Case ID: 3268141
-- Client ID: 3502578 (DAMARA HASTY) - 8ebb7c42-678c-484c-8ef6-4e98e0ee8100
-- Delete removal # 254372	23199946-57b6-4884-bba6-80146abe527b
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254372
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254372
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
						where removalid = 254372
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254372
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254372
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254372
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '5dead835-a181-4f8a-9ab4-15b9e9b43e3f'
	and personid = '8ebb7c42-678c-484c-8ef6-4e98e0ee8100'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-10 00:00:00',
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = '5dead835-a181-4f8a-9ab4-15b9e9b43e3f'
	and personid = '8ebb7c42-678c-484c-8ef6-4e98e0ee8100'
	and programkey = 'OOH'
	and activeflag = 1 ;

-- 6)
-- Case ID: 3226907
-- Client ID: 3545868 (JACOB ALLEN GALLAGI) - 5cd3957e-e6e6-4f74-acd6-e719129c88a1
-- Delete removal # 254417	21e732e1-5b91-440f-91f0-11b6b70f07a0
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254417
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254417
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
						where removalid = 254417
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254417
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254417
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254417
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'dc4681e5-cb18-4714-aadd-23ea10330570'
	and personid = '5cd3957e-e6e6-4f74-acd6-e719129c88a1'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-28 00:00:00',
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = 'dc4681e5-cb18-4714-aadd-23ea10330570'
	and personid = '5cd3957e-e6e6-4f74-acd6-e719129c88a1'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 7)
-- Case ID: 3239761 
-- Client ID: 3694738 (ZION L BERRYMAN) - d7f5f99a-4728-4362-9bea-18ef5bb489b6
-- Delete removal # 254044	5a93272e-400f-4694-b172-b22499c9960b
-- No associated placements, IV-E and Active OOH

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254044
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254044
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
		
-- 8)
-- Case ID: 3226907 
-- Client ID: 3842015 (KAYLEE NICOLE WELTY) - 9d6255c4-0d0c-4968-9edb-584b52e17f6a
-- Delete removal # 254419	3a129d34-b272-4f16-bb45-6f4dcf8f8a66
-- IV-E and Active OOH  - No associated placements
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254419
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254419
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
						where removalid = 254419
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254419
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254419
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254419
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'f6fb0a7b-5d9d-47d7-8f49-247ebe4b50a0'
	and personid = '9d6255c4-0d0c-4968-9edb-584b52e17f6a'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-28 00:00:00',
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = 'f6fb0a7b-5d9d-47d7-8f49-247ebe4b50a0'
	and personid = '9d6255c4-0d0c-4968-9edb-584b52e17f6a'
	and programkey = 'OOH'
	and activeflag = 1 ;


-- 9)
-- Case ID: 3284382
-- Client ID: 3907165 (FERNANDO EMILIANO WALL) - 14968a57-8b7c-478c-9582-867179af3695
-- Delete removal # 254011	1d9ecbfd-7cbd-4315-9578-eaef47f5e83e
-- No associated placements, IV-E and Active OOH

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254011
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254011
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

-- 10)
-- Case ID: 3266217
-- Client ID: 3941064 (MICHAEL WEBER) - ebe402de-c1ea-4074-af46-4662b3c468fc
-- Delete removal # 254063	bc08ca94-30e6-4e55-bdd1-f49cfcfb9941
-- No associated placements, IV-E and Active OOH

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254063
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254063
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
		
-- 11)
-- Case ID: 3139039
-- Client ID: 3994125 (TANIYA C CAMPBELL) - 4b376125-9643-4815-b52c-bad8f6188bff
-- Delete removal # 254256	e6e3dac7-8775-442c-8322-d9898d12fb22
-- Delete removal # 254132	c7408906-b8d3-4dff-972a-dbc1817990a0
-- No associated placements, IV-E and Active OOH

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid  in ( 254256, 254132 )
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid  in ( 254256, 254132 )
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
		

-- 12)
-- Case ID: 221030016480
-- Client ID: 4080693 (MALIYA ROSS) - cf1a5228-0641-4d79-9657-4e8bedd34adc
-- Delete removal # 254160	0487d038-6091-45d6-b291-18d4e2d6ddf1
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254160
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254160
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
						where removalid = 254160
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254160
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254160
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254160
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'bc9ce26c-498f-43e7-ad79-015826c6adc4'
	and personid = 'cf1a5228-0641-4d79-9657-4e8bedd34adc'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-06-03 00:00:00',
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = 'bc9ce26c-498f-43e7-ad79-015826c6adc4'
	and personid = 'cf1a5228-0641-4d79-9657-4e8bedd34adc'
	and programkey = 'OOH'
	and activeflag = 1 ;


-- 13)
-- Case ID: 3226907
-- Client ID: 4332715 (CARLY WELTY) - 92a1efb6-661f-41dd-93ab-c825d1ded01c
-- Delete removal # 254418	7274c88d-4548-4f81-acab-d95215eab048
-- IV-E and Active OOH  - No associated placements
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254418
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254418
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
						where removalid = 254418
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254418
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254418
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254418
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'c7c93a0b-a3f1-4168-b517-9965971a44a0'
	and personid = '92a1efb6-661f-41dd-93ab-c825d1ded01c'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-28 00:00:00',
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = 'c7c93a0b-a3f1-4168-b517-9965971a44a0'
	and personid = '92a1efb6-661f-41dd-93ab-c825d1ded01c'
	and programkey = 'OOH'
	and activeflag = 1 ;

-- 14)
-- Case ID: 3195517
-- Client ID: 200006343 (Avery James Dotson) - 6af53e2e-6ea3-4b33-8427-f111c5a4dee4
-- Delete removal # 254317	20a88e68-df82-4e1f-ac96-cb0924781f6a
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254317
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254317
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
						where removalid = 254317
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254317
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254317
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254317
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '6700098b-8fce-47fa-914c-fb174aa44b09'
	and personid = '6af53e2e-6ea3-4b33-8427-f111c5a4dee4'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-11 00:00:00',
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = '6700098b-8fce-47fa-914c-fb174aa44b09'
	and personid = '6af53e2e-6ea3-4b33-8427-f111c5a4dee4'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 15)
-- Case ID: 202107106563
-- Client ID: 200640530 (Cam'ron Anthony Adams) - 67d3c615-4bcf-4489-b5d6-148b2737ae2a
-- Delete removal # 254303	14732605-f1ca-4ebb-85a9-8b5a64e32025
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254303
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254303
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
						where removalid = 254303
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254303
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254303
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254303
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '5704ec8f-37c2-4152-9176-55898a1574ee'
	and personid = '67d3c615-4bcf-4489-b5d6-148b2737ae2a'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-08 00:00:00',
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = '5704ec8f-37c2-4152-9176-55898a1574ee'
	and personid = '67d3c615-4bcf-4489-b5d6-148b2737ae2a'
	and programkey = 'OOH'
	and activeflag = 1 ;


-- 16)
-- Case ID: 2021012407658
-- Client ID: 200661000	(Sai'mira Saunders) - 50c2b399-3d21-4828-a9b7-8a11bad47d2b 
-- Delete removal # 254473	a333c7ca-ef5b-4eb9-84e5-a986f7075b66
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254473
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254473
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
						where removalid = 254473
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254473
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254473
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254473
	and delete_sw = 'N' ;	


-- 17)
-- Case ID: 3131299
-- Client ID: 200774719 (Wayne A Robinson) - 09420041-9bec-4d71-8617-7c845665ff5c
-- Delete removal # 254373	7be4021d-4bed-4b5c-83bd-9b108dab29fb
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254373
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254373
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
						where removalid = 254373
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254373
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254373
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254373
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '3d71ee3a-82b6-4fef-9129-b0832e16fbf2'
	and personid = '09420041-9bec-4d71-8617-7c845665ff5c'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-19 00:00:00',
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = '3d71ee3a-82b6-4fef-9129-b0832e16fbf2'
	and personid = '09420041-9bec-4d71-8617-7c845665ff5c'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 18)
-- Case ID: 211030009143
-- Client ID: 200779715 (Meiko Vodopia-Miro) - 74658af4-d816-4067-8622-6d58cbd0e6a5 
-- Delete removal # 254378	ac33b4d7-d43b-4bd3-aa76-b6103d5ac6ca
-- No associated placements, IV-E and Active OOH

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254378
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254378
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
		

-- 19)
-- Case ID: 211030008744
-- Client ID: 200786725 (Mya Brown) - b10e6ccf-7d9f-446d-86d5-b01745b8b089
-- Delete removal # 254341	98957541-aaf9-4ce0-8497-73d704ac9a93
-- IV-E and Active OOH  - No associated placements
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254341
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254341
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
						where removalid = 254341
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254341
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254341
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254341
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '1f2e3e88-6f7a-4bb9-82f0-f7623da6f0dc'
	and personid = 'b10e6ccf-7d9f-446d-86d5-b01745b8b089'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = '1f2e3e88-6f7a-4bb9-82f0-f7623da6f0dc'
	and personid = 'b10e6ccf-7d9f-446d-86d5-b01745b8b089'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 20)
-- Case ID: 202107106563
-- Client ID: 200799145 (D'vaughndre Adams) - b84dc567-515e-4b65-bc0e-41ebd92059d4
-- Delete removal # 254304	3c274116-2a58-44fe-99e1-dbc76c9f9e56
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254304
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254304
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
						where removalid = 254304
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254304
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254304
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254304
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '0f34ab50-59e4-430e-bb22-92e7c3ea63ad'
	and personid = 'b84dc567-515e-4b65-bc0e-41ebd92059d4'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-08 00:00:00',
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = '0f34ab50-59e4-430e-bb22-92e7c3ea63ad'
	and personid = 'b84dc567-515e-4b65-bc0e-41ebd92059d4'
	and programkey = 'OOH'
	and activeflag = 1 ;



-- 21)
-- Case ID: 221030015157
-- Client ID: 200816097 (Jose Martinez Rodriguez) - a590245a-497a-48af-9639-6a8b6046a1e4
-- Delete removal # 253961	44d301be-f2b2-4a34-9724-a87f00eeb132
-- No associated placements, IV-E and Active OOH

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253961
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 253961
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
		

-- 22)
-- Case ID: 221030013277
-- Client ID: 200851435 (Ruth Boutaouakou) - 4ce6f751-f1c7-4c10-85fd-68d47d422687
-- Delete removal # 254288	a0fde3f8-2c84-49fe-b47b-a9a6a15d798d
-- No associated placements, IV-E  & Active OOH

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254288
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254288
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
						where removalid = 254288
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254288
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254288
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254288
	and delete_sw = 'N' ;	


-- 23)
-- Case ID: 221030016439 
-- Client ID: 200872836 (Mylo Rodas) - 5f67c809-c91c-44e3-bf33-2e1210019b11
-- Delete removal # 254121	74f3d270-1b56-4a4f-b436-94677e189f6c
-- IV-E - No associated placements & Active OOH 

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254121
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254121
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
						where removalid = 254121
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254121
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254121
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254121
	and delete_sw = 'N' ;	


-- 24)
-- Case ID: 221030017757
-- Client ID: 200879404	(Isabella Rose Townsend Harryman) - e2161861-8e3f-4fba-a749-0be77ab162e1
-- Delete removal # 254478	dd060836-3c92-402d-8ea3-752d4e893c2a
-- No associated placements, IV-E and Active OOH

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254478
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254478
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
	


-- 25)
-- Case ID: 221030015314
-- Client ID: 200893261 (Logan Gainey) - 93a50564-86d5-455d-a8bc-17e54faafcf0
-- Delete removal # 254193	632caf06-5caa-4a4e-b5d1-437e66e24c7c
-- No associated placements, IV-E and Active OOH

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254193
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254193
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
		

-- 26)
-- Case ID: 221030017645
-- Client ID: 200896281 (Saleem O Salawudeen) - eb87bef6-23f0-4da1-9f8d-0a9ddadc822c
-- Delete removal # 254508	559bfdff-a564-461f-b627-ebd1a7833dea
-- IV-E and Active OOH  - No associated placements
-- Removal was fixed with CDM-24915

-- 27)
-- Case ID: 221030015911
-- Client ID: 200905229	(ROSALEIA BUFORD) - d1c36797-2813-4437-8249-1a8022a2492f
-- Delete removal # 253958	0f561bb5-0e12-4bd5-80b4-35ca3a3dfbb7
-- IV-E - No associated placements and Active OOH 

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253958
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 253958
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
						where removalid = 253958
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253958
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253958
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 253958
	and delete_sw = 'N' ;	

	
-- 28)
-- Case ID: 221030016381
-- Client ID: 200910230	(Tika Z Jensen) - 5803f9da-b1cb-437c-b563-8ad657d439ff
-- Delete removal # 254329	8c426443-d84f-416d-be30-d4a126fc56cb
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254329
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254329
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
						where removalid = 254329
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254329
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254329
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254329
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '870f3ecd-1545-4775-b97d-906a3dbec5a6'
	and personid = '5803f9da-b1cb-437c-b563-8ad657d439ff'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-13 00:00:00',
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = '870f3ecd-1545-4775-b97d-906a3dbec5a6'
	and personid = '5803f9da-b1cb-437c-b563-8ad657d439ff'
	and programkey = 'OOH'
	and activeflag = 1 ;
	



-- 29)
-- Case ID: 221030016213
-- Client ID: 200912256 (Camden King) - a412c379-d85f-41f0-bfff-806229a27140
-- Delete removal # 254065	ef2f1404-51da-44cd-9a87-b43ea767e207
-- IV-E and Active OOH  - No associated placements
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254065
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254065
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
						where removalid = 254065
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254065
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254065
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254065
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '24bdbfbc-cfb7-4b5f-9b1d-f0269807dc97'
	and personid = 'a412c379-d85f-41f0-bfff-806229a27140'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = '24bdbfbc-cfb7-4b5f-9b1d-f0269807dc97'
	and personid = 'a412c379-d85f-41f0-bfff-806229a27140'
	and programkey = 'OOH'
	and activeflag = 1 ;


-- 30)
-- Case ID: 3101158
-- Client ID: 200922064 (Taylor Williams) - 36c89b73-5cbe-47ec-a943-1163a421dfa6
-- Delete removal # 254170	26304152-23b0-4273-85e2-ee598b79b05a
-- No associated placements, IV-E and Active OOH

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254170
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254170
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

-- 31)
-- Case ID: 221030016828
-- Client ID: 200924040 (Junior Akili) - f148e117-94bd-4139-8937-8db27ebfadcf
-- Delete removal # 254213	edcf0d97-05a2-4289-b579-3eda5c51fcfb
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254213
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254213
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
						where removalid = 254213
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254213
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254213
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254213
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'f4735bb2-4707-49ac-bea8-aa41c45d1338'
	and personid = 'f148e117-94bd-4139-8937-8db27ebfadcf'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-06-19 00:00:00',
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = 'f4735bb2-4707-49ac-bea8-aa41c45d1338'
	and personid = 'f148e117-94bd-4139-8937-8db27ebfadcf'
	and programkey = 'OOH'
	and activeflag = 1 ;
	



-- 32)
-- Case ID: 221030016990
-- Client ID: 200926527 (Violetta Esparza) - 981d89bb-1047-4f94-819e-15dcc8cc626d
-- Delete removal # 254255	7d2e2116-c041-4d3b-a870-b69198d9290b
-- No associated placements, IV-E and Active OOH

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254255
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254255
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
						where removalid = 254255
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254255
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254255
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254255
	and delete_sw = 'N' ;	

-- 33)
-- Case ID: 221030016990
-- Client ID: 200926528 (Erik Said Esparza) - 07d5da7b-771a-48c3-a167-662265ed94d6
-- Delete removal # 254254	26b16c79-e4dc-4a15-9dc2-676e44742f5e
-- No associated placements, IV-E and Active OOH

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254254
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254254
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

	
-- 34)
-- Case ID: 221030016999
-- Client ID: 200927710 (Amelia	Sage Carroll) - a926233a-b877-4d00-8d25-f1571e491e64
-- Delete removal # 254464	aece4f58-b594-4428-89c7-6a43d6e152b8
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254464
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254464
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
						where removalid = 254464
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254464
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254464
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254464
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'd564d35d-4d20-4936-a408-a613fceca0f1'
	and personid = 'a926233a-b877-4d00-8d25-f1571e491e64'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = 'd564d35d-4d20-4936-a408-a613fceca0f1'
	and personid = 'a926233a-b877-4d00-8d25-f1571e491e64'
	and programkey = 'OOH'
	and activeflag = 1 ;


-- 35)
-- Case ID: 221030017199
-- Client ID: 200930691	(Malachi Spruill) - b296f448-68b3-4b56-bff8-63ab9e001b5a
-- Delete removal # 254318	847d3686-3649-4606-809b-8a16221f91f9
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254318
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254318
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
						where removalid = 254318
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254318
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254318
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254318
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '85c0a9bf-db2f-4103-ad51-926172f214df'
	and personid = 'b296f448-68b3-4b56-bff8-63ab9e001b5a'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-11 00:00:00',
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = '85c0a9bf-db2f-4103-ad51-926172f214df'
	and personid = 'b296f448-68b3-4b56-bff8-63ab9e001b5a'
	and programkey = 'OOH'
	and activeflag = 1 ;

-- 36)
-- Case ID: 221030017430
-- Client ID: 200935464 (Isabella Brown) - 2810918b-9a9c-4881-ace9-1f26d2b63a2a
-- Delete removal # 254388	58507e6e-3251-4aa3-8818-40de1fc5636e
-- No associated placements, IV-E and Active OOH

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254388
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254388
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
		
	
-- 37)
-- Case ID: 221030017566
-- Client ID: 200938137 (KAIDEN ELIAS JACKSON) - f130a418-862c-41a2-bf51-780bfb2dd944
-- Delete removal # 254429	756812d5-67b7-4103-930b-5345a5742a23
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254429
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
	rm.updatedby = 'CDM-24331_R1',
	rm.updatedon = now()
where rm.removalid = 254429
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
						where removalid = 254429
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R1',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 254429
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254429
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R1'
where removal_id = 254429
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '76937d44-47be-403f-b329-9eeae3820b9d'
	and personid = 'f130a418-862c-41a2-bf51-780bfb2dd944'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-29 00:00:00',
	updatedby = 'CDM-24331_R1',
	updatedon = now() 		
where personprogramid = '76937d44-47be-403f-b329-9eeae3820b9d'
	and personid = 'f130a418-862c-41a2-bf51-780bfb2dd944'
	and programkey = 'OOH'
	and activeflag = 1 ;
