-- CDM-20063 - Duplicated child removal record
/*
-- Issue Description: 
   Closed Case # 3256210 having duplicate Removals
 
-- Case ID: 3256210
-- Client ID: 4162831 (CHANNELL CAMPBELL) - e1d200e5-9f2d-49b5-993f-c3d2cdee7893
-- Duplicate Removal ID: 253326 - 2017-11-07 To Current - a2db5357-af03-4b33-88ff-24ce43a561b4


-- Category/ Module: Child Removals (Case Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Delete duplicate removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.servicecaseid, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253326
--	and rm.personid = ??
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-20063',
	rm.updatedon = now()
where rm.removalid = 253326
--	and rm.personid = ??
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

-- Delete duplicate OOH 
-- Client ID: 200013350	(JADEN RIORDAN)
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'a14c895e-08db-4f48-8d13-21ad4c1dffb8' 
	and	personid = 'e1d200e5-9f2d-49b5-993f-c3d2cdee7893'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CDM-20063',
	updatedon = now() 		
where personprogramid = 'a14c895e-08db-4f48-8d13-21ad4c1dffb8' 
	and	personid = 'e1d200e5-9f2d-49b5-993f-c3d2cdee7893'
	and programkey = 'OOH'
	and activeflag = 1 ;

-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253326
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-20063'
where removal_id = 253326
	and delete_sw = 'N' ;