/*
  Issue Description:CIDM-9195
Category/ Module:Application
Root cause: Data cleanup activities done for the following
Provider Not involved, School and Daycare, ProviderInvolved with data.
Pull request# for code fix:
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 
*/

-----231020550301
update investigationmaltreatment 
set providerid = 5088697, providername = 'Ronique Jones',  providerphonenumber = '', 
updatedby = 'CIDM-9195',  updatedon = now() 
where maltreatmentid =  '644b52d1-3466-4c0d-976a-2b6e5d9b7d2f' and activeflag = 1;

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'dcc5131f-14b7-4ff5-a3bd-96b78d3052c0' , 'FCPS', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

-------231021684277
update investigationmaltreatment
set providername ='Board of Child Care of the United Methodist Church – Cottage 4',
updatedby = 'CIDM-9195',  updatedon = now()
where maltreatmentid ='4a4d9621-4987-4d7d-96e8-9e091300f4aa' and activeflag =1;

-------221020253846
update investigationmaltreatment 
set providerid = null, providername = null, 
updatedby = 'CIDM-9195',  updatedon = now() 
where maltreatmentid =  '03e4bce3-6d95-4b1e-910e-ff01b3814023' and activeflag = 1;

-------231021281034 
update investigationmaltreatment 
set providerid = null, providername = null, 
updatedby = 'CIDM-9195',  updatedon = now() 
where maltreatmentid =  '75bb4a04-e38a-4ede-9560-a21fc84af197' and activeflag = 1;

DELETE FROM cjams.allegationprovidermaltreatment
WHERE investigationallegationid ='3b6c18ea-66fb-446e-8d15-556e47f3fa16' and updatedby ='CIDM-9195';
