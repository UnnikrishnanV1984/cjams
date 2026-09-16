/*
   Issue Description: CJAMS-68154
   Category/ Module  :  Child Removal Fix
   Root cause: user requested to  Remove the Child Removal End Date ,Remove the OOH Program Assignment End Date ,
   Update the Placement Exit Type from Permanently Leaving Custody & Care to Change in Placement Structure
   Fix provided: Data fix is done to remove the Child Removal End Date ,Remove the OOH Program Assignment End Date ,
   Update the Placement Exit Type from Permanently Leaving Custody & Care to Change in Placement Structure
   Is code fix required: N
   Reason why no related code fix: User error
   Status of the code fix if already submitted and expected prod fix date: 
*/





update intakeservreqchildremoval 
set exitdate = null,
	returntransts = null,
	returndate = null,
	returntime = null,
	removalexitreason = null,
    updatedby = 'CJAMS-68154',
    updatedon = now()
where intakeservreqchildremovalid='9b87a1c3-c785-4f3c-ae7d-74bd13764b42'
and activeflag =1;

Update personprogramarea 
set enddate = null, 
updatedby ='CJAMS-68154', 
updatedon = now()  
where personprogramid ='92a124b5-d1d9-4e66-bb62-83932f37b1f0' 
and activeflag = 1;


update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-68154',
    update_ts = now()
where removal_id = 194021
and delete_sw = 'N';

update placement  
set exittypekey = 'CIPS', --	Change in Placement structure
	remarks = 'Placement exit type changed to CIP  as the part of data fix ticket CJAMS-68154',
	updatedon = now(), 
	updatedby = 'CJAMS-68154'
where placementid = '1aed327e-f4c5-496d-bd6e-e322a0144f6b'
	and activeflag = 1 ;



update placementrevision 
set exitreasontypkey = 'CIPS',
    updatedon = now(), 
    updatedby = 'CJAMS-68154' 
where placementid ='1aed327e-f4c5-496d-bd6e-e322a0144f6b' 
and activeflag =1;