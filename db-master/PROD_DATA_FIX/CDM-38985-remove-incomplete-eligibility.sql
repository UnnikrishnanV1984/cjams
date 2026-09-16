/*
  Issue Description:CDM-38985 Remove incomplete Adoption Redet.
  Category/ Module : Title-IVE Adoption
  Root cause: User error
  Fix Provided: Data fix has been promoted to Remove incomplete Adoption Redet.
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1264496, NULL, '2010-03-17 00:00:00.000', NULL, '3597', 111965, '2024-05-13 12:47:44.236', 'admin', '2024-05-13 12:47:44.236', 'admin', 'N', NULL, NULL, 'I', NULL, NULL, 'Incomplete', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


delete from tb_eligibility_period tep where eligibility_period_id = '1264496';