/*
   Issue Description: CDM-37636
   Category/ Module  : Christina Robbins Error
   Root cause: I added Maria Salgado-Hernandez to the case by mistake. I need her removed from the case please. 
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-37636'
where actorid in('62bf089c-4166-44bc-be8b-67cca402a462');

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-37636'
where intakeservicerequestactorid in('8e244a3a-7208-4800-ac7f-9542727df103','a4f0146b-5b66-4c4c-8b06-c14d168bc99a','70b70391-c46d-4c01-9008-6cdb901f0d2c');

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-37636'
where personroleid  in('ab7ae891-c4f7-44eb-a404-805f9c4f3fa2');

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-37636'
where actorrelationshipid in('1cc052a8-1f36-4246-b0d4-22fe8a9988a1','98b0c38f-3f8d-41fa-b6c4-c2191aee0bea','677ee987-e25c-4321-9dd6-76b715860eb8');


update personprogramarea 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-37636'
where objectid = 'bc833289-0e3c-4cc4-b184-39cb8908a64d'
and personid = '44e783f8-8720-477c-8c10-3bb2ae367f8f'
and personprogramid ='3468d853-ed58-434f-b5e5-79fb1589b4e9';