update routing set activeflag = 1,updatedby = 'CDM-10780', updatedon = now() where routingid = '694a5d02-fc85-49c6-9f78-f5da772f438b';
update intakeservicerequestdispositioncode i set activeflag  = 1, IntakeSerReqStatusTypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby = 'CDM-10780', updatedon = now() where intakeserviceid = 'df513111-c7a2-47cc-ae58-b3d88f3be87a' and intakeservicerequestdispositioncodeid = '806ab2f5-3db5-448c-a19b-c5ef057374ab';

