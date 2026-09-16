/*
   Issue Description: CDM-15618
   Category/ Module  :  Removal Date
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakeservreqchildremoval 
SET removaldate = '2020-08-18T00:00:00',  
	removaltime = '2020-08-18T09:00:00',
	updatedby = 'CDM-15618',
	updatedon = now() 
WHERE intakeservreqchildremovalid = '0f7fc311-e3e0-4804-bb93-7f7917c0d304';