-- Table: cjams.tb_foster_care_rate_fss

-- DROP TABLE cjams.tb_foster_care_rate_fss;

CREATE TABLE cjams.tb_foster_care_rate_fss
(
    rate_id integer NOT NULL,
    service_id integer,
    start_dt timestamp without time zone,
    end_dt timestamp without time zone,
    min_age_no integer,
    max_age_no integer,
    monthly_rate_no numeric(10,2),
    per_diem_rate_no numeric(10,2),
    monthly_clothing_no numeric(10,2),
    emergency_per_diem_no numeric(10,2),
    emergency_bed_fee numeric(10,2),
    create_user_id character varying(50) COLLATE pg_catalog."default" NOT NULL,
    update_user_id character varying(50) COLLATE pg_catalog."default" NOT NULL,
    delete_sw character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::bpchar,
    rate_type_cd character(5) COLLATE pg_catalog."default",
    difficulty_level_cd character(5) COLLATE pg_catalog."default",
    max_clothing_no numeric(10,2),
    monthly_stipend_no numeric(10,2),
    monthly_differential_no numeric(10,2),
    create_ts timestamp without time zone,
    update_ts timestamp without time zone,
    run_no character varying(100) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE cjams.tb_foster_care_rate_fss
    OWNER to welfareadmin;