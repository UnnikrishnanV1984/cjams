/*
   Issue Description: CDM-38060
   Category/ Module  : case open in error
   Root cause: ROA-CPS case is open in error.
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
   Case is closed without closing removal and placement. Need to do data fix
*/

 
UPDATE intakeservicerequest  
SET  activeflag = 0, 
updatedby = 'CDM-38060', updatedon = now() 
WHERE intakeserviceid = 'cbdf94a1-32ec-4128-bc00-cf0a90c9f93e' AND activeflag = 1;

update caseassignment
set activeflag = 0, updatedby = 'CDM-38060', updatedon = now() 
where objectid = 'cbdf94a1-32ec-4128-bc00-cf0a90c9f93e';

update routing
set activeflag = 0, updatedby = 'CDM-38060', updatedon = now() 
where objectid = 'cbdf94a1-32ec-4128-bc00-cf0a90c9f93e' and activeflag = 1;



