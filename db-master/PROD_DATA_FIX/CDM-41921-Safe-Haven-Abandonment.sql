/*
-- Issue Description:CDM-41921
-- Category/ Module: SDM
-- Fix Provided: Datafix to remove change sdm tab in intake and CPS IR.
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update cjams.intakeservicerequestsdm 
set isneggn_childdischarged = true, isnegfp_cargiverintervene = null, updatedby= 'CDM-41921', updatedon=NOW()
where intakeserviceid='ecda62e8-6848-4d76-8031-b8af713a7875' and activeflag=1;


UPDATE intakesnapshot 
SET updatedby = 'CDM-41921', updatedon = now(),
jsondata = REPLACE (jsondata :: TEXT, '"isnegfp_cargiverintervene": true', '"isnegfp_cargiverintervene": false' )::jsonb
WHERE intakenumber = 'I241013124355' AND activeflag = 1;

UPDATE intakesnapshot 
SET updatedby = 'CDM-41921', updatedon = now(),
jsondata = REPLACE (jsondata :: TEXT, '"isneggn_childdischarged": false', '"isneggn_childdischarged": true' )::jsonb
WHERE intakenumber = 'I241013124355' AND activeflag = 1;



UPDATE intakedastaging 
SET updatedby = 'CDM-41921', updatedon = now(),
jsondata = REPLACE (jsondata :: TEXT, '"isnegfp_cargiverintervene": true', '"isnegfp_cargiverintervene": false' )::jsonb
WHERE intakenumber = 'I241013124355' AND activeflag = 1;

UPDATE intakedastaging 
SET updatedby = 'CDM-41921', updatedon = now(),
jsondata = REPLACE (jsondata :: TEXT, '"isneggn_childdischarged": false', '"isneggn_childdischarged": true' )::jsonb
WHERE intakenumber = 'I241013124355' AND activeflag = 1;



