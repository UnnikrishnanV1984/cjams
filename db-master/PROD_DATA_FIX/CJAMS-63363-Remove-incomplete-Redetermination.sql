/*
  Issue Description: CJAMS-63363 ncomplete" status needs to be removed. The Determination button should not have been selected for the redetermination because no initial determination was completed. 
  This was an error. 2017 -Case migrated ineligible and remains ineligible. Please remove the incomplete for CJAMS PID#3270178 / CIS ID# 431045778 / Michael Bucklew
  Category/ Module : Title-IVE / Foster Care
  Root cause: Redetermination was done by mistake for the CJAMS PID#3270178 / CIS ID# 431045778 / Michael Bucklew
             This is an 2017 case migrated ineligibile and data fix needed to remove it.
  Fix Provided: Data fix has been done to remove the incomplete redetermination for CJAMS PID#3270178 / CIS ID# 431045778 / Michael Bucklew.
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: User error and data fix needed to resolve it.
*/

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1558851, NULL, '2017-11-20 00:00:00.000', '2018-10-31 00:00:00.000', '3597', 162042, '2025-11-06 11:08:28.106', '9335720b-d4d5-4bd4-b846-f17d02bb6a32', '2025-11-06 11:08:28.106', '9335720b-d4d5-4bd4-b846-f17d02bb6a32', 'Y', NULL, NULL, 'R1', NULL, NULL, '201_MISSING_INFO', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1558885, NULL, '2017-11-20 00:00:00.000', '2018-10-31 00:00:00.000', '3597', 162042, '2025-11-06 11:18:34.677', '9335720b-d4d5-4bd4-b846-f17d02bb6a32', '2025-11-06 11:18:34.677', '9335720b-d4d5-4bd4-b846-f17d02bb6a32', 'Y', NULL, NULL, 'R1', NULL, NULL, '201_MISSING_INFO', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1558887, NULL, '2017-11-20 00:00:00.000', '2018-10-31 00:00:00.000', '3597', 162042, '2025-11-06 11:19:21.111', '9335720b-d4d5-4bd4-b846-f17d02bb6a32', '2025-11-06 11:19:21.111', '9335720b-d4d5-4bd4-b846-f17d02bb6a32', 'N', NULL, NULL, 'R1', NULL, NULL, '201_MISSING_INFO', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


delete from tb_eligibility_period tep where eligibility_period_id in (1558851,1558885,1558887); 
