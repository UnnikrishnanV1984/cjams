

drop table if exists personmedicalconditioninfo;


DROP TABLE if exists cjams.personmedicalcondition;

CREATE table if not exists cjams.personmedicalcondition (
	personmedicalconditionid uuid NOT NULL DEFAULT gen_random_uuid(), -- Person Medical condition stored in this table(Primary key)
	personid uuid NOT NULL, -- Person id (foreign key)
	begindate timestamp NULL, -- Medical  start date
	enddate timestamp NULL, -- Medical enddate
	recordedby varchar(300) NULL, -- Medical record by
	medicalconditiontypekey varchar(100) NULL, --  Medical Condition type Foregin Key
	activeflag int4 NOT NULL DEFAULT 1, -- Status of the record
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp NULL DEFAULT now(), -- Record updated date and time
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp NULL DEFAULT now(), -- Record created date and time
	effectivedate timestamp NOT NULL DEFAULT now(), -- Record valid from
	expirationdate timestamp NULL, -- Record inactive date
	medicalconditionother varchar NULL, -- Medical condition type  other 
	medicalprofilekey float8 NULL,
	medicalconditionkey float8 NULL,
	wrkrtemplatecode varchar(20) NULL,
	medicalconditiontext varchar(254) NULL,
	medicalconditionstatindc varchar(6) NULL,
	uploadpath json NULL,
	ismedfragile bool NULL,
	severitysymptomkey varchar(50) NULL,
	ischronic bool NULL,
	allergies_adverse_reactions varchar NULL,
	medication_client_allergies varchar NULL,
	medicalcondition varchar NULL,
	notes varchar NULL,
	CONSTRAINT pk_personmedicalcondition PRIMARY KEY (personmedicalconditionid),
	CONSTRAINT fk_personmedicalcondition_personid FOREIGN KEY (personid) REFERENCES person(personid)
);

CREATE TABLE cjams.personmedicalconditioninfo (
	personmedicalconditioninfoid uuid NOT NULL DEFAULT gen_random_uuid(), -- Unique identifier for the table
	personmedicalconditionid uuid NULL, -- foreign key
	medicalconditiontypekey varchar(50) NOT NULL, -- foreign key
	activeflag int4 NOT NULL DEFAULT 1, -- Status of the record
	insertedby varchar(50) NULL, -- User who created this record
	updatedby varchar(50) NULL, -- user who last updated the record
	insertedon timestamp NULL, -- Record created date and time
	updatedon timestamp NULL, -- Record updated date and time
	effectivedate timestamp NOT NULL DEFAULT now(), -- Date from which the record has to be effective
	expirationdate timestamp NULL, -- Record inactive date
	old_id varchar(50) NULL, -- Used for migration purpose
	uploadpath json NULL,
	CONSTRAINT pk_personmedicalconditioninfo PRIMARY KEY (personmedicalconditioninfoid),
	CONSTRAINT fk_personmedicalconditioninfo_personmedicalconditionid FOREIGN KEY (personmedicalconditionid) REFERENCES personmedicalcondition(personmedicalconditionid)
);



DROP TABLE if exists cjams.personexamination;

CREATE TABLE if not exists cjams.personexamination (
	personexaminationid uuid NOT NULL DEFAULT gen_random_uuid(),
	fk_id varchar(50) NULL,
	appointkeptflag int4 NULL,
	appoinmentdate timestamp NULL,
	nextappointmentdate timestamp NULL,
	examinationtypekey varchar(50) NULL,
	"comments" varchar(500) NULL,
	specialityexamtypekey varchar(50) NULL,
	labtesttypekey varchar(50) NULL,
	hivconsentflag int4 NULL,
	recommendations varchar(500) NULL,
	providerid uuid NULL,
	insertedon timestamp NULL,
	insertedby varchar(50) NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	motherflag int4 NULL,
	fatherflag int4 NULL,
	otherflag int4 NULL,
	othernotes varchar(2000) NULL,
	infocomments varchar(500) NULL,
	exprovidedtypekey varchar(50) NULL,
	providedbyclientid uuid NULL,
	collateralid uuid NULL,
	infoclienttypekey varchar(50) NULL,
	physicianname varchar(100) NULL,
	physicianspeciality varchar(100) NULL,
	affiliateorg varchar(100) NULL,
	addresstypekey varchar(50) NULL,
	formattypekey varchar(50) NULL,
	streetnumber int4 NULL,
	boxnumber int4 NULL,
	predirtypekey varchar(50) NULL,
	streetname varchar(100) NULL,
	streetsuffixtypekey varchar(50) NULL,
	postdirtypekey varchar(50) NULL,
	unittypekey varchar(50) NULL,
	unitnumbertx varchar(500) NULL,
	cityname varchar(100) NULL,
	countytypekey varchar(50) NULL,
	statetypekey varchar(50) NULL,
	zip5no int4 NULL,
	zip4no int4 NULL,
	direction varchar(500) NULL,
	foreignaddress varchar(500) NULL,
	workphone varchar(10) NULL,
	workextn varchar(10) NULL,
	homephone varchar(100) NULL,
	pager varchar(10) NULL,
	email varchar(100) NULL,
	fax varchar(100) NULL,
	mobile varchar(100) NULL,
	url varchar(100) NULL,
	othercontacts varchar(100) NULL,
	foreignstate varchar(20) NULL,
	country varchar(100) NULL,
	postalcode varchar(100) NULL,
	streetnotes varchar(2000) NULL,
	providedbynotes varchar(2000) NULL,
	providedbyrelationtypekey varchar(50) NULL,
	expungementflag int4 NULL,
	datavalidflag int4 NULL,
	clientmergeid uuid NULL,
	old_id varchar(50) NULL,
	personid uuid NULL,
	uploadpath varchar(1000) NULL,
	address2 varchar(100) NULL,
	address1 varchar(100) NULL,
	medicalreferrals varchar(50) NULL,
	followupneeded varchar(50) NULL,
	uploadedfiles jsonb NULL,
	nextappointmentreason text NULL,
	notkeptreason text NULL,
	providerinfoflag int4 NULL,
	parentexaminationid uuid NULL
);

