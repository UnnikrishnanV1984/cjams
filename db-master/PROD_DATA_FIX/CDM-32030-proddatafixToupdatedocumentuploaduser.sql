/*
   Issue Description: CDM-32072
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




--d10f8391-5e92-43d9-bf7f-7aaa9964cd73
--61007cf2-e75a-4e4b-abb2-6ad103b33311
--d226dcf0-121b-4ddf-88d9-cfa397e4d1ee
--8bc1ab63-2969-4e65-9dea-937cb2b79bf3
--dd3ac302-59b9-4e32-ac55-94a0d551ee4f
update documentproperties set insertedby = '130cf592-827f-4cc1-b448-5fcfeabc5d9f', updatedby = 'CDM-32030', updatedon = now()
where documentpropertiesid in ('57e9bd58-f710-4682-8c8b-d15c9d6afe77',
'e83ab542-232c-487a-8e95-78e99a379211',
'3c3879fb-2509-4c23-b37d-6c0e1c2b55d5',
'f3da9960-6250-4ca3-9dfe-84b3f3819cb1',
'53108821-9b67-401f-953e-8ad1a08e93e8');



--d10f8391-5e92-43d9-bf7f-7aaa9964cd73
--61007cf2-e75a-4e4b-abb2-6ad103b33311
--d226dcf0-121b-4ddf-88d9-cfa397e4d1ee
--8bc1ab63-2969-4e65-9dea-937cb2b79bf3
--dd3ac302-59b9-4e32-ac55-94a0d551ee4f
update documentattachment set insertedby = '130cf592-827f-4cc1-b448-5fcfeabc5d9f', updatedby = 'CDM-32030', updatedon = now()
where documentpropertiesid in ('57e9bd58-f710-4682-8c8b-d15c9d6afe77',
'e83ab542-232c-487a-8e95-78e99a379211',
'3c3879fb-2509-4c23-b37d-6c0e1c2b55d5',
'f3da9960-6250-4ca3-9dfe-84b3f3819cb1',
'53108821-9b67-401f-953e-8ad1a08e93e8');
