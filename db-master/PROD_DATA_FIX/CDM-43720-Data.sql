/*
  Issue Description:  CDM-43720
   Category/ Module  :  Assessments: SAFE-C
   Root cause:User request to do a data fix to 1. Person (CJAMS PID# 4380771) to be removed from the case.
   2. Contact (Contact ID# 14667084) - to be changed (Person Contacted, Who is the subject matter of the contact? values to be changed as CJAMS PID# 200843655 instead of CJAMS PID# 4380771).
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/

UPDATE cjams.contactparticipant
SET intakeservicerequestactorid='bbfd3d60-f0da-49d0-afb6-1e5e4febb2fe'::uuid, updatedby = 'CDM-43720', updatedon = now() 
WHERE contactparticipantid='3ce98119-cc59-44d4-a312-8a40f180d29a'::uuid ;

UPDATE cjams.progressnote
SET 
focusperson='{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"bbfd3d60-f0da-49d0-afb6-1e5e4febb2fe","participantid":"bbfd3d60-f0da-49d0-afb6-1e5e4febb2fe","firstname":"Seven","lastname":"Bagley","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}'::json, 
updatedby = 'CDM-43720', updatedon = now()
WHERE progressnoteid='3129634a-f4b4-4e40-abc2-c2355d1cfce3'::uuid
and activeflag = 1;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-43720',
	updatedon = now()
where personid = 'a01718dc-78ae-4a47-9511-4b20fa3e7aa6'
	and objectid = 'eeed8155-9362-4df0-8de3-de45277013b3' 
	and activeflag = 1 ;

    update personrole
set activeflag = 0,
	updatedby = 'CDM-43720',
	updatedon = now()
where personid = 'a01718dc-78ae-4a47-9511-4b20fa3e7aa6'
	and intakeserviceid  = 'eeed8155-9362-4df0-8de3-de45277013b3' 
	and activeflag = 1 ;

    update actor
set activeflag = 0,
	updatedby = 'CDM-43720',
	updatedon = now()
where personid = 'a01718dc-78ae-4a47-9511-4b20fa3e7aa6'
	and intakeserviceid  = 'eeed8155-9362-4df0-8de3-de45277013b3' 
	and activeflag = 1 ;

update actorrelationship 
set activeflag = 0,
updatedby = 'CDM-43720',
updatedon = now()
where intakeservicerequestactorid = 'f54f3032-9bb2-400b-a8c2-6c4300d55901'
and intakeserviceid = 'eeed8155-9362-4df0-8de3-de45277013b3'
and activeflag = 1;

update personroletype set activeflag = 0,
updatedby = 'CDM-43720',
updatedon = now()
where personroletypeid = 'ad1580e0-8771-440b-b123-34707d526d9b' 
and personroleid = '8e210092-a462-4faa-ab12-7afef55309f9'
and activeflag = 1;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-43720',
	updatedon = now()
where personid = 'a01718dc-78ae-4a47-9511-4b20fa3e7aa6'
	and intakeserviceid  = 'eeed8155-9362-4df0-8de3-de45277013b3' 
	and activeflag = 1 ;
