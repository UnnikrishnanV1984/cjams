
-- 10/18/2023 prasanna sai kommineni -- CIDM-9541 B-206485 : CW-Psychotropic Medications - Secondary Review
DROP TABLE if exists cjams.psycotrophicothercurrentmedication;

DROP TABLE if exists cjams.psychotropicmedications;

CREATE TABLE if not exists cjams.psychotropicmedications(
psychotropicid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
objecttypekey varchar(50) null,
objectid varchar(50) null,
personid uuid  null,
medicationname character varying  null,
classification character varying  null,
dateprescribed timestamp NULL,
targetedsymptoms varchar(50) null,
methodofdelivery varchar(50) null,
otherfrequency text,
othersymptoms text,
specifyhour text,
prescribedduration varchar(50) null,
isdraft  boolean  DEFAULT false,
dosage text null,
frequency varchar(50) null,
diagnosis varchar(50) null,
prescribername varchar(255) null,
prescribercontactinfo  varchar(50) null,
prescriberemail varchar(50) null,
psychotropiccomments text null,
insertedon timestamp NOT NULL DEFAULT now(),
insertedby varchar(50) NOT NULL,
updatedon timestamp  not NULL DEFAULT now(),
updatedby varchar(50) not  NULL,
activeflag int4 NOT NULL DEFAULT 1,
CONSTRAINT pk_psychotropicid PRIMARY KEY (psychotropicid),
CONSTRAINT fk_pshychotropic_personid FOREIGN KEY (personid) REFERENCES cjams.person(personid));
-- Column comments
COMMENT ON COLUMN cjams.psychotropicmedications.objectid IS 'to save casenumber id';
COMMENT ON COLUMN cjams.psychotropicmedications.objecttypekey IS 'to save casen type ';
COMMENT ON COLUMN cjams.psychotropicmedications.personid IS 'to save personid';
COMMENT ON COLUMN cjams.psychotropicmedications.medicationname IS 'to save medicationname';
COMMENT ON COLUMN cjams.psychotropicmedications.classification IS 'to save classification';
COMMENT ON COLUMN cjams.psychotropicmedications.psychotropicid IS 'to save psychotropicid Table primary key(UUID) ';
COMMENT ON COLUMN cjams.psychotropicmedications.activeflag IS 'to save activeflag';
COMMENT ON COLUMN cjams.psychotropicmedications.updatedby IS 'to save updatedby';
COMMENT ON COLUMN cjams.psychotropicmedications.updatedon IS 'to save updatedon';
COMMENT ON COLUMN cjams.psychotropicmedications.insertedby IS 'to save insertedby';
COMMENT ON COLUMN cjams.psychotropicmedications.insertedon IS 'to save insertedon';
COMMENT ON COLUMN cjams.psychotropicmedications.psychotropiccomments IS 'to save psychotropiccomments';
COMMENT ON COLUMN cjams.psychotropicmedications.prescriberemail IS 'to save prescriberemail';
COMMENT ON COLUMN cjams.psychotropicmedications.prescribercontactinfo IS 'to save prescribercontactinfo';
COMMENT ON COLUMN cjams.psychotropicmedications.prescribername IS 'to save prescribername';
COMMENT ON COLUMN cjams.psychotropicmedications.diagnosis IS 'to save diagnosis';
COMMENT ON COLUMN cjams.psychotropicmedications.frequency IS 'to save frequency';
COMMENT ON COLUMN cjams.psychotropicmedications.dosage IS 'to save dosage';
COMMENT ON COLUMN cjams.psychotropicmedications.isdraft IS 'to save isdraft';
COMMENT ON COLUMN cjams.psychotropicmedications.prescribedduration IS 'to save prescribedduration';
COMMENT ON COLUMN cjams.psychotropicmedications.methodofdelivery IS 'to save methodofdelivery';
COMMENT ON COLUMN cjams.psychotropicmedications.targetedsymptoms IS 'to save targetedsymptoms';
COMMENT ON COLUMN cjams.psychotropicmedications.dateprescribed IS 'to save dateprescribed';


