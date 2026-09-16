/*
   Issue Description: CDM-30356
   Category/ Module  : Child Removal history
   Root cause: user wants to remove record from removal history
   Pull request# for code fix: 5421
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

UPDATE intakeservreqchildremoval 
SET updatedby = 'CDM-30356', 
	updatedon = now(), 
	activeflag = 0
WHERE intakeservreqchildremovalid = 'bce4bc2b-c0e2-4c1c-b8ec-fcb574b1a34d';

UPDATE routing 
SET updatedby = 'CDM-30356', 
	updatedon = now(), 
	activeflag = 0
WHERE  routingid = 'b1129360-a2b6-4b91-93bc-8c89f71dd669';

UPDATE personprogramarea 
SET activeflag = 0
	, updatedby ='CDM-30356'
	, updatedon = now() 
WHERE personprogramid  = 'e37ffb9e-55cd-4741-8178-ae3551328cec';
