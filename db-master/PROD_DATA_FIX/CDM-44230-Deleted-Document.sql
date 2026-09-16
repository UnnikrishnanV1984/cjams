/*
   Issue Description: CDM-44230
   Category/ Module  : Prod data fix to add documents into case.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.documentproperties
SET objecttypekey ='CasePerson', updatedon = now(), updatedby = 'CDM-44230'
WHERE documentpropertiesid IN ('61f03a12-008e-4c36-b45c-8268d4430648'::uuid,'e3c9a525-522a-4dec-9d6d-d26dd303a8d1'::uuid,'08f351ce-5d88-4733-a2be-51b3fa08d5b8'::uuid,'c1fd1827-879c-4f7b-9f50-3626db8aac79'::uuid,'b7f84cad-1064-4abc-bcb6-09dff2da3265'::uuid,'c532e6e5-1852-4b7c-ba6f-80f10fa4d3c7'::uuid,'35b29a33-f3cd-405b-bd2f-a8a5e30e718c'::uuid,'3dfe9458-ceeb-4600-b06e-28fc22e8a28a'::uuid,'8ab1452b-ae46-4c70-91b9-ee5494cc2e70'::uuid) and activeflag = 1;