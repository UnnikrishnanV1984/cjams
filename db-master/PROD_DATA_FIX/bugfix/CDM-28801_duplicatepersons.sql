/*
   Issue Description: CDM-28801
   Category/ Module  : Person Profile
   Root cause: Duplicate records in person role
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.personrole
set activeflag = 0, updatedon = now(), updatedby = 'CDM-28801'
where personroleid in ('a8a67bbb-36cb-4c5a-89ae-14e6632bd67e','a684a8bc-b2f9-4d6f-8bb7-65d163caefa8');

UPDATE cjams.contactparticipant
SET activeflag=0, updatedby='CDM-28801', updatedon=now()
WHERE contactparticipantid='05ca7d0c-218b-43dc-8b34-46846eecfcaa' and progressnoteid='7c005149-6622-4cd6-9dbd-20ad14acc9b8';


