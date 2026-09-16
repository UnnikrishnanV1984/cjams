/*
   Issue Description: CDM-28613
   Category/ Module  : Case Decision
   Root cause: Previous datafix which update the status to open reverting that.
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.intakeservicerequest
SET intakeserreqstatustypeid='7995cecb-062d-406c-8ea9-b1da4b1877d8', exitdate = '2021-06-22 00:00:00', updatedby='CDM-28613', updatedon=now()
WHERE intakeserviceid='557a43c7-a0cc-4047-89db-cc20e5d22120' and servicerequestnumber='202101170104864';

UPDATE IntakeServiceRequestDispositionCode 
SET servicerequesttypeconfigiddispostionid = 'd90db0d3-f665-49db-b3ad-0edb468bc02d',
updatedby = 'CDM-28613',updatedon = now() 
WHERE intakeservicerequestdispositioncodeid = '5a814f7a-e3e7-47fc-91c0-e980ac7f7349';