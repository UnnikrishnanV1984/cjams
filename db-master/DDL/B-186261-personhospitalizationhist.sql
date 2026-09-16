ALTER TABLE IF EXISTS cjams.personhospitalization_history DROP CONSTRAINT IF EXISTS pk_personhospitalization_history;
DROP TABLE IF EXISTS cjams.personhospitalization_history;




-- cjams.personhospitalization definition

-- Drop table

--DROP TABLE cjams.personhospitalization;

CREATE TABLE if not exists cjams.personhospitalization_history (
    personhospitalizationhistoryid uuid NOT NULL DEFAULT gen_random_uuid(),
    currentdata json,
    previousdata json,
    modifieddata json,
    rowtype character varying(20),
	hospitalizationid uuid NULL,
		typekey varchar NULL,
	reasontypekey varchar NULL,
	adrfaxtx varchar(20) NULL,
	startdt date NULL,
	enddt date NULL,
	diagnosistx varchar NULL,
	commentstx varchar NULL,
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	adrdirectiontx varchar NULL,
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
	adrunitnotx varchar NULL,
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
	hospitalnm varchar NULL,
	adrcountytypekey varchar(50) NULL,
	adrforeigntx varchar NULL,
	adremailtx varchar NULL,
	infocommentstx varchar NULL,
	adrpagertx varchar(20) NULL,
	infomotherflag int4 NULL,
	infofatherflag int4 NULL,
	adrhomephonetx varchar(10) NULL,
	infootherflag int4 NULL,
	infoothertx varchar(50) NULL,
	adrworkxtntx varchar(10) NULL,
	adrworkphonetx varchar(10) NULL,
	adrurltx varchar NULL,
	adrothercontacttx varchar NULL,
	hoinfoprovidedtypekey varchar(50) NULL,
	infoprovidedbyclientid int4 NULL,
	infoprovidedbycollateralid int4 NULL,
	infoclienttypekey varchar(50) NULL,
	adrtypetypekey varchar(50) NULL,
	adrstreettx varchar NULL,
	infoprovidedbytx varchar NULL,
	infoprovidedbyrelationctypekey varchar(50) NULL,
	expungementflag int4 NULL,
	datavalidflag int4 NULL,
	clientmergeid uuid NULL,
	old_id varchar(50) NULL,
	uploadpath json NULL,
	hospital_address1 varchar NULL,
	hospital_address2 varchar NULL,
	hospital_phone varchar(50) NULL,
	hospital_city varchar(50) NULL,
	hospitalization_type varchar NULL,
	hospitalization_reason varchar NULL,
	hospital_state varchar(50) NULL,
	hospital_zipcode varchar(50) NULL,
	hasdischargeplan int4 NULL,
	dischargeplan varchar(500) NULL,
	county varchar(50) NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	starttime varchar NULL, -- This holds the start time of a hospitalization record.
	endtime varchar NULL, -- This holds the end time of a hospitalization record.
	hospital_erexamination bool NULL, -- hospital room phonenumber
	hospital_erevaluation bool NULL,
	hospital_inpatientadmission bool NULL,
	hospital_overstay bool NULL,
	hospital_transfer bool NULL,
	hospital_discharged bool NULL,
	hospital_examstartdate timestamp NULL,
	hospital_evaluatstartdate timestamp NULL,
	hospital_overstaydate timestamp NULL,
	hospital_transferdate timestamp NULL,
	hospital_inpatientadmissiondate timestamp NULL,
	hospital_dischargeddate timestamp NULL,
	hospital_dischargeplan text NULL,
	reasoforfenialbyprovider text NULL,
	hospital_dischargediagnoses text NULL,
	hospital_transferredname varchar NULL,
	hospital_unit varchar NULL,
	hospital_roomnumber varchar NULL,
	hospital_phonenumber varchar NULL,
	hospital_addressline1 varchar NULL,
	hospital_addressline2 varchar NULL,
	hospital_country varchar NULL,
	hospital_dischargerecommendation varchar NULL,
	hospital_reasonforovrstay varchar NULL,
	hospital_denialsbyproviders varchar NULL,
	hospital_lengthofoverstay varchar NULL,
	hospital_grouphome varchar NULL,
	hospital_cityname varchar NULL,
	hospital_statename varchar NULL,
	hospital_zipcode1 varchar NULL,
	hospitalization_reasonforhospitalization_others varchar NULL,
	durationdays varchar NULL,
	medicalnecessitydays varchar NULL,
	hospital_room varchar NULL,
	hospital_roomphoneno varchar NULL,
	objectid varchar NULL, -- To link Hospitalization with Living Arrangement
	notificationdate timestamp NULL,
	actual_placement_after_discharge varchar NULL, -- To record Actual Placement After Discharge value
	hospitalization_discharge_recommendation_others varchar NULL, -- To record other hospitalization discharge recommendation value
	actual_placement_after_discharge_others varchar NULL, -- To record other actual placement discharge recommendation value
	CONSTRAINT pk_personhospitalization_history PRIMARY KEY (personhospitalizationhistoryid)
);



