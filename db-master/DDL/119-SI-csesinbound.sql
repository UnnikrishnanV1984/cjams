-- Table: cjams.csesinbound

 DROP TABLE cjams.csesinbound;

CREATE TABLE cjams.csesinbound
(
    csesinboundid uuid NOT NULL DEFAULT gen_random_uuid(),
    text character varying(1000) COLLATE pg_catalog."default",
    status character varying(5) COLLATE pg_catalog."default",
    insertedon timestamp(6) without time zone NOT NULL DEFAULT now(),
    insertedby character varying(50) COLLATE pg_catalog."default",
    old_id character varying(12) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE cjams.csesinbound
    OWNER to welfareadmin;