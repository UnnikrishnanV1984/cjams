
DROP TABLE if exists cjams.healthcaredecisionmakerinformation;


CREATE TABLE if not exists cjams.healthcaredecisionmakerinformation(
healthcaredecisionmakerinformationid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
objecttype varchar(50)  NULL ,
objectid varchar(50)  NULL ,
personid varchar(50)  NULL ,
healthcaredecisionmaker varchar(250)  NULL ,
otherhcdm varchar(250)  NULL ,
name varchar(250)  NULL ,
authorizedhcdm varchar(250)  NULL ,
email varchar(250)  NULL ,
phonenumber varchar(250)  NULL ,
addressline1 varchar(250)  NULL ,
addressline2 varchar(250)  NULL ,
city varchar(250)  NULL ,
state varchar(250)  NULL ,
zip varchar(250)  NULL ,
hcdmflag varchar(250) null,
activeflag int4 NOT NULL DEFAULT 1,
updatedby varchar(50) NULL,
updatedon timestamp NOT NULL DEFAULT now(),
insertedby varchar(50) NULL,
insertedon timestamp NOT NULL DEFAULT now()
);

alter table cjams.healthcaredecisionmakerinformation  add COLUMN IF NOT exists  courtorderid varchar(50)  NULL;

COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.healthcaredecisionmakerinformationid IS 'Unique primary key identifier for healthcare decision-maker record';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.objecttype IS 'Classification type of associated object';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.objectid IS 'Identifier for the associated object';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.personid IS 'Unique identifier for the person linked to the decision-maker';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.healthcaredecisionmaker IS 'Role or title of the healthcare decision-maker';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.name IS 'Full name of the healthcare decision-maker';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.authorizedhcdm IS 'Details of the authorized healthcare decision-maker';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.email IS 'Contact email of the healthcare decision-maker';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.phonenumber IS 'Phone number for contacting the decision-maker';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.addressline1 IS 'Primary address line of the healthcare decision-maker';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.addressline2 IS 'Secondary address line, if applicable';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.city IS 'City of residence';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.state IS 'State of residence';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.zip IS 'Postal ZIP code';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.activeflag is 'Status of the record';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.updatedby is 'user who last updated the record';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.updatedon is 'Record updated date and time';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.insertedby is 'User who created this record';
COMMENT ON COLUMN cjams.healthcaredecisionmakerinformation.insertedon IS 'Record created date and time';


ALTER TABLE cjams.personmedicpshychotropic ADD COLUMN if not exists diagnosisfromsecond character varying (255);
ALTER TABLE cjams.personmedicpshychotropic ADD COLUMN  if not exists diagnosisotherfromsecond character varying (255);
ALTER TABLE cjams.personmedicpshychotropic ADD COLUMN if not exists psychosocialinterventions character varying (255);
ALTER TABLE cjams.personmedicpshychotropic ADD COLUMN if not exists additionalpsychosocialinterventions character varying (255);
ALTER TABLE cjams.personmedicpshychotropic ADD COLUMN if not exists otheradditionalpsychosocialinterventions character varying (255);
ALTER TABLE cjams.personmedicpshychotropic ADD COLUMN if not exists prescribercontactinfo character varying (255);
ALTER TABLE cjams.personmedicpshychotropic ADD COLUMN if not exists prescriberemail character varying (255);
ALTER TABLE cjams.personmedicpshychotropic ADD COLUMN if not exists prescriberdegree character varying (255);
ALTER TABLE cjams.personmedicpshychotropic ADD COLUMN if not exists otherprescriberdegree character varying (255);
ALTER TABLE cjams.personmedicpshychotropic ADD COLUMN if not exists prescriberspecialty character varying (255);
ALTER TABLE cjams.personmedicpshychotropic ADD COLUMN if not exists otherprescriberspecialty character varying (255);
ALTER TABLE cjams.personmedicpshychotropic ADD COLUMN if not exists settingmedicationprescribed character varying (255); 
ALTER TABLE cjams.personmedicpshychotropic 
ADD COLUMN IF NOT EXISTS secondaryreviewcompleted BOOLEAN;

ALTER TABLE cjams.personmedicpshychotropic 
ADD COLUMN IF NOT EXISTS pshychotropicid character varying (255);

COMMENT ON COLUMN cjams.personmedicpshychotropic.pshychotropicid IS 'to save pshychotropicid';
COMMENT ON COLUMN cjams.personmedicpshychotropic.settingmedicationprescribed IS 'to save secondary review completed';
COMMENT ON COLUMN cjams.personmedicpshychotropic.diagnosisfromsecond IS 'Secondary diagnosis of the person.';
COMMENT ON COLUMN cjams.personmedicpshychotropic.diagnosisotherfromsecond IS 'Other secondary diagnosis details.';
COMMENT ON COLUMN cjams.personmedicpshychotropic.psychosocialinterventions IS 'Psychosocial interventions applied.';
COMMENT ON COLUMN cjams.personmedicpshychotropic.additionalpsychosocialinterventions IS 'Additional psychosocial interventions provided.';
COMMENT ON COLUMN cjams.personmedicpshychotropic.otheradditionalpsychosocialinterventions IS 'Other additional psychosocial interventions details.';
COMMENT ON COLUMN cjams.personmedicpshychotropic.prescribercontactinfo IS 'Contact information of the prescriber.';
COMMENT ON COLUMN cjams.personmedicpshychotropic.prescriberemail IS 'Email address of the prescriber.';
COMMENT ON COLUMN cjams.personmedicpshychotropic.prescriberdegree IS 'Degree qualifications of the prescriber.';
COMMENT ON COLUMN cjams.personmedicpshychotropic.otherprescriberdegree IS 'Other degree qualifications of the prescriber.';
COMMENT ON COLUMN cjams.personmedicpshychotropic.prescriberspecialty IS 'Specialty of the prescriber.';
COMMENT ON COLUMN cjams.personmedicpshychotropic.otherprescriberspecialty IS 'Other specialty of the prescriber.';
COMMENT ON COLUMN cjams.personmedicpshychotropic.settingmedicationprescribed IS 'Setting where the medication was prescribed.';

