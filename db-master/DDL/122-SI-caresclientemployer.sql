-- Table: cjams.caresclientemployer

 DROP TABLE cjams.caresclientemployer;

CREATE TABLE cjams.caresclientemployer
(
    caresclientemployerid uuid NOT NULL DEFAULT gen_random_uuid(),
    employeridno integer,
    employername character varying(50) COLLATE pg_catalog."default",
    employerstartdate timestamp without time zone,
    employerenddate timestamp without time zone,
    employerdeleteflag integer,
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

ALTER TABLE cjams.caresclientemployer
    OWNER to welfareadmin;