-- CDM-13004 - Change in placement
/*
-- Issue Description: 
	Placement creation issue due to the Living Arrangement & Removal data issue.

	Case ID: 3189660 
	Client ID: 3217783 (JANAE AZORIA BEY) - 0f9ab108-f0af-4977-8a4b-d406ab044b8c
	LA ID: 1558861 - af1c47d6-0efa-4152-aaf0-c7cc8ec33f61
	Removal ID: 250865 -  intakeservreqchildremovalid  = '81f0a131-2a3d-4974-a4dd-ac77f2db34e3'
	
-- Category/ Module: Placement/Removal  (Case Management) 
-- Root cause:  Duplicate incomplete removal record is preventing the placement creation 
				(where routing was removed with CDM-4746)
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to remove the duplicate incomplete removal record
-- Removal ID: 250865 
select removalid, removaldate, exitdate, activeflag, updatedby, updatedon 
	from intakeservreqchildremoval 
where intakeservreqchildremovalid  = '81f0a131-2a3d-4974-a4dd-ac77f2db34e3'
	and activeflag = 1 ;
	
update intakeservreqchildremoval 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-13004'
where intakeservreqchildremovalid  = '81f0a131-2a3d-4974-a4dd-ac77f2db34e3'
	and activeflag = 1 ;
	
-- Update placementtypekey as LA
select placementtypekey, alternateid, startdatetime, enddatetime, updatedby, updatedon, activeflag 
	from placement 
where placementid  = 'af1c47d6-0efa-4152-aaf0-c7cc8ec33f61'
	and activeflag  = 1	;

update placement 
set placementtypekey = 'LA',
	updatedon = now(),
	updatedby = 'CDM-13004'
where placementid  = 'af1c47d6-0efa-4152-aaf0-c7cc8ec33f61'
	and activeflag  = 1	;
	