COMMENT ON COLUMN cjams.psychotropicmedications.otherfrequency IS 'to save other frequency';
COMMENT ON COLUMN cjams.psychotropicmedications.othersymptoms IS 'to save other symptoms';
COMMENT ON COLUMN cjams.psychotropicmedications.specifyhour IS 'to save specify hour';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists specifyduration text;

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists otherspecifyduration text;


COMMENT ON COLUMN cjams.psychotropicmedications.specifyduration IS 'to save specify duration';
COMMENT ON COLUMN cjams.psychotropicmedications.otherspecifyduration IS 'to save other specify duration';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists isinfoincomplete boolean;
COMMENT ON COLUMN cjams.psychotropicmedications.isinfoincomplete IS 'to save INFORMATION INCOMPLETE';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists prescriberdegree varchar(50) null;
COMMENT ON COLUMN cjams.psychotropicmedications.prescriberdegree IS 'to save prescriber degree';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists otherprescriberdegree TEXT null;
COMMENT ON COLUMN cjams.psychotropicmedications.otherprescriberdegree IS 'to save other prescriber degree';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists prescriberspecialty varchar(50) null;
COMMENT ON COLUMN cjams.psychotropicmedications.prescriberspecialty IS 'to save  Prescriber Field of Specialty ';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists otherprescriberspecialty TEXT null;
COMMENT ON COLUMN cjams.psychotropicmedications.otherprescriberspecialty IS 'to save other  Prescriber Field of Specialty ';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists settingmedicationprescribed varchar(50) null;
COMMENT ON COLUMN cjams.psychotropicmedications.settingmedicationprescribed IS 'to save  Setting where medication prescribed';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists otherdiagnosis TEXT null;
COMMENT ON COLUMN cjams.psychotropicmedications.otherdiagnosis IS 'to save other diagnosis';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists  psychosocialinterventions varchar(50) null;
COMMENT ON COLUMN cjams.psychotropicmedications.psychosocialinterventions IS 'to save Currently receiving psychosocial interventions -YES/NO';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists  additionalpsychosocialinterventions varchar(50) null;
COMMENT ON COLUMN cjams.psychotropicmedications.additionalpsychosocialinterventions IS 'to save Currently additional receiving psychosocial interventions -drop down';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists otheradditionalpsychosocialinterventions TEXT null;
COMMENT ON COLUMN cjams.psychotropicmedications.otheradditionalpsychosocialinterventions IS 'to save other  to save Currently additional receiving psychosocial interventions -drop down';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists peerreview boolean null;
COMMENT ON COLUMN cjams.psychotropicmedications.peerreview IS 'to save Peer to Peer review done';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists  revieweddate date null;
COMMENT ON COLUMN cjams.psychotropicmedications.revieweddate IS 'to save Peer to Peer review reviewe ddate';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists  reviewedby text null;
COMMENT ON COLUMN cjams.psychotropicmedications.reviewedby IS 'to save Peer to Peer review reviewed by';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists countytypekey varchar(50) null;
COMMENT ON COLUMN cjams.psychotropicmedications.countytypekey IS 'to save county type';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists othermedications text null;
COMMENT ON COLUMN cjams.psychotropicmedications.othermedications IS 'to save other medications';
-- 1.age ,2.peerdecision 3.medicaldiagnosis 

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists age text null;
COMMENT ON COLUMN cjams.psychotropicmedications.age IS 'to save age';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists peerdecision varchar(50) null;
COMMENT ON COLUMN cjams.psychotropicmedications.peerdecision IS 'to save peer decision';

ALTER TABLE cjams.psychotropicmedications  ADD COLUMN if not exists medicaldiagnosis text null;
COMMENT ON COLUMN cjams.psychotropicmedications.medicaldiagnosis IS 'to save medical diagnosis';

