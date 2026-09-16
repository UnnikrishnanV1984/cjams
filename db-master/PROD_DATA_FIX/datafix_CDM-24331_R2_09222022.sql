-- CDM-24331 - Duplicate removals
/*
-- Issue Description: Datafix to remove the Duplicate Removals
*/

-- 1)
-- Case ID: 3100646 
-- Client ID: 1603242 (SERENITY LYNN BUTLER) b8d925e6-6b39-4adb-9ecc-37561bf57913
-- Delete removal 253473 - 210b63ca-e7eb-47b5-bc9a-e4f86fa335a5
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253473
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253473
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
						where removalid = 253473
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253473
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253473
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253473
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'e282360e-595e-48ef-ba27-47726c44b5fa'
	and personid = 'b8d925e6-6b39-4adb-9ecc-37561bf57913'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-01-21 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = 'e282360e-595e-48ef-ba27-47726c44b5fa'
	and personid = 'b8d925e6-6b39-4adb-9ecc-37561bf57913'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 2)
-- Case ID: 3242638
-- Client ID: 1660927 (SHAYNE J	GARRETT) - e0888ed1-3fd3-477d-8fef-2199969c3870
-- Delete removal # 253466	919c4564-a42d-4e14-9883-7bc603afa283
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253466
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253466
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
						where removalid = 253466
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253466
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253466
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253466
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '47ab28e4-7e38-4db1-82a4-c046b1040434'
	and personid = 'e0888ed1-3fd3-477d-8fef-2199969c3870'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-01-25 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = '47ab28e4-7e38-4db1-82a4-c046b1040434'
	and personid = 'e0888ed1-3fd3-477d-8fef-2199969c3870'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- 3)
-- Case ID: 221030014801
-- Client ID: 1697740 (KNIKYA DIMISHA BRAND) - ed656d05-1687-4a47-baaf-adc9dc989109
-- Delete removal # 253681	ec8f9965-601d-4d80-a6b0-2403836162be
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253681
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253681
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
						where removalid = 253681
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253681
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253681
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253681
	and delete_sw = 'N' ;	
	
-- 4)
-- Case ID: 3127828
-- Client ID: 1709531 (KENIYA HAYWOOD) - db1bb8d6-55cc-4a1e-8bdb-2d2ea931f9a2
-- Delete removal # 253536	4332c7f7-2dfd-4ab4-848f-0b3cd4b15a9c
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253536
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253536
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
						where removalid = 253536
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253536
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253536
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253536
	and delete_sw = 'N' ;	
	
-- 5)
-- Case ID: 211030011468
-- Client ID: 2274835 (ALIESHA L HENRY) - 20b7e749-a534-4471-ad55-61792082cea1
-- Delete removal # 253670	ae007ae8-a801-4a2c-b4eb-2119027320ed
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253670
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253670
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
						where removalid = 253670
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253670
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253670
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253670
	and delete_sw = 'N' ;	
	
-- 6)
-- Case ID: 211030009860
-- Client ID: 3082561 (SACRED SUSAYE' SMITH) - 91b2dba6-7fa4-48b3-b6dd-63c284124dbc
-- Delete removal # 253608	e38f954e-bbbd-4bf3-9398-a26b852cad55
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253608
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253608
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
						where removalid = 253608
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253608
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253608
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253608
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'cccd4e8b-cddc-4801-95a7-d13c9b5d72d5'
	and personid = '91b2dba6-7fa4-48b3-b6dd-63c284124dbc'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-02-28 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = 'cccd4e8b-cddc-4801-95a7-d13c9b5d72d5'
	and personid = '91b2dba6-7fa4-48b3-b6dd-63c284124dbc'
	and programkey = 'OOH'
	and activeflag = 1 ;


-- 7)
-- Case ID: 3197855
-- Client ID: 3211916 (Jah'sherra STOKES) - cd0b7d3d-cbbf-48da-badd-48ecbb6aab3a
-- Delete removal # 253616	90fd9a9e-d4af-458b-a12f-e45f59602c34
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253616
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253616
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
						where removalid = 253616
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253616
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253616
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253616
	and delete_sw = 'N' ;	

	
-- 8)
-- Case ID: 
-- Client ID: 3307637 (DARNELL LEVY) - b535e4df-5c16-4012-982d-cac551e24ca0
-- Delete removal # 253873	cdfc5fcb-ef86-4269-94e7-9d2366413c69
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253873
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253873
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
						where removalid = 253873
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253873
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253873
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253873
	and delete_sw = 'N' ;	
	
