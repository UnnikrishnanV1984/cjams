/*
   Issue Description: CDM-27073
   Category/ Module  : Prod data fix to update correct removal exit reason
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-27073', updatedon =  now()
where intakeservreqchildremovalid = '830b174b-5684-4278-afd1-87d52f1d6636';