DROP TABLE if exists cjams.personbehavioralhealth;

CREATE TABLE if not exists cjams.personbehavioralhealth (
	personbehavioralhealthid uuid NOT NULL DEFAULT gen_random_uuid(), -- Person Behavioralhealth in this table(Primary key)
	personid uuid NOT NULL, -- personid id (foreign key)
	clinicianname varchar(50) NULL, -- Behavioralhealth Clinic Name
	currentdiagnoses varchar(100) NULL, -- Behavioralhealth currentdiagnoses
	phone varchar(25) NULL, -- Behavioralhealth phone
	address1 varchar(100) NULL, -- Behavioralhealth address1
	address2 varchar(100) NULL, -- Behavioralhealth address2
	reportname varchar(50) NULL, -- Behavioralhealth reportname
	city varchar(50) NULL, -- Behavioralhealth city (Foreign Key)
	state varchar(50) NULL, -- Behavioralhealth state
	countyid uuid NULL, -- Behavioralhealth countyid
	zip varchar(50) NULL, -- Behavioralhealth zip
	activeflag int4 NOT NULL DEFAULT 1, -- Status of the record
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp NULL DEFAULT now(), -- Record updated date and time
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp NULL DEFAULT now(), -- Record created date and time
	effectivedate timestamp NOT NULL DEFAULT now(), -- Record valid from
	expirationdate timestamp NULL, -- Record inactive date
	reportpath text NULL, -- Behavioralhealth reportpath
	isbehavioralhealth bool NULL, -- Behavioralhealth isbehavioralhealth
	personservicetypekey varchar NULL, -- Behavioralhealth personservicetypekey
	county varchar(50) NULL,
	uploadpath varchar(1000) NULL,
	email varchar(100) NULL,
	nodiagnosisreason text NULL,
	evaluationby varchar(50) NULL,
	dateofevaluation timestamp NULL,
	parentbehaviouralhealthid uuid NULL,
	CONSTRAINT pk_personbehavioralhealth PRIMARY KEY (personbehavioralhealthid),
	CONSTRAINT fk_personbehavioralhealth_countyid FOREIGN KEY (countyid) REFERENCES county(countyid),
	CONSTRAINT fk_personbehavioralhealth_personid FOREIGN KEY (personid) REFERENCES person(personid)
);

DROP TABLE if exists cjams.clientunder5yearsinfo;

CREATE TABLE if not exists cjams.clientunder5yearsinfo (
	clientunder5yearsinfoid uuid NOT NULL DEFAULT gen_random_uuid(),
	personid uuid NULL,
	providedbyclientid int4 NULL,
	providedbycollateralid int4 NULL,
	infoclienttypekey varchar(50) NULL,
	prenatalcaretypekey varchar(50) NULL,
	deliverytypekey varchar(50) NULL,
	deliverytypetx varchar(500) NULL,
	deliverycomplicationnotes varchar(500) NULL,
	u5notes varchar(500) NULL,
	providerid uuid NULL,
	insertedon timestamp NULL,
	insertedby varchar(50) NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	hospitalname varchar(50) NULL,
	addresstypekey varchar(100) NULL,
	formattypekey varchar(100) NULL,
	streetnumber int4 NULL,
	boxnumber int4 NULL,
	predirtypekey varchar(50) NULL,
	streetname varchar(100) NULL,
	streetsuffixtypekey varchar(50) NULL,
	postdirtypekey varchar(50) NULL,
	unittypekey varchar(50) NULL,
	unitnumbertx varchar(100) NULL,
	cityname varchar(100) NULL,
	countytypekey varchar(50) NULL,
	statetypekey varchar(50) NULL,
	zip5no numeric(5) NULL,
	zip4no numeric(4) NULL,
	directionnotes varchar(500) NULL,
	foreignnotes varchar(500) NULL,
	workphone varchar(10) NULL,
	workphoneextn varchar(10) NULL,
	homephone varchar(50) NULL,
	pager varchar(200) NULL,
	email varchar(100) NULL,
	fax varchar(50) NULL,
	mobile varchar(50) NULL,
	url varchar(100) NULL,
	othercontacts varchar(50) NULL,
	foreignstatetx varchar(50) NULL,
	country varchar(50) NULL,
	postalcode varchar(50) NULL,
	street varchar(50) NULL,
	providedby varchar(300) NULL,
	providerbyrelationtypekey varchar(50) NULL,
	expungementflag int4 NULL,
	datavalidflag int4 NULL,
	clientmergeid uuid NULL,
	old_id varchar(50) NULL,
	uploadpath varchar(1000) NULL,
	whenbegun varchar(50) NULL,
	gestation json NULL,
	"comments" text NULL,
	address1 varchar(50) NULL,
	address2 varchar(50) NULL,
	phone varchar(50) NULL,
	complicationsspecify varchar(50) NULL,
	county varchar(50) NULL
);

DROP TABLE if exists cjams.personsexualinfo;

CREATE TABLE if not exists cjams.personsexualinfo (
	personsexualinfoid uuid NOT NULL,
	personid uuid NOT NULL,
	infoprovidedbypersonid uuid NULL,
	infoprovidedbycollateralid uuid NULL,
	infoclientkey varchar(50) NULL,
	sexualactiveflag varchar(10) NULL DEFAULT 1,
	sexualorientationkey varchar(50) NULL,
	pregnancyno int4 NULL,
	childrenno int4 NULL,
	birthcontrol varchar(100) NULL,
	sicomments varchar(500) NULL,
	insertedon timestamp NULL,
	insertedby varchar(50) NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	sextransdis varchar(100) NULL,
	infoprovidedby varchar(100) NULL,
	infoprovidedbyrelationkey varchar(50) NULL,
	expungementflag int4 NULL,
	datavalidflag int4 NULL,
	clientmergeid uuid NULL,
	fk_id varchar(50) NULL,
	old_id varchar(50) NULL,
	uploadpath varchar(1000) NULL,
	ispregnant bool NULL,
	std_treatment_startdate date NULL,
	std_treatment_enddate date NULL,
	stdspecify varchar NULL,
	bcspecify varchar NULL
);


