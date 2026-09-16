/*
   Issue Description: CDM-42014 Assigned case not showing on worker case list
   Category/ Module  :Workload
   Root cause: Supervisor laura.joiner@maryland.gov has  case available in the workload dashboard that where no persons are loading, there is no HOH .
               This happens due to incorrect object type key in case assignment table which is set as service case instead of adoptioncase .
   Fix provided : Data fix has been done to change the object type key to Adoption case.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/


update caseassignment 
set objecttypekey ='adoptioncase',
    updatedby = 'CDM-42014',
    updatedon = now()
 where caseassignmentid in ('630af024-da6b-47a6-912a-38791d40bf13');