-- 9)
-- Case ID: 3113422
-- Client ID: 3453483 (ZYRIHANNA THOMPSON) - f08b4139-7b2f-43d2-a308-301ef0c9eb60
-- Delete removal # 253564	4ca90c97-9e8b-489b-8a7a-4edfd807d9cf
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253564
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253564
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
						where removalid = 253564
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253564
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253564
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253564
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'ea80c171-2dc4-4b66-99be-5e72689cb0f2'
	and personid = 'f08b4139-7b2f-43d2-a308-301ef0c9eb60'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-02-16 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = 'ea80c171-2dc4-4b66-99be-5e72689cb0f2'
	and personid = 'f08b4139-7b2f-43d2-a308-301ef0c9eb60'
	and programkey = 'OOH'
	and activeflag = 1 ;


-- 10)
-- Case ID: 3303002
-- Client ID: 3606689 (BRIONNA WADDELL) - b59e6517-e6dd-4f83-b600-0c4e751e6881
-- Delete removal # 253920	fd0384e8-e881-4a1b-9496-b75402fe80d1
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253920
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253920
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
						where removalid = 253920
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253920
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253920
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253920
	and delete_sw = 'N' ;	
	
-- 11)
-- Case ID: 221030014597
-- Client ID: 3776951 (TISEAN BLAND) - 613589ac-f736-46ef-a0f2-c1b3f066f46d
-- Delete removal # 253629	a92cc45f-3926-43f8-9972-09aa762d3324
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253629
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253629
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
						where removalid = 253629
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253629
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253629
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253629
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '48de82bd-5fb2-42e6-b702-ae2bff70a9f9'
	and personid = '613589ac-f736-46ef-a0f2-c1b3f066f46d'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-03-03 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = '48de82bd-5fb2-42e6-b702-ae2bff70a9f9'
	and personid = '613589ac-f736-46ef-a0f2-c1b3f066f46d'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 12)
-- Case ID: 3127423
-- Client ID: 3811013 (ANDREW GATTIS) - d2be64f7-958d-43ef-8c6c-1fb5d16370ec
-- Delete removal # 253714	d97ef031-d59d-410d-bae0-d2972fc31639
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253714
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253714
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
						where removalid = 253714
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253714
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253714
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253714
	and delete_sw = 'N' ;	

-- 13)
-- Case ID: 221030015048
-- Client ID: 4182218 (TROYVALE HOBSON) - b7cb39a5-0586-42b3-8f26-f37dae686b4a
-- Delete removal # 253747	5e771bab-ad59-41e9-9a62-d3bd12cdefb1
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253747
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253747
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
						where removalid = 253747
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253747
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253747
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253747
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'e250f462-36c2-4ddc-b53b-670298ae829e'
	and personid = 'b7cb39a5-0586-42b3-8f26-f37dae686b4a'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-03-22 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = 'e250f462-36c2-4ddc-b53b-670298ae829e'
	and personid = 'b7cb39a5-0586-42b3-8f26-f37dae686b4a'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- Delete duplicate 
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '00b64bf3-61c7-4a5d-a9c3-7f6c0d137220'
	and personid = 'b7cb39a5-0586-42b3-8f26-f37dae686b4a'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = '00b64bf3-61c7-4a5d-a9c3-7f6c0d137220'
	and personid = 'b7cb39a5-0586-42b3-8f26-f37dae686b4a'
	and programkey = 'OOH'
	and activeflag = 1 ;

