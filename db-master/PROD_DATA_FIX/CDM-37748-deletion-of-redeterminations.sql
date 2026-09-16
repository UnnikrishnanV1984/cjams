/*
   Issue Description: CDM-37748 - Deletion of redeterminations
   
   Root cause: User rejected the 2 redeterminations. This youth is co-committed with DJS. The 2 rejections showing on the Dashboard is an issue for DJS moving forwarded with the case.
   Fix: As requested by the user removed 2 rejected redeterminations.
*/

-- To get eligibility_id
select eligibility_id from tb_client_eligibility where removal_id in (190401) and delete_sw = 'N';

-- Backup
select * from cjams.tb_eligibility_period 
where eligibility_id=164040 and eligibility_period_id in (918104,1017581) and delete_sw  = 'N';

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1017581, NULL, '2022-04-01 00:00:00.000', '2023-03-31 00:00:00.000', '2912 ', 164040, '2023-05-08 15:25:52.560', 'admin', '2023-05-08 15:31:05.766', 'admin', 'N', NULL, NULL, 'R5', 'REJECTED', 'dbab6f6a-fb15-4df5-9899-b3b6c189e600', 'ELIGIBLE_NON_REIMBURSABLE', 'ef810897-bc56-456e-9347-d188a8569b3e'::uuid, 'YES', 'Crystal Aye', '2023-07-31 13:46:02.182', NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(918104, NULL, '2021-04-01 00:00:00.000', '2022-03-31 00:00:00.000', '2912 ', 164040, '2022-05-02 19:55:06.007', 'admin', '2022-05-03 11:58:16.479', 'admin', 'N', NULL, NULL, 'R4', 'REJECTED', '282fa279-bfe1-4d20-9cef-52f346b43d21', 'ELIGIBLE_NON_REIMBURSABLE', '14e76aef-9883-4e39-9020-2096b18aab3f'::uuid, 'YES', 'Crystal Aye', '2023-07-31 13:44:14.960', NULL, NULL, NULL, NULL, NULL, NULL);


delete from tb_eligibility_period tep where eligibility_period_id in (918104,1017581);