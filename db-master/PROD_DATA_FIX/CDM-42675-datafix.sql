/*
  Issue Description:  CDM-42675
   Category/ Module  :  Assessments: Other
   Root cause: User request to remove the case from the Assesments pending approval. Updated active accordingly
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/

update routing set activeflag = 0 , updatedby ='CDM-42675', updatedon = now() 
where routingid ='81e9286f-02a1-45f1-994f-21e01d438ccb';