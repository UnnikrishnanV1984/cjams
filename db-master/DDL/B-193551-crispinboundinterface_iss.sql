ALTER TABLE IF EXISTS cjams.crispinboundinterface_iss DROP CONSTRAINT IF EXISTS pk_crispinboundinterface_iss;
DROP TABLE IF EXISTS cjams.crispinboundinterface_iss;

CREATE TABLE cjams.crispinboundinterface_iss (
	crispinboundinterfaceissid uuid NOT NULL DEFAULT gen_random_uuid(),
	crispinboundinterfaceid uuid NULL, 
	addedondate timestamp  NULL,
	studentno int8  NULL,
	clientid int8 NULL,
	matchtype varchar(200) NULL,
	firstname varchar(50)  NULL,
	middlename varchar(50) NULL,
	lastname varchar(50)  NULL,
	birthdate timestamp  NULL,
	gender varchar(10),
	race varchar(50) NULL,
	ethnicity varchar(50) NULL,
	streetaddress varchar(100) NULL,
	otheraddrln varchar(100)  NULL,
	addresstypecode varchar(50)  NULL,
	cityname varchar(50)  NULL,
	statecode varchar(50)  NULL,
	zipcode int8 NULL,
	countycode1 varchar(20)  NULL,
	emailaddr varchar(200)  NULL,
	phonenumber varchar(100),
	mothersfirstname varchar(50)  NULL,
	mothersmaidenlast varchar(50)  NULL,
	immunizationid varchar(250)  NULL,
	vaccinationdt timestamp NULL,
	vaccinetype varchar(200)  NULL,
	sendingorg varchar(100)  NULL,
	vfcpin varchar(250)  NULL,
	enteredbyorgid varchar(100) NULL,
	lastupdateddt timestamp  NULL,
	lastupdateddt1 timestamp  NULL,
	bodysitecode varchar(10)  NULL,
	administrationroutecd varchar(10)  NULL,
	vaccinelotid varchar(50)  NULL,
	cptcode varchar(50)  NULL,
	cvxcode varchar(50)  NULL,
	vaccinename varchar(200)  NULL,
	manufacturercd varchar(50)  NULL,
	manufacturername varchar(200)  NULL,
	populationgrpcode varchar(50)  NULL,
	administeringorg varchar(50)  NULL,
	administeringorgname varchar(250) NULL,	
	activeflag int4 NOT NULL DEFAULT 1, 
   	insertedby varchar(50) NOT NULL DEFAULT 'CRISP_INBOUND_INTERFACE', 
   	insertedon timestamp NOT NULL DEFAULT now(), 
   	updatedby varchar(50) NOT NULL DEFAULT 'CRISP_INBOUND_INTERFACE', 
   	updatedon timestamp NULL DEFAULT now(),
	batchlogid int8 NULL,
	status text NULL,
	comments text NULL,
	CONSTRAINT pk_crispinboundinterface_iss PRIMARY KEY (crispinboundinterfaceissid)	
);


---Column comments

COMMENT ON COLUMN cjams.crispinboundinterface_iss.crispinboundinterfaceissid IS 'crispinboundinterface_iss snapshot details stored in this snapshot table(primary key)';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.crispinboundinterfaceid IS 'crispinboundinterface table';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.addedondate IS 'Date the immunization record was first created';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.studentno IS 'student number';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.clientid IS 'client id of the person';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.matchtype IS 'match type to the crisp system';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.firstname IS 'first name of the person';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.middlename IS 'middle name of the person';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.lastname IS 'last name of the person';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.birthdate IS 'birthdate of the person';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.gender IS 'gender of the person';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.race IS 'race of the person';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.ethnicity IS 'ethinicity of the person';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.streetaddress IS 'street address';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.otheraddrln IS 'additional address';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.addresstypecode IS 'address type code';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.cityname IS 'city name';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.statecode IS 'state code';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.zipcode IS 'zip code';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.countycode1 IS 'county code';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.emailaddr IS 'email address of the person';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.phonenumber IS 'phone number of the person';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.mothersfirstname IS 'persons mother first name';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.mothersmaidenlast IS 'persons mother maiden or last name';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.immunizationid IS 'immunization id';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.vaccinationdt IS 'date of vaccination';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.vaccinetype IS 'vaccine type';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.sendingorg IS 'organization sending this record';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.vfcpin IS 'vfc pin for this record';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.enteredbyorgid IS 'organization that enetered this record';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.lastupdateddt IS 'last update timestamp for this record';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.lastupdateddt1 IS 'new timestamp for any updates to existing records';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.bodysitecode IS 'body site code';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.administrationroutecd IS 'administration route code';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.vaccinelotid IS 'vaccine lot id';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.cptcode IS 'cpt code for this record';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.cvxcode IS 'cvx code for this record';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.vaccinename IS 'vaccination name';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.manufacturername IS 'manufacturer name';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.manufacturercd IS 'manufacturer code';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.populationgrpcode IS 'population group code for this record';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.administeringorg IS 'adminstering organization';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.administeringorgname IS 'administering organization name';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.activeflag IS 'status of the record';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.insertedby IS 'user who created this record';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.insertedon IS 'record created date and time';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.updatedby IS 'user who last updated this record';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.updatedon IS 'record updated date and time';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.batchlogid IS 'CJAMS-CRISP Inbound Batch Log ID';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.status IS 'success status of this record';
COMMENT ON COLUMN cjams.crispinboundinterface_iss.comments IS 'comments on this record';