DROP TABLE if exists cjams.personsexualinfo;

CREATE TABLE if not exists cjams.personsexualinfo (
	personsexualinfoid uuid NOT NULL,
	personid uuid NOT NULL,
	infoprovidedbypersonid uuid NULL,
	infoprovidedbycollateralid uuid NULL,
	infoclientkey varchar(50) NULL,
	sexualactiveflag varchar(10) NULL DEFAULT 1,
	sexualorientationkey varchar(50) NULL,
	pregnancyno int4 NULL,
	childrenno int4 NULL,
	birthcontrol varchar(100) NULL,
	sicomments varchar(500) NULL,
	insertedon timestamp NULL,
	insertedby varchar(50) NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	sextransdis varchar(100) NULL,
	infoprovidedby varchar(100) NULL,
	infoprovidedbyrelationkey varchar(50) NULL,
	expungementflag int4 NULL,
	datavalidflag int4 NULL,
	clientmergeid uuid NULL,
	fk_id varchar(50) NULL,
	old_id varchar(50) NULL,
	uploadpath varchar(1000) NULL,
	ispregnant bool NULL,
	std_treatment_startdate date NULL,
	std_treatment_enddate date NULL,
	stdspecify varchar NULL,
	bcspecify varchar NULL
);


DROP TABLE if exists cjams.personhospitalization;

CREATE TABLE if not exists cjams.personhospitalization (
	hospitalizationid uuid NOT NULL DEFAULT gen_random_uuid(),
	typekey varchar(100) NULL,
	reasontypekey varchar(100) NULL,
	adrfaxtx varchar(20) NULL,
	startdt date NULL,
	enddt date NULL,
	diagnosistx varchar(500) NULL,
	commentstx varchar(500) NULL,
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	adrdirectiontx varchar(500) NULL,
	insertedby varchar(50) NULL,
	adrzip4no numeric(4) NULL,
	insertedon timestamp NULL,
	activeflag int4 NULL DEFAULT 1,
	adrzip5no numeric(5) NULL,
	adrstatetypekey varchar(50) NULL,
	personid uuid NULL,
	adrcitynm varchar(50) NULL,
	adrforeignstatetx varchar(50) NULL,
	providerid uuid NULL,
	adrunitnotx varchar(100) NULL,
	adrcountrytx varchar(50) NULL,
	adrunittypetypekey varchar(50) NULL,
	adrpostdirtypekey varchar(50) NULL,
	adrstreetsuffixtypekey varchar(50) NULL,
	adrstreetnm varchar(50) NULL,
	adrpredirtypekey varchar(50) NULL,
	adrpostalcodetx varchar(10) NULL,
	adrboxno int4 NULL,
	adrstreetno int4 NULL,
	adrcellphonetx varchar(10) NULL,
	adrformattypekey varchar(50) NULL,
	hospitalnm varchar(50) NULL,
	adrcountytypekey varchar(50) NULL,
	adrforeigntx varchar(500) NULL,
	adremailtx varchar(100) NULL,
	infocommentstx varchar(500) NULL,
	adrpagertx varchar(20) NULL,
	infomotherflag int4 NULL,
	infofatherflag int4 NULL,
	adrhomephonetx varchar(10) NULL,
	infootherflag int4 NULL,
	infoothertx varchar(50) NULL,
	adrworkxtntx varchar(10) NULL,
	adrworkphonetx varchar(10) NULL,
	adrurltx varchar(100) NULL,
	adrothercontacttx varchar(100) NULL,
	hoinfoprovidedtypekey varchar(50) NULL,
	infoprovidedbyclientid int4 NULL,
	infoprovidedbycollateralid int4 NULL,
	infoclienttypekey varchar(50) NULL,
	adrtypetypekey varchar(50) NULL,
	adrstreettx varchar(100) NULL,
	infoprovidedbytx varchar(300) NULL,
	infoprovidedbyrelationctypekey varchar(50) NULL,
	expungementflag int4 NULL,
	datavalidflag int4 NULL,
	clientmergeid uuid NULL,
	old_id varchar(50) NULL,
	uploadpath varchar(1000) NULL,
	hospital_address1 varchar(100) NULL,
	hospital_address2 varchar(100) NULL,
	hospital_phone varchar(50) NULL,
	hospital_city varchar(50) NULL,
	hospitalization_type varchar(50) NULL,
	hospitalization_reason varchar(50) NULL,
	hospital_state varchar(50) NULL,
	hospital_zipcode varchar(50) NULL
);

DROP TABLE if exists cjams.personimmunization;

