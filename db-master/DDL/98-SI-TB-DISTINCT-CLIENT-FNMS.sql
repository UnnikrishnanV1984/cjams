-- Table: tb_distinct_client_fnms

 --DROP TABLE tb_distinct_client_fnms;

CREATE TABLE tb_distinct_client_fnms
(
    formatted_first_nm character varying(20) COLLATE pg_catalog."default",
    first_nm_soundex character varying(4) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE tb_distinct_client_fnms
    OWNER to welfareadmin;