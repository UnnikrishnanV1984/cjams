/*
  Issue Description:  CDM-44236
   Category/ Module  :  Assignments
   Root cause: User request to Data fix to end date the Assignments
   Pull request# for code fix: 
   Reason why no related code fix:NA 
*/

update caseassignment set enddate = '2025-02-06 00:00:00', updatedby = 'CDM-44236', updatedon = now()
where caseassignmentid in ('0b6532f7-5bdb-43f1-ad3d-9553078cf40d','e4d02889-cb09-4845-a19c-09132a859ea2') and activeflag = 1; 

update caseassignment set enddate = '2025-01-28 00:00:00', updatedby = 'CDM-44236', updatedon = now()
where caseassignmentid in ('263d050c-bb46-4900-ba3a-3395db79d1a1','ed4d42c6-46e5-4176-ba22-3f334587ba92') and activeflag = 1; 

update caseassignment set enddate = '2025-01-27 00:00:00', updatedby = 'CDM-44236', updatedon = now()
where caseassignmentid = '3d5886b8-6fc3-48df-b55f-414b31dfc451' and activeflag = 1; 