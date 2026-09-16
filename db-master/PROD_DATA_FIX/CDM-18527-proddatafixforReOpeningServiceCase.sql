
/*
   Issue Description: CDM-18527
   Category/ Module  : Re-opening Service case and removing person program area for open removal
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-11-13 21:18:06
-- 2021-11-13 21:18:06
update personprogramarea set activeflag = 0, updatedby = 'CDM-18527', updatedon = now() where personprogramid in ('fd54b753-18b1-467b-bc2b-3b61aeed085d','f38fe129-425e-49a5-9787-39ec32196100');
update servicecasedisposition set activeflag = 0, updatedby = 'CDM-18527', updatedon = now() where servicecasedispositionid = '70690f8f-d40e-4e67-acc2-7a27f4ebe11b';
-- Closed	2021-11-14 02:18:06 Closed
UPDATE servicecase SET statustypekey = 'Open', dispositioncode = 'Open', 
    enddate = null, 
    updatedby = 'CDM-18527',
    updatedon = now() 
WHERE servicecaseid = '67f6d38a-d262-4507-9301-b0763cd5dae8';