
/*
   Issue Description: CDM-19790
   Category/ Module  : Updating Intake screenout Request
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-19790', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber in ('I202100131771', 'I202100229706','I202100416812','I202000370562','I211010171400') AND activeflag=1;


--"Scrnin"
--select jsondata->'DAType'->'DATypeDetail'->0 -> 'supDisposition' from intakesnapshot i where intakenumber in ('I202100131771', 'I202100229706','I202100416812','I202000370562','I211010171400') and activeflag = 1;