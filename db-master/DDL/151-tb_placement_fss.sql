-- Table: cjams.tb_placement_fss

 DROP TABLE cjams.tb_placement_fss;

CREATE TABLE cjams.tb_placement_fss
(
    placement_id integer NOT NULL,
    case_id bigint,
    client_id integer NOT NULL,
    removal_id integer,
    provider_organization_id integer,
    provider_id integer,
    contract_program_id integer,
    facility_id integer,
    medicaid_paid_sw character(1) COLLATE pg_catalog."default",
    entry_dt date,
    entry_tm character varying(30) COLLATE pg_catalog."default",
    other_services_tx character varying(500) COLLATE pg_catalog."default",
    exit_dt date,
    exit_tm character varying(30) COLLATE pg_catalog."default",
    exit_explanation_tx character varying(500) COLLATE pg_catalog."default",
    exit_reason_cd character varying(5) COLLATE pg_catalog."default",
    over_under_sw character(1) COLLATE pg_catalog."default",
    approval_status_cd character varying(5) COLLATE pg_catalog."default",
    placement_structure_id integer,
    void_sw character(1) COLLATE pg_catalog."default",
    void_reason_cd character varying(5) COLLATE pg_catalog."default",
    exit_type_cd character varying(5) COLLATE pg_catalog."default",
    court_ordered_sw character(1) COLLATE pg_catalog."default",
    icpc_approved_sw character(1) COLLATE pg_catalog."default",
    create_ts character varying(30) COLLATE pg_catalog."default" NOT NULL DEFAULT now(),
    create_user_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    update_ts character varying(30) COLLATE pg_catalog."default" NOT NULL DEFAULT now(),
    update_user_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    delete_sw character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::bpchar,
    short_list_id integer,
    payment_header_id integer,
    placement_change_dt date,
    fiscal_category_cd character(5) COLLATE pg_catalog."default",
    rate_structure_id integer,
    conversion_sw character(1) COLLATE pg_catalog."default",
    orig_placement_id integer,
    data_valid_sw character(1) COLLATE pg_catalog."default",
    client_merge_id uuid,
    run_no character varying(9) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE cjams.tb_placement_fss
    OWNER to welfareadmin;