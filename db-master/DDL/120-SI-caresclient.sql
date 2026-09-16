-- Table: cjams.caresclient

 DROP TABLE cjams.caresclient;

CREATE TABLE cjams.caresclient
(
    caresclientid uuid NOT NULL DEFAULT gen_random_uuid(),
    lastname character varying(50) COLLATE pg_catalog."default",
    firstname character varying(50) COLLATE pg_catalog."default",
    middlename character varying(50) COLLATE pg_catalog."default",
    suffix character varying(50) COLLATE pg_catalog."default",
    ssn integer,
    dob timestamp without time zone,
    gender character varying(50) COLLATE pg_catalog."default",
    race character varying(50) COLLATE pg_catalog."default",
    maflag integer,
    insertedby character varying(50) COLLATE pg_catalog."default" NOT NULL,
    insertedon timestamp(6) without time zone NOT NULL DEFAULT now(),
    updatedby character varying(50) COLLATE pg_catalog."default",
    updatedon timestamp(6) without time zone,
    activeflag integer NOT NULL DEFAULT 1,
    statusflag integer,
    datavalidflag integer,
    old_id character varying(12) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE cjams.caresclient
    OWNER to welfareadmin;