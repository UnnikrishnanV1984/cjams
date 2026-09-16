	
/*
   Issue Description: CDM-32174
   Category/ Module  : Prod data fix to update correct inserted user details 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 7d83183d-e600-4de4-bf7b-25b74b3495a7    JillLepus    0d2826c0-86ea-44bf-8fda-693ea7e9716d
-- f7b97cee-2314-42a0-9582-8fa89c8efb9a    JillLepus    28a6c14b-f7f8-4cbb-a536-d985aba515ee
-- 4d98a0c2-3006-4687-914a-72ae28497f68    JillLepus    58c291de-0953-4b43-85f6-17354a279c66
-- ec5596de-0ae8-4877-b699-d3d1c51e2b38    JillLepus    92169779-60b1-4440-b55c-b19e329974b5


 update documentproperties set insertedby = '7d83183d-e600-4de4-bf7b-25b74b3495a7', updatedby = 'CDM-32174', updatedon = now()
where documentpropertiesid in 
('92169779-60b1-4440-b55c-b19e329974b5','28a6c14b-f7f8-4cbb-a536-d985aba515ee','0d2826c0-86ea-44bf-8fda-693ea7e9716d','58c291de-0953-4b43-85f6-17354a279c66');

update documentattachment 
set insertedby = '7d83183d-e600-4de4-bf7b-25b74b3495a7', updatedby = 'CDM-32174', updatedon = now()
where documentpropertiesid in 
('92169779-60b1-4440-b55c-b19e329974b5','28a6c14b-f7f8-4cbb-a536-d985aba515ee','0d2826c0-86ea-44bf-8fda-693ea7e9716d','58c291de-0953-4b43-85f6-17354a279c66');