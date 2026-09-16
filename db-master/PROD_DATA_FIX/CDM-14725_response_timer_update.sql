/*
   Issue Description: CDM-14725
   Category/ Module  : Response Timer
   Root cause: User requested to update the response timer
*/

UPDATE
  intakeservicerequest
SET
  responsetimer = '2021-04-18 11:42:00.000',
  updatedby = 'CDM-14725',
  updatedon = now()
WHERE
  servicerequestnumber = '202101090102509';