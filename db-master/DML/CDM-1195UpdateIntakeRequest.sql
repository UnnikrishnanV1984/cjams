update intakeservicerequest SET activeflag = 0, updatedon = now(), updatedby = 'CDM-1195' WHERE 
intakenumber in ('CW10197960','CW10197725')  AND activeflag = 1;