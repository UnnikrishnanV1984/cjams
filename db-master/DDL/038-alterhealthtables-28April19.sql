--- Adding uploadpath columns for below tables for document upload fuctionality

alter table birthhealthinfo add column if not exists uploadpath varchar (1000) null;           
alter table birthhealthinfo add column if not exists uploadpath varchar (1000) null;   
alter table persondisability add column if not exists uploadpath varchar (1000) null;   
alter table personexamination add column if not exists uploadpath varchar (1000) null;   
alter table personfmlymdclhstry add column if not exists uploadpath varchar (1000) null; 
alter table personhospitalization add column if not exists uploadpath varchar (1000) null;   
alter table personimmunization add column if not exists uploadpath varchar (1000) null;
alter table personhealthinsurance add column if not exists uploadpath varchar (1000) null;
alter table personmedicalcondition add column if not exists uploadpath varchar (1000) null;   
alter table personmedicalconditioninfo add column if not exists uploadpath varchar (1000) null;    
alter table personsexualinfo add column if not exists uploadpath varchar (1000) null;   
alter table clientunder5yearsinfo add column if not exists uploadpath varchar (1000) null;
alter table personhlthfeeding add column if not exists uploadpath varchar (1000) null; 
alter table personhlthmobilityspeech add column if not exists uploadpath varchar (1000) null;  
alter table personhlthsleeping add column if not exists uploadpath varchar (1000) null; 
alter table personhlthelimination add column if not exists uploadpath varchar (1000) null; 

alter table personallergiesinfo add column if not exists phobiacomments text;

alter table personallergiesinfo add column if not exists hygienecomments text;

alter table personallergiesinfo add column if not exists specialneedcomments text;

alter table personallergiesinfo add column if not exists adversecomments text;

alter table personexamination add column if not exists address2 varchar(100) null;

alter table personexamination add column if not exists address1 varchar(100) null;

ALTER TABLE cjams.personexamination ALTER COLUMN collateralid DROP NOT NULL;
ALTER TABLE cjams.personexamination ALTER COLUMN providedbyclientid DROP NOT NULL;
ALTER TABLE cjams.personexamination ALTER COLUMN providerid DROP NOT NULL;


alter table personbehavioralhealth add column if not exists county varchar(50) null;

alter table personbehavioralhealth drop constraint fk_personbehavioralhealth_personservicetypekey;

alter table personmedicalinfo add column if not exists isprescribedmedication boolean null;

alter table personbehavioralhealth add column if not exists uploadpath varchar (1000) null;

alter table personmedicalinfo add column if not exists medicinename varchar(100) null;
alter table personmedicalinfo add column if not exists dosage varchar(100) null;
alter table personmedicalinfo add column if not exists frequency varchar(100) null;
alter table personmedicalinfo add column if not exists startdate timestamp null;
alter table personmedicalinfo add column if not exists enddate timestamp null;
alter table personmedicalinfo add column if not exists expirationdate timestamp null;

alter table personmedicalinfo add column if not exists prescribingdoctor varchar(50) null;

alter table personmedicalinfo add column if not exists complaint varchar(50) null;

alter table personmedicalinfo add column if not exists reportedby varchar(50) null;

alter table personmedicalinfo add column if not exists isprescribedmedication boolean null;

alter table personmedicalinfo add column otherreason varchar(100) null;
alter table personmedicalinfo add column prescribedreason varchar(100) null;

alter table personexamination add column medicalreferrals varchar(50) null;

alter table personexamination add column followupneeded varchar(50) null;

alter table clientunder5yearsinfo add column whenbegun varchar(50) null;

alter table personhealthinsurance add column county varchar(50) null;

ALTER TABLE cjams.personsexualinfo ALTER COLUMN sexualactiveflag DROP NOT NULL;
ALTER TABLE cjams.birthhealthinfo ALTER COLUMN mothersusepregnant TYPE json USING mothersusepregnant::json;
ALTER TABLE cjams.birthhealthinfo ALTER COLUMN mentalcondition TYPE json USING mentalcondition::json;
ALTER TABLE cjams.birthhealthinfo ALTER COLUMN diseasescondition TYPE json USING diseasescondition::json;
alter table personexamination add column uploadedfiles json null;

ALTER TABLE cjams.personhospitalization ALTER COLUMN activeflag SET DEFAULT 1;

ALTER TABLE cjams.medicalconditiontype ALTER COLUMN medicalconditiontypekey TYPE varchar(100) USING medicalconditiontypekey::varchar;

alter table personmedicalcondition add column ismedfragile boolean null;

alter table personmedicalcondition add column severitysymptomkey varchar(50) null;

alter table persondisability add column hygienekey json null;


alter table persondisability add column specialkey json null;


alter table personhospitalization add column hospital_address1 varchar(100) null;
alter table personhospitalization add column hospital_address2 varchar(100) null;
alter table personhospitalization add column hospital_phone varchar(50) null;
alter table personhospitalization add column hospital_city varchar(50) null;
alter table personhospitalization add column hospitalization_type varchar(50) null;
alter table personhospitalization add column hospitalization_reason varchar(50) null;
alter table personhospitalization add column hospital_state varchar(50) null;
alter table personhospitalization add column hospital_zipcode varchar(50) null;

ALTER TABLE cjams.personhospitalization ALTER COLUMN hospitalizationid SET DEFAULT gen_random_uuid();
alter table personmedicalinfo add column comments varchar(1000) null;

alter table personmedicalinfo add column uploadpath varchar(1000) null;

alter table personexamination add column if not exists nextappointmentreason text null;

alter table personexamination add column if not exists notkeptreason text null;

alter table personexamination add column if not exists providerinfoflag int null;

ALTER TABLE cjams.personexamination ALTER COLUMN insertedby TYPE varchar(50) USING insertedby::varchar;
ALTER TABLE cjams.personexamination ALTER COLUMN updatedby TYPE varchar(50) USING updatedby::varchar;

ALTER TABLE cjams.personexamination ALTER COLUMN personexaminationid SET DEFAULT gen_random_uuid();
ALTER TABLE cjams.personexamination ALTER COLUMN fk_id DROP NOT NULL;
ALTER TABLE cjams.personexamination ALTER COLUMN clientmergeid DROP NOT NULL;

alter table personabusesubstance add column uploadpath varchar(1000) null;
alter table personbehavioralhealth add column uploadpath varchar(1000) null;
alter table personbehavioralhealth add column email varchar(100) null;

alter table personbehavioralhealth add column nodiagnosisreason text null;
alter table personbehavioralhealth add column evaluationby varchar(50) null;

alter table personbehavioralhealth add column dateofevaluation timestamp null;

alter table personmedicalinfo add column if not exists otherreason text null;

ALTER TABLE cjams.clientunder5yearsinfo ALTER COLUMN clientunder5yearsinfoid SET DEFAULT gen_random_uuid();
alter table clientunder5yearsinfo add column gestation json null;

alter table clientunder5yearsinfo add column comments text null;

alter table clientunder5yearsinfo add column address1 varchar(50) null;
alter table clientunder5yearsinfo add column address2 varchar(50) null;
alter table clientunder5yearsinfo add column phone varchar(50) null;
alter table clientunder5yearsinfo add column complicationsspecify varchar(50) null;

ALTER TABLE cjams.personimmunization ALTER COLUMN personimmunizationid SET DEFAULT gen_random_uuid();
alter table personimmunization add column if not exists dose varchar(50) null;

alter table personimmunization add column personimmunizationconfigid uuid null;