ALTER TABLE cjams.psychotropicmedications
ADD COLUMN if not exists psychotropicrequestid BIGSERIAL not null;

COMMENT ON COLUMN cjams.psychotropicmedications.psychotropicrequestid IS 'to save psychotropic requestid';

ALTER TABLE cjams.userprofile  ADD COLUMN if not exists alternateemailid varchar(100);

COMMENT ON COLUMN cjams.userprofile.alternateemailid IS 'to save alternatee mail id of the user';




CREATE TABLE cjams.psycotrophicothercurrentmedication (
	psycotrophicothercurrentmedicationid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
	psychotropicid uuid NOT NULL,
	currentmedication varchar(255) NULL,
	dosage varchar(255) NULL,
	indication text NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	insertedby varchar(50) NOT NULL,
	updatedon timestamp NOT NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	CONSTRAINT pk_psycotrophicothercurrentmedicationid PRIMARY KEY (psycotrophicothercurrentmedicationid),
	CONSTRAINT fk_psychotropicid FOREIGN KEY (psychotropicid) REFERENCES cjams.psychotropicmedications(psychotropicid)
);

-- Add comments for the columns
COMMENT ON COLUMN cjams.psycotrophicothercurrentmedication.psycotrophicothercurrentmedicationid IS 'Unique identifier for the psychotropic other current medication';
COMMENT ON COLUMN cjams.psycotrophicothercurrentmedication.psychotropicid IS 'Foreign key linking to the psychotropic medications';
COMMENT ON COLUMN cjams.psycotrophicothercurrentmedication.currentmedication IS 'Current medication';
COMMENT ON COLUMN cjams.psycotrophicothercurrentmedication.dosage IS 'Dosage of the medication';
COMMENT ON COLUMN cjams.psycotrophicothercurrentmedication.indication IS 'Indication for the medication';
COMMENT ON COLUMN cjams.psycotrophicothercurrentmedication.insertedon IS 'Timestamp of insertion';
COMMENT ON COLUMN cjams.psycotrophicothercurrentmedication.insertedby IS 'User who inserted the record';
COMMENT ON COLUMN cjams.psycotrophicothercurrentmedication.updatedon IS 'Timestamp of last update';
COMMENT ON COLUMN cjams.psycotrophicothercurrentmedication.updatedby IS 'User who last updated the record';
COMMENT ON COLUMN cjams.psycotrophicothercurrentmedication.activeflag IS 'Active flag (1 for active, 0 for inactive)';

DROP TABLE if exists cjams.countygoliveconfig;
-- Create table countygoliveconfig
CREATE TABLE  cjams.countygoliveconfig (
    countygoliveconfigid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),  -- Unique identifier for the county go-live config
    objecttype VARCHAR(50),  -- Type of object
    statewide DATE,  -- Statewide go-live date
    charles DATE,  -- Charles county go-live date
    washington DATE,  -- Washington county go-live date
    stmarys DATE,  -- St. Mary's county go-live date
    annearundel DATE,  -- Anne Arundel county go-live date
    frederick DATE,  -- Frederick county go-live date
    garrett DATE,  -- Garrett county go-live date
    carroll DATE,  -- Carroll county go-live date
    allegany DATE,  -- Allegany county go-live date
    princegeorge DATE,  -- Prince George's county go-live date
    montgomery DATE,  -- Montgomery county go-live date
    calvert DATE,  -- Calvert county go-live date
    baltimorecity DATE,  -- Baltimore City go-live date
    baltimorecounty DATE,  -- Baltimore County go-live date
    caroline DATE,  -- Caroline county go-live date
    dorchester DATE,  -- Dorchester county go-live date
    kent DATE,  -- Kent county go-live date
    queenannes DATE,  -- Queen Anne's county go-live date
    somerset DATE,  -- Somerset county go-live date
    wicomico DATE,  -- Wicomico county go-live date
    worcester DATE,  -- Worcester county go-live date
    cecil DATE,  -- Cecil county go-live date
    talbot DATE,  -- Talbot county go-live date
    harford DATE,  -- Harford county go-live date
    howard DATE,  -- Howard county go-live date
    dhris DATE,  -- DHRIS go-live date
    insertedon TIMESTAMP NOT NULL DEFAULT NOW(),  -- Timestamp of insertion
    insertedby VARCHAR(50) NOT NULL,  -- User who inserted the record
    updatedon TIMESTAMP NOT NULL DEFAULT NOW(),  -- Timestamp of last update
    updatedby VARCHAR(50),  -- User who last updated the record
    activeflag INT4 NOT NULL DEFAULT 1  -- Active flag (1 for active, 0 for inactive)
);

