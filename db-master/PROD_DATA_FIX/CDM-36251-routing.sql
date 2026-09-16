/*
   Issue Description: CDM-36251
   Category/ Module  : Routing
   Root cause: routing record not removed from approval inbox 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-36251', updatedon=now()
WHERE routingid in ('fae7a510-ca7a-465e-987c-88dc9746e28b','2bcf0862-ff94-48cb-b237-54c28bfd2e47')
and eventcode='SPLAN' and objectid='407fd34e-b96f-4a61-a5f8-888bfb2ec6bf';
