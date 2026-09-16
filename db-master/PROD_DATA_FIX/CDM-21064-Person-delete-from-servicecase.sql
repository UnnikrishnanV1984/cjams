/*
   Issue Description: CDM-21064
   Category/ Module  : Wrong client added
   Root cause: user added wrong child to the intakecase
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update intakeservicerequestactor set activeflag =0, updatedby ='CDM-21064',updatedon = now()  where 
intakeservicerequestactorid ='9464a586-6f7f-4a74-8cce-6622fef4a3a7';

update personrole set activeflag =0, updatedby ='CDM-21064',updatedon = now()  where personid='65aecae6-b3f5-4da7-8ea6-353193a1d0d4'
 and personroleid='5086b648-fa07-46c2-9947-89a1f8b17c09';

 update actor set activeflag =0, updatedby ='CDM-21064',updatedon = now()
  where actorid='7533ad69-502d-4699-8be3-3fb73c0cec43';