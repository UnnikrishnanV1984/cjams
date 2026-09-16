
/*
   Issue Description: CDM-15683
   Category/ Module  :  Update removal information
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- 6bc0255f-92a1-412e-a7e1-00466b5bc2dd	2515802
update intakeservreqchildremoval set primarycaregiveractorid = '333ae24f-f608-4e72-8779-6c647de02a53', primarycaregiverid = '3115690',updatedby = 'CDM-15683', updatedon = now() where removalid in (193556,193557);
