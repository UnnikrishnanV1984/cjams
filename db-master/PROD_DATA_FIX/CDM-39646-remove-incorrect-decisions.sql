/*
  Issue Description:CDM-39646 The child was on runaway then corrections during the 6/1/18-5/31/19 period, which the decision should be ineligible and the remainder redets after that need to be removed.
  Category/ Module : Title-IVE Foster care 
  Root cause: User wants to delete incorrect decision from the child foster care decision with clientID/removalid (3787459/174384) as child ran away during that period.
  Fix Provided: Data fix has been promoted to Remove incorrect decisions from IV-E foster care decision Dashboard
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1264496, NULL, '2010-03-17 00:00:00.000', NULL, '3597', 111965, '2024-05-13 12:47:44.236', 'admin', '2024-05-13 12:47:44.236', 'admin', 'N', NULL, NULL, 'I', NULL, NULL, 'Incomplete', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


delete from tb_eligibility_period tep where eligibility_period_id in ('1283742', '1044824' , '1044361', '1043896',  '1045853', '1043929', '1043863', '1043731', '1043267');


-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1043929, NULL, '2020-11-11 00:00:00.000', NULL, '2912 ', 151358, '2023-06-22 15:27:35.095', 'admin', '2023-06-22 15:27:35.095', 'admin', 'N', NULL, NULL, '18BDAY', NULL, NULL, 'ELIGIBLE_NON_REIMBURSABLE', '562010d5-188f-49b6-9677-beb078cc8a9e'::uuid, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1283742, NULL, '2023-06-01 00:00:00.000', '2023-11-11 00:00:00.000', '2914 ', 151358, '2024-06-03 12:33:01.167', 'admin', '2024-06-03 12:41:54.363', 'admin', 'N', NULL, NULL, 'R9', 'REJECTED', 'd4f2c840-1945-49e4-9ff4-60dddfca2892', 'INELIGIBLE', 'c6fc423d-9d39-4d60-a8e7-d2b1c4b7d6c9'::uuid, 'YES', 'Crystal Aye', '2024-06-14 15:14:26.593', NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1044824, NULL, '2022-06-01 00:00:00.000', '2023-05-31 00:00:00.000', '2913 ', 151358, '2023-06-23 15:53:53.733', 'admin', '2023-07-03 11:55:35.685', 'admin', 'N', NULL, NULL, 'R8', 'REJECTED', '5ec13875-8ede-4dba-a32b-1ca01a9b9749', 'ELIGIBLE_NON_REIMBURSABLE', '8374ba28-5390-420d-8b6e-d36f24b04bee'::uuid, 'YES', 'Crystal Aye', '2024-06-14 15:14:07.964', NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1044361, NULL, '2021-06-01 00:00:00.000', '2022-05-31 00:00:00.000', '2913 ', 151358, '2023-06-23 10:06:49.550', 'admin', '2023-07-03 11:54:51.501', 'admin', 'N', NULL, NULL, 'R7', 'REJECTED', '895b372c-c8be-4fcc-bada-ce160d115a1f', 'ELIGIBLE_REIMBURSABLE', '87d991b8-5145-4fef-8f34-6e8e36250dd1'::uuid, 'YES', 'Crystal Aye', '2024-06-14 15:13:51.710', NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1043896, NULL, '2020-06-01 00:00:00.000', '2021-05-31 00:00:00.000', '2913 ', 151358, '2023-06-22 15:24:02.519', 'admin', '2023-07-03 11:54:05.151', 'admin', 'N', NULL, NULL, 'R6', 'REJECTED', '050fdb7c-e615-4c4e-8a17-f118bda6981c', 'ELIGIBLE_REIMBURSABLE', '96592a23-2ac6-4b21-861c-10ee2986ce21'::uuid, 'YES', 'Crystal Aye', '2024-06-14 15:13:36.360', NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1045853, NULL, '2019-06-01 00:00:00.000', '2020-05-31 00:00:00.000', '2912 ', 151358, '2023-06-27 09:37:09.205', 'admin', '2023-07-03 11:53:17.653', 'admin', 'N', NULL, NULL, 'R5', 'REJECTED', '6196d816-3766-494c-ba5c-c54b5a218342', 'ELIGIBLE_NON_REIMBURSABLE', 'ceca7930-7454-4263-83a4-99929a3fe18f'::uuid, 'YES', 'Crystal Aye', '2024-06-14 15:13:21.229', NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1043863, NULL, '2020-06-01 00:00:00.000', '2021-05-31 00:00:00.000', '3597', 151358, '2023-06-22 15:17:20.545', 'admin', '2023-06-22 15:17:20.545', 'admin', 'Y', NULL, NULL, 'R6', NULL, NULL, '201_MISSING_INFO', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1043731, NULL, '2020-06-01 00:00:00.000', '2021-05-31 00:00:00.000', '3599', 151358, '2023-06-22 13:25:12.223', 'admin', '2023-06-22 13:25:12.223', 'admin', 'Y', NULL, NULL, 'R6', NULL, NULL, 'INVALID_CRITERIA', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1043267, NULL, '2019-06-01 00:00:00.000', '2020-05-31 00:00:00.000', '2912 ', 151358, '2023-06-22 11:56:35.116', 'admin', '2023-06-22 11:56:35.116', 'admin', 'Y', NULL, NULL, 'R5', NULL, NULL, 'ELIGIBLE_NON_REIMBURSABLE', 'b401c7ab-44ed-4191-b110-6844014450ce'::uuid, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

