/*
   Issue Description: CDM-28614
   Category/ Module  : Case Decision
   Root cause: Previous datafix which update the status to open reverting that.
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.intakeservicerequest
SET intakeserreqstatustypeid='7995cecb-062d-406c-8ea9-b1da4b1877d8', exitdate = '2021-12-21 00:00:00', updatedby='CDM-28614', updatedon=now()
WHERE intakeserviceid='cfb13857-a03d-40aa-89f5-3be5ecf87bb3' and servicerequestnumber='211020153156';

UPDATE IntakeServiceRequestDispositionCode 
SET servicerequesttypeconfigiddispostionid = 'd90db0d3-f665-49db-b3ad-0edb468bc02d',
updatedby = 'CDM-28614',updatedon = now() 
WHERE intakeservicerequestdispositioncodeid = '2ab695d8-28c9-4ccc-8524-dd2c366df5d5';