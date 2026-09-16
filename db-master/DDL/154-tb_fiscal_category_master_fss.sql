-- Table: cjams.tb_fiscal_category_master_fss

-- DROP TABLE cjams.tb_fiscal_category_master_fss;

CREATE SEQUENCE tb_fiscal_category_master_fss_fiscal_category_id_seq START 101;

CREATE TABLE cjams.tb_fiscal_category_master_fss
(
    fiscal_category_id integer NOT NULL DEFAULT nextval('tb_fiscal_category_master_fss_fiscal_category_id_seq'::regclass),
    fiscal_category_cd character(5) COLLATE pg_catalog."default",
    fiscal_category_desc character varying(100) COLLATE pg_catalog."default",
    eligibility_cd character varying(5) COLLATE pg_catalog."default",
    ancillary_maintenance_sw character(1) COLLATE pg_catalog."default",
    payment_type_cd character varying(5) COLLATE pg_catalog."default",
    create_user_id character varying(50) COLLATE pg_catalog."default" NOT NULL,
    update_user_id character varying(50) COLLATE pg_catalog."default" NOT NULL,
    delete_sw character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::bpchar,
    start_dt date,
    end_dt date,
    create_ts timestamp without time zone,
    update_ts timestamp without time zone,
    run_no character varying(100) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE cjams.tb_fiscal_category_master_fss
    OWNER to welfareadmin;