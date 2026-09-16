/* 
  Issue Description: CDM-40490
  Category/ Module  : Assignments
  Root cause: There is change in worker name and date due to data migration
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update intakedastaging set insertedby='4be6ab75-66ee-467f-ba8c-c91ee6e7379c',updatedby='4be6ab75-66ee-467f-ba8c-c91ee6e7379c',
insertedon='2016-01-11 16:21:57.000', updatedon='2016-01-11 16:21:57.000', intakeuser='4be6ab75-66ee-467f-ba8c-c91ee6e7379c', status = 'Completed'
where intakenumber ='CW9699914';

update intakeservicerequest set updatedby='4be6ab75-66ee-467f-ba8c-c91ee6e7379c', updatedon = '2016-01-11 16:21:57.000'
where intakenumber ='CW9699914';

update intakedastatus set updatedby='4be6ab75-66ee-467f-ba8c-c91ee6e7379c', updatedon='2016-01-11 16:21:57.000',
submitteddate='2016-01-11 16:21:57.000'
where intakenumber ='CW9699914';