DROP TABLE if exists cjams.sdmtraffickingaudittrail;

CREATE TABLE if not exists cjams.sdmtraffickingaudittrail (
    sdmtraffickingaudittrailid uuid NOT NULL DEFAULT gen_random_uuid(), 
    intakeservicerequestsdmid uuid, 
    insertedon timestamp NULL DEFAULT now(),
    insertedby varchar(50) NULL,
    updatedby varchar(50) NULL, 
    updatedon timestamp NULL DEFAULT now(), 
    objectid varchar(50) NULL,
    objecttype varchar(50) NULL,
    activeflag varchar NOT NULL DEFAULT 1,
    concernfortrafficking varchar(10) NULL,
    selecttrafficking varchar(30) NULL,

    CONSTRAINT pk_sdmtraffickingaudittrail PRIMARY KEY (sdmtraffickingaudittrailid)    
);

comment on column cjams.sdmtraffickingaudittrail.sdmtraffickingaudittrailid is 'Sdm Trafficking information (PRIMARY KEY)';
comment on column cjams.sdmtraffickingaudittrail.intakeservicerequestsdmid is 'Intakeservice request SDM  id (Foriegn Key)';
comment on column cjams.sdmtraffickingaudittrail.insertedby is 'to store inserted by';
comment on column cjams.sdmtraffickingaudittrail.insertedon is 'to store inserted on';
comment on column cjams.sdmtraffickingaudittrail.updatedby is 'to store updated by';
comment on column cjams.sdmtraffickingaudittrail.updatedon is 'to store updated on';
comment on column cjams.sdmtraffickingaudittrail.objectid is 'to store case number and intakenumber';
comment on column cjams.sdmtraffickingaudittrail.objecttype is 'to store case type';
comment on column cjams.sdmtraffickingaudittrail.activeflag is 'to store activeflag';
comment on column cjams.sdmtraffickingaudittrail.concernfortrafficking is 'to store concern for trafficking values';
comment on column cjams.sdmtraffickingaudittrail.selecttrafficking is 'to store selected trafficking values';