-- Table: cjams.caresinboundtxt

 DROP TABLE cjams.caresinboundtxt;

CREATE TABLE cjams.caresinboundtxt
(
    caresinboundid uuid NOT NULL DEFAULT gen_random_uuid(),
    text character varying(256) COLLATE pg_catalog."default",
    status character varying(256) COLLATE pg_catalog."default",
    insertedon timestamp(6) without time zone,
    old_id character varying(12) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE cjams.caresinboundtxt
    OWNER to welfareadmin;