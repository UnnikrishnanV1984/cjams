/*
  Issue Description:  CDM-41568
   Category/ Module  : Assessments: SAFE-C
   Root cause: For some reason submission has not been created. Generated one more
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update assessment set submissionid='83ac4cb8-2dad-4733-bfb7-a8fc61079aa0', updatedby = 'CDM-41568', updatedon = now() 
where assessmentid = 'bd5859a1-a87d-4826-9ec3-911101e0fcc1';
