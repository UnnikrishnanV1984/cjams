
/*
Issue:211030011669:Nevaeh Sutton Id:200815844Please remove Mallory Norfolk (204113770) from the person's tab. She was added to the case in error.
Root Cause:User request delete the requested person due to they do not have access to do that.
Fix Provided (Data Fix Only):Data fix was done by Updated personprogramarea table.
Data/Code fix ticket#: CJAMS-61311
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update actor 
set activeflag =0,updatedon = now(),updatedby ='CJAMS-61311'
where actorid  ='8f0fd32f-eea3-49a2-8e6f-76163bf4239b' and activeflag =1;

update intakeservicerequestactor 
set activeflag =0,updatedon = now(),updatedby ='CJAMS-61311'
where intakeservicerequestactorid in ('69b6238b-14ae-4aa8-8c12-6ddbbad1094e') and activeflag =1;


update personrole 
set activeflag =0,updatedon = now(),updatedby ='CJAMS-61311'
where personroleid  in ('97a6e9c4-4fc9-47ac-80bc-2b4bf60be401') and activeflag =1;


update personroletype 
set activeflag =0,updatedon = now(),updatedby ='CJAMS-61311'
where personroletypeid  in ('4c11ea99-bfc7-409f-8af8-17c144459447') and activeflag =1;
