/* DDL - DML scripts */

CREATE TABLE cjams.ecmsdocuments
(
   cjamsdocumentid     uuid NOT NULL,
   entitytype          CHARACTER VARYING (100) NULL,
   entityid            uuid NULL,
   documentname        CHARACTER VARYING (500) NULL,
   documentcategory    CHARACTER VARYING (100) NULL,
   documenttype        CHARACTER VARYING (100) NULL,
   administration      CHARACTER VARYING (100) NULL,
   jurisdiction        CHARACTER VARYING (100) NULL,
   site                CHARACTER VARYING (100) NULL,
   uploadeddate        TIMESTAMP (6) NULL,
   uploadedby          CHARACTER VARYING (100) NULL,
   ecmsdocumentid      CHARACTER VARYING (100) NULL,
   mdmid               CHARACTER VARYING (100) NULL,
   casenumber          CHARACTER VARYING (100) NULL,
   cjamsid             CHARACTER VARYING (100) NULL,
   firstname           CHARACTER VARYING (100) NULL,
   lastname            CHARACTER VARYING (100) NULL,
   clientssn           CHARACTER VARYING (100) NULL,
   dob                 TIMESTAMP (6) NULL,
   testrun             BOOLEAN NULL,
   migrdocfilename     CHARACTER VARYING (30) NULL,
   ecmsmigrstatus      CHARACTER VARYING (30) NULL,
   ecmsmigrdate        TIMESTAMP (6) NULL,
   ecmsmigruser        CHARACTER VARYING (30) NULL,
   CONSTRAINT pk_ecmsdocuments PRIMARY KEY (cjamsdocumentid)
      NOT DEFERRABLE INITIALLY IMMEDIATE
);


CREATE TABLE cjams.mdm_sys_reference
(
   mdm_id            CHARACTER VARYING (50) NOT NULL,
   source_sys        CHARACTER VARYING (25) NOT NULL,
   source_sys_id     CHARACTER VARYING (50) NOT NULL,
   active_flag       CHARACTER (1) NULL DEFAULT 'Y'::bpchar,
   process_status    CHARACTER VARYING (25) NULL,
   insert_date       TIMESTAMP (6) NOT NULL DEFAULT now (),
   update_date       TIMESTAMP (6) NOT NULL DEFAULT now (),
   CONSTRAINT pk_mdmssyreference PRIMARY KEY
      (mdm_id, source_sys, source_sys_id)
      NOT DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE cjams.ecmsdoctypecatmap
(
   seqnum              INTEGER NOT NULL,
   documentcategory    CHARACTER VARYING (100) NULL,
   documenttype        CHARACTER VARYING (100) NULL,
   CONSTRAINT pk_ecmsdoctypecatmap PRIMARY KEY (seqnum)
      NOT DEFERRABLE INITIALLY IMMEDIATE
);


/* INSERT SCRIPTS TO LOAD ECMS document types/category lookup table */
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(1, 'CW-Assessment', 'CW-Assessment Document');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(2, 'CW-Court', 'CW-Court-CINA Hearing');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(3, 'CW-Court', 'CW-Court-Petition');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(4, 'CW-Court', 'CW-Court-Rescission');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(5, 'CW-Court', 'CW-Court-Shelter Hearing');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(6, 'CW-CPS', 'CW-CPS Clearance');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(7, 'CW-CPS', 'CW-CPS Clearance - Child Care');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(8, 'CW-CPS', 'CW-CPS Clearance - Provider');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(9, 'CW-CPS', 'CW-CPS Clearance - School');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(10, 'CW-CPS', 'CW-CPS Clearance - Summer Camp');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(11, 'CW-CPS', 'CW-CPS Document');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(12, 'CW-Education', 'CW-School-HS or College Transcript');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(13, 'CW-Education', 'CW-School-IEP/505');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(14, 'CW-Education', 'CW-School-Post Secondary Documentation');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(15, 'CW-Education', 'CW-School-Progress Update');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(16, 'CW-Education', 'CW-School-Report Card');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(17, 'CW-Employment', 'CW-Employment-Pay Stub');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(18, 'CW-Finance', 'CW-Finance-Receipt');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(19, 'CW-Finance', 'CW-Finance-Service Authorization');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(20, 'CW-Health', 'CW-Health-Dental Annual Report-Receipt');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(21, 'CW-Health', 'CW-Health-Dental Comprehensive Report-Receipt');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(22, 'CW-Health', 'CW-Health-Development Status 631C');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(23, 'CW-Health', 'CW-Health-Disability Document');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(24, 'CW-Health', 'CW-Health-EPSDT');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(25, 'CW-Health', 'CW-Health-Family Medical Record');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(26, 'CW-Health', 'CW-Health-Health Annual Report-Receipt');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(27, 'CW-Health', 'CW-Health-Health Comprehensive Report-Receipt');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(28, 'CW-Health', 'CW-Health-Health History 631B');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(29, 'CW-Health', 'CW-Health-Immunization');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(30, 'CW-Health', 'CW-Health-Initial Visit');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(31, 'CW-Health', 'CW-Health-Medi-Alert 631A');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(32, 'CW-Health', 'CW-Health-Mental Health');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(33, 'CW-Health', 'CW-Health-SEN Written Notice From Hospital');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(34, 'CW-Health', 'CW-Health-Vision');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(35, 'CW-Health', 'CW-Psychiatric Evaluation');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(36, 'CW-Identity (ID)', 'CW-Citizen Certification');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(37, 'CW-Identity (ID)', 'CW-Client Photo');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(38, 'CW-Identity (ID)', 'CW-Credit Report');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(39, 'CW-Identity (ID)', 'CW-Director Override Letter');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(40, 'CW-Identity (ID)', 'CW-Driver License Or State ID');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(41, 'CW-Identity (ID)', 'CW-ID-Birth Certificate');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(42, 'CW-Identity (ID)', 'CW-ID-Social Security Card');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(43, 'CW-Intake', 'CW-Referral Document');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(44, 'CW-Provider', 'CW-Pre-Service Training');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(45, 'CW-Provider', 'CW-Provider');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(46, 'CW-Provider', 'CW-Provider Application');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(47, 'CW-Provider', 'CW-Provider Document');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(48, 'CW-Provider', 'CW-Provider License');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(49, 'CW-Providers', 'CW-In-Service Training');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(50, 'CW-Legal', 'CW-Adoption Reconsideration');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(51, 'CW-Redeterminations', 'CW-Annual Redetermination');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(52, 'CW-CJAMS', 'CW-CASA Document');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(53, 'CW-Legal', 'CW-Case Document');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(54, 'CW-CJAMS', 'CW-Case Planning Document');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(55, 'CW-Legal', 'CW-Consent');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(56, 'CW-CJAMS', 'CW-CRBC Document');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(57, 'CW-CJAMS', 'CW-GAP Reconsideration');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(58, 'CW-Legal', 'CW-Legal Document');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(59, 'CW-CJAMS', 'CW-Other Document');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(60, 'CW-CJAMS', 'CW-Reconsideration');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(61, 'CW-Income', 'CW-SSA Approved beyond Board Rate');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(62, 'CW-Income', 'CW-SSI-SSDI Awarded');
INSERT INTO cjams.ecmsdoctypecatmap (seqnum, documentcategory, documenttype) VALUES(63, 'CW-IV-E', 'CW-Title IV-E');

