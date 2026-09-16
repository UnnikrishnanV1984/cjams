/*
   Issue Description: CDM-41502 Adoption cases
   Category/ Module  :Workload
   Root cause: User lori.engle@maryland.gov has three cases available in the workload dashboard that where no persons are loading, there is no HOH and you cannot see documents that were previously uploaded
               This happens due to migration cases which has incorrect object type key in case assignment table which is set as service case instead of adoptioncase .
   Fix provided : Data fix has been done to change the object type key to Adoption case.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/
update caseassignment 
set objecttypekey ='adoptioncase',
    updatedby = 'CDM-41502',
    updatedon = now()
 where caseassignmentid in ('5efc863a-a634-4c2c-9243-a5009ed5ecbf','f15ee3f6-1afb-41fe-801b-bc38dc390d87','009ad1c6-1e5c-4343-94f1-6e21032407dd');