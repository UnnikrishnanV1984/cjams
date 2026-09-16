/*
   Issue Description: CDM-20628
   Category/ Module  : Reopen the case 
   Root cause: user wants to reopen the case which is closed bymistake
   Pull request# for code fix: 7270
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix.
*/
update servicecasedisposition 
set activeflag = 0, updatedby = 'CDM-20628', updatedon = now()
where servicecasedispositionid = '38b3495d-5cdf-44ff-bfc5-f57fa86f7fb5';

update servicecase
set statustypekey = 'Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-20628', updatedon = now()
where servicecaseid = '4b153f0f-e599-4371-8e30-813e11041b73';