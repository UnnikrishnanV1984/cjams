/*
   Issue Description: CDM-39791
   Category/ Module  : SDM 
   Root cause: safec checklist is not checked in ar summary
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastatus 
set activeflag = 0,updatedby = 'CDM-39791',updatedon = now()
where intakenumber = 'I241012564245' and activeflag = 1;

update routing 
set activeflag = 0,updatedby = 'CDM-39791',updatedon = now()
where objectid = 'I241012564245' and activeflag = 1;

update intakedastaging 
set activeflag = 0,updatedby = 'CDM-39791',updatedon = now()
where intakenumber = 'I241012564245' and activeflag = 1;

