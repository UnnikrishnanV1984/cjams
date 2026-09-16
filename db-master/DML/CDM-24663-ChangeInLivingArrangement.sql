/*
   Issue Description: CDM-244663
   Category/ Module  :  Change in Living Arrangement
   Root cause: Change in Living Arrangement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-244663', updatedon = now()
where servicecaseid = 'c6761e3e-2372-47e5-b069-ac7eabbd9b43' and personid = '615dab84-837a-4e76-b8d1-b62b5d7437e9';

update actor set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-244663'
where actorid = '23d04477-a46b-49ba-af2f-09ad89da9dd3';

update placement set servicecaseid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c', updatedby = 'CDM-244663', updatedon = now() where placementid in ('c7e774f5-fa0a-4dc4-8f9a-6123dcfa80b7', 'a09ff9ff-2d7d-4181-8df9-674c2d3c0632');

update intakeservicerequestactor set servicecaseid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c', updatedby = 'CDM-244663', updatedon = now() where intakeservicerequestactorid = '560a81f7-db99-4557-b6d7-86053892e50e';

update actor set servicecaseid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c', activeflag = 1,
    updatedon = now(),
    updatedby = 'CDM-244663' where actorid = '23d04477-a46b-49ba-af2f-09ad89da9dd3';

update permanencyplan set activeflag = 0, updatedby = 'CDM-24663', updatedon = now() where permanencyplanid = 'e91880e6-e01b-41d6-9861-ec0278fca1b0';