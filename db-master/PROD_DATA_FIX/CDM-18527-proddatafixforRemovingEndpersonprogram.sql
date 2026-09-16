/*
   Issue Description: CDM-18527
   Category/ Module  : Removing end date for personprogram
   
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-11-13 21:18:06
-- 2021-11-13 21:18:06
update personprogramarea set activeflag = 1,enddate = null, updatedby = 'CDM-18527', updatedon = now() where personprogramid in ('fd54b753-18b1-467b-bc2b-3b61aeed085d','f38fe129-425e-49a5-9787-39ec32196100');
