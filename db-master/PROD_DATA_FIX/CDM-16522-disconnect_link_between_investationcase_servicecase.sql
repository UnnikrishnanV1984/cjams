/*
Issue Description: CDM-16522
Category/ Module : Case delink
Root cause: User connected to case that need to be disconnected
Pull request# for code fix:
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date:
*/

UPDATE intakeservicerequest 
SET servicecaseid = null,
	updatedon = now(),
	updatedby = 'CDM-16522'
WHERE activeflag = 1 AND servicerequestnumber = '211020133674'; 