/*
   Issue Description: CDM-31189
   Category/ Module  : Documents  
   Root cause: user requested
   Reason why no related code fix: web fix already raised 
*/

update cjams.documentproperties set activeflag =0, updatedby ='CDM-31189',updatedon = now()
where documentpropertiesid in ('59de44d7-4312-42c9-a38a-a78306375522','9756e4b9-5cb6-4f79-a5e6-92154bb66998',
'8d56a164-527f-42e4-b32e-eb6b760904d2', 'a9346af0-a0fe-4d0d-9e63-11fd1aa4bce4');

update cjams.documentattachment set activeflag =0, updatedby ='CDM-31189',updatedon = now()
where documentpropertiesid in ('59de44d7-4312-42c9-a38a-a78306375522','9756e4b9-5cb6-4f79-a5e6-92154bb66998',
'8d56a164-527f-42e4-b32e-eb6b760904d2', 'a9346af0-a0fe-4d0d-9e63-11fd1aa4bce4');