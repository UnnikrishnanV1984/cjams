/*
   Issue Description: CDM-17731
   Category/ Module  :  Response Timer
   Root cause: User asked to update response timer date
   Pull request# for code fix: 6505
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   CDM-18312 updated wrongly do doing data fix again
*/
UPDATE
  intakeservicerequest
SET
  responsetimer = '2021-10-21 16:15:00.000',
  updatedby = 'CDM-17731',
  updatedon = now()
WHERE
  servicerequestnumber = '211020139173';