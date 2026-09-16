/*
   Issue Description: CDM-32799
   Category/ Module  : Prod data fix to remove the Person program area for a dummy case
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




UPDATE Intakeservicerequestdispositioncode SET activeflag =0, updatedby = 'CDM-34942', updatedon = now() 
WHERE intakeservicerequestdispositioncodeid = 'bb1d74d1-ef69-4002-811b-84e82d71c576' and activeflag = 1;

update personprogramarea set activeflag = 0, updatedon = now(), updatedby = 'CDM-34942' where personprogramid in 
('243973b4-0513-4ea8-a735-896c20bd8ffe',
'b7d4b9f9-0cf6-4039-b435-dae8df085ff8',
'e1a29440-afc6-4d43-9286-702090c87d48',
'0a08ce67-b624-4fb0-9b90-fc97b8817a06',
'0b1078ba-bdfe-4bb0-bc92-513744cc74e7',
'4e766d58-e993-4c51-ba22-c5510d75450f',
'187a6128-aa17-42a3-b141-bda7f16e2ad6',
'2ab2601e-abe0-4a0f-842c-78dc06c6c27f',
'dff6597e-3231-4b1a-b7de-b0e09e82d281',
'4c775092-f037-4973-8767-321bce9d785c',
'a00802fe-b285-4471-b3cd-f8e882008919',
'de350a1d-22db-4dc6-b3d1-6daa76fef412',
'0bbd786b-a55d-422c-9664-ec3368f962e1',
'ab1fb1b7-c7db-469a-8aa0-0f57b8619f0b',
'ed4bbed7-9528-4c00-9bfb-5e46db3e92e8',
'3db03485-29e4-467f-97c6-008f816847d5',
'7e6f3b3d-b2c3-47eb-9bcb-708057c26fce',
'bf9b99bb-7b97-492c-9dbb-2e240eb0241e',
'37d122a9-3b0c-4ebe-9bae-0d17bff6fe60',
'b8da4248-4d46-40d7-9239-90eb443a54a0',
'b9ce7bfa-cd79-4427-bc2c-8ebe4bfff0c0',
'1b176c3e-060c-4b43-86a1-a71a869d1de5',
'43dfc54b-db8b-4ee6-808f-6057cb17ded8',
'd0cec4e5-a1be-4487-85dc-f848c75470dd') and activeflag = 1;



update personprogramarea set enddate = '2021-10-02 09:46:27', updatedby = 'CDM-34942', updatedon = now() 
where objectid ='f76b4260-ff9a-41f7-8bd3-4f31d282a3b6' and activeflag = 1 and enddate is null;


update personprogramarea set entityid = '211020135688', updatedby = 'CDM-34942', updatedon = now() 
where objectid ='f76b4260-ff9a-41f7-8bd3-4f31d282a3b6' and activeflag = 1 and coalesce(entityid) = '';
