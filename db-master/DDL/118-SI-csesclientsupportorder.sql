-- Table: cjams.csesclientsupportorder

 DROP TABLE cjams.csesclientsupportorder;

CREATE TABLE cjams.csesclientsupportorder
(
    csesclientsupportorderid uuid NOT NULL,
    cisclientid character varying(12) COLLATE pg_catalog."default",
    personid uuid,
    socounty character varying(50) COLLATE pg_catalog."default",
    socityname character varying(50) COLLATE pg_catalog."default",
    sostate character varying(12) COLLATE pg_catalog."default",
    sonumber character varying(50) COLLATE pg_catalog."default",
    sodate timestamp without time zone,
    sostatusdate timestamp without time zone,
    sostatustypekey character varying(50) COLLATE pg_catalog."default",
    sopaymentamount numeric,
    sopaymentfreqtypekey character varying(50) COLLATE pg_catalog."default",
    sodatasource character varying COLLATE pg_catalog."default",
    insertedon timestamp(6) without time zone NOT NULL DEFAULT now(),
    insertedby character varying(50) COLLATE pg_catalog."default" NOT NULL,
    updatedon timestamp(6) without time zone,
    updatedby character varying(50) COLLATE pg_catalog."default",
    activeflag integer NOT NULL DEFAULT 1,
    datavalidflag integer,
    clientmergeid character varying(12) COLLATE pg_catalog."default",
    old_id character varying(12) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE cjams.csesclientsupportorder
    OWNER to welfareadmin;