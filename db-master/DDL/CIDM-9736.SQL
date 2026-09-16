-- Drop table

-- DROP TABLE cjams.beaconrequestdetails;
--------------------------------------------------------------------------------------------------
-- 04/10/2025 prasanna sai kommineni - CIDM-9736 BEACON Interface

-----------------------------------------------------------------------------------------------------
DROP TABLE if exists cjams.beaconrequestdetails;

CREATE TABLE if not exists cjams.beaconrequestdetails (
beaconrequestdetailsid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
caseobjecttype varchar(50)  NULL ,
caseobjectid varchar(50)  NULL ,
personid uuid NOT NULL ,
ssn varchar(50) NULL,
activeflag int4 NOT NULL DEFAULT 1,
updatedby varchar(50) NULL,
updatedon timestamp NOT NULL DEFAULT now(),
insertedby varchar(50) NULL,
insertedon timestamp NOT NULL DEFAULT now(),
CONSTRAINT pk_beaconrequestdetailsid PRIMARY KEY (beaconrequestdetailsid),
CONSTRAINT fk_beaconrequestdetailsid_personid FOREIGN KEY (personid) REFERENCES cjams.person(personid)
);

ALTER TABLE cjams.beaconrequestdetails
ADD COLUMN if not exists sourcetrackingid BIGSERIAL ;

ALTER TABLE cjams.beaconrequestdetails
ADD COLUMN if not exists sourcesystem varchar(50) ;

-- Remove the default sequence associated with BIGSERIAL
ALTER TABLE cjams.beaconrequestdetails ALTER COLUMN sourcetrackingid DROP DEFAULT;

-- Alter the column type from BIGSERIAL to INT
ALTER TABLE cjams.beaconrequestdetails ALTER COLUMN sourcetrackingid TYPE INT USING sourcetrackingid::INTEGER;

COMMENT ON COLUMN cjams.beaconrequestdetails.sourcesystem IS 'to save source system';
COMMENT ON COLUMN cjams.beaconrequestdetails.sourcetrackingid IS 'to save source tracking id';
COMMENT ON COLUMN cjams.beaconrequestdetails.beaconrequestdetailsid IS 'table primary key';
COMMENT ON COLUMN cjams.beaconrequestdetails.caseobjecttype IS 'Type of case';
COMMENT ON COLUMN cjams.beaconrequestdetails.caseobjectid is 'Case uuid.Ex: service case or AR or IR';
COMMENT ON COLUMN cjams.beaconrequestdetails.Personid is 'Requested person uuid and it is foreign key ';
COMMENT ON COLUMN cjams.beaconrequestdetails.ssn is 'Requeseted person ssn';
COMMENT ON COLUMN cjams.beaconrequestdetails.activeflag is 'Status of the record';
COMMENT ON COLUMN cjams.beaconrequestdetails.updatedby is 'user who last updated the record';
COMMENT ON COLUMN cjams.beaconrequestdetails.updatedon is 'Record updated date and time';
COMMENT ON COLUMN cjams.beaconrequestdetails.insertedby is 'User who created this record';
COMMENT ON COLUMN cjams.beaconrequestdetails.insertedon IS 'Record created date and time';

drop sequence if EXISTS  beacon_sourcetrackingid_Sequence;
CREATE SEQUENCE beacon_sourcetrackingid_Sequence;

ALTER TABLE cjams.beaconrequestdetails
ADD COLUMN if not exists historyresponseprocesseddate varchar(50) ;

ALTER TABLE cjams.beaconrequestdetails
DROP column if  exists sourcesystem;

DROP TABLE if exists cjams.beaconaudittrail;

CREATE TABLE if not exists cjams.beaconaudittrail (
beaconaudittrailid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
event varchar(255)  NULL ,
eventpage varchar(255)  NULL ,
eventid varchar(255)  NULL ,
activeflag int4 NOT NULL DEFAULT 1,
updatedby varchar(50) NULL,
updatedon timestamp NOT NULL DEFAULT now(),
insertedby varchar(50) NULL,
insertedon timestamp NOT NULL DEFAULT now(),
CONSTRAINT pk_beaconaudittrailid PRIMARY KEY (beaconaudittrailid)
);


ALTER TABLE cjams.beaconaudittrail
ADD COLUMN if not exists ssn  varchar(50) NULL ;

COMMENT ON COLUMN cjams.beaconaudittrail.ssn IS 'to save ssn';

COMMENT ON COLUMN cjams.beaconaudittrail.beaconaudittrailid IS 'table primary key';
COMMENT ON COLUMN cjams.beaconaudittrail.event IS 'Type of event';
COMMENT ON COLUMN cjams.beaconaudittrail.eventpage is 'info accessed info';
COMMENT ON COLUMN cjams.beaconaudittrail.eventid is 'Requested event id';
COMMENT ON COLUMN cjams.beaconaudittrail.activeflag is 'Status of the record';
COMMENT ON COLUMN cjams.beaconaudittrail.updatedby is 'user who last updated the record';
COMMENT ON COLUMN cjams.beaconaudittrail.updatedon is 'Record updated date and time';
COMMENT ON COLUMN cjams.beaconaudittrail.insertedby is 'User who created this record';
COMMENT ON COLUMN cjams.beaconaudittrail.insertedon IS 'Record created date and time';