-- 14)
-- Case ID: 3291021
-- Client ID: 4271458 (JA'KYIA M MOORE) - e34b13b5-ee92-4f04-ae9e-dbf4c2c3b516
-- Delete removal # 253505	3a72b671-4222-45e6-a4ce-009a550c8437
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253505
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253505
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
						where removalid = 253505
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253505
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253505
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253505
	and delete_sw = 'N' ;
	
-- 15)
-- Case ID: 3284953
-- Client ID: 4284996 (NAHMIR ALEXANDER) - 6ae6faf6-76e2-4573-9cff-f8b3be2deb62
-- Delete removal # 252849	095e0e42-afab-43f6-8c29-ad378a35ce75
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252849
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 252849
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
						where removalid = 252849
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 252849
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252849
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 252849
	and delete_sw = 'N' ;
	
-- 16)
-- Case ID: 221030014320
-- Client ID: 4306762 (ALICIA STANGE) - 08df9b62-ec31-4ac9-b8d5-8185d0eafa32
-- Delete removal # 253585	14d298c3-6425-4b61-a8eb-510097da03e4
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253585
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253585
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
						where removalid = 253585
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253585
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253585
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253585
	and delete_sw = 'N' ;
	
-- 17)
-- Case ID: 221030014495
-- Client ID: 4389869 (DEMIA FLOOD) - 92e298db-25f7-4423-94ec-95299b67ea51
-- Delete removal # 253603	d46d12af-dedb-4700-85f6-e271451fde84
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253603
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253603
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
						where removalid = 253603
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253603
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253603
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253603
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '43ad25e7-2bb1-4aa7-b988-05307cb80c98'
	and personid = '92e298db-25f7-4423-94ec-95299b67ea51'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-02-25 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = '43ad25e7-2bb1-4aa7-b988-05307cb80c98'
	and personid = '92e298db-25f7-4423-94ec-95299b67ea51'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- Delete duplicate 
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'b50a8229-3fc0-44ba-a253-3c8ce290a66b'
	and personid = '92e298db-25f7-4423-94ec-95299b67ea51'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = 'b50a8229-3fc0-44ba-a253-3c8ce290a66b'
	and personid = '92e298db-25f7-4423-94ec-95299b67ea51'
	and programkey = 'OOH'
	and activeflag = 1 ;	


-- 18)
-- Case ID: 3219786
-- Client ID: 4403040 (DAYLIN DEAVON JOHNSON) - 443ce7d9-5516-494c-9a06-31314201d38b
-- Delete removal # 253491	d594c8fc-2f89-4d74-88c7-d38b06f69718
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253491
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253491
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
						where removalid = 253491
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253491
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253491
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253491
	and delete_sw = 'N' ;	
	
-- 19)
-- Case ID: 2020022302270
-- Client ID: 4409678 (SABRINA CHARLOTTE CARPENTER) - 37abc3f3-2320-4d77-81fd-2adfa762adec
-- Delete removal # 253782	51d04934-c1e1-4f0f-952a-dd4215fbe77c
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253782
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253782
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
						where removalid = 253782
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253782
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253782
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253782
	and delete_sw = 'N' ;	
	
-- 20)
-- Case ID: 221030015435
-- Client ID: 4424656 (LAZARUS TAYLOR) - 3c8de4a7-9606-40f3-8b4e-6829e2d13c42
-- Delete removal # 253917	943e54cc-617c-426e-8dae-3adeb2c6ccc6
--					253919	284bde5b-dbc7-44f7-92c1-fe738fd12648	
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253917
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253917
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
						where removalid = 253917
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253917
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253917
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253917
	and delete_sw = 'N' ;	
	

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253919
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253919
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
						where removalid = 253919
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253919
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253919
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253919
	and delete_sw = 'N' ;	
	
