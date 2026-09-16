-- CDM-32254 - Data fix
/*
-- Issue Description:
-- Category/ Module: Ive Foster care History Review Periods
-- Fix Provided: Datafix has been done to remove the review period from history as the case is closed by then
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(901518, NULL, '2019-03-01 00:00:00.000', '2020-02-28 00:00:00.000', '2913 ', 163745, '2020-07-20 15:07:54.438', 'admin', '2020-07-20 15:07:54.438', 'admin', 'Y', NULL, NULL, 'R2', NULL, NULL, 'ELIGIBLE_REIMBURSABLE', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(901457, NULL, '2019-03-01 00:00:00.000', '2020-02-28 00:00:00.000', '2913 ', 163745, '2020-07-20 10:02:04.359', 'admin', '2020-07-20 10:02:04.359', 'admin', 'Y', NULL, NULL, 'R2', NULL, NULL, 'ELIGIBLE_REIMBURSABLE', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(901456, NULL, '2019-03-01 00:00:00.000', '2020-02-28 00:00:00.000', '2913 ', 163745, '2020-07-20 10:01:57.792', 'admin', '2020-07-20 10:01:57.792', 'admin', 'Y', NULL, NULL, 'R2', NULL, NULL, 'ELIGIBLE_REIMBURSABLE', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(901458, NULL, '2019-03-01 00:00:00.000', '2020-02-28 00:00:00.000', '2913 ', 163745, '2020-07-20 10:04:57.297', 'admin', '2020-07-20 10:04:57.297', 'admin', 'Y', NULL, NULL, 'R2', NULL, NULL, 'ELIGIBLE_REIMBURSABLE', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(901828, NULL, '2019-03-01 00:00:00.000', '2020-02-28 00:00:00.000', '2912 ', 163745, '2020-07-29 19:36:51.200', 'admin', '2020-07-29 19:42:48.962', 'admin', 'N', NULL, NULL, 'R2', 'APPROVED', 'fdb0d000-cb6d-458f-b673-082fb85a6aa8', 'ELIGIBLE_NON_REIMBURSABLE', 'bf550f87-6036-4523-90f8-0e50345dc2c7', 'YES', 'Crystal Aye', '2020-09-15 11:01:41.917', NULL, NULL, NULL, NULL, NULL, NULL);

DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id in (901518, 901457, 901456, 901458, 901828);

