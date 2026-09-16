/*
  Issue Description: CJAMS-69340 "incomplete" status needs to be removed. 
  There is a redetermination period that is preventing this case from disappearing off dashboard.
  Category/ Module : Title-IVE / Foster Care
  Root cause: Redetermination was done by mistake for the clientid#2997109/removal#180758
  Fix Provided: Data fix has been done to remove the incomplete redetermination for the clientid#2997109/removal#180758
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: User error and data fix needed to resolve it.
*/


-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1108793, NULL, '2017-01-03 00:00:00.000', '2017-06-30 00:00:00.000', '3597', 156398, '2023-09-18 10:10:40.268', 'admin', '2023-09-18 10:10:40.268', 'admin', 'N', NULL, NULL, 'R2', NULL, NULL, '201_MISSING_INFO', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=1108793;
