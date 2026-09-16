/* 
    Issue Description: CDM-39625
  Category/ Module  : Permanency Plan
  Root cause: moving active GAP from old Permanency Plan to the new Permanency Plan.
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/


update guardianship set permanencyplanid='ed8c3f05-b1bc-4b23-9316-083a0f8f9375',
updatedby='CDM-39625',updatedon=now()
where permanencyplanid='e6033bb0-fd87-4643-aa75-e910ba39a1e3';
