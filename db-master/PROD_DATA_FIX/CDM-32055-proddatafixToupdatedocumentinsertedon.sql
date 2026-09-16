/*
   Issue Description: CDM-32055
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- 22417e18-7b17-4bce-aa0a-e6c68eae7426
update documentproperties set insertedby = '4d98a0c2-3006-4687-914a-72ae28497f68', updatedby = 'CDM-32055', updatedon = now()
where documentpropertiesid = '3188ac3f-6266-4402-9887-69ad727065b9';


-- 22417e18-7b17-4bce-aa0a-e6c68eae7426
update documentattachment set insertedby = '4d98a0c2-3006-4687-914a-72ae28497f68', updatedby = 'CDM-32055', updatedon = now()
where documentpropertiesid = '3188ac3f-6266-4402-9887-69ad727065b9';

