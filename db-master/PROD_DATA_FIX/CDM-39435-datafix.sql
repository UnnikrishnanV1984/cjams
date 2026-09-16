/*
   Issue Description: CDM-39435
   Category/ Module  :Persons
   Root cause:  need of removing Norman Logan Sr from the case head of household name is Stone. This person is listed in others.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update actor set activeflag = 0, updatedby = 'CDM-39435', updatedon = now() 
where personid='2f2b78c0-22e0-4275-9f80-aa80be7ede99' and actorid='aaa32c16-547f-4254-a41e-6afd2a1f461b' and activeflag = 1;

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-39435', updatedon = now() 
where personid='2f2b78c0-22e0-4275-9f80-aa80be7ede99' and actorid='aaa32c16-547f-4254-a41e-6afd2a1f461b' and activeflag = 1;

update personrole set activeflag = 0, updatedby = 'CDM-39435', updatedon = now() 
where personid='2f2b78c0-22e0-4275-9f80-aa80be7ede99' and personroleid='49979477-3f2c-44b0-afc9-4b77985c0d11' and activeflag = 1;

update personprogramarea set activeflag = 0, updatedby = 'CDM-39435', updatedon = now()
where personprogramid='0fbb10dc-a91b-4260-9e8a-870108630c6c' and personid='2f2b78c0-22e0-4275-9f80-aa80be7ede99' and  activeflag=1;

update personroletype set activeflag = 0, updatedby = 'CDM-39435', updatedon = now()
where personroleid='49979477-3f2c-44b0-afc9-4b77985c0d11' and activeflag = 1;