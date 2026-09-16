/*
   Issue Description: CDM-13966
   Category/ Module  : User Notification  
   Root cause: Notication error 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update cjams.usernotification set activeflag =0, updatedby ='CDM-13966', updatedon =now()

where usernotificationid in('1b4311a4-88ff-4d6f-a28c-f36ba4eb9054','6592eebe-37d9-4504-9616-f70543d7ff9e','524628fe-af12-42ef-9837-73241e5bc519');

update cjams.usernotification set securityusersid  ='2744efa4-8129-48fb-b292-7c4351f66f89', updatedby ='CDM-13966', updatedon =now()

where usernotificationid in('81a6cc54-8116-4439-a55c-637d61ea5b5c','37fe0630-79ba-410f-90a3-7606414873f2','c3476b42-53cc-432f-8249-864e5b4d0389')
