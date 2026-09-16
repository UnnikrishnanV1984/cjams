/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- 9f767911-dcb2-44ae-9152-b85a19589095
--0ef03dbd-da56-4b52-801a-734f54b11e73
 update documentproperties set insertedby = 'a6d94a59-2980-44ed-931d-3fbdc72c4f08', updatedby = 'CDM-32025', updatedon = now()
where documentpropertiesid in ('4164b48b-1f85-437d-a611-55289b82a199',
'80b87b64-f9af-447c-8031-c95899c0e81f');

-- 130cf592-827f-4cc1-b448-5fcfeabc5d9f
update documentproperties set insertedby = '871fb22b-0ac6-42e9-93c2-337c4a28d176', updatedby = 'CDM-32025', updatedon = now()
where documentpropertiesid = '203db3f6-0323-459d-b25d-28589476ddbb';

-- 9f767911-dcb2-44ae-9152-b85a19589095
--0ef03dbd-da56-4b52-801a-734f54b11e73
 update documentattachment set insertedby = 'a6d94a59-2980-44ed-931d-3fbdc72c4f08', updatedby = 'CDM-32025', updatedon = now()
where documentpropertiesid in ('4164b48b-1f85-437d-a611-55289b82a199',
'80b87b64-f9af-447c-8031-c95899c0e81f');

-- 130cf592-827f-4cc1-b448-5fcfeabc5d9f
update documentattachment set insertedby = '871fb22b-0ac6-42e9-93c2-337c4a28d176', updatedby = 'CDM-32025', updatedon = now()
where documentpropertiesid = '203db3f6-0323-459d-b25d-28589476ddbb';

