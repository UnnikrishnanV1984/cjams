-- CDM-36444 - Remove redets
/* Issue Description: Remove all redets after redet period 7/30/19-6/30/20 from history as the case has been determined INE as of 4/30/20.

    PersonId: 3409445
    RemovalId: 196717
-- Category/ Module: Ive Foster care History Review Periods

-- Root cause: Remove all redets after redet period 7/30/19-6/30/20 from history as the case has been determined INE as of 4/30/20. 
-- Fix Provided: Datafix has been done to remove the review periods from history.

*/

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(919776, NULL, '2020-07-01 00:00:00.000', '2021-06-30 00:00:00.000', '2912 ', 169203, '2022-07-21 10:00:24.322', 'admin', '2022-07-21 10:01:43.364', 'admin', 'N', NULL, NULL, 'R2', 'APPROVED', '6654a6d9-12d4-47d2-aec2-f304dcd0467a', 'ELIGIBLE_NON_REIMBURSABLE', '7302f153-c3ca-40d7-bda2-7a3d334464a5'::uuid, 'YES', 'Crystal Aye', '2022-07-21 13:50:49.148', NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(919777, NULL, '2020-10-25 00:00:00.000', NULL, '2912 ', 169203, '2022-07-21 10:06:53.549', 'admin', '2022-07-21 10:08:46.705', 'admin', 'N', NULL, NULL, '18BDAY', 'APPROVED', '02e94df0-a256-43d9-bcd2-f578b43ca6f7', 'ELIGIBLE_NON_REIMBURSABLE', 'b627e577-171b-4299-a75c-16f5a6db3791'::uuid, 'YES', 'Crystal Aye', '2022-07-21 14:03:23.178', NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(919779, NULL, '2021-07-01 00:00:00.000', '2022-06-30 00:00:00.000', '2912 ', 169203, '2022-07-21 10:15:05.152', 'admin', '2022-07-21 10:20:36.787', 'admin', 'N', NULL, NULL, 'R3', 'APPROVED', 'a6c093ba-f570-4d6c-98ad-89092bd821d4', 'ELIGIBLE_NON_REIMBURSABLE', '0eab474d-54fd-40c8-b95c-fdb5589b256c'::uuid, 'YES', 'Crystal Aye', '2022-07-21 14:22:51.706', NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1069969, NULL, '2022-07-01 00:00:00.000', '2023-06-30 00:00:00.000', '2912 ', 169203, '2023-07-26 15:21:52.914', 'admin', '2023-07-26 15:23:24.563', 'admin', 'N', NULL, NULL, 'R4', 'REJECTED', 'd18c0361-3664-4dc0-9057-6f3ab600eeea', 'ELIGIBLE_NON_REIMBURSABLE', '4ee583cf-8204-46bd-a75b-4f71dd95130b'::uuid, 'YES', 'Crystal Aye', '2024-01-12 10:03:23.061', NULL, NULL, NULL, NULL, NULL, NULL);

DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id in (919776,919777,919779,1069969);