CREATE TABLE if not exists cjams.personimmunization (
	personimmunizationid uuid NOT NULL DEFAULT gen_random_uuid(),
	personid uuid NOT NULL,
	immunizationtypekey varchar(50) NULL,
	immunizationdate timestamp NULL,
	nextduedate timestamp NULL,
	"comments" varchar(500) NULL,
	certifiedcopyflag int4 NULL,
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	insertedby varchar(50) NOT NULL,
	direction varchar(500) NULL,
	insertedon timestamp NULL,
	zip4no int4 NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	fk_id varchar(50) NULL,
	zip5no int4 NULL,
	statetypekey varchar(50) NULL,
	providerid uuid NULL,
	nonimmunreason varchar(500) NULL,
	foreignstate varchar(100) NULL,
	cityname varchar(100) NULL,
	notimmunizedflag int4 NULL,
	unitnumber varchar(10) NULL,
	country varchar(100) NULL,
	unittypekey varchar(50) NULL,
	postdirtypekey varchar(50) NULL,
	streetsuffixtypekey varchar(50) NULL,
	postalcode varchar(100) NULL,
	streetname varchar(100) NULL,
	predirtypekey varchar(50) NULL,
	boxnumber int4 NULL,
	mobile varchar(100) NULL,
	streetnumber int4 NULL,
	hospitalname varchar(100) NULL,
	fax varchar(20) NULL,
	countytypekey varchar(50) NULL,
	foreignaddress varchar(500) NULL,
	email varchar(200) NULL,
	pager varchar(10) NULL,
	infocomments varchar(500) NULL,
	motherflag int4 NULL,
	fatherflag int4 NULL,
	homephone varchar(200) NULL,
	otherflag int4 NULL,
	othernotes varchar(2000) NULL,
	workextn varchar(10) NULL,
	workphone varchar(10) NULL,
	formattypekey varchar(50) NULL,
	url varchar(200) NULL,
	othercontacts varchar(200) NULL,
	iminfoprovidedtypekey varchar(50) NULL,
	providedbyclientid int4 NULL,
	collateralid int4 NULL,
	infoclienttypekey varchar(50) NULL,
	addresstypekey varchar(50) NULL,
	streetnotes varchar(2000) NULL,
	providedbynotes varchar(2000) NULL,
	providedbyrelationtypekey varchar(50) NULL,
	expungementflag int4 NULL,
	datavalidflag int4 NULL,
	clientmergeid uuid NULL,
	old_id varchar(50) NULL,
	reportedby varchar(100) NULL, -- Immunization reported by name
	immunizationdocpath text NULL, -- Immunization uploaded document path
	immunizationdocname varchar(50) NULL, -- Immunization uploaded document name
	isimmunefileavail bool NULL, -- Is Immunization File Available
	uploadpath varchar(1000) NULL,
	dose varchar(50) NULL,
	personimmunizationconfigid uuid NULL
);

DROP TABLE if exists cjams.personfmlymdclhstry;

CREATE TABLE if not exists cjams.personfmlymdclhstry (
	personfmlymdclhstryid uuid NOT NULL DEFAULT gen_random_uuid(),
	fk_id varchar(50) NULL,
	relativeid uuid NULL,
	deathcausetypekey varchar(50) NULL,
	insertedon timestamp NULL,
	insertedby varchar(50) NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	motherflag int4 NULL,
	fatherflag int4 NULL,
	otherflag int4 NULL,
	othernotes varchar(2000) NULL,
	"comments" varchar(500) NULL,
	fmprovidedtypekey varchar(50) NULL,
	providedbyclientid uuid NULL,
	collateralid uuid NULL,
	infoclienttypekey varchar(50) NULL,
	relationshiptypekey varchar(50) NULL,
	famhistclientid uuid NULL,
	famhistreltypekey varchar(50) NULL,
	providedbynotes varchar(2000) NULL,
	providedbyrelationtypekey varchar(50) NULL,
	famhistclientnotes varchar(2000) NULL,
	famhistrelationtypekey varchar(50) NULL,
	expungementflag int4 NULL,
	datavalidflag int4 NULL,
	clientmergeid uuid NULL,
	old_id varchar(50) NULL,
	personid uuid NULL,
	uploadpath json NULL,
	majorhistoryproblem varchar NULL,
	famhistclient varchar NULL,
	famhistrelationtype varchar NULL,
	deathcausetype varchar NULL
);

DROP TABLE if exists cjams.personphycisianinfo;

CREATE TABLE if not exists cjams.personphycisianinfo (
	personphycisianinfoid uuid NOT NULL DEFAULT gen_random_uuid(), -- Person Provider information details stored in this table(Primary key)
	personid uuid NOT NULL, -- Person id (foreign key)
	isprimaryphycisian bool NULL, -- Provider information isprimaryphycisian 
	"name" varchar(50) NULL, -- Provider information name
	facility varchar(100) NULL, -- Provider information facility
	phone varchar(25) NULL, --  Provider information phone 
	email varchar(50) NULL, -- Provider information email 
	address1 varchar(100) NULL, -- Provider information address1
	address2 varchar(100) NULL, -- Provider information address2
	city varchar(50) NULL, --  Provider information  city 
	state varchar(10) NULL, -- Provider information state 
	countyid uuid NULL, -- Provider information Foregin Key 
	zip varchar(50) NULL, -- Provider information zip
	startdate timestamp NULL, -- Provider information startdate
	enddate timestamp NULL, -- Provider information enddate
	activeflag int4 NOT NULL DEFAULT 1, -- Status of the record
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp NULL DEFAULT now(), -- Record updated date and time
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp NULL DEFAULT now(), -- Record created date and time
	effectivedate timestamp NOT NULL DEFAULT now(), -- Record valid from
	expirationdate timestamp NULL, -- Record inactive date
	physicianspecialtytypekey varchar NULL, -- Provider information physicianspecialtytypekey
	medicalprofilekey float8 NULL,
	completeworkeridno float8 NULL,
	mcotext varchar(45) NULL,
	physicianfaxtext varchar(10) NULL,
	psychrasesindc varchar(1) NULL,
	psychrasesloctntext varchar(60) NULL,
	psychrasesdate timestamp NULL,
	psychrasesdiagkey float8 NULL,
	psychrhospindc varchar(1) NULL,
	psychrhosploctntext varchar(60) NULL,
	psychrhospdate timestamp NULL,
	psychrhospdiagkey float8 NULL,
	psychlasesindc varchar(1) NULL,
	psychlasesloctntext varchar(60) NULL,
	psychlasesdate timestamp NULL,
	psychlasesdiagkey float8 NULL,
	counselingindc varchar(1) NULL,
	counselingloctntext varchar(60) NULL,
	counselingdate timestamp NULL,
	psychotropicdrugindc varchar(1) NULL,
	addictionindc varchar(1) NULL,
	addictionloctntext varchar(60) NULL,
	addictiondate timestamp NULL,
	addictionresultkey float8 NULL,
	placementsummarykey float8 NULL,
	completedate timestamp NULL,
	completeindc varchar(1) NULL,
	marylandmamcocode varchar(15) NULL,
	otherinsuranceindc varchar(1) NULL,
	othinseffectivedate timestamp NULL,
	othinsexpiredate timestamp NULL,
	othinscompanytext varchar(254) NULL,
	othinsmcotext varchar(45) NULL,
	othinspolicynumbtext varchar(45) NULL,
	othinspolicyholdertext varchar(254) NULL,
	othphysicianname_text varchar(254) NULL,
	othphysicianpracttext varchar(254) NULL,
	othphysicianphonetext varchar(10) NULL,
	othphysicianfaxtext varchar(10) NULL,
	isphysician bool NULL,
	isdentist bool NULL,
	dental_speciality varchar NULL,
	physician_speciality varchar NULL,
	physician_child_lang_check bool NULL,
	translation_service_available bool NULL,
	dentist_child_lang_check bool NULL,
	uploadpath json NULL,
	CONSTRAINT pk_personphycisianinfo PRIMARY KEY (personphycisianinfoid),
	CONSTRAINT fk_personphycisianinfo_countyid FOREIGN KEY (countyid) REFERENCES county(countyid),
	CONSTRAINT fk_personphycisianinfo_personid FOREIGN KEY (personid) REFERENCES person(personid),
	CONSTRAINT fk_personphycisianinfo_physicianspecialtytypekey FOREIGN KEY (physicianspecialtytypekey) REFERENCES physicianspecialtytype(physicianspecialtytypekey)
);


