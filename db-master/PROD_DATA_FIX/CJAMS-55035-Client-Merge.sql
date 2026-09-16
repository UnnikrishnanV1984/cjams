/*
Issue Description: 
Changes Need to be done from application side:
CJAMS PID: 4407622, Correct the name to match with MDM/R360 

First Name: Parker
Middle Name: James
Last Name: Colton
SSN: 774-62-6225
DOB: 01/18/2019
GEN: Male
 
Once the above change is made in the Local DB,

PID 4407622 Needs removed from Intake - I241013155047 - Correct child, PID:200771469 needs to be added
PID 4407622 Needs removed from Intake - CW10195615 - Correct child, PID:200771469 needs to be added.
PID 4407622 Needs removed from Service case - 3273553 (Note: Correct child already added in this case)

   Category/ Module  :  Person Profile
   Root cause: E&E data update
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:

*/

update person 
set firstname='Parker',middlename='James',lastname='Colton',ssnno='774626225', updatedby='CJAMS-55035', updatedon=now() 
where personid='d65ee26b-9678-4a7a-ac8d-e156cd408782'
and activeflag=1;

update personidentifier 
set personidentifiervalue='774626225', updatedby='CJAMS-55035', updatedon=now()
where personid = 'd65ee26b-9678-4a7a-ac8d-e156cd408782' and personidentifiertypekey='SSN' and activeflag=1;


--PID 4407622 Needs removed from Intake - I241013155047 - Correct child, PID:200771469 needs to be added

update actor 
set personid='569f7668-9459-49ed-8c56-635678610ed4', updatedby='CJAMS-55035', updatedon=now() 
where actorid in ('106a9785-306e-4da7-88a2-e9156063989c') and activeflag = 1;


update intakeservicerequestactor 
set personid='569f7668-9459-49ed-8c56-635678610ed4', updatedby='CJAMS-55035', updatedon=now() 
where actorid ='106a9785-306e-4da7-88a2-e9156063989c' and activeflag = 1;

update cjams.personrole
set personid='569f7668-9459-49ed-8c56-635678610ed4', updatedon = now(), updatedby = 'CJAMS-55035'
where personroleid ='a6db0b86-bb1f-4ae1-883a-a84877905674' and activeflag = 1;


--PID 4407622 Needs removed from Intake - CW10195615 - Correct child, PID:200771469 needs to be added.

update actor 
set personid='569f7668-9459-49ed-8c56-635678610ed4', updatedby='CJAMS-55035', updatedon=now() 
where actorid in ('2672f32e-4c6e-48a1-9830-74ae2be457d4') and activeflag = 1;


update intakeservicerequestactor 
set personid='569f7668-9459-49ed-8c56-635678610ed4', updatedby='CJAMS-55035', updatedon=now() 
where actorid ='2672f32e-4c6e-48a1-9830-74ae2be457d4' and activeflag = 1;

update cjams.personrole
set personid='569f7668-9459-49ed-8c56-635678610ed4', updatedon = now(), updatedby = 'CJAMS-55035'
where personroleid ='443c7222-fc85-4012-a551-abfec7ed98b4' and activeflag = 1;

--PID 4407622 Needs removed from Service case - 3273553 (Note: Correct child already added in this case)
update actor 
set activeflag =0, updatedby='CJAMS-55035', updatedon=now() 
where actorid in ('7c8425ff-6474-4b3a-8aa6-bc4eebaa9417') and activeflag = 1;


update intakeservicerequestactor 
set activeflag =0, updatedby='CJAMS-55035', updatedon=now() 
where actorid ='7c8425ff-6474-4b3a-8aa6-bc4eebaa9417' and activeflag = 1;

update cjams.personrole
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-55035'
where personroleid ='00c95396-dee0-41c4-8e16-dc02e475afec' and activeflag = 1;

update cjams.personroletype
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-55035'
where personroleid ='00c95396-dee0-41c4-8e16-dc02e475afec' and activeflag = 1;

update personprogramarea 
set activeflag =0 , updatedby = 'CJAMS-55035', updatedon = now() 
where personprogramid='81e775f3-15b0-4468-8e01-022b3ecabc01' and activeflag = 1;


UPDATE actorrelationship ar
SET activeflag = 0, updatedby = 'CJAMS-55035', updatedon = now()
WHERE ar.intakeservicerequestactorid = '7a664520-d33f-41a0-ade3-e762af95ceeb' AND ar.person1id = 'd65ee26b-9678-4a7a-ac8d-e156cd408782' AND ar.activeflag = 1; 