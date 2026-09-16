
/*
   Issue Description: CDM-18803
   Category/ Module  : User asked to remove the end date for child removal
   Root cause: user wants to remove
   Pull request# for code fix: 
   Explanantion: user wants to delete the approval record which is already approved
*/

UPDATE Intakeservreqchildremoval
SET exitdate = null, updatedby = 'CDM-18803', updatedon = now() 
WHERE intakeservreqchildremovalid = 'd0270818-d783-4449-a56d-4f63b6421ddf';
    
update personprogramarea set enddate = null, updatedby = 'CDM-18803', updatedon = now() 
where personprogramid = '3b63d047-4436-4fb2-b6a2-ead090b02c1a';