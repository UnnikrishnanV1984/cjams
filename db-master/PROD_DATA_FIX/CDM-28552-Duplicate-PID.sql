/*
   Issue Description: CDM-28552
   Category/ Module  : Others
   Root cause: user wants to delete persons form others tab
   Pull request# for data fix:8040
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update cjams.actor set activeflag = 0,updatedon = now(),updatedby = 'CDM-28552'
where actorid in ('68df060a-69f3-4965-a399-a0297962e127', '8ceab653-39b7-42fa-8f90-ae0e811f2903', 
'ed1c4b79-6af6-4c0a-9142-a8d86abc1e91', '3d0563c3-818b-48f4-864a-fb82db800e27', 'adc647c7-83e2-43d3-bad8-a093f6b34171');

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-28552'
where intakeservicerequestactorid in ('749ac9a2-325d-446a-ba1c-56fca6113f7e', 'e6d5bd22-18ab-4994-aac2-b849fefa7aa5', 
'f4fab791-c2c0-4ff8-88de-225cb8a8c6ed', 'f2bd3479-3e4f-447a-af06-e330ebd2cde4', 'ce29f448-b7a0-4c5b-9144-2e3627311a4a');

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-28552'
where personroleid in ('1dc5b818-5a69-4ce7-93f7-baf79bdde3f9',
'4193411c-dc0c-4a22-b485-9bab2b966e03',
'27826584-4359-4e7a-9860-8a9a5a75a08a',
'79af86c6-a347-4ad0-adfe-c3d9769bc993',
'9db4af78-9613-4dbd-93e2-a8a17a27f5e1');

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-28552'
where intakeservicerequestactorid in ('749ac9a2-325d-446a-ba1c-56fca6113f7e', 'e6d5bd22-18ab-4994-aac2-b849fefa7aa5', 
'f4fab791-c2c0-4ff8-88de-225cb8a8c6ed', 'f2bd3479-3e4f-447a-af06-e330ebd2cde4', 'ce29f448-b7a0-4c5b-9144-2e3627311a4a');

update personprogramarea set activeflag = 0 ,
updatedon = now(),
updatedby = 'CDM-28552'
where personprogramid in('3d3decfd-8b6c-4dd1-8fbf-901d8136f619', 'deabd89a-e797-4f22-a61c-b0acfbeaa279', '84636408-c52e-480b-9897-0358fff8e8e1',
'9fc12022-1cbd-4968-976c-2adda0386b9d', '320ff311-94a6-40e9-951e-7105b126bc43');