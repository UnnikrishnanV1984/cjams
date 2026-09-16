
    /*
  Issue Description:  CDM-31252
   Category/ Module  :Assessment  
   Root cause: wrongly created
   Pull request# for code fix: 
   Reason why no related code fix: user requested 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/


update assessment set submissiondata = jsonb_set(submissiondata::jsonb, '{submissionapprovaldate}', '"2023-04-18T11:08"')
where assessmentid = '114f824a-7a86-4f49-bed6-361d2458beb4';