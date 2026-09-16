/*
   Issue Description: CDM-34944
   Category/ Module : Prod data fix to remove duplicate investigation findings
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

UPDATE cjams.investigationallegationmaltreators
SET intakeservicerequestactorid='50e6c373-7983-4d20-addb-74119cba5fb4', updatedby='CDM-34944', updatedon=now()
WHERE investigationallegationmaltreatorsid='7069061a-87bc-47de-960e-f37a605fb1b2' and investigationallegationid='7ac20382-7305-44af-bc46-af9c1daa5f3b' and activeflag=1;
