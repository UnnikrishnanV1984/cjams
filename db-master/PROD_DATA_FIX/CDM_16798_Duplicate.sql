/*
   Issue Description: CDM-16798
   Category/ Module  : case approvals
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   
*/


update caseassignment set activeflag=0, updatedby = 'CDM-16798', updatedon = now() 
	where caseassignmentid in ('82e14594-2650-4ce1-b5f3-1ef94f2f05b7', 'a3c6d5f8-3ce3-4b97-80ab-a1fbb9ba6983');