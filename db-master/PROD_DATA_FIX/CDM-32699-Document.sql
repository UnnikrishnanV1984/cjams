/*
   Issue Description: CDM-32699
   Category/ Module  : Documents 
   Root cause:  Prod data fix to update correct inserted user details, it's due to new document changes 
   Fix Provide: Did data fix to update the correct user details (code fix for this issue already done)

*/

update cjams.documentproperties set insertedby ='81c848fd-7e90-4a9a-8a3e-69334a6effbc', updatedby ='CDM-32699'
where documentpropertiesid ='edc201ae-f014-4c46-87e0-a310b429427b';

update cjams.documentattachment  set insertedby ='81c848fd-7e90-4a9a-8a3e-69334a6effbc', updatedby ='CDM-32699'
where documentpropertiesid ='edc201ae-f014-4c46-87e0-a310b429427b';