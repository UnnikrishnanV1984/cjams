/*
   Issue Description: CDM-17268
      Category/ Module  :end date removal
   Pull request# for code fix: 
  explanantion: user wants to remove end date

  */


UPDATE Intakeservreqchildremoval
SET exitdate = null, updatedby = 'CDM-17268', updatedon = now() 
WHERE intakeservreqchildremovalid = 'e5be7e9c-1b04-4099-af29-98a493d981b7';
	
update personprogramarea set enddate = null, updatedby = 'CDM-17268', updatedon = now() 
where personprogramid = 'cc5b0a2f-e46b-40ad-bd12-a8632538ef5d';