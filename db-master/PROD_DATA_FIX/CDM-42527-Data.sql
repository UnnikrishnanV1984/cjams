/*
  Issue Description:  CDM-42527
   Category/ Module  : Permanency Plan
   Root cause: data fix to add Assignment end date 10/25/2024 
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup before update/ delete: NA
*/

update  cjams.caseassignment 
set enddate = '2024-10-25',
    updatedon = now(), 
    updatedby = 'CDM-42527'
where caseassignmentid ='6642e58f-3046-4529-a59a-ba640482a7b1' and activeflag = 1;