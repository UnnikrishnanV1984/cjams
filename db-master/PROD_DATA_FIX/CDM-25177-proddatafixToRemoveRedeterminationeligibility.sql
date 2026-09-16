/*
   Issue Description: CDM-25177
   Category/ Module  : Prod data fix to Remove Redetermination Eligibility
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--INSERT INTO cjams.tb_eligibility_period
--(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
--VALUES(920432, NULL, '2019-12-02 00:00:00.000', '2020-11-30 00:00:00.000', '2914 ', 170265, '2022-08-18 14:43:02.361', 'admin', '2022-08-18 14:50:09.567', 'admin', 'N', NULL, NULL, 'R1', 'PENDING', 'c765aea7-5d5f-4d14-baeb-dfcc8e951747', '201_MISSING_INFO', '540e26a1-775e-4a25-9cda-3e380037976b'::uuid, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);



DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=920432;