--Column comments
COMMENT ON COLUMN cjams.personhospitalization_history.personhospitalizationhistoryid IS 'personhospitalization_history snapshot details stored in this snapshot table(primary key)';
COMMENT ON COLUMN cjams.personhospitalization_history.hospitalizationid IS 'personhospitalization details stored in the personhospitalization table';
COMMENT ON COLUMN cjams.personhospitalization_history.currentdata IS 'Column to record the latest data ';
COMMENT ON COLUMN cjams.personhospitalization_history.previousdata IS 'Column to record the previous data ';
COMMENT ON COLUMN cjams.personhospitalization_history.modifieddata IS 'Column to record the modified data ';
COMMENT ON COLUMN cjams.personhospitalization_history.rowtype IS 'Column to record the type of transaction';
COMMENT ON COLUMN cjams.personhospitalization_history.personid IS 'Peson id of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.typekey is 'Type of personhospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.reasontypekey is 'Reason of hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.startdt is 'start date of hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.enddt is 'End date of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.diagnosistx is 'diagnosis text of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.commentstx is 'Comments/notes of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrdirectiontx is 'address direction text of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrzip4no is 'address zip of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrstatetypekey is 'address state';
COMMENT ON COLUMN cjams.personhospitalization_history.adrcitynm is 'address and city name of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrforeignstatetx is 'foreign address of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.providerid is 'provider id of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrunitnotx is 'unit addressid of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrcountrytx is 'country address of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrunittypetypekey is 'address unit type of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrpostdirtypekey is 'address directions of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrstreetsuffixtypekey is 'address suffix type of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrstreetnm is 'street name address of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrpredirtypekey is 'address direction type key of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrpostalcodetx is 'postal code address of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrboxno is 'address box number of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrstreetno is 'street number address of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrcellphonetx is 'cellphone number ';
COMMENT ON COLUMN cjams.personhospitalization_history.adrformattypekey is 'address format';
COMMENT ON COLUMN cjams.personhospitalization_history.hospitalnm is 'Name of the hospital';
COMMENT ON COLUMN cjams.personhospitalization_history.adrcountytypekey is 'county address of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrforeigntx is 'foreign address of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adremailtx is 'email text of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.infocommentstx is 'addition comments of hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.adrpagertx is 'Pager details';
COMMENT ON COLUMN cjams.personhospitalization_history.infomotherflag is 'Info about mother flag';
COMMENT ON COLUMN cjams.personhospitalization_history.infofatherflag is 'Info abouth father flag';
COMMENT ON COLUMN cjams.personhospitalization_history.adrhomephonetx is 'Home phone number of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.infootherflag is 'Info about other flag';
COMMENT ON COLUMN cjams.personhospitalization_history.infoothertx is 'other infor comments';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_address1 is 'Hospital address 1';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_address2 is 'Hospital address 2';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_phone is 'Hospital phone number';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_city is 'Hospital city';
COMMENT ON COLUMN cjams.personhospitalization_history.hospitalization_type is 'Type of hospital';
COMMENT ON COLUMN cjams.personhospitalization_history.hospitalization_reason is 'reason of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_state is 'State of the hospital';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_zipcode is 'Zip code of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.hasdischargeplan is 'check box for discharge plan of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.dischargeplan is 'id of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.county is 'Country of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.starttime is 'start time of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.endtime is 'End time of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_erexamination is 'ER examination of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_erevaluation is 'ER Evaludation of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_inpatientadmission is 'In patient admission of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_overstay is 'Overstay of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_transfer is 'Hospital transfer check';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_discharged is 'Discharge check for hospital';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_examstartdate is 'Exam start date';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_evaluatstartdate is 'Evaluation of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_overstaydate is 'Over stay of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_transferdate is 'Transfer date of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_inpatientadmissiondate is 'Patient admission date of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_dischargeddate is 'Discharge date of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_dischargeplan is 'Discharge plan of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.reasoforfenialbyprovider is 'reasoforfenialbyprovider of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_dischargediagnoses is 'Discharge diagnoses text of the hospitalization';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_transferredname is 'Transfer name';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_unit is 'Hospital unit';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_roomnumber is 'Hospital Room number';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_phonenumber is 'Hospital Phone number';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_addressline1 is 'Hospital addressline1';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_addressline2 is 'Hospital addressline2';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_country is 'Hospital country';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_dischargerecommendation is 'Hospital discharge recommendation';
COMMENT ON COLUMN cjams.personhospitalization_history.Actual_Placement_After_Discharge is 'Actual placement after discharge';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_reasonforovrstay is 'Reason for overstay in hospital';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_denialsbyproviders is 'Provider denials';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_lengthofoverstay is 'Duration of overstay';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_grouphome is 'Group Home';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_cityname is 'Hospital city name';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_statename is 'Hospital State';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_zipcode1 is 'Hospital zip code';
COMMENT ON COLUMN cjams.personhospitalization_history.hospitalization_reasonforhospitalization_others is 'Reason for hospitalizaton';
COMMENT ON COLUMN cjams.personhospitalization_history.durationdays is 'duration in hospital';
COMMENT ON COLUMN cjams.personhospitalization_history.medicalnecessitydays is 'On med time frame';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_room is 'Hospital room number';
COMMENT ON COLUMN cjams.personhospitalization_history.hospital_roomphoneno is 'Hospital room phone number';
COMMENT ON COLUMN cjams.personhospitalization_history.objectid is 'Object id Mapping to Living arrangement id';
comment on column cjams.personhospitalization_history.notificationdate is 'Notification Date in displaying the pop-up';	
COMMENT on column cjams.personhospitalization_history.actual_placement_after_discharge is 'To record Actual Placement After Discharge value';
COMMENT ON COLUMN cjams.personhospitalization_history.hospitalization_discharge_recommendation_others is 'To record other hospitalization discharge recommendation value';
COMMENT ON COLUMN cjams.personhospitalization_history.actual_placement_after_discharge_others is 'To record other actual placement discharge recommendation value';