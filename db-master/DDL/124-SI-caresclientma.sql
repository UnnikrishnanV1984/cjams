-- Table: cjams.caresclientma

 DROP TABLE cjams.caresclientma;

CREATE TABLE cjams.caresclientma
(
    caresclientmaid uuid NOT NULL DEFAULT gen_random_uuid(),
    caresclientid uuid,
    matype character varying(50) COLLATE pg_catalog."default",
    maeligstartdate timestamp without time zone,
    maeligenddate timestamp without time zone,
    maid character varying(50) COLLATE pg_catalog."default",
    insertedby character varying(50) COLLATE pg_catalog."default",
    insertedon timestamp(6) without time zone,
    updatedby character varying(50) COLLATE pg_catalog."default",
    updatedon timestamp(6) without time zone,
    activeflag integer,
    statusflag integer,
    datavalidflag integer,
    old_id character varying(12) COLLATE pg_catalog."default",
    auno character varying COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE cjams.caresclientma
    OWNER to welfareadmin;