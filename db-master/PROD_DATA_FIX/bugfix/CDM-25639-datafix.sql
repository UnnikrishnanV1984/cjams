/*
   Issue Description: CDM-25639
   Category/ Module  : IVE - Eligibility Details
   Root cause: User requested to remove the episode 10/1/2021 to 9/30/2022 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select  *
from    tb_eligibility_period   
where   eligibility_period_id = 921277;

/* 
INSERT INTO cjams.tb_eligibility_period
(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
VALUES(921277, NULL, '2021-10-01 00:00:00.0000', '2022-09-30 00:00:00.000', '2912', 10001373, '2022-10-06 16:23:02.832', 'admin', '2022-10-14 23:58:00.921', 'admin', 'N', NULL, NULL, 'R2', NULL, NULL, 'ELIGIBLE_NON_REIMBURSABLE', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

delete from tb_eligibility_period tep where eligibility_period_id = 921277;