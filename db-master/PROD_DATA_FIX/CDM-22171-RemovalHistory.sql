/*
   Issue Description: CDM-22171
   Category/ Module  : Child Removal history
   Root cause: user wants to remove record from removal history
   Pull request# for code fix: 5421
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

UPDATE intakeservreqchildremoval 
SET updatedby = 'CDM-22171', 
	updatedon = now(), 
	activeflag = 0
WHERE intakeservreqchildremovalid = 'cf616b81-6c43-4054-b981-3e90293b159f';

UPDATE routing 
SET updatedby = 'CDM-22171', 
	updatedon = now(), 
	activeflag = 0
WHERE objectid = 'cf616b81-6c43-4054-b981-3e90293b159f';

