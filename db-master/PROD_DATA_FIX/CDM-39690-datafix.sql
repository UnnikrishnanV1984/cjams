/* 
    Issue Description: CDM-39690
  Category/ Module  : Application
  Root cause: User request to Add Enrollment date
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update personeducation set enrollmentdate='2023-08-23 00:00:00',
updatedby='CDM-39690',updatedon=now()
where personeducationid='329c3c67-9c7a-4132-9609-e8a68f700401' and personid='e27d411c-c3a5-42d2-9f98-1b37be5a71f0';
