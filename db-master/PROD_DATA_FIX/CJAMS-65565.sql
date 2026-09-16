/*
Issue Description:CJAMS-65565
Category/Module:Child removal
Root cause: Requested to remove Placement Exit Date and Child removal End date
Fix provided: Data fix has been done to remove Placement Exit Date and Child removal End date
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Not a code issue.
*/



update placement set enddatetime = null, endtime = null, updatedon = now(), updatedby = 'CJAMS-65565' 
where placementid = 'adc07028-2485-4628-9f79-b1b1f2e996de';


update placementrevision  set exitdate = null, exittime = null, updatedon = now(), updatedby = 'CJAMS-65565' 
where placementid = 'adc07028-2485-4628-9f79-b1b1f2e996de';


update intakeservreqchildremoval 
set exitdate = null,
    returntransts = null,
    returntime = null,
    returndate = null,
    removalexitreason = null,
    updatedby = 'CJAMS-65565',
    updatedon = now()
where intakeservreqchildremovalid='6e0f7b9b-bb99-48a3-aa95-e99a8d70d9bc'
and activeflag =1;

update personprogramarea 
set enddate = null, 
    updatedby ='CJAMS-65565', 
    updatedon = now()  
where personprogramid ='63087dec-b64b-4a0c-9e98-e9782f1013df' 
and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-65565',
    update_ts = now()
where removal_id = 187176
and delete_sw = 'N';