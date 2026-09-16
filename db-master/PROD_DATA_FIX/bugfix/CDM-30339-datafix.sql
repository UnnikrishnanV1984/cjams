/*
   Issue Description: CDM-30358
   Category/ Module  : person remove
   Root cause: Updates that by user in CJams is showing the name Kemeshia Maith instead of Cindy Sindorf 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-30339', updatedon = now()
where intakeservicerequestactorid='1c75f6e8-49f6-47d4-bf09-87ee910333b8';

update actor set activeflag = 0, updatedby = 'CDM-30339', updatedon = now()
where personid='507be2a7-9b5a-4d5f-87e7-51f795d78928';
