/*
   Issue Description: CJAMS-68090
   Category/ Module  :  Child Removal Fix
   Root cause: user requested to  Remove the Child Removal End Date ,Remove the OOH Program Assignment End Date ,
   Update the Placement Exit Type from Permanently Leaving Custody & Care to Change in Placement Structure
   Fix provided: Data fix is done to remove the Child Removal End Date ,Remove the OOH Program Assignment End Date ,
   Update the Placement Exit Type from Permanently Leaving Custody & Care to Change in Placement Structure
   Is code fix required: N
   Reason why no related code fix: User request
   Status of the code fix if already submitted and expected prod fix date: 
*/





update intakeservreqchildremoval 
set exitdate = null,
	returntransts = null,
	returndate = null,
	returntime = null,
	removalexitreason = null,
    updatedby = 'CJAMS-68090',
    updatedon = now()
where intakeservreqchildremovalid='9a4670e9-4816-4398-b4e7-05c3b01fd5df'
and activeflag =1;

Update personprogramarea 
set enddate = null, 
updatedby ='CJAMS-68090', 
updatedon = now()  
where personprogramid ='47c4f698-b457-4a37-aee0-7ae13d8c13aa' 
and activeflag = 1;


update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-68090',
    update_ts = now()
where removal_id = 331877
and delete_sw = 'N';

update placement  
set exittypekey = 'CIPS', --	Change in Placement structure
	remarks = 'Placement exit type changed to CIP  as the part of data fix ticket CJAMS-68090',
	updatedon = now(), 
	updatedby = 'CJAMS-68090'
where placementid = 'cbd10845-2fef-4b2e-842c-122163e0b472'
	and activeflag = 1 ;



update placementrevision 
set exitreasontypkey = 'CIPS',
    updatedon = now(), 
    updatedby = 'CJAMS-68090' 
where placementid ='cbd10845-2fef-4b2e-842c-122163e0b472' 
and activeflag =1;