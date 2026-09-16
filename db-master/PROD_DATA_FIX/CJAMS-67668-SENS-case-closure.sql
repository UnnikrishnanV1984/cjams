/*
  Issue Description:  CJAMS-67668
   Category/ Module: Services
   Root cause: user request to remove the POSC
   Fix Provided: Data fix has been provided by deleting the POSC
   Pull request# for code fix: 
   Reason why no related code fix:NA 
*/

update safecareplan
set activeflag=0, updatedon=now()
where safecareplanid='2294172f-7ac0-4fab-b9b5-b1691bb83fe9' and activeflag=1;