DROP TABLE if exists cjams.personhealthinsurance;

CREATE table if not exists cjams.personhealthinsurance (
	personhealthinsuranceid uuid NOT NULL DEFAULT gen_random_uuid(), -- Person Health Insurance details stored in this table(Primary key)
	personid uuid NOT NULL, -- Person id (foreign key)
	ismedicaidmedicare bool NULL, -- Health Insurance ismedicaidmedicare 
	policyholdername varchar(50) NULL, -- Health Insurance policyholdername
	address1 varchar(100) NULL, -- Health Insurance address1
	address2 varchar(100) NULL, -- Health Insurance address2
	city varchar(50) NULL, --  Health Insurance  city 
	state varchar(10) NULL, -- Health Insurance state 
	countyid uuid NULL, -- Health Insurance Foregin Key 
	zip varchar(50) NULL, -- Health Insurance zip
	providerphone varchar(25) NULL, -- Health Insurance providerphone
	patientpolicyholderrelation varchar(50) NULL, -- Health Insurance patientpolicyholderrelation
	policyname varchar(50) NULL, -- Health Insurance policyname
	groupnumber varchar(50) NULL, -- Health Insurance groupnumber
	activeflag int4 NOT NULL DEFAULT 1, -- Status of the record
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp NULL DEFAULT now(), -- Record updated date and time
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp NULL DEFAULT now(), -- Record created date and time
	effectivedate timestamp NULL DEFAULT now(), -- Record valid from
	expirationdate timestamp NULL, -- Record inactive date
	providertypeother varchar NULL, -- Health Insurance providertypeother
	insurancetype varchar(50) NULL,
	providertype varchar(50) NULL,
	medicalinsuranceprovider varchar(50) NULL, -- Medical Insurance Provider Name
	medicarenumber varchar(50) NULL, -- Medicare Number
	isinsuranceavailable bool NULL,
	uploadpath varchar(1000) NULL,
	county varchar(50) NULL,
	policynumber varchar(50) NULL,
	CONSTRAINT pk_personhealthinsurance PRIMARY KEY (personhealthinsuranceid),
	CONSTRAINT fk_personhealthinsurance_countyid FOREIGN KEY (countyid) REFERENCES county(countyid),
	CONSTRAINT fk_personhealthinsurance_personid FOREIGN KEY (personid) REFERENCES person(personid)
);

DROP TABLE if exists cjams.personmedicalinfo;

