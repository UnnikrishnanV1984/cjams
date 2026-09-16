/*
   Issue Description: CDM-38595
   Category/ Module  : Assessments
   Root cause: User requested to change the dates home visit (4/9 10am) rather than the initial face-to-face visit (4/6 11am). 
   Pull request# 
   for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


---SAFE-C 
select 	submissiondata, * from assessment
where 	objectid = '5ef2f851-fcc6-4133-aa91-cee05aeadf41' and assessmentid ='ae8c87e6-616e-4fe9-b2fc-8f6a1d35c127' and activeflag = 1;


---SAFE-C = updated (4/9 10am) to (4/6 11am).
update assessment 
set  updatedby = 'CDM-38595', updatedon = now(), 
submissiondata = jsonb_set(submissiondata, '{dateassessmentinitiated}', '"04/06/2024 11:00 am"') where assessmentid ='ae8c87e6-616e-4fe9-b2fc-8f6a1d35c127';
