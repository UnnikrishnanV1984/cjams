
/*
   Issue Description: CDM-32795
   Category/ Module  : Documents 
   Root cause: Document file type inserted wrong 
   Fix provided: Did data fix to update correct file format 
*/

--This record was inserted by data migration so they might insert wrong format document file insted of jpg they insert doc 

update cjams.documentproperties set originalfilename ='2726211.jpg', filename ='Mowry Text Message 4.jpg', title ='Mowry Text Message 4.jpg', description ='Mowry Text Message 4.jpg',
mime ='jpg', s3bucketpathname ='/attachments/downloadFileFromECMS?docId=5f1ca6baefa3241cc099cdc9&filename=2726211.jpg', updatedby ='CDM-32795', updatedon = now()
where documentpropertiesid ='b8af5d66-6e7b-447c-9d52-9037a3a8b2df';