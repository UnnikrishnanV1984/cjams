/* Issue Description:CDM-13670 - Unable to see the Perm plan review for supervisior 
   Category/ Module  :  Perm plan review for supervisior
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   It is a data fix as intakeservicerequest actor id for that case is null so it couldn't able to see any review option to review it

*/




update permanencyplan set intakeservicerequestactorid ='59c2f7fe-e625-4e8c-b32c-799ce6a60fc5', updatedby='CDM-13670', updatedon=now()	WHERE  servicecaseid='e97b0dc9-8fdb-4bb9-a905-7201c6c20bf0' AND activeflag=1;
