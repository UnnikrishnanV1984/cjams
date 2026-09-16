/*
   Issue Description: CDM-32422
   Category/ Module  : Routing
   Root cause: routing record not removed from approval inbox 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-32422', updatedon=now()
WHERE routingid='8470b6e4-6f69-4d0e-af65-6183023c8922' and eventcode='SPLAN' and objectid='de0d144e-5a58-4e7b-9991-d884a9d3f957';
