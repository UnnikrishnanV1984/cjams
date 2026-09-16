/*
   Issue Description: CDM-20408
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 4824
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
	
UPDATE Intakeservreqchildremoval
SET exitdate = null, updatedby = 'CDM-20408', updatedon = now() 
WHERE intakeservreqchildremovalid in  ('d32c50d3-b96a-4f9a-9d3f-16355fc824db', '8c883ccf-070a-42ed-8a52-093ba868e21d');

update personprogramarea 
set enddate = null, updatedby = 'CDM-20408', updatedon = now() 
where personprogramid in ('75aa572f-ea82-46f8-a16a-891a9c793cdc', '7871b139-ab5a-4767-9015-5a8ce3438ff4');