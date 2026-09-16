/*
  Issue Description:  CDM-41278
   Category/ Module  :  Assessments: Other
   Root cause: User request to Data fix to give permissions for the user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update teammemberassignment set teammemberid = 'f8d5da5e-25d3-4272-9b66-108f240c079b', updatedon = now(),updatedby = 'CDM-41278' 
where securityusersid = 'e0e97b66-50a9-495b-92f9-46adff7a50b3' and activeflag = 1