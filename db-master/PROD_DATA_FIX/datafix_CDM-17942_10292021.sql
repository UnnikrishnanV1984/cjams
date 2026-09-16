-- CDM-17942 - Baltimore City Data Corrections for Duplicate Removals
/*
-- Issue Description: 
    Datafix for Baltimore City Data Corrections for Duplicate Removals
	Note: No fix for 200567851	Ashton  Miller as there is an associated placment (voided) with payment	
*/
-- 1)
-- Case ID: 2021011307457
-- Client ID: 4014236 (KALEB FRAZIER) - 856d7d68-488e-4357-88cc-b35e61f02302
-- Removals 
-- 252442	2021-04-22 To 2021-08-09 - c9727105-f719-4e9a-96f2-a2e9dd757c05 (Approved - Delete)
-- 251937	2021-04-22 To 2021-06-29 - 071a16ef-39f4-4712-a345-bb46007fdc85

-- Delete removal # 252442 / IV-E and Active OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252442
	and rm.personid = '856d7d68-488e-4357-88cc-b35e61f02302'
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
	rm.updatedby = 'CDM-17942',
	rm.updatedon = now()
where rm.removalid = 252442
	and rm.personid = '856d7d68-488e-4357-88cc-b35e61f02302'
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
	and ro.objectid  = 'c9727105-f719-4e9a-96f2-a2e9dd757c05'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-17942',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'c9727105-f719-4e9a-96f2-a2e9dd757c05'
	and ro.activeflag = 1 ;
	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252442
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-17942'
where removal_id = 252442
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'f867dc49-59e0-4a21-9a45-b447646c43ad'
	and personid = '856d7d68-488e-4357-88cc-b35e61f02302'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set enddate = startdate,
	activeflag = 0, 
	updatedby = 'CDM-17942',
	updatedon = now() 		
where personprogramid = 'f867dc49-59e0-4a21-9a45-b447646c43ad'
	and personid = '856d7d68-488e-4357-88cc-b35e61f02302'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- 2)
-- Case ID: 2021011307457
-- Client ID: 200171812 (Maziah	Frazier) - a820f353-2490-4cd4-9517-6b755bb067ba
-- Removals 
-- 252493	2021-04-22 To 2021-08-09 - 089659d2-54b5-4baa-ae8d-6e5c13942eeb
-- 251938	2021-04-22 To 2021-07-26 - 02a45bed-a024-4098-8400-86cfcf7ff1b1 (Approved - Delete)

-- Delete removal # 251938 / IV-E and Active OOH and move the associated placements to other removal
select alternateid, placementtypekey, altproviderid, intakeservreqchildremovalid, updatedby, updatedon 
	from placement
where intakeservreqchildremovalid = '02a45bed-a024-4098-8400-86cfcf7ff1b1'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid = '089659d2-54b5-4baa-ae8d-6e5c13942eeb',
	updatedon = now(), 
	updatedby = 'CDM-16539'
where intakeservreqchildremovalid = '02a45bed-a024-4098-8400-86cfcf7ff1b1'
	and activeflag = 1 ;

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251938
	and rm.personid = 'a820f353-2490-4cd4-9517-6b755bb067ba'
	and rm.activeflag = 1 ;
			
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-17942',
	rm.updatedon = now()
where rm.removalid = 251938
	and rm.personid = 'a820f353-2490-4cd4-9517-6b755bb067ba'
	and rm.activeflag = 1 ;
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '02a45bed-a024-4098-8400-86cfcf7ff1b1'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-17942',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '02a45bed-a024-4098-8400-86cfcf7ff1b1'
	and ro.activeflag = 1 ;
	

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251938
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-17942'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251938
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;	
	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 251938
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-17942'
where removal_id = 251938
	and delete_sw = 'N' ;	
	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '36868076-487d-4557-8583-7e9362239415'
	and personid = 'a820f353-2490-4cd4-9517-6b755bb067ba'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
update personprogramarea
set activeflag = 0, 
	updatedby = 'CDM-17942',
	updatedon = now() 		
