
/*
   Issue Description: CDM-20672
   Category/ Module  :  Removal Date revision
   Root cause: user wants to edit removal date
   Pull request# for data fix: 6420
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakeservreqchildremoval 
SET removaldate = '2022-02-02T:00:00',  
	removaltime = '2022-02-02T18:00:00',
	updatedby = 'CDM-20672',
	updatedon = now() 
WHERE intakeservreqchildremovalid = '03b0bde3-2fb9-491d-abd5-356f8392b618';

UPDATE personprogramarea SET startdate  = '2022-02-02T:00:00',updatedby = 'CDM-20672',
	updatedon = now() WHERE personprogramid  ='ba7e536c-abcc-4c4b-a967-302c6577b047';