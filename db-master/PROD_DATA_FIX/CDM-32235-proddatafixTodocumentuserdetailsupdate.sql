/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- 909e4d4d-ef23-4dd3-9351-98f776c63f1c
--27f04c71-9e53-4b6a-9301-ba559c66e4ba
--0dd103e2-2a10-409c-8338-3ec95f635781
--ac0b65b9-b299-4727-b3d8-b834a38bdbc8
  update documentproperties set insertedby = 'b66338ae-a2dc-425d-a59a-f4e7a1d5d704', updatedby = 'CDM-32232' 
  where documentpropertiesid in ('cbc06fdf-eeb7-4204-8376-ffa885734101',
'b999441a-f7c2-4cea-af3c-536d0653b721',
'cce6cc8b-52a9-47df-b084-f4be4a866aea',
'2b17c809-b56a-48ec-b313-5f6756619898');




-- 909e4d4d-ef23-4dd3-9351-98f776c63f1c
--27f04c71-9e53-4b6a-9301-ba559c66e4ba
--0dd103e2-2a10-409c-8338-3ec95f635781
--ac0b65b9-b299-4727-b3d8-b834a38bdbc8
  update documentattachment set insertedby = 'b66338ae-a2dc-425d-a59a-f4e7a1d5d704', updatedby = 'CDM-32232' 
  where documentpropertiesid in ('cbc06fdf-eeb7-4204-8376-ffa885734101',
'b999441a-f7c2-4cea-af3c-536d0653b721',
'cce6cc8b-52a9-47df-b084-f4be4a866aea',
'2b17c809-b56a-48ec-b313-5f6756619898');