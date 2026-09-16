/*
   Issue Description: CDM-28612
   Category/ Module  : Case Decision
   Root cause: Previous datafix which update the status to open reverting that.
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.intakeservicerequest
SET intakeserreqstatustypeid='7995cecb-062d-406c-8ea9-b1da4b1877d8', exitdate = '2021-06-22 00:00:00', updatedby='CDM-28612', updatedon=now()
WHERE intakeserviceid='67f426de-3605-4c33-91ea-b2261b2f747b' and servicerequestnumber='202101230106109';

UPDATE IntakeServiceRequestDispositionCode 
SET servicerequesttypeconfigiddispostionid = 'd90db0d3-f665-49db-b3ad-0edb468bc02d',
updatedby = 'CDM-28612',updatedon = now() 
WHERE intakeservicerequestdispositioncodeid = '6cb18053-56ae-4dfa-9958-c5e0e2400ddb';