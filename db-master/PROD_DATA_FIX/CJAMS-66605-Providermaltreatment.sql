
/*
-- Issue Description: 
   261023566743:Maltreatment Allegation
-- Category/ Module: Maltreatment-Allegation 
-- Root cause:Issue is not replicable in staging environment, Maltreatment allegation is not checked off where it is correct in SDM  
-- Fix Provided: Data fix to check the provider involved maltreatment as Yes.
 */




UPDATE cjams.investigationallegation
SET isproviderinvolved=1,
updatedby='CJAMS-66605',
updatedon=now()
WHERE investigationid='154a6950-8651-46f5-bc56-2d8831936964';