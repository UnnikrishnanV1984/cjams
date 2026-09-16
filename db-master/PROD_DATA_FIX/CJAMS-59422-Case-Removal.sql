/*
   Issue Description: CJAMS-62697
   Category/ Module  : Case assignments 
   Root cause: User Error, Wrong dispositioncode type choosen 
   (Supposed to choose Recommend for closure instead selected Recommend for Transfer) allowing user to assign case for case worker even after case completed. 
    Fix Provided: Datafix has been promoted to update the flags and to update the case recommendation status.
    Pull request# N/A 
    Is Code fix Required?: No
    Code fix ticket#: 
    Reason why no related code fix: 
    Regression Impacts: Assignment and Intake case assignment dashboard
*/

update caseassignment 
set activeflag = 0,updatedby ='CJAMS-59422',updatedon = now() 
where caseassignmentid = 'db3f4fc6-7ca0-4eb1-9d18-af053ad95d8f'
	and activeflag =1;

update intakeservicerequestdispositioncode
set servicerequesttypeconfigiddispostionid = 'd90db0d3-f665-49db-b3ad-0edb468bc02d', --f9e9779f-a491-4d55-90dd-4ff44d6ce4aa
	updatedby ='CJAMS-59422',updatedon = now()	
where intakeserviceid = '45bf8f52-1139-4283-b53e-457abe9a198e'
	and intakeservicerequestdispositioncodeid = '79b52aa9-82df-4d64-a652-ec0d1789949d'
	and activeflag =1;
