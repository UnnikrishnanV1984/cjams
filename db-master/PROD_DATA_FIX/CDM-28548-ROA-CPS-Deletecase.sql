/*
   Issue Description: CDM-28548
   Category/ Module  : ROA CPS CASE 
   Root cause: user wants to delete case which created for ROA-CPS IN STATE
   Pull request# for data fix:8542
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: data fix
*/
update intakeservicerequest set activeflag = 0, updatedby = 'CDM-28548',
updatedon = now() where servicerequestnumber = '231020335865';
