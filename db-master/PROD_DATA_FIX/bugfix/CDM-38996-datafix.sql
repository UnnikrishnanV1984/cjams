/* 
    Issue Description: CDM-38996
  Category/ Module  : Reports-Qlik
  Root cause: Ashantia Rhoomes is the supervisor for this all the 6 users.  
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

update userprofile set supervisorid = 'fb24ba8b-94e5-44a4-84ab-de57fa3ecb26', updatedby = 'CDM-38996', updatedon = now()
where securityusersid ='06c1bd76-81e0-458b-b874-9dfa58aa456c';

update userprofile set supervisorid = 'fb24ba8b-94e5-44a4-84ab-de57fa3ecb26', updatedby = 'CDM-38996', updatedon = now()
where securityusersid = 'a278fd6f-8e7e-4c06-8230-4f33ee9d12e8';

update userprofile set supervisorid = 'fb24ba8b-94e5-44a4-84ab-de57fa3ecb26', updatedby = 'CDM-38996', updatedon = now()
where securityusersid = '4a289f1e-4a4d-439e-9388-27d233418800';

update userprofile set supervisorid = 'fb24ba8b-94e5-44a4-84ab-de57fa3ecb26', updatedby = 'CDM-38996', updatedon = now()
where securityusersid = '986b7507-9f23-46ba-98aa-95b0bf04ccf8';

update userprofile set supervisorid = 'fb24ba8b-94e5-44a4-84ab-de57fa3ecb26', updatedby = 'CDM-38996', updatedon = now()
where securityusersid = '688443e3-a72e-44af-ae75-336da31ace0c';

update userprofile set supervisorid = 'fb24ba8b-94e5-44a4-84ab-de57fa3ecb26', updatedby = 'CDM-38996', updatedon = now()
where securityusersid = '14a94c59-9c84-4ab8-af47-f4471de77f84';
