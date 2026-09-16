/*
   Issue Description: CJAMS-65872
   Category/ Module  :  Child Removal Fix
   Root cause: user requested to  Remove the Child Removal End Date ,Remove the OOH Program Assignment End Date ,
   Update the Placement Exit Type from Permanently Leaving Custody & Care to Change in Placement Structure
   Fix provided: Data fix is done to remove the Child Removal End Date ,Remove the OOH Program Assignment End Date ,
   Update the Placement Exit Type from Permanently Leaving Custody & Care to Change in Placement Structure
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/





update intakeservreqchildremoval 
set exitdate = null,
	returntransts = null,
	returndate = null,
	returntime = null,
	removalexitreason = null,
    updatedby = 'CJAMS-65872',
    updatedon = now()
where intakeservreqchildremovalid='df4cb969-f929-4578-a02d-246b772ed1dd'
and activeflag =1;

Update personprogramarea 
set enddate = null, 
updatedby ='CJAMS-65872', 
updatedon = now()  
where personprogramid ='e9670a62-cfd4-4537-9d80-6f259482300c' 
and activeflag = 1;


update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-65872',
    update_ts = now()
where removal_id = 340957
and delete_sw = 'N';

update placement  
set exittypekey = 'CIPS', --	Change in Placement structure
	remarks = 'Placement exit type changed to CIP  as the part of data fix ticket CJAMS-65872',
	updatedon = now(), 
	updatedby = 'CJAMS-65872'
where placementid = 'bdf72b66-3369-47ad-a1a8-10fdffd2e03b'
	and activeflag = 1 ;



update placementrevision 
set exitreasontypkey = 'CIPS',
    updatedon = now(), 
    updatedby = 'CJAMS-65872' 
where placementid ='bdf72b66-3369-47ad-a1a8-10fdffd2e03b' 
and activeflag =1;