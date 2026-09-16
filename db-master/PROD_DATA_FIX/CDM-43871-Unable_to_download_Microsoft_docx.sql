
/*
   Issue Description: CDM-43871
   Category/ Module  : Documents
   Root cause: Document is deleted from ECMS system due to which user unable to download the file in cjams
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update documentproperties set activeflag =0, updatedby ='CDM-43871', updatedon = now()
where documentpropertiesid ='1587bbb9-7e76-4ddd-9125-f7efddf3f75b' and activeflag =1;


update documentattachment set activeflag =0, updatedby ='CDM-43871', updatedon = now()
where documentpropertiesid ='1587bbb9-7e76-4ddd-9125-f7efddf3f75b' and activeflag =1;