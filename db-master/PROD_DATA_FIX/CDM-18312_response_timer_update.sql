/*
   Issue Description: CDM-18312
   Category/ Module  : Response Timer
   Root cause: User requested to update the response timer
*/

UPDATE
  intakeservicerequest
SET
  responsetimer = '2021-10-12 16:15:00.000',
  updatedby = 'CDM-18312',
  updatedon = now()
WHERE
  servicerequestnumber = '211020139173';