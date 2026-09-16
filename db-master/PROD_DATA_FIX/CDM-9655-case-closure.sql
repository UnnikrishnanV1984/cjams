update servicecasedisposition
set 
statusdate = '2021-1-11 09:00:00', 
intakeserreqstatustypekey = 'Closed',
dispositioncode = 'Closed',
"comments" = 'This case has been closed through ICPC, however we have been unable to close in CJAMS as it has been requiring a MFRA or MFIRA, which is not needed.',
effectivedate = '2021-1-11 09:00:00',
updatedby = 'CDM-9655',
updatedon = now()
Where servicecasedispositionid = '73a42c95-1be6-4c77-8006-32b5ca479cf9';

update routing set activeflag = 0, updatedby = 'CDM-9655', updatedon = now() where routingid = 'ab6ce040-8e9e-47f5-a131-be6f76dd1f4a';