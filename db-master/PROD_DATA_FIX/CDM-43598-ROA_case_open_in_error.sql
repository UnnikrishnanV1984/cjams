/*
  Issue Description:  CDM-43598
   Category/ Module  :  ROA case open in error
   Root cause: User requested ROA-CPS case is open in error and needs to be closed.
   Pull request# for code fix: NA
   Reason why no related code fix: NA
*/


UPDATE intakeservicerequest  
SET  activeflag = 0, 
updatedby = 'CDM-43598', updatedon = now() 
WHERE intakeserviceid = 'fd0893d6-da13-4eef-a128-23de64a43799' AND activeflag = 1;

update caseassignment
set activeflag = 0, updatedby = 'CDM-43598', updatedon = now() 
where objectid = 'fd0893d6-da13-4eef-a128-23de64a43799' AND activeflag = 1;

update routing
set activeflag = 0, updatedby = 'CDM-43598', updatedon = now() 
where objectid = 'fd0893d6-da13-4eef-a128-23de64a43799' AND activeflag = 1;


update personprogramarea
set activeflag = 0, updatedby = 'CDM-43598', updatedon = now() 
where objectid = 'fd0893d6-da13-4eef-a128-23de64a43799' AND activeflag = 1;