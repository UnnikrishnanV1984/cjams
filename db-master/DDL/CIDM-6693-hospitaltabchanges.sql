ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_erexamination boolean null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_erevaluation boolean null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_inpatientAdmission boolean null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_overstay boolean null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_transfer boolean null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_discharged boolean null;
ALTER TABLE cjams.personhospitalization  ADD column IF NOT exists hospital_examstartdate timestamp NULL;
ALTER TABLE cjams.personhospitalization  ADD column IF NOT exists hospital_evaluatstartdate timestamp NULL;
ALTER TABLE cjams.personhospitalization  ADD column IF NOT exists hospital_overstaydate timestamp NULL;
ALTER TABLE cjams.personhospitalization  ADD column IF NOT exists hospital_transferdate timestamp NULL;
ALTER TABLE cjams.personhospitalization  ADD column IF NOT exists hospital_inpatientadmissiondate timestamp NULL;
ALTER TABLE cjams.personhospitalization  ADD column IF NOT exists hospital_dischargeddate timestamp NULL;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_dischargeplan text NULL;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS reasoforfenialbyprovider text NULL;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_dischargediagnoses text NULL;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_transferredname varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_unit varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_roomnumber varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_phonenumber varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_addressline1 varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_addressline2 varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_city varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_state varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_country varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_zipcode varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_dischargerecommendation varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS dischargeplan varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_reasonforovrstay varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_denialsbyproviders varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_lengthofoverstay varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_grouphome varchar null;

ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_cityname varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_statename varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospital_zipcode1 varchar null;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospitalization_reasonForHospitalization_others varchar null;

ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS durationdays varchar NULL;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS medicalnecessitydays varchar NULL;

ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS Hospital_room varchar NULL;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS Hospital_roomPhoneNo varchar NULL;


COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital er examination check';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital er evaluation  check';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital inpatient Admission check';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital overstay check';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital transfer check';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital discharged check';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital examstart date';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital evaluatstart date';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital overstay date';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital transfer date';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital inpatientadmission date';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital discharged date';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital dischargeplan text';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'reason for denial by provider';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital discharged diagnoses';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital transferred name ';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital unit';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital room number';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital address 1 ';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital address 2';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital city';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital phonenumber 1 ';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital state 2';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital country';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital zipcode 1 ';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital hospital_dischargerecommendation';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital discharge plan';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital reason for overstay ';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital denials by providers';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital grouphome ';

COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital cityname';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital statename';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital zipcode1';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital reason for hospitalization';

COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital duration';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital medical duration';


COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital room number';
COMMENT ON COLUMN personhospitalization.hospital_erexamination IS 'hospital room phonenumber';
