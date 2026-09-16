/*
 Issue Description: CDM-43286
-- Category/ Module: Investigation Finding 
-- Root cause: Use requested to ruled out
-- Fix Provided: Datafix has been promoted to ruled out the case
-- Pull request# N/A
-- Reason why no related code fix: N/A
*/

update investigationfinding set investigationfindingtypekey = 'RO', 
updatedby = 'CDM-43286', updatedon = now()
where investigationfindingid = '9dcd9534-2bda-490e-9002-e419a495b296' 
and investigationallegationid = '76d403b1-8665-4dd2-8999-db0caa19a5e6'
and activeflag = 1;