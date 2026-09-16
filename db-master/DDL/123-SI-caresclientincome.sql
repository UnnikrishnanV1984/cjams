-- Table: cjams.caresclientincome

 DROP TABLE cjams.caresclientincome;

CREATE TABLE cjams.caresclientincome
(
    caresclientincomeid uuid NOT NULL DEFAULT gen_random_uuid(),
    incomeidno integer,
    incometype character varying(50) COLLATE pg_catalog."default",
    incomecategory character varying(50) COLLATE pg_catalog."default",
    incomeamount numeric(10,2),
    incomeverification character varying(50) COLLATE pg_catalog."default",
    incomestartdate timestamp without time zone,
    incomeenddate timestamp without time zone,
    incomefrequency character varying(50) COLLATE pg_catalog."default",
    incomedeleteflag integer,
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

ALTER TABLE cjams.caresclientincome
    OWNER to welfareadmin;