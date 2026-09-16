/*
   Issue Description: CDM-17398
   Category/ Module  : add role
   Root cause:  persons involved in visit
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update
    contactparticipant
set
    intakeservicerequestactorid = '52881e0a-8611-48a1-805a-209369b830d7',
    participantid = '52881e0a-8611-48a1-805a-209369b830d7',
    updatedby = 'CDM-17398',
    updatedon = now()
where
    contactparticipantid = 'caf49f20-8ea0-403e-8869-a67b4747022d'
    and progressnoteid = 'f075f7f6-8d3d-4698-beb7-04d9b158d9de';



update
    contactparticipant
set
    intakeservicerequestactorid = '52881e0a-8611-48a1-805a-209369b830d7',
    participantid = '52881e0a-8611-48a1-805a-209369b830d7',
    updatedby = 'CDM-17398',
    updatedon = now()
where
    contactparticipantid = 'a21f42d0-5d32-4de1-b26b-4a5db52ec635'
    and progressnoteid = 'cb962aac-ec10-404f-b260-8a11a68d4250';
   
