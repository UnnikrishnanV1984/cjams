-- CDM-35989 - Data fix
/* Issue Description:Remove last two the review periods from history as the case has been determined INE as of February 2021

-- Category/ Module: Ive Foster care History Review Periods

-- Root cause: Remove Review periods 
-- Fix Provided: Datafix has been done to remove the review periods from history as the case has been determined INE as of February 2021

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1077097, NULL, '2022-08-01 00:00:00.000', '2023-07-31 00:00:00.000', '2912 ', 160755, '2023-08-03 11:50:53.210', 'admin', '2023-08-03 11:55:46.903', 'admin', 'N', NULL, NULL, 'R6', 'PENDING', 'bd88e646-3c51-466f-8031-088d6bb627b1', 'ELIGIBLE_NON_REIMBURSABLE', 'a26fd10a-2cbe-442a-aa2c-02a2fd529fa2', 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1164208, NULL, '2021-08-01 00:00:00.000', '2022-07-31 00:00:00.000', '2912 ', 160755, '2023-12-08 14:20:54.820', 'admin', '2023-12-08 14:23:29.396', 'admin', 'N', NULL, NULL, 'R5', 'PENDING', '19a04194-09c3-4e88-93c2-8479d77c1bf8', 'ELIGIBLE_NON_REIMBURSABLE', 'd9e4baa8-240b-4be7-86de-741456fce0af', 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(920495, NULL, '2021-08-01 00:00:00.000', '2022-07-31 00:00:00.000', '2912 ', 160755, '2022-08-23 14:00:17.507', 'admin', '2022-08-23 14:07:22.481', 'admin', 'Y', NULL, NULL, 'R5', 'PENDING', '6f6b7ba4-48c8-4c3d-8e37-47e90e47fcbe', 'ELIGIBLE_NON_REIMBURSABLE', '8ec47e32-4920-45c2-b38c-a7ac76ce4cc9', 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(933763, NULL, '2021-08-01 00:00:00.000', '2022-07-31 00:00:00.000', '2912 ', 160755, '2022-12-22 00:31:49.315', 'admin', '2022-12-22 00:32:30.317', 'admin', 'Y', NULL, NULL, 'R5', 'REJECTED', 'c3082097-f2f2-4eea-b427-0edb2f4ab259', 'ELIGIBLE_NON_REIMBURSABLE', 'f9d26faf-1bb5-4efb-a48e-a9adfded582b', 'YES', 'Crystal Aye', '2023-12-08 10:33:50.314', NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1095640, NULL, '2023-04-26 00:00:00.000', NULL, '2912 ', 160755, '2023-08-30 14:06:54.149', 'admin', '2023-08-30 14:09:19.900', 'admin', 'N', NULL, NULL, '18BDAY', 'PENDING', 'bfa7269a-15dd-4973-b00f-2326b6834200', 'ELIGIBLE_NON_REIMBURSABLE', 'f0b04f0a-3c8e-4bb1-a43d-0fd78dd273b5', 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id in (1095640, 1077097, 1164208, 920495, 933763);
