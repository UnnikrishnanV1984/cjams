/*
   Issue Description: CDM-21465
   Category/ Module  : service plan 
   Root cause: Head of house hold is not displaying in pdf file for in home 
   Pull request# for code fix: 5749
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
	update snapshothist 
    set snapshotdata = replace(snapshotdata::text, '"legalGuardian": ""', '"legalGuardian": "Rian Matthews"')::json, updatedby = 'CDM-21465', updatedon = now()
    where id = '8a3af1a7-323e-45aa-87cf-dfe01ef8dd45';