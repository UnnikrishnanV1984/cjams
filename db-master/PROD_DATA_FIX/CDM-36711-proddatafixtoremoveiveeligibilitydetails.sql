/*
   Issue Description: CDM-36711
   Category/ Module  : Prod data fix to Remove IVE Eligibility details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


--INSERT INTO cjams.tb_eligibility_period
--(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
--VALUES(916373, NULL, '2021-01-01 00:00:00.000', '2021-12-31 00:00:00.000', '2912 ', 167427, '2022-02-17 10:24:10.555', 'admin', '2022-02-17 11:20:35.048', 'admin', 'N', NULL, NULL, 'R3', 'APPROVED', '5be7ac89-9dc4-403f-8e19-64079307c235', 'ELIGIBLE_NON_REIMBURSABLE', 'f127794b-eb1f-41cc-be48-87bbd3b45ce4'::uuid, 'YES', 'Crystal Aye', '2022-02-28 21:31:06.630', NULL, NULL, NULL, NULL, NULL, NULL);
--INSERT INTO cjams.tb_eligibility_period
--(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
--VALUES(946714, NULL, '2022-01-01 00:00:00.000', '2022-12-31 00:00:00.000', '2912 ', 167427, '2023-01-24 23:51:42.615', 'admin', '2023-01-24 23:52:40.853', 'admin', 'N', NULL, NULL, 'R4', 'REJECTED', '3e036b88-96ac-431d-8c9d-387737c370a7', 'ELIGIBLE_NON_REIMBURSABLE', 'cc807716-4afa-4896-ad75-a8cad196d82b'::uuid, 'YES', 'Crystal Aye', '2024-01-19 14:53:01.750', NULL, NULL, NULL, NULL, NULL, NULL);
--

	
DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=916373;
DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=946714;
