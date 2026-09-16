/*
   Issue Description: CDM-41502 No Head of Household listed
   Category/ Module  :Workload
   Root cause: User markeeta.dixon@maryland.gov has Adoption cases available in the workload dashboard that where no persons are loading, there is no HOH and you cannot see documents that were previously uploaded
               This happens due to migration cases which has incorrect object type key in case assignment table which is set as service case instead of adoptioncase .
   Fix provided : Data fix has been done to change the object type key to Adoption case.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/
update caseassignment 
set objecttypekey ='adoptioncase',
    updatedby = 'CDM-41224',
    updatedon = now()
 where caseassignmentid in ('e3ecb1ab-c07b-4efe-8457-161d03d7de6b','861c10ad-bfab-437a-b865-2caaadab42af','f36fb4f9-0a3b-4ff7-a95e-0d5ce2dfec15')