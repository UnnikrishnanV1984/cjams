-- Table: cjams.tb_client_eligibility_fss

-- DROP TABLE cjams.tb_client_eligibility_fss;

CREATE SEQUENCE tb_client_eligibility_fss_eligibility_id_seq START 101;

CREATE TABLE cjams.tb_client_eligibility_fss
(
    eligibility_id integer NOT NULL DEFAULT nextval('tb_client_eligibility_fss_eligibility_id_seq'::regclass),
    start_dt date,
    end_dt date,
    eligibility_type_cd character varying(5) COLLATE pg_catalog."default",
    eligibility_status_cd character varying(5) COLLATE pg_catalog."default",
    client_id integer,
    removal_id integer,
    create_ts timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    create_user_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    update_ts timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    delete_sw character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::bpchar,
    adoption_id integer,
    case_id integer,
    data_valid_sw character(1) COLLATE pg_catalog."default",
    client_merge_id integer,
    run_no character varying(100) COLLATE pg_catalog."default",
    guardian_subsidy_id integer,
    CONSTRAINT pk_clnt_elig_fss PRIMARY KEY (eligibility_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE cjams.tb_client_eligibility_fss
    OWNER to welfareadmin;

COMMENT ON COLUMN cjams.tb_client_eligibility_fss.guardian_subsidy_id
    IS 'To link SUB G and Eligibility Episode record';

-- Index: ix_354tb_client_fss

-- DROP INDEX cjams.ix_354tb_client_fss;

CREATE INDEX ix_354tb_client_fss
    ON cjams.tb_client_eligibility_fss USING btree
    (removal_id)
    TABLESPACE pg_default;

-- Index: ix_celig03_fss

-- DROP INDEX cjams.ix_celig03_fss;

CREATE INDEX ix_celig03_fss
    ON cjams.tb_client_eligibility_fss USING btree
    (adoption_id)
    TABLESPACE pg_default;

-- Index: ix_client_elig4_fss

-- DROP INDEX cjams.ix_client_elig4_fss;

CREATE INDEX ix_client_elig4_fss
    ON cjams.tb_client_eligibility_fss USING btree
    (client_id, eligibility_status_cd COLLATE pg_catalog."default", eligibility_type_cd COLLATE pg_catalog."default", delete_sw COLLATE pg_catalog."default")
    TABLESPACE pg_default;

-- Index: ix_clmntelg_fss

-- DROP INDEX cjams.ix_clmntelg_fss;

CREATE INDEX ix_clmntelg_fss
    ON cjams.tb_client_eligibility_fss USING btree
    (guardian_subsidy_id)
    TABLESPACE pg_default;

-- Index: ix_f142_fss

-- DROP INDEX cjams.ix_f142_fss;

CREATE INDEX ix_f142_fss
    ON cjams.tb_client_eligibility_fss USING btree
    (client_id)
    TABLESPACE pg_default;

-- Index: ix_perf_impr63_fss

-- DROP INDEX cjams.ix_perf_impr63_fss;

CREATE INDEX ix_perf_impr63_fss
    ON cjams.tb_client_eligibility_fss USING btree
    (case_id)
    TABLESPACE pg_default;