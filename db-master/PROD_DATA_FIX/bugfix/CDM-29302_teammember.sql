/*
   Issue Description: CDM-29302
   Category/ Module  : User Profile 
   Root cause: User as updated the team. Role got changed to case management specialist.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
-- Previous role is 'CWCMSP'
UPDATE cjams.teammember
SET roletypekey='CWCW', updatedby='CDM-29302', updatedon=now()
WHERE teammemberid='0598e771-282b-4cb1-b325-e76125e75512';

UPDATE cjams.rolemapping
SET roleid=71, updatedby='CDM-29302', updatedon=now()
WHERE principalid = '14741' and activeflag = 1;
