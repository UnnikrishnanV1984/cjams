/*
   Issue Description: CDM-28063
   Category/ Module  :Assignments
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update caseassignment 
set toworkeridno = 'c0f485f6-f822-44c5-9001-e63688115603', updatedby = 'CDM-28063', updatedon = now()
where toworkeridno = '16bf7602-5b85-460e-af93-b7218d70aaa8' and enddate is null;

update routing
set fromsecurityusersid= 'c0f485f6-f822-44c5-9001-e63688115603', updatedby = 'CDM-28063', updatedon = now()
where fromsecurityusersid= '16bf7602-5b85-460e-af93-b7218d70aaa8' and activeflag = 1 
and (eventcode ='INTR' or routingstatustypeid =15);