 /*
  Issue Description: CJAMS-59534
   Category/ Module  :  OOH, placement, Child removal
   Root cause: User Error, User exit the living arrangement incorrectly by selecting PLCC for Inpatient Psychiatric Hospital record (Exit Date 03/31/2025 11:00 AM)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/
/*
select 	removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag, personid,*
from 	cjams.intakeservreqchildremoval
where 	removalid = 251556
		and activeflag = 1 ;
*/	
update 	cjams.intakeservreqchildremoval
set 	exitdate = '2025-05-06 12:00:00',
		returntime = '2025-05-06 12:00:00',
		updatedby = 'CJAMS-59534',
		updatedon = now()
where 	removalid = 251556
		and activeflag = 1 ;
	
-- Update OOH
/*
select 	programkey, startdate, enddate, updatedby, updatedon, *
from 	cjams.personprogramarea 
where 	personid = 'a65757b9-365d-4de5-b029-780c51519361' and programkey = 'OOH'
		and personprogramid = 'c79bbe20-c69b-4591-9896-92fad5c5dd7d' and activeflag = 1 ;
*/

update 	cjams.personprogramarea 
set 	enddate = '2025-05-06 12:00:00', 
		updatedby = 'CJAMS-59534',
		updatedon = now()
where 	personid = 'a65757b9-365d-4de5-b029-780c51519361' and programkey = 'OOH'
		and personprogramid = 'c79bbe20-c69b-4591-9896-92fad5c5dd7d' and activeflag = 1 ;
	
-- Update Eligibility
/*
select 	removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
from 	cjams.tb_client_eligibility
where 	removal_id =  251556
		and delete_sw = 'N' ;
*/

update 	cjams.tb_client_eligibility
set 	end_dt = '2025-05-06 12:00:00',
		update_user_id = 'CJAMS-59534',
		update_ts = now()
where 	removal_id =  251556
		and delete_sw = 'N' ;
		
--Inpatient Psychiatric Hospital record (Exit Date 03/31/2025 11:00 AM) - Exit reason Update to : Change in Placement Structure.
-- for placement
/*
select
    exitreasontypekey ,exittypekey ,*
from
    placement
where
    alternateid in ('2047976');--d0f3079a-f7a4-41ab-8cd2-b19604ecca06
*/

update
    placement
set
    exittypekey = 'CIPS',
    exitreasontypekey = null,--EMANIND
    -- Change in Placement Structure
    updatedby = 'CJAMS-59534',
    updatedon = now()
where
    alternateid in ('2047976')
   and placementid = 'd0f3079a-f7a4-41ab-8cd2-b19604ecca06' and activeflag=1;

-- got placementrevisionid from getplacementbyservicecase()
--select queries
/*
select
    exittypetypkey ,exitreasontypkey ,exittypekey,updatedby,*
from
    placementrevision
where
    placementid = 'd0f3079a-f7a4-41ab-8cd2-b19604ecca06'
    and placementrevisionid in (
        'b7b7ce17-63f3-4f10-9c73-00050dc30dbd',
        '0994ea3e-9341-4533-b26a-45c35e0972f3'
    );
*/

-- update queries
update
    placementrevision
set
    exittypekey = 'CIPS',
    exitreasontypkey = null,--EMANIND
    -- Change in Placement Structure
    updatedby = 'CJAMS-59534',
    updatedon = now()
where
    placementid = 'd0f3079a-f7a4-41ab-8cd2-b19604ecca06'
     and placementrevisionid in (
        'b7b7ce17-63f3-4f10-9c73-00050dc30dbd',
        '0994ea3e-9341-4533-b26a-45c35e0972f3'
    );