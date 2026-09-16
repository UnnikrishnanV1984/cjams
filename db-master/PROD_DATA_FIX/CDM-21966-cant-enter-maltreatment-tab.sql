UPDATE
  intakeservicerequestsdm
SET
  isar = TRUE,
  updatedon = now(),
  updatedby = 'CDM-21966'
WHERE
  intakeservicerequestsdmid = '8151d1ae-46c9-444e-8482-5e51b7ad7cc4'
  AND isar = FALSE
  AND isir = FALSE
  AND activeflag = 1;