update intakeservicerequest
set
intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8',
updatedby = 'CDM-12813',
updatedon = now()
where 
intakeserviceid = 'de4e6275-9f78-4562-80ba-6159096eac45';

update intakeservicerequestdispositioncode
set
intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8',
updatedby = 'CDM-12813',
updatedon = now()
where 
intakeservicerequestdispositioncodeid = '5d93027c-a512-4f3c-ae23-5fdfed868b7e';