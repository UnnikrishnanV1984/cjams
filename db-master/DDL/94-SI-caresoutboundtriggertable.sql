-- Table: cjams.caresoutboundtrigger

DROP TABLE cjams.caresoutboundtrigger;

CREATE TABLE cjams.caresoutboundtrigger
(
    caresoutboundtriggerid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
    fk_id character varying(12) COLLATE pg_catalog."default",
    transactionon timestamp without time zone,
    transactiontypekey character varying COLLATE pg_catalog."default",
    batchrunon timestamp without time zone,
    statusflag character varying(2) COLLATE pg_catalog."default",
    activeflag integer,
    batchnumber character varying(12) COLLATE pg_catalog."default",
    datavalidflag integer,
    old_id character varying(20) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE cjams.caresoutboundtrigger
    OWNER to welfareadmin;