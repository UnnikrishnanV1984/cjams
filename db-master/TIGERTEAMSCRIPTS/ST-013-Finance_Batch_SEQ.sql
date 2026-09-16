--sequence for TB_FSS_BATCH_RUN -> run_id, please keep the seq name as SQ_FSS_BATCH_RUN, that is referenced in batch job.

--ignore below script if it already exists
CREATE SEQUENCE cjams.SQ_FSS_BATCH_RUN START WITH 5000;
--GRANT USAGE, SELECT ON SEQUENCE cjams.SQ_FSS_BATCH_RUN to 'user'; -- replace user with appropriate id

--sequence for tb_batch_sp_log -> batch_sp_log_id -- 

--ignore below script if it already exists
CREATE SEQUENCE cjams.sq_tb_batch_sp_log_id START WITH 3000001;
--GRANT USAGE, SELECT ON SEQUENCE cjams.sq_tb_batch_sp_log_id to 'user'; -- replace user with appropriate id

ALTER TABLE cjams.tb_batch_sp_log 
ALTER COLUMN batch_sp_log_id SET DEFAULT nextval('sq_tb_batch_sp_log_id'::regclass);

