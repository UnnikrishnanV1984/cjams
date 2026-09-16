-- CDM-24488 - Dulpicate removal
/*
-- Issue Description: 
	When the child, K. Parker, was removed, there was an issue with his removal. 
	The removal was initially done in the CPS case, but the removal would not carry over to the service case. 

-- Case ID: 3226443
-- Client ID: 3469187 (KAILENE LAMONT PARKER) - b6d62b48-c5e7-4700-baf0-69c76375a907
-- Removals 
-- 254230 - 2022-06-21 To Current - dd7c548e-d6cd-4eed-8fe6-04f22f2fd89d (Service Case)

-- Delete Duplicate - No Placements 
-- 254217 - 2022-06-21 To Current - 4c92773c-7a54-4107-83e3-dc3d4b8536c0 (CPS)

-- Category/ Module: Child Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to remove the Duplicate Removal for CPS case 
-- Delete removal # 254217 - 2022-06-21 To Current - 4c92773c-7a54-4107-83e3-dc3d4b8536c0 (CPS) / IV-E and Active OOH / No associated placements

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 254217
	and rm.personid = 'b6d62b48-c5e7-4700-baf0-69c76375a907'
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
	rm.updatedby = 'CDM-24488',
	rm.updatedon = now()
where rm.removalid = 254217
	and rm.personid = 'b6d62b48-c5e7-4700-baf0-69c76375a907'
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
	and ro.objectid  = '4c92773c-7a54-4107-83e3-dc3d4b8536c0'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24488',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '4c92773c-7a54-4107-83e3-dc3d4b8536c0'
	and ro.activeflag = 1 ;
	

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254217
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-24488'
where removal_id = 254217
	and delete_sw = 'N' ;	

select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '11c88487-f1f4-4609-af6a-05ea18bad50b'
	and personid = 'b6d62b48-c5e7-4700-baf0-69c76375a907'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set enddate = startdate,
	activeflag = 0, 
	updatedby = 'CDM-24488',
	updatedon = now() 		
where personprogramid = '11c88487-f1f4-4609-af6a-05ea18bad50b'
	and personid = 'b6d62b48-c5e7-4700-baf0-69c76375a907'
	and programkey = 'OOH'
	and activeflag = 1 ;

