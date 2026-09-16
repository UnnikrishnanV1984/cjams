/*
   Issue Description: CDM-32255
   Category/ Module  : Prod data fix for updating document user details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--056865a7-2a58-494e-9993-ccc6fd9aae58
update documentproperties set insertedby =  'a2421e69-cb56-408c-8b92-031adcce5bf7', updatedby = 'CDM-32255'
where documentpropertiesid = '1d42829a-2b19-4ffc-ac28-af79f3142958';

-- daa728c1-934d-4ed9-976e-ce9053d07d25
update documentproperties set insertedby = '09e55a48-aef1-4543-9776-2c47d31319d1', updatedby = 'CDM-32255'
where documentpropertiesid = '2c092b0f-64e4-4a27-b27f-3a173a73b4fa';


--056865a7-2a58-494e-9993-ccc6fd9aae58
update documentattachment set insertedby =  'a2421e69-cb56-408c-8b92-031adcce5bf7', updatedby = 'CDM-32255'
where documentpropertiesid = '1d42829a-2b19-4ffc-ac28-af79f3142958';

-- daa728c1-934d-4ed9-976e-ce9053d07d25
update documentattachment set insertedby = '09e55a48-aef1-4543-9776-2c47d31319d1', updatedby = 'CDM-32255'
where documentpropertiesid = '2c092b0f-64e4-4a27-b27f-3a173a73b4fa';
  