-- 21)
-- Case ID: 3305334
-- Client ID: 4457414 (HARMONY MAYES) - 87974304-b561-4d64-9e08-9747d775fdfc 
-- Delete removal # 253900	9827829d-c45b-4efb-a5e3-4ebed5d2b12b
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253900
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253900
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
						where removalid = 253900
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253900
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253900
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253900
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'bf30261c-55c2-46a8-a5cc-42daa4756ae5'
	and personid = '87974304-b561-4d64-9e08-9747d775fdfc'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-04-25 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = 'bf30261c-55c2-46a8-a5cc-42daa4756ae5'
	and personid = '87974304-b561-4d64-9e08-9747d775fdfc'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- Delete duplicate 
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '56766a7e-0c59-4b57-9587-61d8506d21f5'
	and personid = '87974304-b561-4d64-9e08-9747d775fdfc'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = '56766a7e-0c59-4b57-9587-61d8506d21f5'
	and personid = '87974304-b561-4d64-9e08-9747d775fdfc'
	and programkey = 'OOH'
	and activeflag = 1 ;	


-- 22)
-- Case ID: 221030013946
-- Client ID: 4469205 (ZAHARRAH-LYANN FRANCOIS) - 24768ed8-076e-4008-9617-faa5436ef401
-- Delete removal # 253510	2c5d7aa3-46e4-4af0-b065-8aac405bc798
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253510
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253510
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
						where removalid = 253510
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253510
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253510
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253510
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'a6d524f2-1ee3-48cb-9ae9-1f2a6bace715'
	and personid = '24768ed8-076e-4008-9617-faa5436ef401'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-02-02 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = 'a6d524f2-1ee3-48cb-9ae9-1f2a6bace715'
	and personid = '24768ed8-076e-4008-9617-faa5436ef401'
	and programkey = 'OOH'
	and activeflag = 1 ;


-- 23)
-- Case ID: 221030015435
-- Client ID: 200149030 (FREDA TAYLOR) - 799519aa-fb2d-4a34-aa6b-c2beea8abe0a
-- Delete removal # 253918	b2bafd4b-787a-44f8-95c1-4cabde3a94c7
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253918
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253918
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
						where removalid = 253918
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253918
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253918
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253918
	and delete_sw = 'N' ;	
	
-- 24)
-- Case ID: 221030014641
-- Client ID: 200641953 (Caydence Lee Cash Sell) - 59cc936b-2914-4e84-b9de-a9e4ece32373
-- Delete removal # 253634	5f614611-e7b9-4cf7-b8ae-8eabf2502a2f
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253634
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253634
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
						where removalid = 253634
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253634
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253634
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253634
	and delete_sw = 'N' ;	
	
-- 25)
-- Case ID: 211030009218
-- Client ID: 200780829 (Diamond Locklear) - e2f06d09-4e31-4ab9-81bc-25586720fd71
-- Delete removal # 253884	2de493a2-4b60-4fa4-b117-844893363e7d
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253884
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253884
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
						where removalid = 253884
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253884
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253884
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253884
	and delete_sw = 'N' ;	

-- 26)
-- Case ID: 3245835
-- Client ID: 200784105 (Meadow	Murray) - b711359d-4262-4077-86e5-a88c4064a48a
-- Delete removal # 253582	a2fab772-e36d-4293-bbb2-2ed12de515ed
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253582
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253582
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
						where removalid = 253582
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253582
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253582
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253582
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'a3afd97a-27b4-442c-a686-9c0ea9c7079b'
	and personid = 'b711359d-4262-4077-86e5-a88c4064a48a'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-02-18 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = 'a3afd97a-27b4-442c-a686-9c0ea9c7079b'
	and personid = 'b711359d-4262-4077-86e5-a88c4064a48a'
	and programkey = 'OOH'
	and activeflag = 1 ;



