/* 
    Issue Description: CJAMS-60928
  Category/ Module: Persons
  Root cause: User request to remove the delete the wrong child (PID  #204049693) in the case (241030422252) and 
  correct the July 8th contact note with the correct child PID is #204019857.
  Fix provided : data fix provided to remove the delete the wrong child (PID  #204049693) in the case (241030422252) and 
  correct the July 8th contact note with the correct child PID is #204019857.
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CJAMS-60928', updatedon = now()
where intakeservicerequestactorid in ('e5e48169-f796-4511-8837-5b2769ff3e45','7e6094dd-10ac-4dbb-b865-d81ed1217dae') 
and personid = 'ef0a2eb9-a540-428f-973d-ec96e9b27ef7'
and servicecaseid = '0771e1c3-126b-46a4-a612-e1bbb21e43fb'
and activeflag = 1;

update actor
set activeflag =0, updatedby='CJAMS-60928', updatedon= now()
where personid = 'ef0a2eb9-a540-428f-973d-ec96e9b27ef7'and actorid = '25bf057d-3d58-4722-a326-1788446c7fa3'
and activeflag = 1;

update personrole 
set activeflag =0, updatedby='CJAMS-60928', updatedon= now()
where personroleid = '25a1896e-c698-41ec-a664-a1027dca3331' and personid ='ef0a2eb9-a540-428f-973d-ec96e9b27ef7';

update personroletype
set activeflag = 0, updatedby = 'CJAMS-60928', updatedon = now() 
where personroleid = '25a1896e-c698-41ec-a664-a1027dca3331';

update actorrelationship
set activeflag = 0,updatedon = now(),updatedby = 'CJAMS-60928'
where intakeservicerequestactorid in ('e5e48169-f796-4511-8837-5b2769ff3e45','7e6094dd-10ac-4dbb-b865-d81ed1217dae') 
and activeflag = 1;

update cjams.contactparticipant set participantid = '756ed2ff-0606-4e4c-9cb1-fca5b714d559', intakeservicerequestactorid = '756ed2ff-0606-4e4c-9cb1-fca5b714d559',
updatedon = now(), updatedby = 'CJAMS-60928'
where contactparticipantid = 'bdea1860-30a9-4958-81c5-c93813a27a34' and intakeservicerequestactorid = 'e5e48169-f796-4511-8837-5b2769ff3e45' and activeflag = 1;