-- Table: cjams.tb_adoption_subsidy_agreement_fss

 DROP TABLE cjams.tb_adoption_subsidy_agreement_fss;
 
 CREATE SEQUENCE tb_adoption_subsidy_agreement_fss_subsidy_agreement_id_seq START 101;

CREATE TABLE cjams.tb_adoption_subsidy_agreement_fss
(
    subsidy_agreement_id integer NOT NULL DEFAULT nextval('tb_adoption_subsidy_agreement_fss_subsidy_agreement_id_seq'::regclass),
	adoptionagreementid uuid,
    agreement_type_cd character varying(5) COLLATE pg_catalog."default",
    father_agreement_sw character(1) COLLATE pg_catalog."default",
    mother_agreement_sw character(1) COLLATE pg_catalog."default",
    designee_agreement_sw character(1) COLLATE pg_catalog."default",
    adoption_id integer,
    agreement_start_dt date,
    create_ts timestamp without time zone NOT NULL DEFAULT current_timestamp,
    agreement_end_dt date,
    calculate_board_rate_sw character(1) COLLATE pg_catalog."default",
    create_user_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    update_ts timestamp without time zone NOT NULL DEFAULT current_timestamp,
    negotiated_percentage_no numeric(5,2),
    payment_amount_no numeric(10,2),
    update_user_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    court_hearing_id integer,
    delete_sw character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::bpchar,
    comments_tx character varying(5000) COLLATE pg_catalog."default",
    approval_status_cd character varying(5) COLLATE pg_catalog."default",
    provider_id integer,
    rate_overwritten_sw character(1) COLLATE pg_catalog."default",
    admin_approval_status_cd character varying(5) COLLATE pg_catalog."default",
    child_medically_fragile_sw character(1) COLLATE pg_catalog."default",
    run_no character varying(9) COLLATE pg_catalog."default",
    CONSTRAINT pk_adpn_sub_agmt_fss PRIMARY KEY (subsidy_agreement_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE cjams.tb_adoption_subsidy_agreement_fss
    OWNER to welfareadmin;

