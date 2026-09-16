-- B-192488 CJAMS CW Immunet Interface (CRISP) 
-- New snapshot table to capture the CJAMS to CRISP outbound historical data.
ALTER TABLE IF EXISTS cjams.crispoutboundinterface_iss DROP CONSTRAINT IF EXISTS pk_crispoutboundinterface_iss_id;
DROP TABLE IF EXISTS cjams.crispoutboundinterface_iss;
CREATE TABLE IF NOT EXISTS cjams.crispoutboundinterface_iss (
   crispoutboundinterface_iss_id uuid NOT NULL DEFAULT gen_random_uuid(), 
   crispoutboundinterfaceid uuid NULL, 
   groupname varchar(50) NULL, 
   memberstatus varchar(50) NULL, 
   patientid int8 NULL, 
   firstname varchar(50) NULL,
   middlename varchar(32) NULL,
   lastname varchar(50) NULL,
   namesuffix varchar(32) NULL,
   address1 varchar(100) NULL,
   address2 varchar(100) NULL,
   city varchar(50) NULL,
   state varchar(150) NULL,
   zip varchar(50) NULL,
   birthdate timestamp NULL,
   gender varchar(100) NULL,
   ssnno varchar NULL,
   homephone varchar(50) NULL,
   workphone varchar(50) NULL,
   cellphone varchar(50) NULL,
   practice varchar(50) NULL,
   location varchar(50) NULL,
   pcp varchar(50) NULL,
   npi varchar(50) NULL,
   taxid varchar(50) NULL,
   insurance varchar(50) NULL,
   aco varchar(50) NULL,
   accountnumber varchar(50) NULL, 
   ensstartdate timestamp NULL,
   careprogram varchar(50) NULL,
   careprogramstartdt timestamp NULL,
   careprogramenddt timestamp NULL,
   caremanager varchar(101) NULL, 
   caremanagerphone varchar(50) NULL,
   caremanageremail varchar(50) NULL,
   ldss varchar(50) NULL,
   casesupervisor varchar(101) NULL,
   casesupervisorphone varchar(50) NULL,
   casesupervisoremail varchar(50) NULL,
   riskscore1 varchar(50) NULL,
   riskmethodology1 varchar(50) NULL,
   riskscore2 varchar(50) NULL,
   riskmethodology2 varchar(50) NULL,
   region varchar(50) NULL,
   directemail varchar(50) NULL,
   dochaloid varchar(50) NULL, 
   followupdate timestamp NULL,
   appointmentmisseddate timestamp NULL,
   carealert varchar(50) NULL,
   assigningauthoritycode varchar(50) NULL,
   batchlogid int8 NULL,
   activeflag int4 NOT NULL DEFAULT 1, 
   insertedby varchar(50) NOT NULL, 
   insertedon timestamp NOT NULL DEFAULT now(), 
   updatedby varchar(50) NULL, 
   updatedon timestamp NULL DEFAULT now(),       
   CONSTRAINT pk_crispoutboundinterface_iss_id PRIMARY KEY (crispoutboundinterface_iss_id)
);

-- Column comments

COMMENT ON COLUMN cjams.crispoutboundinterface_iss.crispoutboundinterface_iss_id IS 'crispoutboundinterface_iss details stored in this table(primary key)';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.crispoutboundinterfaceid IS 'crispoutboundinterface table (primary key)'; 
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.groupname IS 'group name of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.memberstatus IS 'member status of of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.patientid IS 'cjamspid (Primary Key of the person)';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.firstname IS 'first name of person';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.middlename IS 'middle name of person';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.lastname IS 'last name of person';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.namesuffix IS 'suffix of person';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.address1 IS 'Child current placement address line 1';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.address2 IS 'Child current placement address line 2';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.city IS 'Child current placement address line City';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.state IS 'Child current placement address line State';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.zip IS 'Child current placement address line Zip';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.birthdate IS 'birthdate of person';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.gender IS 'gender of person';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.ssnno IS 'ssn no of person';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.homephone IS 'to save home phone';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.workphone IS 'to save work phone';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.cellphone IS 'to save cell phone';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.practice IS 'practice of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.location IS 'location of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.pcp IS 'pcp of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.npi IS 'npi of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.taxid IS 'tax id of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.insurance IS ' insurance of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.aco IS 'aco of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.accountnumber IS 'Medicaid ID of the Person';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.ensstartdate IS 'to save ens start date';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.careprogram IS 'to save care program';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.careprogramstartdt IS 'to save care program start date';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.careprogramenddt IS 'to save care program end date';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.caremanager  IS 'CJAMS Child/Family Case Worker Name';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.caremanagerphone IS 'CJAMS Child/Family Case Worker Phone Number';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.caremanageremail IS 'CJAMS Child/Family Case Worker Email';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.ldss IS 'To identify the Service Case County (Family Assignment)';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.casesupervisor IS 'CJAMS Child/Family Case Supervisor name';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.casesupervisorphone IS 'CJAMS Child/Family Case Supervisor phone';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.casesupervisoremail IS 'CJAMS Child/Family Case Supervisor email';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.riskscore1 IS 'risk score1 of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.riskmethodology1 IS 'risk methodology1 of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.riskscore2 IS 'risk score2 of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.riskmethodology2 IS 'risk methodology2 of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.region IS 'region of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.directemail IS 'direct email of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.dochaloid IS 'dochalo id of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.followupdate IS 'follow up date of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.appointmentmisseddate IS 'appointment missed date of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.carealert IS 'care alert of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.assigningauthoritycode IS 'assigning authority code of crisp system';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.batchlogid IS 'CJAMS-CRISP Outbound Batch Log ID';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.activeflag IS 'status of the record';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.insertedby IS 'user who created this record';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.insertedon IS 'record created date and time';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN cjams.crispoutboundinterface_iss.updatedon IS 'record updated date and time';