CREATE TABLE if not exists cjams.personmedicalinfo (
	medicalinfoid uuid NOT NULL DEFAULT gen_random_uuid(),
	personid uuid NOT NULL,
	ispersonhealthy bool NULL,
	providerid uuid NULL,
	hospitalname varchar(250) NULL,
	physicalproblem varchar NULL,
	mentalproblem varchar NULL,
	allergydetails varchar NULL,
	hygienedetails varchar NULL,
	specialdietdetails varchar NULL,
	beforebirthdetail varchar NULL,
	deliverytype varchar NULL,
	birthdefects varchar NULL,
	bloodrelationship varchar NULL,
	sexualdisease varchar NULL,
	childrennumber varchar NULL,
	speechtypekey varchar NULL,
	speechcomments varchar NULL,
	diettypekey varchar NULL,
	eatertypekey varchar NULL,
	feedinginfo varchar NULL,
	sleepinginfo varchar NULL,
	bowelmovent varchar NULL,
	urination varchar NULL,
	"others" varchar NULL,
	eliminationcomments varchar NULL,
	specialconsiderations varchar NULL,
	sensitiveinfo varchar NULL,
	specialneeds varchar NULL,
	phobiainfo varchar NULL,
	physicaldisabilitykey varchar NULL,
	emotionaldisabilitykey varchar NULL,
	learningdisabilitykey varchar NULL,
	hearingdisabilitykey varchar NULL,
	visualdisabilitykey varchar NULL,
	otherdisabilitykey varchar NULL,
	mentallyretarded varchar NULL,
	disabilitycomment varchar NULL,
	childhooddisease varchar NULL,
	bithdisease varchar NULL,
	confidentialinfo varchar NULL,
	infoproviderkey varchar NULL,
	highriskinfo varchar NULL,
	medicationallergy varchar NULL,
	insertedon timestamp NOT NULL, -- Record created date and time
	insertedby varchar(50) NOT NULL, -- User who created this record
	updatedon varchar(50) NULL, -- Record updated date and time
	updatedby timestamp NULL, -- user who last updated the record
	activeflag int4 NOT NULL DEFAULT 1, -- Status of the record
	old_id varchar(50) NULL, -- Used for migration purpose
	clientid int4 NULL,
	badrformattypekey varchar(5) NULL,
	badrstreetno int4 NULL,
	badrboxno int4 NULL,
	badrpredirtypekey varchar(5) NULL,
	badrstreetname varchar(100) NULL,
	badrstreetsuffixtypekey varchar(5) NULL,
	badrpostdirtypekey varchar(5) NULL,
	badrunittypetypekey varchar(5) NULL,
	badrunitno varchar(10) NULL,
	badrcityname varchar(100) NULL,
	badrcountytypekey varchar(5) NULL,
	badrstatetypekey varchar(5) NULL,
	badrzip5no int4 NULL,
	badrzip4no int4 NULL,
	badrdirection varchar(500) NULL,
	badrforeign varchar(500) NULL,
	sexualactiveflag int4 NULL DEFAULT 1,
	sexualorientationtypekey varchar(5) NULL,
	pregnancyno int4 NULL,
	agesatup varchar(20) NULL,
	agewalk varchar(20) NULL,
	agetalk varchar(20) NULL,
	mobilityunknownflag int4 NULL,
	feedingunknownflag int4 NULL,
	bottleformula varchar(20) NULL,
	bottlequantity varchar(20) NULL,
	bottleschedule varchar(20) NULL,
	sleepingunknownflag int4 NULL,
	naptime timestamp NULL,
	bedtime timestamp NULL,
	eliminationunknownflag int4 NULL,
	specialconsunknownflag int4 NULL,
	developmentallydelayedflag int4 NULL,
	deliverycomplications varchar(500) NULL,
	motherusedrug varchar(500) NULL,
	sexualdiseaseflag int4 NULL,
	birthcontrolmethod varchar(500) NULL,
	chinfofatherflag int4 NULL,
	chinfootherflag int4 NULL,
	chinfoother varchar(50) NULL,
	chcomments varchar(500) NULL,
	alinfomotherflag int4 NULL,
	alinfofatherflag int4 NULL,
	alinfootherflag int4 NULL,
	alinfoother varchar(50) NULL,
	alcomments varchar(500) NULL,
	u5infomotherflag int4 NULL,
	u5infofatherflag int4 NULL,
	u5infootherflag int4 NULL,
	u5infoother varchar(50) NULL,
	u5comments varchar(500) NULL,
	acinfomotherflag int4 NULL,
	acinfofatherflag int4 NULL,
	acinfootherflag int4 NULL,
	acinfoother varchar(50) NULL,
	accomments varchar(500) NULL,
	siinfomotherflag int4 NULL,
	siinfofatherflag int4 NULL,
	siinfootherflag int4 NULL,
	siinfoother varchar(50) NULL,
	sicomments varchar(500) NULL,
	msinfomotherflag int4 NULL,
	msinfofatherflag int4 NULL,
	msinfootherflag int4 NULL,
	msinfoother varchar(50) NULL,
	msinfocomments varchar(500) NULL,
	fdinfomotherflag int4 NULL,
	fdinfofatherflag int4 NULL,
	fdinfootherflag int4 NULL,
	fdinfoother varchar(50) NULL,
	fdinfocomments varchar(500) NULL,
	slinfomotherflag int4 NULL,
	slinfofatherflag int4 NULL,
	slinfootherflag int4 NULL,
	slinfoother varchar(50) NULL,
	slinfocomments varchar(500) NULL,
	elinfomotherflag int4 NULL,
	elinfofatherflag int4 NULL,
	elinfootherflag int4 NULL,
	elinfoother varchar(50) NULL,
	elinfocomments varchar(500) NULL,
	scinfomotherflag int4 NULL,
	scinfofatherflag int4 NULL,
	scinfootherflag int4 NULL,
	scinfoother varchar(50) NULL,
	scinfocomments varchar(500) NULL,
	badrforeignstate varchar(50) NULL,
	badrcountry varchar(50) NULL,
	badrpostalcode varchar(10) NULL,
	mentalretardationtypekey varchar(5) NULL,
	chinfoprovidedtypekey varchar(5) NULL,
	alinfoprovidedtypekey varchar(5) NULL,
	u5infoprovidedtypekey varchar(5) NULL,
	acinfoprovidedtypekey varchar(5) NULL,
	siinfoprovidedtypekey varchar(5) NULL,
	msinfoprovidedtypekey varchar(5) NULL,
	fdinfoprovidedtypekey varchar(5) NULL,
	slinfoprovidedtypekey varchar(5) NULL,
	elinfoprovidedtypekey varchar(5) NULL,
	childspecialneedflag int4 NULL,
	splneedprimarybasistypekey varchar(5) NULL,
	badrstreet varchar(100) NULL,
	expungementflag int4 NULL,
	datavalidflag int4 NULL,
	clientimeergeid uuid NULL,
	isprescribedmedication bool NULL,
	medicinename varchar(100) NULL,
	dosage varchar(100) NULL,
	frequency varchar(100) NULL,
	startdate timestamp NULL,
	enddate timestamp NULL,
	expirationdate timestamp NULL,
	prescribingdoctor varchar(50) NULL,
	complaint varchar(50) NULL,
	reportedby varchar(50) NULL,
	otherreason varchar(100) NULL,
	prescribedreason varchar(100) NULL,
	"comments" varchar(1000) NULL,
	uploadpath varchar(1000) NULL,
	CONSTRAINT fk_personmedicalinfo_diettype FOREIGN KEY (diettypekey) REFERENCES diettype(diettypekey),
	CONSTRAINT fk_personmedicalinfo_disabilitytype FOREIGN KEY (physicaldisabilitykey) REFERENCES disabilitytype(disabilitytypekey),
	CONSTRAINT fk_personmedicalinfo_eatertype FOREIGN KEY (eatertypekey) REFERENCES eatertype(eatertypekey),
	CONSTRAINT fk_personmedicalinfo_emotionaldisabilitykey FOREIGN KEY (emotionaldisabilitykey) REFERENCES disabilitytype(disabilitytypekey),
	CONSTRAINT fk_personmedicalinfo_hearingdisabilitykey FOREIGN KEY (hearingdisabilitykey) REFERENCES disabilitytype(disabilitytypekey),
	CONSTRAINT fk_personmedicalinfo_learningdisabilitykey FOREIGN KEY (learningdisabilitykey) REFERENCES disabilitytype(disabilitytypekey),
	CONSTRAINT fk_personmedicalinfo_otherdisabilitykey FOREIGN KEY (otherdisabilitykey) REFERENCES disabilitytype(disabilitytypekey),
	CONSTRAINT fk_personmedicalinfo_person FOREIGN KEY (personid) REFERENCES person(personid),
	CONSTRAINT fk_personmedicalinfo_visualdisabilitykey FOREIGN KEY (visualdisabilitykey) REFERENCES disabilitytype(disabilitytypekey)
);



