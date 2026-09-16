/*
Issue Description: Please remove the person (PID: 203480804) from the case (241022475764).
Category/ Module : Error
Root cause: Wrong person was added to the case by mistake
Fix provided: Yes, write db query
Code fix ticket#: CDM-39970
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating actor
update actor 
set 
	activeflag = 0,
	updatedby = 'CDM-39970',
	updatedon = now()
where actorid = '0340853b-310c-4ee4-a35c-280268779e57' and activeflag = 1;

--Updating intakeservicerequestactor
update intakeservicerequestactor
set 
	activeflag = 0,
	updatedby = 'CDM-39970',
	updatedon = now()
where intakeservicerequestactorid = '1a70df6a-608e-4df2-b27b-08c1db591ab7' and activeflag = 1;

--Updating actorrelationship
update actorrelationship
set 
	activeflag = 0,
	updatedby = 'CDM-39970',
	updatedon = now()
where intakeservicerequestactorid = '1a70df6a-608e-4df2-b27b-08c1db591ab7' and activeflag = 1;

--Updating personrole
update personrole 
set 
	activeflag = 0,
	updatedby = 'CDM-39970',
	updatedon = now()
where personroleid = 'df54a474-867d-4294-afa9-e0b2f929a18d' and activeflag = 1;

--Updating personroletype
update personroletype
set 
	activeflag = 0,
	updatedby = 'CDM-39970',
	updatedon = now()
where personroleid = 'df54a474-867d-4294-afa9-e0b2f929a18d' and activeflag = 1;

--Updating personprogramarea
update personprogramarea 
set 
	activeflag = 0,
	updatedby = 'CDM-39970',
	updatedon = now()
where personprogramid = 'feb19f01-5328-4c6e-8043-1b4320e1becf' and activeflag = 1;