UPDATE
  routing
SET
  activeflag = 0 ,
  updatedby = 'CDM-19590',
  updatedon = now()
WHERE
  activeflag = 1
  AND routingid = '5f44df7c-a3ec-46dc-ba22-410b00491335';
