CREATE TABLE public.afcarsmissingelmts
(
    afcarsmissingelmtsid uuid NOT NULL,
    afcarstypekey character varying(10),
    rptstartdate timestamp without time zone,
    rptenddate timestamp without time zone,
    ldss character varying(50),
    personid UUID,
    firstname character varying(100),
    middlename character varying(100),
    lastname character varying(100),
    cisclientid character varying(25),
    dobdate timestamp without time zone,
    genderkey character varying(15),
    caseid uuid,
    casestatus character varying(20),
    caseworkerfirstname character varying(100),
    caseworkerlastname character varying(100),
    supervisorfirstname character varying(100),
    supervisorlastname character varying(100),
    missingelements character varying(1000),
    insertedby character varying(10) NOT NULL,
    insertedon timestamp without time zone NOT NULL,
    updatedby character varying(10) NOT NULL,
    updatedon timestamp without time zone NOT NULL,
    activeflag integer NOT NULL,
    CONSTRAINT pkafcrmsngelmts PRIMARY KEY (afcarsmissingelmtsid)
);



CREATE TABLE public.afcarclientvalues
(
    caseid uuid NOT NULL,
    personid uuid NOT NULL,
    afcardataelementid uuid NOT NULL,
    afcartypeflag integer ,
    value character varying(200),
    datavalidflag integer,
    CONSTRAINT pkafcarclntval PRIMARY KEY (caseid, personid, afcardataelementid, afcartypeflag)
);

CREATE TABLE public.tempafcarsplacement
(
    tempafcarsplacementid uuid NOT NULL,
    personid uuid,
    placementid uuid,
    origplacementid uuid,
    removalid uuid,
    providerid uuid,
    origentrydate timestamp without time zone,
    exitdate timestamp without time zone,
    insertedon timestamp without time zone NOT NULL,
    insertedby character varying(10) ,
    updatedon timestamp without time zone NOT NULL,
    updatedby character varying(10) ,
    activeflag integer ,
    CONSTRAINT fktmpafcrsplmt PRIMARY KEY (tempafcarsplacementid)
);

CREATE TABLE public.tempafcarsremoval
(
    tempafcarsremovalid uuid NOT NULL,
    personid uuid,
    removalid uuid,
    origremovalid uuid,
    origremovaldate timestamp without time zone,
    returndate timestamp without time zone,
    insertedon timestamp without time zone NOT NULL,
    insertedby character varying(10) NOT NULL,
    updatedon timestamp without time zone NOT NULL,
    updateuserid character varying(10) NOT NULL,
    activeflag integer,
    disregardflag integer,
    removaltypekey character varying(5) ,
    afcarsremovaldate timestamp without time zone,
    CONSTRAINT pktmpafcrsrmvl PRIMARY KEY (tempafcarsremovalid)
);