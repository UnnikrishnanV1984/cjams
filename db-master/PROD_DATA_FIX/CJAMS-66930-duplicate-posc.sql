/*
  Issue Description:  CJAMS-66930
   Category/ Module: Services
   Root cause: user request to remove the duplicate POSC
   Fix Provided: Data fix has been provided by deleting the duplicate POSC
   Pull request# for code fix: 
   Reason why no related code fix:NA 
*/

update safecareplan
set activeflag=0, updatedon=now()
where safecareplanid='2b737b2f-2924-4fc6-b3c0-fe33c2ee1380' and objectid='22421e97-0b88-49b3-90ca-e66173f82dde' and activeflag=1;