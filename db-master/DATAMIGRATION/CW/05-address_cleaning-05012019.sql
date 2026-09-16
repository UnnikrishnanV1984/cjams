CREATE TABLE public.cjams_c_ldg_address
(
    src_rowid bigint,
    last_update_date timestamp(6) without time zone,
    pkey_src_obj character varying(200) COLLATE pg_catalog."default",
    addr_line_1 character varying(200) COLLATE pg_catalog."default",
    addr_line_2 character varying(50) COLLATE pg_catalog."default",
    county_cd character varying(50) COLLATE pg_catalog."default",
    city character varying(50) COLLATE pg_catalog."default",
    country_cd character varying(50) COLLATE pg_catalog."default",
    state character varying(50) COLLATE pg_catalog."default",
    zip character varying(10) COLLATE pg_catalog."default",
    zip4 character varying(5) COLLATE pg_catalog."default",
    validated character varying(10) COLLATE pg_catalog."default",
    src_sys character varying(50) COLLATE pg_catalog."default",
    del_ind character(1) COLLATE pg_catalog."default",
    addr_line_1_raw character varying(200) COLLATE pg_catalog."default",
    addr_line_2_raw character varying(50) COLLATE pg_catalog."default",
    mailability_score bigint,
    address_status_indicator character varying(5) COLLATE pg_catalog."default"
);

CREATE TABLE public.cjams_c_ldg_party_role_addr
(
    src_rowid bigint,
    last_update_date timestamp(6) without time zone,
    src_sys character varying(50) COLLATE pg_catalog."default",
    del_ind character(1) COLLATE pg_catalog."default",
    eff_start_date timestamp(6) without time zone,
    addr_pkey character varying(50) COLLATE pg_catalog."default",
    party_role_pkey character varying(50) COLLATE pg_catalog."default",
    addr_type_cd character varying(50) COLLATE pg_catalog."default",
    eff_end_date timestamp(6) without time zone
);

CREATE TABLE public.cjams_address_reject
(
    address_id integer,
    adr_line_1 character varying(60) COLLATE pg_catalog."default",
    addr_line_2 character varying(60) COLLATE pg_catalog."default",
    city character varying(100) COLLATE pg_catalog."default",
    zipcode character varying(15) COLLATE pg_catalog."default",
    county character varying(15) COLLATE pg_catalog."default",
    state_cd character varying(15) COLLATE pg_catalog."default",
    cntry_cd character varying(15) COLLATE pg_catalog."default",
    district_cd character varying(15) COLLATE pg_catalog."default",
    address_type_cd character varying(15) COLLATE pg_catalog."default",
    adr_vefctn_data character varying(15) COLLATE pg_catalog."default",
    adr_vrfyd_ind character varying(15) COLLATE pg_catalog."default",
    session_id character varying(15) COLLATE pg_catalog."default",
    created_by character varying(15) COLLATE pg_catalog."default",
    created_ts timestamp(6) without time zone,
    updated_by character varying(15) COLLATE pg_catalog."default",
    updated_ts timestamp(6) without time zone,
    reject_id integer,
    reject_type character varying(15) COLLATE pg_catalog."default",
    reject_reason character varying(250) COLLATE pg_catalog."default",
    reject_ts timestamp(6) without time zone,
    parent_key_id integer
);