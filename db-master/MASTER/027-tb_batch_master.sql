INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(1, 'late_valid_pmnt.sh', NULL, 'Over Under Payment Batch', 'Y', 'D', '19.30.00', 30, 90, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(2, 'paymentgen1.sh', NULL, 'Draft Payment Batch', 'Y', '1', '19.00.00', 60, 120, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(3, 'snapshot_payment_1.sh', 2, 'Snapshot before Draft Payment Batch', 'Y', '1', '19.00.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(4, 'snapshot_payment_2.sh', 2, 'Snapshot after Draft Payment Batch', 'Y', '1', '19.00.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(6, 'snapshot_fmis.sh', 5, 'Snapshot for FMIS Batch', 'Y', '1', '19.00.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(7, 'late_valid_pmnt.sh', 2, 'Over Under Payment Batch', 'Y', '1', '19.00.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(8, 'paymentgen2.sh', NULL, 'Final Payment Batch', 'Y', '13', '19.00.00', 60, 120, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(9, 'late_valid_pmnt.sh', 8, 'Over Under Payment Batch', 'Y', '13', '19.00.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(11, 'snapshot_fmis.sh', 10, 'Snapshot for FMIS Batch', 'Y', '13', '19.00.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(12, 'auto_redet.sh', NULL, 'IV-E Auto Redetermination Batch', 'Y', '2', '19.00.00', 60, 90, 'SEV-2', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(13, 'RE869_870.sh', NULL, 'LSRI Reports RE869 and RE870 Batch', 'Y', '19', '19.00.00', NULL, NULL, 'SEV-2', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(14, 'expvendor.sh', 2, 'FMIS Vendor File Outbound Batch', 'Y', '1', '21.00.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(15, 'expvendor.sh', 8, 'FMIS Vendor File Outbound Batch', 'Y', '13', '21.00.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(16, 'FMIS_payment', NULL, 'Move Payment File to FTP location Batch', 'Y', '4', '21.00.00', 10, 20, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(17, 'FMIS_payment', NULL, 'Move Payment File to FTP location Batch', 'Y', '16', '21.00.00', 10, 20, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(18, 'cans_tickler.sh', NULL, 'Tickler Generation for CANS Batch', 'Y', 'D', '21.30.00', 10, 20, 'SEV-2', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(19, 'auto_appeal.sh', NULL, 'Auto Appeals Finalization Batch', 'Y', 'D', '21.35.00', 10, 20, 'SEV-2', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(20, 'expafs.sh', NULL, 'AFS Payment File Outbound Batch', 'Y', 'WD', '22.00.00', 20, 30, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(21, 'snapshot_afs.sh', 20, 'Snapshot for AFS Batch', 'Y', 'WD', '22.00.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(22, 'expcrcs.sh', NULL, 'Wrapper script for CARES, CSES & Expungements Batches', 'Y', 'WD', '22.30.00', 60, 30, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(25, 'expunge.sh', 22, 'Expungement Outbound Batch', 'Y', 'WD', '22.30.00', 120, 150, 'SEV-1', 'N', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(26, 'cis_send_data.sh', 25, 'CIS File Outbound Batch', 'Y', 'WD', '22.30.00', NULL, NULL, 'SEV-2', 'N', '<cisprd RSZ77P CHO1CEMD CISPDB>', NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(27, 'expunge.sh', NULL, 'Expungement Outbound Batch', 'Y', 'WE', '22.30.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(28, 'cis_send_data.sh', 27, 'CIS File Outbound Batch', 'Y', 'WE', '22.30.00', NULL, NULL, 'SEV-2', 'N', '<cisprd RSZ77P CHO1CEMD CISPDB>', NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(29, 'load_afs_response.sh', NULL, 'AFS Response File Inbound Batch', 'Y', 'D', '22.45.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(30, 'dwo_stats.sh', NULL, 'Datawindow status Batch', 'Y', 'D', '22.48.00', NULL, NULL, 'SEV-3', 'N', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(31, 'load_fmis_response.sh', NULL, 'FMIS Response File Inbound Batch', 'Y', 'D', '23.00.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(32, 'rptdb_refresh_check.sh', NULL, 'Reports DB refresh Check Batch', 'Y', 'D', '23.28.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(33, 'Backup', NULL, 'Reports DB Backup Batch', 'N', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(34, 'search_cleanup.sh', NULL, 'Drop and recreate search tables Batch', 'Y', 'D', '00.00.00', NULL, NULL, 'SEV-3', 'N', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(35, 'vmst.sh', NULL, 'Fetch system performance and FTP to UAT Batch', 'Y', 'D', '00.10.00', NULL, NULL, 'SEV-3', 'N', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(36, 'cnt_users.sh', NULL, '', 'Y', 'D', '00.10.00', NULL, NULL, 'SEV-3', 'N', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(37, 'staff_inactive.sh', NULL, 'Active and Inactive Staff Batch', 'Y', 'D', '00.10.00', NULL, NULL, 'SEV-3', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(38, 'tickler_gen_daily.sh', NULL, 'Tickler Generation Daily Batch', 'Y', 'D', '00.30.00', NULL, NULL, 'SEV-2', 'N', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(39, 'crb_outbound.sh', NULL, 'CRB File Outbound Batch', 'Y', 'D', '01.00.00', NULL, NULL, 'SEV-2', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(40, 'db2redirected.restore.ksh', NULL, '', 'Y', 'D', '01.30.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(41, 'refresh_ksh', NULL, '', 'Y', 'D', '01.35.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(42, 'pg_batches.sh', NULL, 'Assignment Retransfer Batch', 'Y', 'D7', '02.15.00', NULL, NULL, 'SEV-2', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(43, 'client_merge.sh', NULL, 'Client Merge Batch', 'N', 'D', '02.30.00', NULL, NULL, 'SEV-2', 'N', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(44, 'pmnt_stamping.sh', NULL, 'Payment Stamping Batch', 'Y', '1', '02.31.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(45, 'cjams_cares_rej.sh', NULL, 'CARES File Rejection Inbound Batch', 'Y', 'WD', '03.00.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(46, 'ssn_validation.sh', NULL, 'SSN Validation Batch', 'Y', 'WD', '03.00.00', NULL, NULL, 'SEV-2', 'N', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(47, 'cjams_cses_rej.sh', NULL, 'CSES File Rejection Inbound Batch', 'Y', 'WD', '03.30.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(48, 'expunge_response.sh', NULL, 'Expungement Response Inbound Batch', 'Y', 'W6', '03.30.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(49, 'expunge_out.sh', NULL, 'CIS CDBP EXPUNGEMENT File Outbound Batch', 'Y', 'W6', '03.45.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(50, 'load_cares.sh', NULL, 'CARES File Inbound Batch', 'Y', 'D', '04.00.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(51, 'load_cses.sh', NULL, 'CSES File Inbound Batch', 'Y', 'WD', '05.00.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(52, 'fm005r.sh', NULL, 'FM005R Financial Monthly File Outbound Batch', 'Y', '2', '22.20.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(53, 'batch_status.sh', NULL, 'Daily Batch Status Email Notification Batch', 'Y', 'D', '07.20.00', NULL, NULL, 'SEV-1', 'N', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(56, 'cis_send_data.sh', NULL, 'CIS File Outbound Batch', 'Y', 'WD', '07.00.00', NULL, NULL, 'SEV-2', 'N', '<cisprd RSZ77P CHO1CEMD CISPDB> 7AM to 7PM every 30 mins', NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(57, 'cis_vches.sh', NULL, 'CIS File Inbound Batch', 'Y', 'WD', '07.15.00', NULL, NULL, 'SEV-2', 'Y', '7AM to 7PM every 30 mins', NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(58, 'ncands_agency.sh', NULL, 'NCANDS outbound file creation batch', 'Y', 'OD', NULL, NULL, NULL, 'SEV-2', 'Y', 'This is on-demand batch.', NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(59, 'ncands_child_main.sh', NULL, 'NCANDS Child file creation batch', 'Y', 'OD', NULL, NULL, NULL, 'SEV-2', 'Y', 'This is on-demand batch.', NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(60, 'afcars_fostercare.sh', NULL, 'AFCARS Fostercare batch', 'Y', 'OD', NULL, NULL, NULL, 'SEV-2', 'Y', 'This is on-demand batch.', NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(61, 'afcars_cares_response.sh', NULL, 'AFCARS CARES Response batch batch', 'Y', 'OD', NULL, NULL, NULL, 'SEV-2', 'Y', 'This is on-demand batch.', NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(62, 'afcars_cses_response.sh', 61, 'AFCARS CSES Response batch', 'Y', 'OD', NULL, NULL, NULL, 'SEV-2', 'Y', 'This is on-demand batch.', NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(63, 'generate_afcars_fostercare.sh', 61, 'Generate AFCARS Fostercare batch', 'Y', 'OD', NULL, NULL, NULL, 'SEV-2', 'Y', 'This is on-demand batch.', NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(64, 'afcars_adoption.sh', NULL, 'AFCARS Adoption batch', 'Y', 'OD', NULL, NULL, NULL, 'SEV-2', 'Y', 'This is on-demand batch.', NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(65, 'fmis_processing.sh', NULL, 'FMIS Payment Processing', 'Y', 'OD', NULL, NULL, NULL, 'SEV-2', 'Y', 'This is on-demand batch', NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(5, 'exp_payment_interface.sh', 2, 'FMIS Payment File Outbound Batch', 'Y', '1', '19.00.00', NULL, NULL, 'SEV-1', 'Y', '<A  200>', NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(10, 'exp_payment_interface.sh', 8, 'FMIS Payment File Outbound Batch', 'Y', '13', '19.00.00', NULL, NULL, 'SEV-1', 'Y', '<F  200>', NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(23, 'cses_outbound.sh', NULL, 'CSES File Outbound Batch', 'Y', 'WD', '22.30.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_batch_master
(batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, module_cd)
VALUES(24, 'cares_outbound.sh', NULL, 'CARES File Outbound Batch', 'Y', 'WD', '22.30.00', NULL, NULL, 'SEV-1', 'Y', NULL, NULL, NULL, NULL, NULL);
