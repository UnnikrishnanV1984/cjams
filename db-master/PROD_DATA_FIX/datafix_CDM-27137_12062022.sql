-- CDM-27137 - FYI - There are three kids that have draft removals
/*
-- Issue Description: 
   User reuest to remove the duplicate Removal of 2 kids

-- Case ID: 3264164 - 81352b87-1a2e-4405-b2b6-42eea1b4c26f
-- Client ID: 3915530 (CALEB WILLIAM MERZ) - 1ccba752-a519-4bcc-9eab-bb7c6ef6cc38
-- Removal ID: 255242 - 2022-11-18 To Current - 9db73f05-7f30-42eb-9b25-8e1b6c29e3f2
-- No OOH, Placement & IV-E

-- Client ID: 3915531 (BRYSON RUSSELL MERZ) - 90ec0563-1e0c-4321-b724-91fcf9a1a8d0
-- Removal ID: 255243 - 2022-11-18 TO Current - 32db6a57-c602-4b6d-aade-7cbf8da55bdd
-- No OOH, Placement & IV-E

-- Client ID: 4136149 (RILEY Merz) - fe2dea18-3f24-4b6f-88fa-70a3f3a19867
-- Removal ID: 255244 - 2022-11-18 To Current - 830b174b-5684-4278-afd1-87d52f1d6636
-- No OOH, Placement & IV-E
-- Fixed with CDM-27073

-- Category/ Module: Child Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to remove the Duplicate Removal

-- Client ID: 3915530 (CALEB WILLIAM MERZ) - 1ccba752-a519-4bcc-9eab-bb7c6ef6cc38
-- Removal ID: 255242 - 2022-11-18 To Current - 9db73f05-7f30-42eb-9b25-8e1b6c29e3f2
-- No OOH, Placement & IV-E

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 255242
	and rm.personid = '1ccba752-a519-4bcc-9eab-bb7c6ef6cc38'
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
set activeflag = 0,
	updatedby = 'CDM-27137',
	updatedon = now()
where rm.removalid = 255242
	and rm.personid = '1ccba752-a519-4bcc-9eab-bb7c6ef6cc38'
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
		
-- Client ID: 3915531 (BRYSON RUSSELL MERZ) - 90ec0563-1e0c-4321-b724-91fcf9a1a8d0
-- Removal ID: 255243 - 2022-11-18 TO Current - 32db6a57-c602-4b6d-aade-7cbf8da55bdd
-- No OOH, Placement & IV-E

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 255243
	and rm.personid = '90ec0563-1e0c-4321-b724-91fcf9a1a8d0'
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
set activeflag = 0,
	updatedby = 'CDM-27137',
	updatedon = now()
where rm.removalid = 255243
	and rm.personid = '90ec0563-1e0c-4321-b724-91fcf9a1a8d0'
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
