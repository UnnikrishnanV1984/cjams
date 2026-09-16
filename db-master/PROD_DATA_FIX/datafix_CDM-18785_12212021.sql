-- CDM-18785 - Approved Removals in CPS don't appear in Service Case
/*
-- Issue Description: 
   Four children have Approved Open Removals in CPS case 211020155796 
   however when user goes to the associated Service Case, the children are NOT IN A REMOVAL. 
   Service Case id 211030012139 displays a Removal in the Removal History of the person tab
   but has no Service Case id associated
 
-- CPS-IR: 211020155796 - 923359d1-3a98-45e6-a531-d0e9483a2962
-- Case ID: 211030012139 - 8266f291-52b6-4526-9671-304b0754b4e2
 
-- Category/ Module: Child Removals (Case Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/


-- Update Service Case ID
-- Client ID: 200150114 (TRULY Z SMITH) - 6b702ad4-30b6-4409-9b67-4ce1a9a00002
-- Removal ID: 253077 - 2beaa52a-7347-4c1a-a221-81178cdf6e00
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.servicecaseid, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253077
	and rm.personid = '6b702ad4-30b6-4409-9b67-4ce1a9a00002'
	and rm.activeflag = 1 ;
	
update intakeservreqchildremoval rm
set rm.servicecaseid = '8266f291-52b6-4526-9671-304b0754b4e2',
	rm.updatedon = now(), 
	rm.updatedby = 'CDM-18785'
where rm.removalid = 253077
	and rm.personid = '6b702ad4-30b6-4409-9b67-4ce1a9a00002'
	and rm.activeflag = 1 ;

-- Duplicate created in the Service Case
-- Client ID: 3755845 (TOYA SMITH) - 30d604f5-5eb4-4308-a654-8025d5587b44 
-- Removal ID: 253076 - a26802b4-7830-4569-bbdf-7491178c38ca
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.servicecaseid, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253076
	and rm.personid = '30d604f5-5eb4-4308-a654-8025d5587b44'
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-18785',
	rm.updatedon = now()
where rm.removalid = 253076
	and rm.personid = '30d604f5-5eb4-4308-a654-8025d5587b44'
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'a26802b4-7830-4569-bbdf-7491178c38ca'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-18785',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'a26802b4-7830-4569-bbdf-7491178c38ca'
	and ro.activeflag = 1 ;

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253076
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-18785'
where removal_id = 253076
	and delete_sw = 'N' ;	
	
-- Client ID: 200150112 (Imani Smith) - 43134893-17a1-4c1d-923d-b17d8f92fdf7
-- Removal ID: 253075 - c74d0ed5-afe4-4e16-afa8-cb4a78ebee94
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.servicecaseid, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253075
	and rm.personid = '43134893-17a1-4c1d-923d-b17d8f92fdf7'
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-18785',
	rm.updatedon = now()
where rm.removalid = 253075
	and rm.personid = '43134893-17a1-4c1d-923d-b17d8f92fdf7'
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'c74d0ed5-afe4-4e16-afa8-cb4a78ebee94'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-18785',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'c74d0ed5-afe4-4e16-afa8-cb4a78ebee94'
	and ro.activeflag = 1 ;

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253075
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-18785'
where removal_id = 253075
	and delete_sw = 'N' ;
	
-- Client ID: 4413286 (TAMIA SMITH) - 7815f4b3-d810-4bc9-9f82-23b0b03061e6
-- Removal ID: 253107 - 8c7b5f2d-ba91-4611-a646-78e9504b51cc
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.servicecaseid, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253107
	and rm.personid = '7815f4b3-d810-4bc9-9f82-23b0b03061e6'
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-18785',
	rm.updatedon = now()
where rm.removalid = 253107
	and rm.personid = '7815f4b3-d810-4bc9-9f82-23b0b03061e6'
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '8c7b5f2d-ba91-4611-a646-78e9504b51cc'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-18785',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '8c7b5f2d-ba91-4611-a646-78e9504b51cc'
	and ro.activeflag = 1 ;

select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253107
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-18785'
where removal_id = 253107
	and delete_sw = 'N' ;	
