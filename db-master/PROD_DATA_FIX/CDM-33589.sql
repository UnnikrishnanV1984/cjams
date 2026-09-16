/*
   Issue Description: CDM-33589
   Category/ Module  : person
   Root cause: Client ID # 4106084 is missing from the service case # 231030135775
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update intakeservicerequestactor set servicecaseid='176ea290-2297-4d17-90eb-3a90c66127a5',
updatedby = 'CDM-33589',
updatedon = now() 
where intakeservicerequestactorid='f93acda2-56a3-4a2c-962c-62e38a041931';