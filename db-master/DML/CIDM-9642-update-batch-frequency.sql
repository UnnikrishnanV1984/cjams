-- Update the Batch jobs to sync with Control M Schedule.
UPDATE tb_batch_master SET scheduled_tm = '23:00:00' WHERE batch_master_id=108 AND active_sw = 'Y';
UPDATE tb_batch_master SET frequency='D5', scheduled_tm='05:00:00' WHERE batch_master_id=107 AND active_sw = 'Y';