-- 27)
-- Case ID: 221030013570
-- Client ID: 200832706 (Symphony Lumpkin) - 0b9b6f00-f262-4efa-973f-c3fbab29c9bb
-- Delete removal # 253430	6a545330-f131-42b3-98d3-037c0b7071db
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253430
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253430
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
						where removalid = 253430
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253430
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253430
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253430
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'd69b6ce1-4c49-4d29-a0de-793874f14fa8'
	and personid = '0b9b6f00-f262-4efa-973f-c3fbab29c9bb'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-01-12 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = 'd69b6ce1-4c49-4d29-a0de-793874f14fa8'
	and personid = '0b9b6f00-f262-4efa-973f-c3fbab29c9bb'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 28)
-- Case ID: 221030013305
-- Client ID: 200852313	(Kaylynn Peay) - 284301fa-f36e-4f2e-85a3-26f5a94bf613
-- Delete removal # 253361	4bab065e-51fb-4d62-a9ba-b41108ee4359
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253361
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253361
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
						where removalid = 253361
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253361
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253361
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253361
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '46bf1511-4d86-45d3-aa1a-cf19316cd7df'
	and personid = '284301fa-f36e-4f2e-85a3-26f5a94bf613'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-01-04 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = '46bf1511-4d86-45d3-aa1a-cf19316cd7df'
	and personid = '284301fa-f36e-4f2e-85a3-26f5a94bf613'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 29)
-- Case ID: 221030013620
-- Client ID: 200855064	(samir McGlone) - f41cc82f-f64b-459e-9090-a4dc939c9f0f
-- Delete removal # 253440	d59b2bf7-2e6c-48f1-ba39-ced1917f4e0b
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253440
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253440
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
						where removalid = 253440
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253440
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253440
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253440
	and delete_sw = 'N' ;
	
-- 30)
-- Case ID: 221030015387
-- Client ID: 200858224	(Kehlani Varsanyi) - 52e8897f-0f4b-4885-839a-8ece049a577b
-- Delete removal # 253822	4035cca6-81ff-4d2d-858f-1cff9228bddd
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253822
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253822
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
						where removalid = 253822
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253822
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253822
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253822
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'cf8b9eaf-25cd-49c9-8b58-736e8f424cf9'
	and personid = '52e8897f-0f4b-4885-839a-8ece049a577b'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-04-07 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = 'cf8b9eaf-25cd-49c9-8b58-736e8f424cf9'
	and personid = '52e8897f-0f4b-4885-839a-8ece049a577b'
	and programkey = 'OOH'
	and activeflag = 1 ;

-- 31)
-- Case ID: 221030014600
-- Client ID: 200876081 (Tariah Kajah Webster) - 55ad6771-0e04-488f-ba7b-4ab2cca1e063
-- Delete removal # 253639	67ce1053-41a4-4862-b226-08470b1e9954
-- IV-E and Active OOH  - No associated placements
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253639
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253639
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
						where removalid = 253639
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253639
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253639
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253639
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '3f989502-bdb1-4441-ab35-60264c58e0d8'
	and personid = '55ad6771-0e04-488f-ba7b-4ab2cca1e063'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-03-02 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = '3f989502-bdb1-4441-ab35-60264c58e0d8'
	and personid = '55ad6771-0e04-488f-ba7b-4ab2cca1e063'
	and programkey = 'OOH'
	and activeflag = 1 ;


-- 32)
-- Case ID: 221030015586
-- Client ID: 200878074 (Kayson Legend Flythe) - 66036efb-b336-483d-a5be-0385ddda1d8c
-- Delete removal # 253864	529dccd8-30b3-4e70-8755-618f4c91a4b2
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253864
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253864
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
						where removalid = 253864
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253864
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253864
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253864
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '1360138b-fff5-4d94-94a3-25fd01f79d48'
	and personid = '66036efb-b336-483d-a5be-0385ddda1d8c'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-04-13 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = '1360138b-fff5-4d94-94a3-25fd01f79d48'
	and personid = '66036efb-b336-483d-a5be-0385ddda1d8c'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 33)
