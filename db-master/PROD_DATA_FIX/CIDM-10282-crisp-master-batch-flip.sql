/*
Issue Description: CRISP Job Frequency flip for Batch morning report
Category/ Module : Batch Jobs
Root cause: Master Data correction.
Fix provided : Flip the frequency to the correct schedule based on the batch jobs. 
Regression Impacts: N/A
Data/Code fix ticket#: CIDM-10282
Is code fix needed : No
Reason why no related code fix: NA
*/

update cjams.tb_batch_master  
set frequency = 'D5'
where batch_master_id = 108 and batch_nm = 'crisp_outbound.sh';

update cjams.tb_batch_master  
set frequency = 'D'
where batch_master_id = 107 and batch_nm = 'crisp_inbound.sh';