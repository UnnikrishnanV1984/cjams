/*
   Issue Description: CDM-33758
   Category/ Module  : Prod data fix to Remove IVE eligibility
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- 6b1c172e-a3a9-4880-b6d4-1e906f42fac6	PENDING
-- 52de8068-f3d5-4e4b-ade4-4ac79de76d39	PENDING
-- be296bd9-727c-4fcb-a8dc-7672637202a5	PENDING
-- 44ddabdf-c5a7-4f2d-b976-101584d3aec5	PENDING
update tb_eligibility_period set approvalid = null, approvalstatus = null, update_ts = now(), update_user_id = 'CDM-33758'
where eligibility_period_id in ('982131',
'972098',
'918295',
'918294');



DELETE FROM cjams.tb_ive_fostercare_audit
WHERE auditperiodid=64196;
DELETE FROM cjams.tb_ive_fostercare_audit
WHERE auditperiodid=73862;
DELETE FROM cjams.tb_ive_fostercare_audit
WHERE auditperiodid=15647;
DELETE FROM cjams.tb_ive_fostercare_audit
WHERE auditperiodid=64161;
DELETE FROM cjams.tb_ive_fostercare_audit
WHERE auditperiodid=15646;
DELETE FROM cjams.tb_ive_fostercare_audit
WHERE auditperiodid=15645;
DELETE FROM cjams.tb_ive_fostercare_audit
WHERE auditperiodid=15643;
DELETE FROM cjams.tb_ive_fostercare_audit
WHERE auditperiodid=15644;