--DROP TABLE cjams.job_incr_control;

CREATE TABLE cjams.job_incr_control
(
    job_id integer NOT NULL,
    job_name character varying(500) COLLATE pg_catalog."default",
    job_start_time timestamp without time zone,
    job_end_time timestamp without time zone,
    job_completion_flag character(1) COLLATE pg_catalog."default",
    CONSTRAINT job_incr_control_pkey PRIMARY KEY (job_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


GRANT INSERT, TRUNCATE, DELETE, UPDATE, SELECT ON TABLE cjams.job_incr_control TO bdm_cjams_readonly;

GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE cjams.job_incr_control TO "chandra.nijampudi";
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE cjams.job_incr_control TO "kishore.dasararaju";

GRANT ALL ON TABLE cjams.job_incr_control TO welfareadmin;

-- Index: job_start_end_dt

-- DROP INDEX cjams.job_start_end_dt;

CREATE INDEX job_start_end_dt
    ON cjams.job_incr_control USING btree
    (job_start_time, job_end_time)
    TABLESPACE pg_default;

INSERT INTO cjams.job_incr_control(
job_id, job_name, job_start_time, job_end_time, job_completion_flag)
VALUES ('1000', 'CJAMS_FINANCIAL_REPORT', '1900-01-01 00:00:00',current_timestamp,  'Y'); 
