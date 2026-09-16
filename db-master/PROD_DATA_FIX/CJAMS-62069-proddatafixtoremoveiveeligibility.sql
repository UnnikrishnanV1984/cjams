/*
   Issue Description: CJAMS-62069
   Category/ Module  : Prod data fix to Remove IVE eligibility
   Root cause:  user error
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


/*
INSERT INTO cjams.tb_eligibility_period
(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
VALUES(1391019, NULL, '2018-10-01 00:00:00.000', '2019-09-30 00:00:00.000', '2912 ', 161495, '2024-12-06 10:51:28.960', 'admin', '2025-09-15 13:00:03.447', '1dcf4151-cfa3-461e-80be-b99dbb7a0b06', 'N', NULL, NULL, 'R2', 'REJECTED', 'c5af6c69-fe9f-41aa-b481-4cbc3da2985e', 'ELIGIBLE_NON_REIMBURSABLE', '40649d6a-9568-41fb-859c-2b407f7f0313'::uuid, 'YES', 'Crystal Aye', '2025-09-15 13:00:03.447', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_eligibility_period
(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
VALUES(1391085, NULL, '2019-10-01 00:00:00.000', '2020-09-30 00:00:00.000', '2912 ', 161495, '2024-12-06 11:59:24.586', 'admin', '2025-09-15 13:00:15.459', '1dcf4151-cfa3-461e-80be-b99dbb7a0b06', 'N', NULL, NULL, 'R3', 'REJECTED', '9da65769-7d4c-45de-a240-6fed00695bf7', 'ELIGIBLE_REIMBURSABLE', '3a89b2e9-12dc-4cd7-b2c5-971fc25b6cd1'::uuid, 'YES', 'Crystal Aye', '2025-09-15 13:00:15.459', NULL, NULL, NULL, NULL, NULL, NULL);

*/

DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id in (1391019,1391085);
