-- CDM-16386 - End removal
/*
-- Issue Description: 
	User reuest to remove the duplicate Removal

-- Case ID: 3280491 - 3134eacd-cab7-41bf-9b59-536c91a8276b
-- 			3269076 - 99c6fc45-856f-47ed-9120-cb2ba4e8b125

-- Client ID: 3979845 (DA'KARI NAIZER KERINS) - 73ae696b-c094-45b1-980d-ec5318bbb6c0

-- Delete 250459	2020-06-10 to 2021-02-19  - 2386501a-e8b2-4365-b7a8-40dbb6c86d41
-- Valid  200009	2020-06-10 to 2021-02-19  - beb890b6-1165-4b13-800b-aaab711f3939

-- Category/ Module: Child Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to remove the Duplicate Removal
-- Delete 250459	2020-06-10 to 2021-02-19  - 2386501a-e8b2-4365-b7a8-40dbb6c86d41

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250459
	and rm.personid = '73ae696b-c094-45b1-980d-ec5318bbb6c0'
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
	rm.updatedby = 'CDM-16386',
	rm.updatedon = now()
where rm.removalid = 250459
	and rm.personid = '73ae696b-c094-45b1-980d-ec5318bbb6c0'
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
	and ro.objectid  = '2386501a-e8b2-4365-b7a8-40dbb6c86d41'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-16386',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '2386501a-e8b2-4365-b7a8-40dbb6c86d41'
	and ro.activeflag = 1 ;
	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 250459
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16386'
where removal_id = 250459
	and delete_sw = 'N' ;	

-- d7275bdb-642d-4811-9d17-3e07c61e46a2 - 2020-06-10 00:00:00	2021-06-10 15:30:45
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'd7275bdb-642d-4811-9d17-3e07c61e46a2'
	and personid = '73ae696b-c094-45b1-980d-ec5318bbb6c0'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set enddate = '2021-02-19 19:00:00',
	updatedby = 'CDM-16386',
	updatedon = now() 		
where personprogramid = 'd7275bdb-642d-4811-9d17-3e07c61e46a2'
	and personid = '73ae696b-c094-45b1-980d-ec5318bbb6c0'
	and programkey = 'OOH'
	and activeflag = 1 ;

-- No Associated Placements