DROP TABLE if exists cjams.persondisability;

CREATE table if not exists cjams.persondisability (
	persondisabilityid uuid NOT NULL DEFAULT gen_random_uuid(),
	personid uuid NOT NULL,
	disabilityconditiontypekey varchar(32) NULL,
	disabilityflag int4 NULL,
	diagnoiseddisabilitynotes varchar(100) NULL,
	startdate timestamp NULL,
	enddate timestamp NULL,
	evaluationdate timestamp NULL,
	evaluatorname varchar(50) NULL,
	"comments" varchar(500) NULL,
	insertedon timestamp NULL,
	insertedby varchar(50) NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	expungementflag int4 NULL,
	old_id varchar(16) NULL,
	disabilitytypekey varchar(25) NULL, -- disability Type Key
	disabilitytype varchar(32) NULL,
	uploadpath varchar(1000) NULL,
	hygienekey varchar(8000) NULL,
	specialkey varchar(8000) NULL
);

DROP table if exists cjams.personbehavioralhealth;

CREATE table if not exists cjams.personbehavioralhealth (
	personbehavioralhealthid uuid NOT NULL DEFAULT gen_random_uuid(), -- Person Behavioralhealth in this table(Primary key)
	personid uuid NOT NULL, -- personid id (foreign key)
	clinicianname varchar(50) NULL, -- Behavioralhealth Clinic Name
	currentdiagnoses varchar(100) NULL, -- Behavioralhealth currentdiagnoses
	phone varchar(25) NULL, -- Behavioralhealth phone
	address1 varchar(100) NULL, -- Behavioralhealth address1
	address2 varchar(100) NULL, -- Behavioralhealth address2
	reportname varchar(50) NULL, -- Behavioralhealth reportname
	city varchar(50) NULL, -- Behavioralhealth city (Foreign Key)
	state varchar(50) NULL, -- Behavioralhealth state
	countyid uuid NULL, -- Behavioralhealth countyid
	zip varchar(50) NULL, -- Behavioralhealth zip
	activeflag int4 NOT NULL DEFAULT 1, -- Status of the record
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp NULL DEFAULT now(), -- Record updated date and time
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp NULL DEFAULT now(), -- Record created date and time
	effectivedate timestamp NOT NULL DEFAULT now(), -- Record valid from
	expirationdate timestamp NULL, -- Record inactive date
	reportpath text NULL, -- Behavioralhealth reportpath
	isbehavioralhealth bool NULL, -- Behavioralhealth isbehavioralhealth
	personservicetypekey varchar NULL, -- Behavioralhealth personservicetypekey
	county varchar(50) NULL,
	uploadpath varchar(1000) NULL,
	email varchar(100) NULL,
	nodiagnosisreason text NULL,
	evaluationby varchar(50) NULL,
	dateofevaluation timestamp NULL,
	parentbehaviouralhealthid uuid NULL,
	CONSTRAINT pk_personbehavioralhealth PRIMARY KEY (personbehavioralhealthid),
	CONSTRAINT fk_personbehavioralhealth_countyid FOREIGN KEY (countyid) REFERENCES county(countyid),
	CONSTRAINT fk_personbehavioralhealth_personid FOREIGN KEY (personid) REFERENCES person(personid)
);

DROP TABLE if exists cjams.personabusesubstance;

