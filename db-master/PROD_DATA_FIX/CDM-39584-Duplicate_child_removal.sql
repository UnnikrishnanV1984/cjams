/* 
    Issue Description: CDM-39584
   Category/ Module  : Child Removal
   Root cause: user wants to delete  duplicate child removal. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update intakeservreqchildremoval
set activeflag =0, updatedby ='CDM-39584', updatedon=now()
where intakeservreqchildremovalid ='a54521c0-c25b-44a0-bd1d-93d16892b47b' and activeflag =1;

update intakeservreqchildremoval_history
set activeflag =0,updatedby ='CDM-39584', updatedon=now()
where intakeservreqchildremovalid ='a54521c0-c25b-44a0-bd1d-93d16892b47b' and activeflag =1;

update routing 
set activeflag =0, updatedby ='CDM-39584', updatedon=now()
where objectid ='a54521c0-c25b-44a0-bd1d-93d16892b47b' and activeflag =1;




