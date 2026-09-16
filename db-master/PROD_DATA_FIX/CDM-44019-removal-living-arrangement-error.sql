/*
   Issue Description: CDM-44019
   Category/ Module  : Prod data fix to update child removal.
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update routing
set activeflag=0, updatedby='CDM-44019', updatedon= now()
where routingid='9ea86eae-2e09-4463-a6e4-a524ca15b45d' and activeflag = 1;

update intakeservreqchildremoval
set activeflag=0, updatedby='CDM-44019', updatedon= now()
where intakeservreqchildremovalid='9850e2fb-3f09-481f-b0f5-8f8ac52efdf6' and activeflag = 1;


update intakeservreqchildremoval_history
set activeflag=0, updatedby='CDM-44019', updatedon= now()
where intakeservreqchildremovalid='9850e2fb-3f09-481f-b0f5-8f8ac52efdf6' and activeflag = 1;

update personprogramarea
 set activeflag=0, updatedby='CDM-44019', updatedon= now()
 where personid='e3d47fa8-b221-4a1c-bfa2-d633fdb9a08d' and activeflag = 1 and programkey = 'OOH';

 update personprogramarea
 set activeflag=0, updatedby='CDM-44019', updatedon= now()
 where personprogramid ='7be69578-7e8b-40ea-b796-91ecfb1edd37' and activeflag = 1 and programkey = 'OOH';



update tb_client_eligibility
set delete_sw = 'Y',
    update_user_id = 'CDM-44019',
    update_ts = now()
where removal_id = 335797
and delete_sw = 'N' ;






update placement 
set activeflag =0, updatedby ='CDM-44019', updatedon =now()
where placementid ='5e58b22f-38f1-4b33-a57d-5b3a0d6bf050' and activeflag =1;

update placementrevision 
set activeflag =0, updatedby ='CDM-44019', updatedon =now()
where placementid ='5e58b22f-38f1-4b33-a57d-5b3a0d6bf050' and activeflag =1;

update livingarrangement 
set activeflag =0, updatedby ='CDM-44019', updatedon =now()
where placementid ='5e58b22f-38f1-4b33-a57d-5b3a0d6bf050' and activeflag =1;

update routing 
set activeflag =0, updatedby ='CDM-44019', updatedon =now()
where objectid ='5e58b22f-38f1-4b33-a57d-5b3a0d6bf050' and activeflag =1;






update placement 
set activeflag =0, updatedby ='CDM-44019', updatedon =now()
where placementid ='f0dfe2ce-b132-4071-a791-9e684f7ea7d7' and activeflag =1;

update placementrevision 
set activeflag =0, updatedby ='CDM-44019', updatedon =now()
where placementid ='f0dfe2ce-b132-4071-a791-9e684f7ea7d7' and activeflag =1;

update livingarrangement 
set activeflag =0, updatedby ='CDM-44019', updatedon =now()
where placementid ='f0dfe2ce-b132-4071-a791-9e684f7ea7d7' and activeflag =1;

update routing 
set activeflag =0, updatedby ='CDM-44019', updatedon =now()
where objectid ='f0dfe2ce-b132-4071-a791-9e684f7ea7d7' and activeflag =1;

