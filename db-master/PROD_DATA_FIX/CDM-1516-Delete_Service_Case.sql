UPDATE intakeservicerequest 
SET servicecaseid = NULL, updatedby = 'CDM-1516', updatedon = now()
WHERE intakeserviceid = '7cedab61-b240-4e2f-93ed-8f29b020d0aa';

UPDATE servicecase 
SET activeflag = 0, updatedby = 'CDM-1516', updatedon = now()
WHERE servicecaseid = 'a27ca234-a307-425a-ab07-02d306404d23';