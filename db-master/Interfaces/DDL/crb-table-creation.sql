-- Table: cjams.crbreferencevalues

DROP TABLE if exists crbreferencevalues;

CREATE TABLE crbreferencevalues
(
    referenceid integer NOT NULL,
    cjamscode character varying(50) COLLATE pg_catalog."default",
    chessiecode character varying(50) COLLATE pg_catalog."default",
    description character varying(100) COLLATE pg_catalog."default",
    referencetype character varying(50) COLLATE pg_catalog."default",
    activeflag integer,
    CONSTRAINT crbreferencevalues_pkey PRIMARY KEY (referenceid)
)
WITH (
    OIDS = FALSE
)
-- TABLESPACE pg_default;

-- ALTER TABLE cjams.crbreferencevalues
    -- OWNER to welfareadmin;