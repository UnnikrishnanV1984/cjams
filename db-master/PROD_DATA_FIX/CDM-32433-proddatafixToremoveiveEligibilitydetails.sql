/*
   Issue Description: CDM-32433
   Category/ Module  : Prod data fix to IVE Eligibility
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




update tb_eligibility_period set delete_sw = 'N', update_ts = now(), update_user_id = 'CDM-32433'
where eligibility_period_id = '978053';



--INSERT INTO cjams.tb_eligibility_period
--(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
--VALUES(1042570, NULL, '2022-01-01 00:00:00.000', '2022-12-31 00:00:00.000', '2913 ', 138279, '2023-06-21 16:36:43.772', 'admin', '2023-06-23 16:00:00.373', 'CDM-32433', 'Y', NULL, NULL, 'R10', NULL, NULL, 'ELIGIBLE_REIMBURSABLE', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=1042570;

DELETE FROM cjams.tb_ive_fostercare_audit
WHERE auditperiodid=130480;