-- Case ID: 221030015529
-- Client ID: 200891110 (Owen Yu) -	cf17b8c9-548b-4a6c-abbb-3fbb8f8e2dba
-- Delete removal # 253853	ad891e64-487e-4c87-8ce5-7ad7fefac6bd
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253853
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253853
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
						where removalid = 253853
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253853
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253853
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253853
	and delete_sw = 'N' ;	
	
-- 34)
-- Case ID: 3271616
-- Client ID: 200893474	(Leah Caroline) - b0274ce6-5a39-4023-89a7-4a0e476a9ce4
-- Delete removal # 253889	No	e76b1944-0ea9-45dc-9353-f1b3ead2faaa
--					253888	No	5a394ab5-4aeb-4907-997b-6a4412e679bd
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253889
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253889
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
						where removalid = 253889
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253889
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253889
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253889
	and delete_sw = 'N' ;	
	

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253888
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253888
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
						where removalid = 253888
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253888
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253888
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253888
	and delete_sw = 'N' ;	
	
	
-- 35)
-- Case ID: 3283628
-- Client ID: 200895441	(Lamar Elijah Farmer) - e2527014-b6d3-4ae5-a497-9b522b58897e
-- Delete removal # 253837	31f69699-1153-44d2-9252-092e937b5a43
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253837
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253837
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
						where removalid = 253837
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253837
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253837
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253837
	and delete_sw = 'N' ;	

-- 36)
-- Case ID: 3283628
-- Client ID: 200895442	(Harpor	Renee Farmer) - 99b109bd-a873-4ac5-b508-cd4b6cde54ee
-- Delete removal # 253838	f75d68da-85a0-4f36-8f6b-e7f4bfa9f55a
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253838
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253838
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
						where removalid = 253838
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253838
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253838
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253838
	and delete_sw = 'N' ;	
	
-- 37)
-- Case ID: 221030015866
-- Client ID: 200902576 (Kanijah Johnson) - 767aa315-a8e7-4cb1-825d-c53f1c6cf421
-- Delete removal # 253945	f235338c-2d54-47ec-b4af-a2846b14b31d
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253945
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253945
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
						where removalid = 253945
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253945
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253945
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253945
	and delete_sw = 'N' ;	
	
-- 38)
-- Case ID: 221030015866
-- Client ID: 200902577 (Lacedlles Bradshaw) - b4d6bd2d-67df-414a-a98a-d3ba219d3ec7
-- Delete removal # 253946	9e6e54ac-406b-498e-98df-316165b9bf9b
-- IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253946
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
	rm.updatedby = 'CDM-24331_R2',
	rm.updatedon = now()
where rm.removalid = 253946
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
						where removalid = 253946
					  )			
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24331_R2',
	ro.updatedon = now()	
where ro.eventcode = 'CHRR'
	and ro.objectid = ( select intakeservreqchildremovalid::character varying
							from intakeservreqchildremoval 
						where removalid = 253946
					  )			
	and ro.activeflag = 1 ;	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253946
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24331_R2'
where removal_id = 253946
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'cdea19f3-56ab-4e7d-9c84-8b62356215c9'
	and personid = 'b4d6bd2d-67df-414a-a98a-d3ba219d3ec7'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-04-28 00:00:00',
	updatedby = 'CDM-24331_R2',
	updatedon = now() 		
where personprogramid = 'cdea19f3-56ab-4e7d-9c84-8b62356215c9'
	and personid = 'b4d6bd2d-67df-414a-a98a-d3ba219d3ec7'
	and programkey = 'OOH'
	and activeflag = 1 ;
