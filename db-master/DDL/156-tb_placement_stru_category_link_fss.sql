-- Table: cjams.tb_placement_stru_category_link_fss

-- DROP TABLE cjams.tb_placement_stru_category_link_fss;

CREATE SEQUENCE tb_placement_stru_category_link_placement_stru_cate_link_id_seq START 101;

CREATE TABLE cjams.tb_placement_stru_category_link_fss
(
    placement_stru_cate_link_id integer NOT NULL DEFAULT nextval('tb_placement_stru_category_link_placement_stru_cate_link_id_seq'::regclass),
    service_id integer,
    fiscal_category_id integer,
    create_user_id character varying(50) COLLATE pg_catalog."default" NOT NULL,
    update_user_id character varying(50) COLLATE pg_catalog."default" NOT NULL,
    delete_sw character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::bpchar,
    create_ts timestamp without time zone,
    update_ts timestamp without time zone,
    run_no character varying(100) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE cjams.tb_placement_stru_category_link_fss
    OWNER to welfareadmin;