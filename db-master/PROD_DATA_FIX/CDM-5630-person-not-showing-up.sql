update intakeservicerequestactor 
set isprimary = true, updatedby = 'CDM-5630', updatedon = now()
where 
intakeservicerequestactorid in ('b5b5f890-e557-494a-824c-625efee73ab3', 'eb7cc214-aa1a-451e-b898-90cd87825d4a'); 

update personidentifier set activeflag = 0, updatedby = 'CDM-5630', updatedon = now()
where personidentifierid in ('ce0fc2a2-62cb-4b3f-9297-20eda0a6c030', '3afdf936-9d82-41e2-8280-35a7a78f3266');
