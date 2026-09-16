/* 
    Issue Description: CDM-33992
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to delete  duplicate child removal. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
UPDATE intakeservreqchildremoval 
SET activeflag = 0,
updatedby ='CDM-33992',
updatedon = now()
WHERE intakeservreqchildremovalid = '10463504-5e3f-4003-9969-57d4e0662d91' AND activeflag=1;


update tb_client_eligibility set delete_sw = 'Y' ,
update_user_id = 'CDM-33992', update_ts = now()
where removal_id ='282682';

update personprogramarea set activeflag =0,
updatedby ='CDM-33992', 
updatedon = now() 
where personid ='d5ab4f8d-877b-423b-8b72-6b63ce66cc81' and personprogramid ='cb0b626f-139e-4504-93ab-cc8908799a2e' and programkey ='OOH';


update intakeservreqchildremoval_history
SET activeflag = 0,
updatedby ='CDM-33992',
updatedon = now()
WHERE intakeservreqchildremovalid = '10463504-5e3f-4003-9969-57d4e0662d91' AND activeflag=1;

update routing 
SET activeflag = 0,
updatedby ='CDM-33992',
updatedon = now()
where routingid = '4cbb470b-6166-48fd-8f6b-17a98ab3e89e';


