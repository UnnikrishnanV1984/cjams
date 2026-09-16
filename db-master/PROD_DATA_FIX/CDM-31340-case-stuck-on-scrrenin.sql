  /*
  Issue Description:  CDM-31340
   Category/ Module  : Intake referral
   Root cause: user wants to change the supervisor decision from screenin to screenout , which was entered by mistake
   Pull request# for code fix: 
   Reason why no related code fix: user requested 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/

UPDATE
  intakesnapshot
SET 
  updatedby = 'CDM-31340', 
  updatedon = now(), 
  jsondata = REPLACE(jsondata::TEXT, '"supDisposition": "Scrnin"', '"supDisposition": "ScreenOUT"')::JSONB
WHERE
  intakenumber = 'I231010603134'
  AND activeflag = 1;

UPDATE
  intakedastaging
SET 
  updatedby = 'CDM-31340', 
  updatedon = now(), 
  jsondata = REPLACE(jsondata::TEXT, '"supDisposition": "Scrnin"', '"supDisposition": "ScreenOUT"')::JSONB
  
WHERE
  intakenumber = 'I231010603134'
  AND activeflag = 1;