where personprogramid = '36868076-487d-4557-8583-7e9362239415'
	and personid = 'a820f353-2490-4cd4-9517-6b755bb067ba'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'c0678bc9-15ca-4109-b66c-a8fa4d85bbf4'
	and personid = 'a820f353-2490-4cd4-9517-6b755bb067ba'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set enddate = '2021-08-09 00:00:00',
	updatedby = 'CDM-17942',
	updatedon = now() 		
where personprogramid = 'c0678bc9-15ca-4109-b66c-a8fa4d85bbf4'
	and personid = 'a820f353-2490-4cd4-9517-6b755bb067ba'
	and programkey = 'OOH'
	and activeflag = 1 ;

-- 3)
-- Case ID: 202105406174
-- Client ID: 200569073 (Corey Standback) - f7a265f3-96d6-4f48-bfe4-59e8cbdb5568 
-- Removals 
-- 251783	2021-02-24 To Current 		eaf8470a-bc95-4346-81c8-3ab885033a4e
-- 251619	2021-02-24 To 2021-02-24 	2ce9590b-1ffe-436d-972f-d72a0581e994 (Approved - Delete)

-- Delete removal #  251619 , IV-E and OOH  - No associated placements 

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251619
	and rm.personid = 'f7a265f3-96d6-4f48-bfe4-59e8cbdb5568'
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
	rm.updatedby = 'CDM-17942',
	rm.updatedon = now()
where rm.removalid = 251619
	and rm.personid = 'f7a265f3-96d6-4f48-bfe4-59e8cbdb5568'
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
	and ro.objectid  = '2ce9590b-1ffe-436d-972f-d72a0581e994'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-17942',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '2ce9590b-1ffe-436d-972f-d72a0581e994'
	and ro.activeflag = 1 ;	
	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 251619
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-17942'
where removal_id = 251619
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '78ec2108-404c-483f-a7f9-68abfdfff528'
	and personid = 'f7a265f3-96d6-4f48-bfe4-59e8cbdb5568'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set enddate = startdate,
	activeflag = 0, 
	updatedby = 'CDM-17942',
	updatedon = now() 		
where personprogramid = '78ec2108-404c-483f-a7f9-68abfdfff528'
	and personid = 'f7a265f3-96d6-4f48-bfe4-59e8cbdb5568'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- 4)
-- Case ID: 3169620
-- Client ID: 200571346	(Corey Stanback) - 4946084f-4e6f-4bcf-aea0-625ecce142dd
-- Removals 
-- 251703	2021-02-24 To 2021-02-24 d0617252-21c9-48df-86ec-62d36739761f (Approved - Delete)

-- Delete removal # 251703, IV-E and OOH - No associated placements  

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251703
	and rm.personid = '4946084f-4e6f-4bcf-aea0-625ecce142dd'
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
	rm.updatedby = 'CDM-17942',
	rm.updatedon = now()
where rm.removalid = 251703
	and rm.personid = '4946084f-4e6f-4bcf-aea0-625ecce142dd'
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
	and ro.objectid  = 'd0617252-21c9-48df-86ec-62d36739761f'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-17942',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'd0617252-21c9-48df-86ec-62d36739761f'
	and ro.activeflag = 1 ;
	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 251703
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-17942'
where removal_id = 251703
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '6e7e30c0-e19d-492d-9902-6a3739667026'
	and personid = '4946084f-4e6f-4bcf-aea0-625ecce142dd'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set enddate = startdate,
	activeflag = 0, 
	updatedby = 'CDM-17942',
	updatedon = now() 		
where personprogramid = '6e7e30c0-e19d-492d-9902-6a3739667026'
	and personid = '4946084f-4e6f-4bcf-aea0-625ecce142dd'
	and programkey = 'OOH'
	and activeflag = 1 ;
	

-- 5)
-- Case ID: 3151878
-- Client ID: 200773123	(Tat WRONG PERSON Burch) - 52c29dc2-0691-4c04-8217-e8c5f1402b81
-- Removals 
-- 252237	2021-06-14 To Current - 2c277eb9-ea85-4dce-88fd-161a6a4a4272 (Draft - Delete)

-- Delete removal # 252237 - No associated placements, NO IV-E and Active OOH 

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252237
	and rm.personid = '52c29dc2-0691-4c04-8217-e8c5f1402b81'
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
	rm.updatedby = 'CDM-17942',
	rm.updatedon = now() 		
