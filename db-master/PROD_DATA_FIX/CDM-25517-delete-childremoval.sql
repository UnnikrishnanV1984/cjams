/* 
    Issue Description: CDM-25517
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to delete child removal. 
   Pull request# for code fix: 6497
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
UPDATE intakeservreqchildremoval 
SET activeflag = 0,
updatedby ='CDM-25517',
updatedon = now()
WHERE intakeservreqchildremovalid = '7df1a892-bd93-4ab4-a343-54a490bb02d6' AND activeflag=1;


update tb_client_eligibility set delete_sw = 'Y' ,
update_user_id = 'CDM-25517', update_ts = now()
where removal_id ='254686';

update personprogramarea set activeflag =0,
updatedby ='CDM-25517', 
updatedon = now() 
where personid ='9758fefd-ae5d-412d-8a65-e4c387a05d71' and programkey ='OOH';