/*
   Issue Description: CDM-39476 Remove redets.Case was made Ineligible at initial determination. Please remove all redets after the initial determination
   Category/ Module  : Title IV-E
   Root cause:Case was made Ineligible at initial determination. Please remove all redets after the initial determination
   Fix Provided :Data fix has been promoted to remove all the redets after intial.
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

-- INSERT INTO cjams.tb_eligibility_period
-- (end_dt, approvalstatus, eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES('2020-10-31 00:00:00.000', 'PENDING', 1288112, NULL, '2019-11-01 00:00:00.000', '2020-10-31 00:00:00.000', '2913 ', 166711, '2024-06-07 09:58:35.847', 'admin', '2024-06-07 10:00:03.327', 'admin', 'N', NULL, NULL, 'R2', 'PENDING', '622a2a6b-2f0d-4328-875e-ff501a4115c3', 'ELIGIBLE_REIMBURSABLE', 'ae5e4aef-744e-4556-84b3-86692a54f389', 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=1288112;

-- INSERT INTO cjams.tb_eligibility_period
-- (end_dt, approvalstatus, eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES('2021-10-31 00:00:00.000', 'PENDING', 1288145, NULL, '2020-11-01 00:00:00.000', '2021-10-31 00:00:00.000', '2913 ', 166711, '2024-06-07 10:09:44.314', 'admin', '2024-06-07 10:13:50.699', 'admin', 'N', NULL, NULL, 'R3', 'PENDING', '2473c069-465a-49b0-9df4-7e854e3223e7', 'ELIGIBLE_REIMBURSABLE', '276203f2-07b3-4570-9cd0-ab5e18a60ade', 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=1288145;

-- INSERT INTO cjams.tb_eligibility_period
-- (end_dt, approvalstatus, eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES('2022-10-31 00:00:00.000', 'PENDING', 1288245, NULL, '2021-11-01 00:00:00.000', '2022-10-31 00:00:00.000', '2913 ', 166711, '2024-06-07 10:30:51.958', 'admin', '2024-06-07 10:37:37.245', 'admin', 'N', NULL, NULL, 'R4', 'PENDING', '890fd5b2-cdee-4c32-b305-9532f42bc41c', 'ELIGIBLE_REIMBURSABLE', '6e959274-017a-465b-9e66-662dc7e86794', 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=1288245;


-- INSERT INTO cjams.tb_eligibility_period
-- (end_dt, approvalstatus, eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES('2023-10-31 00:00:00.000', 'PENDING', 1288311, NULL, '2022-11-01 00:00:00.000', '2023-10-31 00:00:00.000', '2913 ', 166711, '2024-06-07 10:40:49.937', 'admin', '2024-06-07 10:43:32.505', 'admin', 'N', NULL, NULL, 'R5', 'PENDING', '40f06663-c587-48e2-b913-1f2b04e7fc9b', 'ELIGIBLE_NON_REIMBURSABLE', '4b288c0d-fadc-4070-9bc3-0028d6d068d4', 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=1288311;