/*
   Issue Description:CDM-33792
   Category/ Module  : Decision 
   Root cause: Duplicate pending review records in decision
   Fix Provided: Did data fix to approve the old 2021 review record as there is a case reopen already available

*/


UPDATE cjams.servicecasedisposition
SET  activeflag=0, updatedby='CDM-33792', updatedon=now()
WHERE servicecasedispositionid='a8f69cf7-8948-4f52-a866-d29be7d35ca9'::uuid and servicecaseid='777c321e-b04d-43e3-b5ff-e033a55ee57e';

UPDATE cjams.routing
SET objectid='931de826-2a18-4103-8108-358012bcc023', activeflag=0, updatedby='CDM-33792', updatedon=now()
WHERE routingid='67b3cf14-9861-4ed4-8483-bc087facdcc0'::uuid and eventcode='SCDR';

UPDATE cjams.routing
SET routingstatustypeid=16, updatedby='CDM-33792', updatedon=now()
WHERE routingid='1c82e087-5c2e-41c0-b16f-396b54da847b'::uuid and eventcode='SCDR';
