ALTER TABLE tb_ncands_elements ADD COLUMN IF NOT EXISTS HPSCC VARCHAR(1);
ALTER TABLE tb_ncands_elements ADD COLUMN IF NOT EXISTS RTCRC VARCHAR(1);

ALTER TABLE ncands_childrisk ADD COLUMN IF NOT EXISTS HPSCC VARCHAR(1);
ALTER TABLE ncands_childrisk ADD COLUMN IF NOT EXISTS RTCRC VARCHAR(1);

CREATE INDEX IF NOT EXISTS idx_tb_service_log_start_dt
ON cjams.tb_service_log
USING btree (start_dt ASC);

CREATE INDEX IF NOT EXISTS idx_IntakeServiceRequestDispositionCode_statusdate
ON cjams.IntakeServiceRequestDispositionCode
USING btree (statusdate ASC);