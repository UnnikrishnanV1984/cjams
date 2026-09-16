/*
   Issue Description: CIDM-8540
   Category/ Module  : Prod data fix to Update Gap Relationship fix
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- 1015	3374872
UPDATE cjams.gapeligibilityinfo
SET primaryguardianrelationshipid=1015, updatedby = 'CIDM-8540', updatedon = now()
WHERE gapeligibilityinfoid='f5aad438-ab31-4050-9b86-69399e02a027'::uuid;

--1015	1463885
UPDATE cjams.gapeligibilityinfo
SET primaryguardianrelationshipid=1015, updatedby = 'CIDM-8540', updatedon = now()
WHERE gapeligibilityinfoid='1d6a2de2-58d1-4849-a8ff-5873289f5fbf'::uuid;

--1015	1463885
UPDATE cjams.gapeligibilityinfo
SET primaryguardianrelationshipid=1015, updatedby = 'CIDM-8540', updatedon = now()
WHERE gapeligibilityinfoid='61612473-ee51-4d2d-b2c3-dabc2070bb01'::uuid;

--1015	2834983
UPDATE cjams.gapeligibilityinfo
SET primaryguardianrelationshipid=1015, updatedby = 'CIDM-8540', updatedon = now()
WHERE gapeligibilityinfoid='d617210b-81f5-48a1-b0cb-c54d5e84f79d'::uuid;

-- 1015	3963422
UPDATE cjams.gapeligibilityinfo
SET primaryguardianrelationshipid=1015, updatedby = 'CIDM-8540', updatedon = now()
WHERE gapeligibilityinfoid='590e028d-8af9-4608-9e0e-71eafb1342d0'::uuid;

--1015	3370829
UPDATE cjams.gapeligibilityinfo
SET primaryguardianrelationshipid=1015, updatedby = 'CIDM-8540', updatedon = now()
WHERE gapeligibilityinfoid='0b764454-af5a-47b7-b353-f7a3c1680b06'::uuid;

-- 1015	3898065
UPDATE cjams.gapeligibilityinfo
SET primaryguardianrelationshipid=1015, updatedby = 'CIDM-8540', updatedon = now()
WHERE gapeligibilityinfoid='afe5237b-b6f4-4a3a-8229-b5fd9e5ca4de'::uuid;

--1015	3151715
UPDATE cjams.gapeligibilityinfo
SET primaryguardianrelationshipid=1015, updatedby = 'CIDM-8540', updatedon = now()
WHERE gapeligibilityinfoid='4ec8b3e0-dace-4131-b65a-81dc2ce24c64'::uuid;

--1015	3642862
UPDATE cjams.gapeligibilityinfo
SET primaryguardianrelationshipid=1015, updatedby = 'CIDM-8540', updatedon = now()
WHERE gapeligibilityinfoid='6aa89803-2555-4450-ab8f-970b010070ec'::uuid;



-- Foster Parent 4220118
UPDATE cjams.gapeligibilityinfo
SET primaryguardianrelationship='Foster-Parent', updatedby = 'CIDM-8540', updatedon = now()
WHERE gapeligibilityinfoid='577c07f7-593b-483c-a244-b0c2aee0161e'::uuid;





-- Updating the picklist values


UPDATE cjams.relationshiptype
SET fourerelid=1001, fourereldesc='within', updatedby = 'CIDM-8540', updatedon = now()
WHERE relationshiptypekey='STGRPT' and sequencenumber = 120;

UPDATE cjams.relationshiptype
SET fourerelid=1001, fourereldesc='within', updatedby = 'CIDM-8540', updatedon = now() 
WHERE relationshiptypekey='STGRCLD' and sequencenumber = 122;

UPDATE cjams.relationshiptype
SET fourerelid=1001, fourereldesc='within', updatedby = 'CIDM-8540', updatedon = now()
WHERE relationshiptypekey='FOSPARNT' and sequencenumber = 129;

UPDATE cjams.relationshiptype
SET fourerelid=1001, fourereldesc='within', updatedby = 'CIDM-8540', updatedon = now()
WHERE relationshiptypekey='Kin' and sequencenumber = 130;

UPDATE cjams.relationshiptype
SET fourerelid=1001, fourereldesc='within', updatedby = 'CIDM-8540', updatedon = now()
WHERE relationshiptypekey='Relative' and sequencenumber = 131;
