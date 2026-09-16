/*
   Issue Description: CDM-21904
   Category/ Module  :  Reopen service case, this is cps ir case and there is no program area to update
   Root cause: user asked to reopen service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservicerequestdispositioncode
set activeflag = 0, updatedby = 'CDM-21904', updatedon = now()
where intakeservicerequestdispositioncodeid = '7447371f-7ac8-420f-9285-efe37b365787';