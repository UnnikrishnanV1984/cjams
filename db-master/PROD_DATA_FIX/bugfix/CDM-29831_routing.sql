/*
   Issue Description: CDM-29831
   Category/ Module  : Permanency Plan routing record
   Root cause: As requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-29831', updatedon=now()
WHERE routingid='66e86322-79cd-4807-b125-40adfab15249' and eventcode='PPLR' and objectid='0dc3cf1e-07bf-40ba-838e-f464ad3669b6';
