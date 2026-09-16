/*
 * CDM-36781 - Unable to complete Guardianship Checklist
 * Customer Email ID:raquel.washington@maryland.gov
 * Focus Area:Permanency Plan
 * Identified As:User Error
 * Description - 211030011355:I have submitted a ticket previously about this and have not heard anything back
 * remove the Child removal end date, so that the user will create a Formal Kinship Care Placement.
 * CJAMS ID :200804841
 * Case ID: 211030011355
 * removalid: 252770
 * personprogramid: 07b5944d-e92f-4696-8fe0-626cec2773b1
 * Category/ Module: Removal (Case Management) 
 * Root cause: User Error
 * Fix Provided: Datafix has been promoted to re-open the Child Removal / OOH   
 * 
 */

-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 252770
	and activeflag = 1;

update cjams.intakeservreqchildremoval
set exitdate = Null, -- 2023-07-28 12:00:00 
	returndate = Null,
	returntime = Null,
    returntransts = NULL,
	removalexitreason = NULL, -- GUARDR
	updatedby = 'CDM-36781',
	updatedon = now()
where removalid = 252770
	and activeflag = 1;

-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '07b5944d-e92f-4696-8fe0-626cec2773b1'
	and activeflag = 1;

update cjams.personprogramarea 
set enddate = Null, -- 2023-07-28 00:00:00 
	updatedby = 'CDM-36781',
	updatedon = now()
where personprogramid = '07b5944d-e92f-4696-8fe0-626cec2773b1'
	and activeflag = 1;

-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id = 252770
	and delete_sw = 'N';

update cjams.tb_client_eligibility
set end_dt = Null, -- 2023-07-28 
	update_user_id = 'CDM-36781',
	update_ts = now()
where removal_id = 252770
	and delete_sw = 'N'
	and end_dt is not null ;
