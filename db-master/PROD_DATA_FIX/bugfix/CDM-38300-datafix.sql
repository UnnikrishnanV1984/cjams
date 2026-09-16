/*
   Issue Description: CDM-38300
   Category/ Module  :  Assignments
   Root cause: Data fix to end date the caseworker assignment
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
   Case is closed without closing removal and placement. Need to do data fix
*/


update caseassignment
set enddate= '2024-04-15 16:20:28.071',
    updatedon = now(),  
    updatedby = 'CDM-38300'
WHERE caseassignmentid ='73cd81e0-3084-4496-8109-d74a5956aaa3' and 
objectid = '8ad89258-2178-439a-87e7-59acf7b2c0f1' and activeflag = 1;
