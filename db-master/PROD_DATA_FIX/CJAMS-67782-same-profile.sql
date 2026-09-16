
/*
Category/Module: Support
Root cause: Please carry out data fix to remove Client Adaeze Agbakwuru, CJAMS PID# 204894885 from Persons, Contacts and Assessments tab

Case# 211030011821
Fix provided: DB queries delete record in contactparticipant
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:
*/


update contactparticipant c 
set activeflag =0, updatedon =now(), updatedby ='CJAMS-67782'
 WHERE progressnoteid IN ('35d7a8df-9b1d-4e92-8724-9eda84b16d65'::uuid,'6635a6f3-4a76-44ef-b71d-69bdf98668a8'::uuid,'60097eb9-ecad-4b24-8533-48b7c27ca4e2'::uuid,'e1d1e60d-0739-4f5d-b5c2-6bd2fcfc7c7d'::uuid,'ffb2eb24-c887-4240-9b10-0332d16bb2b1'::uuid,'4a9f47b4-ac75-496d-a912-b3175ff5212a'::uuid,'8f27bba1-10a3-45b0-aa28-136a53743ef0'::uuid,'e1eaf6b2-e935-4fc5-a437-73b4a026e597'::uuid,'334451a7-a83a-4605-9c00-b0a2c970a28e'::uuid,'6075b2af-6bc4-4acf-aed2-f111800b2455'::uuid,'a9ae1f41-30d3-4521-a1dd-3b804ce23cc1'::uuid,'9339ca98-73c4-4fd0-b4c9-8fbdb17f17da'::uuid,'e6d8447b-f9ca-4829-b8ef-b7a940c0acde'::uuid,'efa91fc8-a16b-47fb-a983-1f2d07c25085'::uuid,'9b476f15-15d9-4dba-bb4b-2e5e7ebf94b2'::uuid,'4e48edb8-2ca3-429b-9ef2-a63095c93509'::uuid,'e78658e1-660d-4cad-9d0b-60b6e0bfaf57'::uuid,'bbbbfa4a-0b36-448d-b05d-00d8758f82ac'::uuid,'13c8bed6-c7a3-4705-8b2c-a73fe777e1db'::uuid,'f804002a-a576-40e6-aded-3cc77ad21fc1'::uuid,'fdce2fcb-3a37-46ec-b77e-d870ccbbc6a0'::uuid,'759a6e2f-1c50-4846-be19-aa17efe22dbc'::uuid,'72f3c19f-4d08-46f7-8c03-01bb65dae851'::uuid,'6b0d07b3-441a-4cc5-bcd8-8bff8281823c'::uuid,'9fe5ab54-8923-4f46-96fe-2cb9cad5be20'::uuid,'d59d9355-ddc5-45f6-9b3c-a53035a0785f'::uuid,'63470e66-40a2-42a3-96c0-5ddf9178f538'::uuid,'a0e3fa7e-e448-49ee-8bc5-b8eaee644896'::uuid,'bf39172f-bdc1-4b2e-8dc5-21157ff7805d'::uuid,'5be12571-979b-4395-9039-f2de7f2fa8a9'::uuid,'0bf3c90c-ce62-4794-9089-8a309b6e38bb'::uuid,'fa366229-5179-47cd-ae9b-903132fae137'::uuid,'3680346f-7065-4786-8760-3412841c09b5'::uuid,'2555f207-a234-4fb7-a15a-a1af2a4ce6fb'::uuid,'8a8b9e45-d5cf-4609-ae9a-8dc187812bf3'::uuid,'5c7e6f15-f122-4e91-8453-15e5d64ef9af'::uuid,'36fd36bb-0b2b-4e6f-82cc-bb7dd59b1055'::uuid,'47bf4672-1a7a-42a4-892e-1308518b7bd7'::uuid,'dd4f125b-59d1-49df-a0d6-9e1d504d76c0'::uuid,'9bd831c2-61c2-4538-8ee8-c2fa2fe76c3c'::uuid,'1bb1c84a-c088-40a2-b946-39357eb1a2bb'::uuid,'00115bc0-cfb5-4b2d-9832-872436bf19a0'::uuid)
 and activeflag =1 and intakeservicerequestactorid in ('ac696980-6398-4cb2-a75d-510c07252a5f','bc9855b4-81b9-46da-a6d2-55c2c375b487');
  
  


  update actor
set activeflag=0, updatedby='CJAMS-67782', updatedon=now()
where actorid='993fb3df-f617-49f6-88fb-ff09dd9ae95c' and activeflag=1;


update intakeservicerequestactor
set activeflag=0, updatedby='CJAMS-67782', updatedon=now()
where intakeservicerequestactorid in ('ac696980-6398-4cb2-a75d-510c07252a5f',
'bc9855b4-81b9-46da-a6d2-55c2c375b487')  and activeflag=1;

update personroletype 
set activeflag =0, updatedby='CJAMS-67782', updatedon=now()
where personroletypeid in ('88e057ae-05a9-4314-94a8-63a67edf87a2',
'a070e637-56f8-4a02-add1-72ee7e58a6c1');


update actorrelationship 
set activeflag =0, updatedby='CJAMS-67782', updatedon=now()
where intakeservicerequestactorid in ('ac696980-6398-4cb2-a75d-510c07252a5f',
'bc9855b4-81b9-46da-a6d2-55c2c375b487') and activeflag=1;

update personrole 
set activeflag =0, updatedby='CJAMS-67782', updatedon=now()
where personid='1c4e2b2d-433d-4edc-9f09-bffe5357b65c' and servicecaseid='7e590674-d0f1-4a44-bf54-813839623f55';



