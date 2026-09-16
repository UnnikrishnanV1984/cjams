
/*
   Issue Description: CDM-36510
   Category/ Module  : ROA-CPS case needs to be closed 
   Root cause: user wants to delete case which created for ROA-CPS
   Resolution: Deleted the case for ROA-CPS
   Pull request# for data fix:N/A
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: data fix
*/


select * from intakeservicerequest where servicerequestnumber='231020953169';

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-36510',
updatedon = now() where servicerequestnumber = '231020953169';
