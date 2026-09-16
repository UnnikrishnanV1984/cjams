/*
   Issue Description: CDM-32276
   Category/ Module  : Ar Summary
   Root cause: AR summary checklist was not checked
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update intakeservicerequestactor set activeflag =0, updatedby = 'CDM-32276',updatedon =now() where intakeservicerequestactorid in ('83b4fb3e-27a8-4a3e-860c-418b689d93e8','f38867dc-e3b8-41f7-92d6-19fd4fd4459a');
