/*
   Issue Description: CDM-18954
   Category/ Module  : remove person
   Root cause: user wants to remove person other
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update actor set activeflag = 0, updatedby = 'CDM-18954', updatedon = now() 
where  personid in ('9d19ba4d-61e4-4ab1-9dac-e0898b10805f','549f349a-2580-4623-9cac-2f390c46ae46')
and servicecaseid = '6183ea3e-b96f-40e6-ac5d-7679da3a2f94';

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-18954', updatedon = now() 
where  personid in ('9d19ba4d-61e4-4ab1-9dac-e0898b10805f','549f349a-2580-4623-9cac-2f390c46ae46')
and servicecaseid = '6183ea3e-b96f-40e6-ac5d-7679da3a2f94';

update personrole set activeflag = 0, updatedby = 'CDM-18954', updatedon = now() 
where  personid in ('9d19ba4d-61e4-4ab1-9dac-e0898b10805f','549f349a-2580-4623-9cac-2f390c46ae46')
and servicecaseid = '6183ea3e-b96f-40e6-ac5d-7679da3a2f94';

update personprogramarea set activeflag = 0, updatedby = 'CDM-18954', updatedon = now() 
where  personid in ('9d19ba4d-61e4-4ab1-9dac-e0898b10805f','549f349a-2580-4623-9cac-2f390c46ae46')
and objectid = '6183ea3e-b96f-40e6-ac5d-7679da3a2f94';
