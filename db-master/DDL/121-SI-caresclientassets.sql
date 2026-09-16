-- Table: cjams.caresclientassets

 DROP TABLE cjams.caresclientassets;

CREATE TABLE cjams.caresclientassets
(
    caresclientassetsid uuid NOT NULL DEFAULT gen_random_uuid(),
    assetidno integer,
    assettype character varying(50) COLLATE pg_catalog."default",
    assetowner integer,
    assetamount numeric(10,2),
    assetaccountno character varying(50) COLLATE pg_catalog."default",
    assetinstitutionname character varying(50) COLLATE pg_catalog."default",
    assetverificationkey character(2) COLLATE pg_catalog."default",
    assetdate timestamp without time zone,
    assetsdeleteflag integer,
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

ALTER TABLE cjams.caresclientassets
    OWNER to welfareadmin;