CREATE table if not exists cjams.personabusesubstance (
	personabusesubstanceid uuid NOT NULL DEFAULT gen_random_uuid(), -- Person Abusesubstance in this table(Primary key)
	personid uuid NOT NULL, -- personid id (foreign key)
	isusetobacco bool NULL, -- Abusesubstance isusetobacco
	isusedrugoralcohol bool NULL, -- Abusesubstance isusedrugoralcohol
	isusedrug bool NULL, -- Abusesubstance isusedrug
	isusealcohol bool NULL, -- Abusesubstance isusealcohol
	drugfrequencydetails varchar(50) NULL, -- Abusesubstance drugfrequencydetails
	drugageatfirstuse varchar(50) NULL, -- Abusesubstance drugageatfirstuse
	alcoholfrequencydetails varchar(50) NULL, -- Abusesubstance alcoholfrequencydetails
	alcoholageatfirstuse varchar(50) NULL, -- Abusesubstance alcoholageatfirstuse
	drugoralcoholproblems varchar(250) NULL, -- Abusesubstance drugoralcoholproblems
	activeflag int4 NOT NULL DEFAULT 1, -- Status of the record
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp NULL DEFAULT now(), -- Record updated date and time
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp NULL DEFAULT now(), -- Record created date and time
	effectivedate timestamp NOT NULL DEFAULT now(), -- Record valid from
	expirationdate timestamp NULL, -- Record inactive date
	tobaccoageatfirstuse varchar(50) NULL, -- Abusesubstance tobaccoageatfirstuse
	tobaccofrequencydetails varchar(50) NULL, -- Abusesubstance tobaccofrequencydetails
	drugfrequencytypekey varchar(100) NULL, -- drug frequency details type key
	alcoholfrequencytypekey varchar(100) NULL, -- alcohol frequency details type key
	tobaccofrequencytypekey varchar(100) NULL, -- tobacco frequency detail type 
	drugtimes int4 NULL, -- drug times
	alcoholtimes int4 NULL, -- no  of alcohol times
	tobaccotimes int4 NULL, -- no of tobacco times
	medicalprofilekey float8 NULL,
	substanceusekey float8 NULL,
	substancecode varchar(4) NULL,
	substanceusenotetext varchar(256) NULL,
	uploadpath varchar(1000) NULL,
	parentabusesubstanceid uuid NULL,
	CONSTRAINT pk_personabusesubstance PRIMARY KEY (personabusesubstanceid),
	CONSTRAINT fk_personabusesubstance_alcoholpersonabusesubstancefretype FOREIGN KEY (alcoholfrequencytypekey) REFERENCES personabusesubstancefrequencytype(personabusesubstancefrequencytypekey),
	CONSTRAINT fk_personabusesubstance_drugpersonabusesubstancefretype FOREIGN KEY (drugfrequencytypekey) REFERENCES personabusesubstancefrequencytype(personabusesubstancefrequencytypekey),
	CONSTRAINT fk_personabusesubstance_personid FOREIGN KEY (personid) REFERENCES person(personid),
	CONSTRAINT fk_personabusesubstance_tobaccopersonabusesubstancefretype FOREIGN KEY (tobaccofrequencytypekey) REFERENCES personabusesubstancefrequencytype(personabusesubstancefrequencytypekey)
);

DROP TABLE if exists cjams.personhlthelimination;

CREATE TABLE if not exists cjams.personhlthelimination (
	personhltheliminationid uuid NOT NULL DEFAULT gen_random_uuid(),
	providedname varchar NULL,
	relationship varchar NULL,
	ishousehold bool NULL,
	iscollateral bool NULL,
	iseliminationinfoknown bool NULL,
	elimination_currentstatus jsonb NULL,
	toilettrainingmethod jsonb NULL,
	wordforbowelmovement varchar NULL,
	wordforurination varchar NULL,
	insertedon timestamp NULL,
	insertedby varchar NULL,
	updatedon timestamp NULL,
	updatedby varchar NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	"comments" varchar(500) NULL,
	personid uuid NULL,
	specialcomments varchar(1000) NULL
);

DROP TABLE if exists cjams.personhlthmobilityspeech;

CREATE table if not exists cjams.personhlthmobilityspeech (
	personhlthmobilityspeechid uuid NOT NULL DEFAULT gen_random_uuid(),
	providedname varchar NULL,
	relationship varchar NULL,
	ishousehold bool NULL,
	iscollateral bool NULL,
	ismbltyspchknown bool NULL,
	satupage int4 NULL,
	walkedage int4 NULL,
	talkedage int4 NULL,
	insertedon timestamp NULL,
	insertedby varchar NULL,
	updatedon timestamp NULL,
	updatedby varchar NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	"comments" varchar(500) NULL,
	personid uuid NULL,
	uploadpath varchar(1000) NULL,
	mblty jsonb NULL,
	speech jsonb NULL
);


DROP TABLE if exists cjams.personhlthfeeding;

CREATE TABLE if not exists cjams.personhlthfeeding (
	personhlthfeedingid uuid NOT NULL DEFAULT gen_random_uuid(),
	providedname varchar NULL,
	relationship varchar NULL,
	ishousehold bool NULL,
	iscollateral bool NULL,
	isfeedinginfoknown bool NULL,
	diettype jsonb NULL,
	eatertype jsonb NULL,
	liquids jsonb NULL,
	solidfood jsonb NULL,
	feeding_position jsonb NULL,
	otherneeds jsonb NULL,
	typeofformula varchar NULL,
	amountperfeeding varchar NULL,
	schedule varchar NULL,
	insertedon timestamp NULL,
	insertedby varchar NULL,
	updatedon timestamp NULL,
	updatedby varchar NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	"comments" varchar(500) NULL,
	personid uuid NULL,
	uploadpath varchar(1000) NULL
);

DROP table if exists cjams.personhlthsleeping;

CREATE table if not exists cjams.personhlthsleeping (
	personhlthfeedingid uuid NOT NULL DEFAULT gen_random_uuid(),
	providedname varchar NULL,
	relationship varchar NULL,
	ishousehold bool NULL,
	iscollateral bool NULL,
	issleepinginfoknown bool NULL,
	sleepingenvironment jsonb NULL,
	sleepingproblems jsonb NULL,
	sleepingposition jsonb NULL,
	sleepingschedule_naptime timestamp NULL,
	sleepingschedule_bedtime timestamp NULL,
	insertedon timestamp NULL,
	insertedby varchar NULL,
	updatedon timestamp NULL,
	updatedby varchar NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	"comments" varchar(500) NULL,
	personid uuid NULL
);

DROP TABLE if exists cjams.personimmunizationconfig;

CREATE table if not exists cjams.personimmunizationconfig (
	personimmunizationconfigid uuid NOT NULL DEFAULT gen_random_uuid(),
	value_text varchar(100) NULL,
	description varchar(100) NULL,
	uiconfig jsonb NULL,
	agetype varchar(50) NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	effectivedate timestamp NOT NULL DEFAULT now(),
	expirationdate timestamp NULL,
	old_id varchar(20) NULL
);