COMMENT ON COLUMN countygoliveconfig.countygoliveconfigid IS 'Unique identifier for the county go-live config';
COMMENT ON COLUMN countygoliveconfig.objecttype IS 'Type of object';
COMMENT ON COLUMN countygoliveconfig.statewide IS 'Statewide go-live date';
COMMENT ON COLUMN countygoliveconfig.charles IS 'Charles county go-live date';
COMMENT ON COLUMN countygoliveconfig.washington IS 'Washington county go-live date';
COMMENT ON COLUMN countygoliveconfig.stmarys IS 'St. Mary''s county go-live date';
COMMENT ON COLUMN countygoliveconfig.annearundel IS 'Anne Arundel county go-live date';
COMMENT ON COLUMN countygoliveconfig.frederick IS 'Frederick county go-live date';
COMMENT ON COLUMN countygoliveconfig.garrett IS 'Garrett county go-live date';
COMMENT ON COLUMN countygoliveconfig.carroll IS 'Carroll county go-live date';
COMMENT ON COLUMN countygoliveconfig.allegany IS 'Allegany county go-live date';
COMMENT ON COLUMN countygoliveconfig.princegeorge IS 'Prince George''s county go-live date';
COMMENT ON COLUMN countygoliveconfig.montgomery IS 'Montgomery county go-live date';
COMMENT ON COLUMN countygoliveconfig.calvert IS 'Calvert county go-live date';
COMMENT ON COLUMN countygoliveconfig.baltimorecity IS 'Baltimore City go-live date';
COMMENT ON COLUMN countygoliveconfig.baltimorecounty IS 'Baltimore County go-live date';
COMMENT ON COLUMN countygoliveconfig.caroline IS 'Caroline county go-live date';
COMMENT ON COLUMN countygoliveconfig.dorchester IS 'Dorchester county go-live date';
COMMENT ON COLUMN countygoliveconfig.kent IS 'Kent county go-live date';
COMMENT ON COLUMN countygoliveconfig.queenannes IS 'Queen Anne''s county go-live date';
COMMENT ON COLUMN countygoliveconfig.somerset IS 'Somerset county go-live date';
COMMENT ON COLUMN countygoliveconfig.wicomico IS 'Wicomico county go-live date';
COMMENT ON COLUMN countygoliveconfig.worcester IS 'Worcester county go-live date';
COMMENT ON COLUMN countygoliveconfig.cecil IS 'Cecil county go-live date';
COMMENT ON COLUMN countygoliveconfig.talbot IS 'Talbot county go-live date';
COMMENT ON COLUMN countygoliveconfig.harford IS 'Harford county go-live date';
COMMENT ON COLUMN countygoliveconfig.howard IS 'Howard county go-live date';
COMMENT ON COLUMN countygoliveconfig.dhris IS 'DHRIS go-live date';
COMMENT ON COLUMN countygoliveconfig.insertedon IS 'Timestamp of insertion';
COMMENT ON COLUMN countygoliveconfig.insertedby IS 'User who inserted the record';
COMMENT ON COLUMN countygoliveconfig.updatedon IS 'Timestamp of last update';
COMMENT ON COLUMN countygoliveconfig.updatedby IS 'User who last updated the record';
COMMENT ON COLUMN countygoliveconfig.activeflag IS 'Active flag (1 for active, 0 for inactive)';