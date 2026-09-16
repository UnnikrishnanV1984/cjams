/*
  Issue Description:CDM-43778 Delete records from eligibilty detail screen
  Category/ Module : Title-IVE Adoption
  Root cause: User error
  Fix Provided: Data fix has been promoted to Remove incomplete Adoption Redet.
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/


--INSERT INTO cjams.tb_eligibility_period
--(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
--VALUES(1304225, NULL, '2022-04-01 00:00:00.000', '2023-03-31 00:00:00.000', '2913 ', 164034, '2024-06-28 14:57:30.541', 'admin', '2024-06-28 15:30:55.296', 'admin', 'N', NULL, NULL, 'R5', 'PENDING', '4ba49a55-df16-45ab-8ac6-44196ab61a99', 'ELIGIBLE_NON_REIMBURSABLE', '921e1a51-c73b-4598-94a9-a65c1de54d40'::uuid, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=1304225;


--INSERT INTO cjams.tb_eligibility_period
--(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
--VALUES(1304457, NULL, '2023-04-01 00:00:00.000', '2024-03-31 00:00:00.000', '2912 ', 164034, '2024-06-28 16:40:49.064', 'admin', '2024-06-28 17:17:06.646', 'admin', 'N', NULL, NULL, 'R6', 'PENDING', '3ddb02f7-fb77-480b-a09b-a2ea63c27878', 'ELIGIBLE_REIMBURSABLE', 'ad2ffc6b-8f3c-47ab-bf3e-5347870d9476'::uuid, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=1304457;