ALTER TABLE cjams.personmedicpshychotropic_history ADD COLUMN if not exists diagnosisfromsecond character varying (255);
ALTER TABLE cjams.personmedicpshychotropic_history ADD COLUMN if not exists diagnosisotherfromsecond character varying (255);
ALTER TABLE cjams.personmedicpshychotropic_history ADD COLUMN if not exists psychosocialinterventions character varying (255);
ALTER TABLE cjams.personmedicpshychotropic_history ADD COLUMN if not exists additionalpsychosocialinterventions character varying (255);
ALTER TABLE cjams.personmedicpshychotropic_history ADD COLUMN if not exists otheradditionalpsychosocialinterventions character varying (255);
ALTER TABLE cjams.personmedicpshychotropic_history ADD COLUMN if not exists prescribercontactinfo character varying (255);
ALTER TABLE cjams.personmedicpshychotropic_history ADD COLUMN if not exists prescriberemail character varying (255);
ALTER TABLE cjams.personmedicpshychotropic_history ADD COLUMN if not exists prescriberdegree character varying (255);
ALTER TABLE cjams.personmedicpshychotropic_history ADD COLUMN if not exists otherprescriberdegree character varying (255);
ALTER TABLE cjams.personmedicpshychotropic_history ADD COLUMN if not exists prescriberspecialty character varying (255);
ALTER TABLE cjams.personmedicpshychotropic_history ADD COLUMN if not exists otherprescriberspecialty character varying (255);
ALTER TABLE cjams.personmedicpshychotropic_history ADD COLUMN if not exists settingmedicationprescribed character varying (255);
ALTER TABLE cjams.personmedicpshychotropic_history 
ADD COLUMN IF NOT EXISTS secondaryreviewcompleted BOOLEAN;
ALTER TABLE cjams.personmedicpshychotropic_history 
ADD COLUMN IF NOT EXISTS pshychotropicid character varying (255);

COMMENT ON COLUMN cjams.personmedicpshychotropic_history.pshychotropicid IS 'to save pshychotropicid';

COMMENT ON COLUMN cjams.personmedicpshychotropic_history.settingmedicationprescribed IS 'to save secondary review completed';

COMMENT ON COLUMN cjams.personmedicpshychotropic_history.diagnosisfromsecond IS 'Secondary diagnosis of the person.';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.diagnosisotherfromsecond IS 'Other secondary diagnosis details.';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.psychosocialinterventions IS 'Psychosocial interventions applied.';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.additionalpsychosocialinterventions IS 'Additional psychosocial interventions provided.';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.otheradditionalpsychosocialinterventions IS 'Other additional psychosocial interventions details.';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.prescribercontactinfo IS 'Contact information of the prescriber.';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.prescriberemail IS 'Email address of the prescriber.';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.prescriberdegree IS 'Degree qualifications of the prescriber.';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.otherprescriberdegree IS 'Other degree qualifications of the prescriber.';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.prescriberspecialty IS 'Specialty of the prescriber.';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.otherprescriberspecialty IS 'Other specialty of the prescriber.';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.settingmedicationprescribed IS 'Setting where the medication was prescribed.';



DROP table if EXISTS cjams.healthcaredecisionmakerinformation_history;

CREATE TABLE cjams.healthcaredecisionmakerinformation_history(
	healthcaredecisionmakerinformationauditlogid uuid NOT null DEFAULT gen_random_uuid(),
	currentdata json,
    previousdata json,
    modifieddata json,
    rowtype character varying(20),
	healthcaredecisionmakerinformationid uuid NOT NULL,
objecttype varchar(50)  NULL ,
objectid varchar(50)  NULL ,
personid varchar(50)  NULL ,
healthcaredecisionmaker varchar(250)  NULL ,
otherhcdm varchar(250)  NULL ,
name varchar(250)  NULL ,
authorizedhcdm varchar(250)  NULL ,
email varchar(250)  NULL ,
phonenumber varchar(250)  NULL ,
addressline1 varchar(250)  NULL ,
addressline2 varchar(250)  NULL ,
city varchar(250)  NULL ,
state varchar(250)  NULL ,
zip varchar(250)  NULL ,
hcdmflag varchar(250) null,
activeflag int4 NOT NULL ,
updatedby varchar(50) NULL,
updatedon timestamp NOT NULL ,
insertedby varchar(50) NULL,
insertedon timestamp NOT NULL ,
courtorderid varchar(50)
);