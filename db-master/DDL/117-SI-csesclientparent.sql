-- Table: cjams.csesclientparent

 DROP TABLE cjams.csesclientparent;

CREATE TABLE cjams.csesclientparent
(
    csesclientparentid uuid NOT NULL DEFAULT gen_random_uuid(),
    cisparentclientid character varying(12) COLLATE pg_catalog."default",
    cisclientid character varying(12) COLLATE pg_catalog."default",
    personid uuid,
    parrelationshiptypekey character varying(50) COLLATE pg_catalog."default",
    parlegalesttypekey character varying(50) COLLATE pg_catalog."default",
    parlegalestdate date,
    parlastname character varying(50) COLLATE pg_catalog."default",
    parfirstname character varying(50) COLLATE pg_catalog."default",
    parmiddlename character varying(50) COLLATE pg_catalog."default",
    parsuffix character varying(50) COLLATE pg_catalog."default",
    parssn integer,
    pargendertypekey character varying(50) COLLATE pg_catalog."default",
    pardob timestamp(6) without time zone,
    parracetypekey character varying(50) COLLATE pg_catalog."default",
    parlastaddressline1 character varying(50) COLLATE pg_catalog."default",
    parlastaddressline2 character varying(50) COLLATE pg_catalog."default",
    parlastaddresscity character varying(50) COLLATE pg_catalog."default",
    parlastaddressstate character varying(6) COLLATE pg_catalog."default",
    parlastaddresszip character varying(50) COLLATE pg_catalog."default",
    parlastphonenumber character varying(50) COLLATE pg_catalog."default",
    parlastaddressdate timestamp without time zone,
    pardateofdeath timestamp without time zone,
    parcuremp1name character varying(50) COLLATE pg_catalog."default",
    parcuremp1addressline1 character varying(50) COLLATE pg_catalog."default",
    parcuremp1addressline2 character varying(50) COLLATE pg_catalog."default",
    parcuremp1addresscity character varying(50) COLLATE pg_catalog."default",
    parcuremp1addressstate character varying(50) COLLATE pg_catalog."default",
    parcuremp1addresszip character varying(50) COLLATE pg_catalog."default",
    parcuremp1phoneno character varying(50) COLLATE pg_catalog."default",
    parcuremp1startdate date,
    parcuremp1enddate date,
    parcuremp2name character varying(50) COLLATE pg_catalog."default",
    parcuremp2addressline1 character varying(50) COLLATE pg_catalog."default",
    parcuremp2addressline2 character varying(50) COLLATE pg_catalog."default",
    parcuremp2addresscity character varying(50) COLLATE pg_catalog."default",
    parcuremp2addressstate character varying(6) COLLATE pg_catalog."default",
    parcuremp2addresszip character varying(50) COLLATE pg_catalog."default",
    parcuremp2phoneno character varying(50) COLLATE pg_catalog."default",
    parcuremp2startdate date,
    parcuremp2enddate date,
    parmedinsuranceflag integer,
    parmilitarystartdate date,
    parmilitaryenddate date,
    parmilitarybranchtypekey character varying(50) COLLATE pg_catalog."default",
    parsoflag integer,
    parsonumber character varying(50) COLLATE pg_catalog."default",
    parsolastpayamount numeric(10,2),
    parsolastpaydate timestamp without time zone,
    parsolastpaymethodtypekey character varying(50) COLLATE pg_catalog."default",
    insertedby character varying(50) COLLATE pg_catalog."default" NOT NULL,
    insertedon timestamp(6) without time zone NOT NULL DEFAULT now(),
    updatedby character varying(50) COLLATE pg_catalog."default",
    updatedon timestamp(6) without time zone,
    activeflag integer NOT NULL DEFAULT 1,
    datavalidflag integer,
    clientmergeid integer,
    old_id character varying(12) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE cjams.csesclientparent
    OWNER to welfareadmin;