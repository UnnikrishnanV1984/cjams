/*
Issue Description:User has requested to do a data fix to remove the Child removal 
Category/Module: Bug
Root cause: data fix to remove the Child removal 
Fix provided: DB queries to do a data fix  to remove the Child removal 
Data/Code fix ticket#: CJAMS-58469
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/


UPDATE intakeservreqchildremoval 
SET activeflag =0,    
    updatedby ='CDM-38976',
    updatedon = now()
WHERE intakeservreqchildremovalid = 'fea64bb0-e9ce-4974-a9f3-68f6fc8a3ca0'
and activeflag = 1;

UPDATE personprogramarea 
set activeflag =0,     
    updatedby ='CDM-38976',
    updatedon = now()
WHERE personprogramid ='b991e09c-4aa8-461e-9076-dfe52816f2ba'
and personid ='14f6b30a-f9b5-4384-bceb-debe6e932f3e'
and activeflag = 1;


UPDATE tb_client_eligibility 
SET delete_sw = 'Y',     
    update_user_id ='CDM-38976',
    update_ts = now()
WHERE removal_id = '342856';


 update
    intakeservreqchildremoval_history
set
    activeflag = 0,
    updatedby = 'CJAMS-58352',
    updatedon = now()
where
    intakeservreqchildremovalid = 'fea64bb0-e9ce-4974-a9f3-68f6fc8a3ca0' 
and personid = '14f6b30a-f9b5-4384-bceb-debe6e932f3e' 
and intakeservreqchildremovalhistoryid = 'ae85db14-c2ec-47ce-9215-9c033a78ffcd'
and activeflag = 1;

update routing
set 
  activeflag = 0,
    updatedby = 'CJAMS-58352',
    updatedon = now()
where  objectid = 'fea64bb0-e9ce-4974-a9f3-68f6fc8a3ca0' 
and activeflag = 1;
