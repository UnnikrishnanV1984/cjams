/*
   Issue Description: CDM-28756 - Delete Person Card
   221030016103:The wrong person was added to this case. Please delete the persons card.
   Root cause: User Error. Wrong person addedd to case.
   Case#: 221030016103 (676ca3d7-7cd2-451e-9c39-ef1f1eec4f0c)
   Person to be deleted from case: 200910260 (e4b4e724-577f-4867-9b99-ec30f4c15aff)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix: Data fix to remove the approval request record.
*/

update cjams.intakeservicerequestactor  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-28756'
where intakeservicerequestactorid= '28d380d5-99a8-4442-b05c-1a4c8e375917'
and activeflag = 1;

update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-28756'
where actorid ='0fbd7806-db99-4201-b22d-a843398dd794'
and activeflag = 1;

update cjams.personrole 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-28756'
where personroleid  = 'f758e136-301a-489f-ba54-6121de139d7a'
and activeflag = 1;


update cjams.personroletype 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-28756'
where personroleid  = 'f758e136-301a-489f-ba54-6121de139d7a'
and activeflag = 1;


update cjams.actorrelationship 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-28756'
where intakeservicerequestactorid ='28d380d5-99a8-4442-b05c-1a4c8e375917'
and activeflag = 1;