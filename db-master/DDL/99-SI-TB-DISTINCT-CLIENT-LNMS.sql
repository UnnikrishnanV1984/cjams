	-- Table: tb_distinct_client_lnms

 --DROP TABLE tb_distinct_client_lnms;

CREATE TABLE tb_distinct_client_lnms
(
    formatted_last_nm character varying(20) COLLATE pg_catalog."default",
    last_nm_soundex character varying(4) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE tb_distinct_client_lnms
    OWNER to welfareadmin;