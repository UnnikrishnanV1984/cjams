/*
 * CDM-37322 - 231030117727
 * Customer Email ID:teresa.hewlin2@maryland.gov
 * Focus Area:Documents
 * Description - Dashboard:I am unable to upload documents as it will not delete the previous uploads.
 * Need to remove the pending upload document as displayed in the screenshot
 * 
 */

--select * from searchcaseworkerattachments('5ee4c83e-c94e-49a8-a03f-b5b3908826ea',null,null,'Servicecase',1,10,null,null,'updatedon','desc',null,null,null,null,null,2);
--
--select dp.documentpropertiesid , dp.activeflag , *  
--FROM documentproperties dp 
--LEFT JOIN documentattachment da on da.documentpropertiesid = dp.documentpropertiesid and dp.activeflag=2
--LEFT JOIN userprofile up on up.securityusersid = da.insertedby and up.activeflag=1
--WHERE dp.activeflag=2 and dp.servicecaseid='5ee4c83e-c94e-49a8-a03f-b5b3908826ea' :: uuid; 

UPDATE documentproperties
 SET activeflag = 0, updatedby = 'CDM-37322', updatedon = now() 
where 
 documentpropertiesid IN (
   	select distinct dp.documentpropertiesid 
	FROM documentproperties dp 
	LEFT JOIN documentattachment da on da.documentpropertiesid = dp.documentpropertiesid and dp.activeflag=2
	LEFT JOIN userprofile up on up.securityusersid = da.insertedby and up.activeflag=1
	WHERE dp.activeflag=2 and dp.servicecaseid='5ee4c83e-c94e-49a8-a03f-b5b3908826ea' :: uuid 
);
