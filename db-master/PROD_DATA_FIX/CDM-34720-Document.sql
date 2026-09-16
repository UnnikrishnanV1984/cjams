
/*
   Issue Description: CDM-34720
   Category/ Module  : Documents 
   Root cause: Document file type inserted wrong 
   Fix provided: Did data fix to update correct file format 
*/

--This record was inserted by data migration so they might insert wrong format document file insted of png they insert doc 


update cjams.documentproperties set originalfilename ='1563407.png',
mime ='png', s3bucketpathname ='/attachments/downloadFileFromECMS?docId=5e2340c3db33910c8cd8bedf&filename=1563407.png',
updatedby ='CDM-34720', updatedon = now()
where documentpropertiesid ='b39a4928-8369-4108-b736-803d7cb44eb6';


update cjams.documentproperties set originalfilename ='1563406.png',
mime ='png', s3bucketpathname ='/attachments/downloadFileFromECMS?docId=5e2340c2db33910c8cd8be9d&filename=1563406.png',
updatedby ='CDM-34720', updatedon = now()
where documentpropertiesid ='501c2c1b-884f-4e95-bcf5-cc727c88b99e';