where rm.removalid = 252237
	and rm.personid = '52c29dc2-0691-4c04-8217-e8c5f1402b81'
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
-- Case ID: 211030008142
-- Client ID: 200775142 (Sumiyha Duplicate Avery) - 86556655-86e1-4dce-b342-248263653f24
-- Removals 
-- 252247	2021-06-21 To 2021-06-21 - 	5d07e975-408e-4001-85ab-1267b93b22c1 (Approved - Delete)

-- Delete removal #  252247,IV-E and OOH  - No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252247
	and rm.personid = '86556655-86e1-4dce-b342-248263653f24'
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
	rm.updatedby = 'CDM-17942',
	rm.updatedon = now()
where rm.removalid = 252247
	and rm.personid = '86556655-86e1-4dce-b342-248263653f24'
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
	and ro.objectid  = '5d07e975-408e-4001-85ab-1267b93b22c1'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-17942',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '5d07e975-408e-4001-85ab-1267b93b22c1'
	and ro.activeflag = 1 ;
	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252247
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-17942'
where removal_id = 252247
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '3ec083d9-7004-4fc7-bbba-33aa3182b8fd'
	and personid = '86556655-86e1-4dce-b342-248263653f24'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set enddate = startdate,
	activeflag = 0, 
	updatedby = 'CDM-17942',
	updatedon = now() 		
where personprogramid = '3ec083d9-7004-4fc7-bbba-33aa3182b8fd'
	and personid = '86556655-86e1-4dce-b342-248263653f24'
	and programkey = 'OOH'
	and activeflag = 1 ;

-- 7)
-- Case ID: 
-- Client ID: 200667393	(Kimberly Duplicate	Campbell) - 36730ec4-a003-45cf-8191-275f882dfa55
-- Removals 
-- 252075	2021-05-19 To Current 	4c7b5ea0-e212-4420-bd9e-ca259ece4c81 (Rejetced - Delete)

-- Delete removal # 252075 - No associated placements, NO IV-E and Active OOH 

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252075
	and rm.personid = '36730ec4-a003-45cf-8191-275f882dfa55'
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
	rm.updatedby = 'CDM-17942',
	rm.updatedon = now()
where rm.removalid = 252075
	and rm.personid = '36730ec4-a003-45cf-8191-275f882dfa55'
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
	and ro.objectid  = '4c7b5ea0-e212-4420-bd9e-ca259ece4c81'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-17942',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '4c7b5ea0-e212-4420-bd9e-ca259ece4c81'
	and ro.activeflag = 1 ;

-- 8)
-- Case ID: 3113399
-- Client ID: 200022091	(KEYON Duplicate FORD) - 387fc1f8-2ad0-4cdb-bf15-f9092e894c04
-- Removals 
-- 251836	2021-04-03 To 2021-04-04 - ac4f7a08-4d19-4131-8029-ef9e79cadeaa (Approved - Delete)

-- Delete removal # 251836, IV-E and OOH - No associated placements, 

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251836
	and rm.personid = '387fc1f8-2ad0-4cdb-bf15-f9092e894c04'
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
	rm.updatedby = 'CDM-17942',
	rm.updatedon = now()
where rm.removalid = 251836
	and rm.personid = '387fc1f8-2ad0-4cdb-bf15-f9092e894c04'
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
	and ro.objectid  = 'ac4f7a08-4d19-4131-8029-ef9e79cadeaa'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-17942',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'ac4f7a08-4d19-4131-8029-ef9e79cadeaa'
	and ro.activeflag = 1 ;
	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 251836
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-17942'
where removal_id = 251836
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '6c19ae4f-4dcc-466d-92c2-547a75fa755f'
	and personid = '387fc1f8-2ad0-4cdb-bf15-f9092e894c04'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set enddate = startdate,
	activeflag = 0, 
	updatedby = 'CDM-17942',
	updatedon = now() 		
where personprogramid = '6c19ae4f-4dcc-466d-92c2-547a75fa755f'
	and personid = '387fc1f8-2ad0-4cdb-bf15-f9092e894c04'
	and programkey = 'OOH'
	and activeflag = 1 ;
