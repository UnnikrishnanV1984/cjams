/*
   Issue Description: CDM-18351
			This case has been closed but still appears on the workers tree
      Category/ Module  : case closure, decision
   Root cause: user wants to change
   Pull request# for code fix: 
  explanantion: user wants to remove AR case closed, but decision entry is missed

  */
  
  
update cjams.caseassignment
set enddate = '08/12/2021',
updatedby = 'CDM-18351',
updatedon = now()
where 
caseassignmentid = '2a0fca12-2245-4fe1-89ac-9db78b6216c2'; 



UPDATE IntakeServiceRequestDispositionCode 
SET activeflag = 1, 
updatedby = 'CDM-18351',
updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = '74d9f0f6-2189-4cd1-ab1a-21bdaa66e9b7';
