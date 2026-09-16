-- Auto-generated from api-master LoopBack model definitions (common/models/*.json, server/models/**/*.json)
-- Generated: 2026-09-16T04:53:51.389Z
-- Source of truth: each model's "postgresql" blocks declare exact column name/type/length/precision/scale/nullable.
-- This captures every table api-master's model layer is configured to read/write. It does NOT include
-- FK constraints (LoopBack relations are app-level, not enforced DB FKs in these model files) or
-- indexes/sequences/triggers that live only in db-master/dbsp-master.

CREATE SCHEMA IF NOT EXISTS "cjams";
CREATE SCHEMA IF NOT EXISTS "defecttracking";
CREATE SCHEMA IF NOT EXISTS "prov";

-- Model(s): Personprimaryincometype
CREATE TABLE IF NOT EXISTS "cjams"."Personprimaryincometype" (
    "personprimaryincometypekey" varchar(50),
    "activeflag" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personprimaryincometypekey")
);

-- Model(s): Accesslist
CREATE TABLE IF NOT EXISTS "cjams"."accesslist" (
    "accesslistid" uuid DEFAULT gen_random_uuid(),
    "loadnumber" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "servicerequesttypeconfigid" uuid,
    PRIMARY KEY ("accesslistid")
);

-- Model(s): AccessToken, accessTkn
CREATE TABLE IF NOT EXISTS "cjams"."accesstoken" (
    "id" varchar(255),
    "ttl" numeric,
    "scopes" varchar(255),
    "created" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "fromdevice" integer,
    PRIMARY KEY ("id")
);

-- Model(s): Accountreceivabledocuments
CREATE TABLE IF NOT EXISTS "cjams"."accountreceivabledocuments" (
    "accountreceivabledocumentsid" uuid DEFAULT gen_random_uuid(),
    "providerid" varchar(20),
    "receivableid" bigint,
    "receivabledetailid" bigint,
    "receivablebalance" numeric(5,2),
    "collectionstatus" varchar(50),
    "uploadedby" uuid,
    "uploadeddate" timestamp,
    "uploadpath" json,
    "activeflag" integer,
    "filename" varchar(500),
    "ecmsdocumentid" varchar(255),
    PRIMARY KEY ("accountreceivabledocumentsid")
);

-- Model(s): ACL
CREATE TABLE IF NOT EXISTS "cjams"."acl" (
    "model" varchar(255),
    "property" varchar(255)
);

-- Model(s): Actionletterheaderconfig
CREATE TABLE IF NOT EXISTS "cjams"."actionletterheaderconfig" (
    "headerconfigid" uuid DEFAULT gen_random_uuid(),
    "programtypekey" varchar(100),
    "comartypekey" varchar(100),
    "actiontypekey" varchar(100),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("headerconfigid")
);

-- Model(s): Actionletterprogramconfig
CREATE TABLE IF NOT EXISTS "cjams"."actionletterprogramconfig" (
    "programconfigid" uuid DEFAULT gen_random_uuid(),
    "headerconfigid" uuid,
    "programtypekey" varchar(100),
    "comartypekey" varchar(100),
    "actiontypekey" varchar(100),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("programconfigid")
);

-- Model(s): Activity
CREATE TABLE IF NOT EXISTS "cjams"."activity" (
    "activityid" uuid DEFAULT gen_random_uuid(),
    "description" text,
    "activitystatustypekey" varchar(15),
    "amactivityid" uuid,
    "ammappingid" uuid,
    "objectid" uuid,
    "sourcedescription" varchar(256),
    "activitytypekey" varchar(50),
    "helptext" text,
    "sequence" integer,
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "groupsequence" integer,
    PRIMARY KEY ("activityid")
);

-- Model(s): Activitygoal
CREATE TABLE IF NOT EXISTS "cjams"."activitygoal" (
    "activitygoalid" uuid,
    "activityid" uuid,
    "name" varchar(50),
    "description" text,
    "helptext" text,
    "amgoalid" uuid,
    "assignedto" varchar(50),
    "activitygoalstatustypekey" varchar(15),
    "activitygoaldispositiontypekey" varchar(15),
    "activitygoaltypekey" varchar(50),
    "activityprioritytypekey" varchar(50),
    "duedate" timestamp,
    "reasonnotmet" varchar(256),
    "completiondate" timestamp,
    "required" boolean,
    "sequence" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid
);

-- Model(s): Activitygoaldispositiontype
CREATE TABLE IF NOT EXISTS "cjams"."activitygoaldispositiontype" (
    "sequencenumber" integer,
    "activitygoaldispositiontypekey" varchar(15),
    "activitytypekey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp
);

-- Model(s): Activitygoalstatustype
CREATE TABLE IF NOT EXISTS "cjams"."activitygoalstatustype" (
    "sequencenumber" integer,
    "activitygoalstatustypekey" varchar(15),
    "activitytypekey" varchar(50),
    "closedstatus" boolean,
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp
);

-- Model(s): Activitygoaltype
CREATE TABLE IF NOT EXISTS "cjams"."activitygoaltype" (
    "sequencenumber" integer,
    "activitygoaltypekey" varchar(50),
    "activitytypekey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp
);

-- Model(s): Activityprioritytype
CREATE TABLE IF NOT EXISTS "cjams"."activityprioritytype" (
    "sequencenumber" integer,
    "activityprioritytypekey" varchar(50),
    "activitytypekey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("activityprioritytypekey")
);

-- Model(s): Activitytask
CREATE TABLE IF NOT EXISTS "cjams"."activitytask" (
    "activitytaskid" uuid DEFAULT gen_random_uuid(),
    "activityid" uuid,
    "name" varchar(512),
    "description" text,
    "helptext" text,
    "amtaskid" uuid,
    "assignedto" varchar(50),
    "assignedon" timestamp,
    "activitytaskstatustypekey" varchar(15),
    "activitytaskdispositiontypekey" varchar(15),
    "activitytasktypekey" varchar(50),
    "activityprioritytypekey" varchar(50),
    "taskcommunicationtypekey" varchar(50),
    "duedate" timestamp,
    "startdatetime" timestamp,
    "enddatetime" timestamp,
    "location" varchar(100),
    "outofoffice" boolean,
    "reasonnotmet" varchar(256),
    "required" boolean,
    "sequence" integer,
    "completeddate" timestamp,
    "taskdispositiontypekey" varchar(30),
    "reminderdate" timestamp,
    "iscontinual " boolean,
    "iseditable" boolean,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "targetcompleteddate" timestamp,
    "notes" text,
    PRIMARY KEY ("activitytaskid")
);

-- Model(s): Activitytaskdispositiontype
CREATE TABLE IF NOT EXISTS "cjams"."activitytaskdispositiontype" (
    "sequencenumber" integer,
    "activitytaskdispositiontypekey" varchar(15),
    "activitytypekey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp
);

-- Model(s): Activitytaskstatustype
CREATE TABLE IF NOT EXISTS "cjams"."activitytaskstatustype" (
    "sequencenumber" integer,
    "activitytaskstatustypekey" varchar(15),
    "activitytypekey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("activitytaskstatustypekey")
);

-- Model(s): Activitytasktype
CREATE TABLE IF NOT EXISTS "cjams"."activitytasktype" (
    "sequencenumber" integer,
    "activitytasktypekey" varchar(50),
    "activitytypekey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("activitytasktypekey")
);

-- Model(s): Activitytasktypestatusdispositionmap
CREATE TABLE IF NOT EXISTS "cjams"."activitytasktypestatusdispositionmap" (
    "activitytasktypestatusdispositionmapid" uuid DEFAULT gen_random_uuid(),
    "activitytasktypekey" varchar(50),
    "activitytaskstatustypekey" varchar(15),
    "activitytaskdispositiontypekey" varchar(15),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "timestamp" bytea,
    PRIMARY KEY ("activitytasktypestatusdispositionmapid")
);

-- Model(s): Activitytype
CREATE TABLE IF NOT EXISTS "cjams"."activitytype" (
    "sequencenumber" integer,
    "activitytypekey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("activitytypekey")
);

-- Model(s): Actor
CREATE TABLE IF NOT EXISTS "cjams"."actor" (
    "actorid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "personid" uuid,
    "actortype" varchar(50),
    "isdangertoworker" integer,
    "dangertoworkerreason" varchar(512),
    "servicecaseid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "primarylanguageid" uuid,
    "secondarylanguageid" uuid,
    "employeetypeid" uuid,
    "employeetypename" varchar(50),
    "medicaideligibility" boolean,
    "blockgranteligibility" boolean,
    "recipientstatus" boolean,
    "livingarrangementtypekey" varchar(50),
    "interpreterrequired" varchar(256),
    "guardianname" varchar(50),
    "guardianinfo" varchar(126),
    "ramentalhealth" boolean,
    "ramentalretarted" boolean,
    "ramentalretartedtype" varchar(50),
    "intakeserviceid" uuid,
    "iscollateralcontact" integer,
    "ishouseholdmember" integer,
    "ismentalillness" integer,
    "mentalillnessdetail" varchar(255),
    "ismentalimpair" integer,
    "mentalimpairdetail" varchar(255),
    "fetalalcoholspctrmdisordflag" integer,
    "drugexposednewbornflag" integer,
    "probationsearchconductedflag" integer,
    "sexoffenderregisteredflag" integer,
    "intakenumber" varchar(255),
    PRIMARY KEY ("actorid")
);

-- Model(s): Actorrelationship
CREATE TABLE IF NOT EXISTS "cjams"."actorrelationship" (
    "actorrelationshipid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "caregiverflag" integer,
    "relationshiptypekey" varchar(255),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "expirationdate" timestamp,
    "effectivedate" timestamp,
    "timestamp" bytea,
    "intakeservicerequestactorid" uuid,
    "person1id" uuid,
    "person2id" uuid,
    "servicecaseid" uuid,
    "intakeserviceid" uuid,
    "intakenumber" varchar(50),
    PRIMARY KEY ("actorrelationshipid")
);

-- Model(s): Actortype
CREATE TABLE IF NOT EXISTS "cjams"."actortype" (
    "activeflag" integer,
    "actortype" varchar(50),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "sequencenumber" integer,
    "tasktype" integer,
    "typedescription" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("actortype")
);

-- Model(s): Actortypeagency
CREATE TABLE IF NOT EXISTS "cjams"."actortypeagency" (
    "actortypeagencyid" uuid DEFAULT gen_random_uuid(),
    "teamtypekey" varchar(50),
    "actortypekey" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("actortypeagencyid")
);

-- Model(s): Addresskeydetaillkup
CREATE TABLE IF NOT EXISTS "cjams"."addresskeydetaillkup" (
    "keyid" uuid DEFAULT gen_random_uuid(),
    "fieldid" uuid,
    "keyvalue" varchar(100),
    "definition" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" varchar(10),
    "status" timestamp,
    PRIMARY KEY ("keyid")
);

-- Model(s): Addresskeylkup
CREATE TABLE IF NOT EXISTS "cjams"."addresskeylkup" (
    "fieldid" uuid DEFAULT gen_random_uuid(),
    "fieldname" varchar(100),
    "definition" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("fieldid")
);

-- Model(s): Adjudicateddecisiontype
CREATE TABLE IF NOT EXISTS "cjams"."adjudicateddecisiontype" (
    "adjudicateddecisiontypeid" uuid,
    "adjudicateddecisiontypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("adjudicateddecisiontypekey")
);

-- Model(s): Adoptionagreement
CREATE TABLE IF NOT EXISTS "cjams"."adoptionagreement" (
    "adoptionagreementid" uuid,
    "adoptionplanningid" uuid,
    "adoptiveparent1id" uuid,
    "adoptiveparent2id" uuid,
    "providerid" uuid,
    "adoptioncaseid" uuid,
    "isofferedsubsidy" integer,
    "offeraccepteddate" varchar(255),
    "startdate" timestamp,
    "enddate" timestamp,
    "finalizationdate" timestamp,
    "isunderappeal" integer,
    "singleparentadoptioncheck" integer,
    "parent1signdate" timestamp,
    "parent2signdate" timestamp,
    "ldssdate" timestamp,
    "issubsidypaid" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    "ismedassist" boolean,
    "parent1providerid" integer,
    "parent2providerid" integer,
    "parent1providername" varchar(100),
    "parent2providername" varchar(100),
    "adoptiveparent1signature" text,
    "adoptiveparent2signature" text,
    "ldssdirectorsignature" text,
    "agreementcomments" varchar(5000),
    "childplacedby" varchar(15),
    "agreementtyperefid" varchar(50),
    "childplacedfrom" varchar(15)
);

-- Model(s): Adoptionagreementrate
CREATE TABLE IF NOT EXISTS "cjams"."adoptionagreementrate" (
    "adoptionagreementrateid" uuid DEFAULT gen_random_uuid(),
    "adoptionagreementid" uuid,
    "startdate" timestamp,
    "enddate" timestamp,
    "provider_id" bigint,
    "paymentamout" numeric,
    "isapproval" integer,
    "isssaapproved" integer,
    "ssaapproveddate" timestamp,
    "approvaldate" timestamp,
    "transactiondate" timestamp,
    "isspeacialneeds" integer,
    "parent1actorid" uuid,
    "parent2actorid" uuid,
    "childrelationship" varchar(50),
    "notes" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    "specialneedtypekey" varchar(15),
    "specialneedremarks" varchar(200),
    "status" varchar(50),
    PRIMARY KEY ("adoptionagreementrateid")
);

-- Model(s): Adoptionagreementraterevision
CREATE TABLE IF NOT EXISTS "cjams"."adoptionagreementraterevision" (
    "adoptionagreementraterevisionid" uuid,
    "adoptionagreementrateid" uuid,
    "adoptionagreementid" uuid,
    "startdate" timestamp,
    "enddate" timestamp,
    "provider_id" bigint,
    "paymentamout" numeric,
    "isapproval" integer,
    "isssaapproved" integer,
    "ssaapproveddate" timestamp,
    "approvaldate" timestamp,
    "isspeacialneeds" integer,
    "parent1providerid" integer,
    "parent2providerid" integer,
    "childrelationship" varchar(50),
    "notes" text,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "specialneedtypekey" varchar(15),
    "specialneedremarks" varchar(200),
    "transactiondate" timestamp,
    "status" varchar(50),
    "isoriginal" boolean
);

-- Model(s): Adoptionagreementrevision
CREATE TABLE IF NOT EXISTS "cjams"."adoptionagreementrevision" (
    "adoptionagreementrevisionid" uuid,
    "adoptionagreementid" uuid,
    "adoptionplanningid" uuid,
    "adoptiveparent1id" uuid,
    "adoptiveparent2id" uuid,
    "providerid" uuid,
    "isofferedsubsidy" integer,
    "offeraccepteddate" varchar(255),
    "startdate" timestamp,
    "enddate" timestamp,
    "finalizationdate" timestamp,
    "isunderappeal" integer,
    "singleparentadoptioncheck" integer,
    "parent1signdate" timestamp,
    "parent2signdate" timestamp,
    "ldssdate" timestamp,
    "issubsidypaid" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    "ismedassist" boolean,
    "isoriginal" boolean,
    "parent1providerid" integer,
    "parent2providerid" integer,
    "parent1providername" varchar(100),
    "parent2providername" varchar(100),
    "adoptiveparent1signature" text,
    "adoptiveparent2signature" text,
    "ldssdirectorsignature" text,
    "agreementcomments" varchar(5000),
    "childplacedby" varchar(15),
    "childplacedfrom" varchar(15),
    "approvalstatustypekey" varchar(5),
    "approvaldate" timestamp,
    "agreementtyperefid" varchar(50)
);

-- Model(s): Adoptionannualreview
CREATE TABLE IF NOT EXISTS "cjams"."adoptionannualreview" (
    "adoptionannualreviewid" uuid DEFAULT gen_random_uuid(),
    "adoptioncaseid" uuid,
    "reviewdate" timestamp,
    "ischilddisability" boolean,
    "ischildspecialneed" boolean,
    "isparentlegalresponsible" boolean,
    "isrenewalsigned" boolean,
    "isfinancialsupport" boolean,
    "ischildenrolledschool" boolean,
    "isdoumentationimmurization" boolean,
    "ischildschoolemployeedisabled" boolean,
    "iscompletesecondaryeducation" boolean,
    "isenrolledinstitution" boolean,
    "isparticipatingemployement" boolean,
    "isemployeehrspermonth" boolean,
    "isincapableactivities" boolean,
    "adoptiveparentonedate" timestamp,
    "adoptiveparenttwodate" timestamp,
    "ldssdirectorsigndate" timestamp,
    "disabilitynotes" varchar(5000),
    "notes" varchar(5000),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("adoptionannualreviewid")
);

-- Model(s): Adoptionbreakthelink
CREATE TABLE IF NOT EXISTS "cjams"."adoptionbreakthelink" (
    "adoptionbreakthelinkid" uuid DEFAULT gen_random_uuid(),
    "adoptionplanningid" uuid,
    "legallyfree" integer,
    "adoptiveplacement" integer,
    "placementagreement" integer,
    "adoptionfinalization" integer,
    "agreementsigneddate" timestamp,
    "associatedcourtorderdate" timestamp,
    "finalizationdate" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("adoptionbreakthelinkid")
);

-- Model(s): Adoptioncase
CREATE TABLE IF NOT EXISTS "cjams"."adoptioncase" (
    "adoptioncaseid" uuid DEFAULT gen_random_uuid(),
    "adoptioncasenumber" varchar(50),
    "servicecaseid" uuid,
    "adoptionplanningid" uuid,
    "statustypekey" varchar(15),
    "startdate" timestamp,
    "enddate" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "narrative" varchar(5000),
    PRIMARY KEY ("adoptioncaseid")
);

-- Model(s): Adoptioncaseactor
CREATE TABLE IF NOT EXISTS "cjams"."adoptioncaseactor" (
    "adoptioncaseactorid" uuid DEFAULT gen_random_uuid(),
    "adoptioncaseid" uuid,
    "personid" uuid,
    "actortypekey" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("adoptioncaseactorid")
);

-- Model(s): AdoptionCaseagreement
CREATE TABLE IF NOT EXISTS "cjams"."adoptioncaseagreement" (
    "adoptionagreementid" uuid,
    "adoptioncaseid" uuid,
    "isofferedsubsidy" integer,
    "offeraccepteddate" varchar(255),
    "startdate" timestamp,
    "enddate" timestamp,
    "finalizationdate" timestamp,
    "isunderappeal" integer,
    "parent1signdate" timestamp,
    "parent2signdate" timestamp,
    "ldssdate" timestamp,
    "issubsidypaid" integer,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    "ismedassist" boolean,
    "parent1providerid" integer,
    "parent2providerid" integer,
    "parent1providername" varchar(100),
    "parent2providername" varchar(100),
    "alternateid" bigint,
    "issingleparent" integer,
    "singleparentadoptioncheck" integer,
    "adoptiveparent1signature" text,
    "adoptiveparent2signature" text,
    "ldssdirectorsignature" text,
    "agreementcomments" varchar(5000),
    "childplacedby" varchar(15),
    "agreementtyperefid" varchar(50),
    "childplacedfrom" varchar(15),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "providerid" integer,
    "adoptiveparent1id" integer,
    "adoptiveparent2id" integer
);

-- Model(s): Adoptioncaseagreementrate
CREATE TABLE IF NOT EXISTS "cjams"."adoptioncaseagreementrate" (
    "adoptionagreementrateid" uuid DEFAULT gen_random_uuid(),
    "adoptionagreementid" uuid,
    "startdate" timestamp,
    "enddate" timestamp,
    "provider_id" bigint,
    "paymentamout" numeric,
    "isapproval" integer,
    "approvaldate" timestamp,
    "transactiondate" timestamp,
    "isspeacialneeds" integer,
    "parent1actorid" uuid,
    "parent2actorid" uuid,
    "childrelationship" varchar(50),
    "notes" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    "specialneedtypekey" varchar(15),
    "specialneedremarks" varchar(200),
    "status" varchar(50),
    PRIMARY KEY ("adoptionagreementrateid")
);

-- Model(s): Adoptioncaseagreementrevision
CREATE TABLE IF NOT EXISTS "cjams"."adoptioncaseagreementrevision" (
    "adoptioncaseagreementrevisionid" uuid,
    "adoptioncaseagreementid" uuid,
    "isofferedsubsidy" integer,
    "offeraccepteddate" varchar(255),
    "startdate" timestamp,
    "enddate" timestamp,
    "finalizationdate" timestamp,
    "isunderappeal" integer,
    "parent1signdate" timestamp,
    "parent2signdate" timestamp,
    "ldssdate" timestamp,
    "issubsidypaid" integer,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    "ismedassist" boolean,
    "parent1providerid" integer,
    "parent2providerid" integer,
    "parent1providername" varchar(100),
    "parent2providername" varchar(100),
    "issingleparent" integer,
    "singleparentadoptioncheck" integer,
    "adoptiveparent1signature" text,
    "adoptiveparent2signature" text,
    "ldssdirectorsignature" text,
    "agreementcomments" varchar(5000),
    "childplacedby" varchar(15),
    "childplacedfrom" varchar(15),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "approvaldate" timestamp,
    "effectiveswitchdate" timestamp,
    "switchprovider" boolean,
    "switchproviderreason" varchar(500),
    "approvalstatustypekey" varchar(50),
    "agreementtyperefid" varchar(50)
);

-- Model(s): Adoptioncasedisposition
CREATE TABLE IF NOT EXISTS "cjams"."adoptioncasedisposition" (
    "adoptioncasedispositionid" uuid DEFAULT gen_random_uuid(),
    "adoptioncaseid" uuid,
    "statusdate" timestamp,
    "intakeserreqstatustypekey" varchar(15),
    "dispositioncode" varchar(15),
    "comments" text,
    "effectivedate" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("adoptioncasedispositionid")
);

-- Model(s): Adoptioncaserevision
CREATE TABLE IF NOT EXISTS "cjams"."adoptioncaserevision" (
    "adoptionrevisionid" uuid DEFAULT gen_random_uuid(),
    "adoptionagreementid" uuid,
    "transactiondate" timestamp,
    "agreementtypetypekey" varchar(50),
    "provider_id" bigint,
    "startdate" timestamp,
    "enddate" timestamp,
    "paymentamout" numeric,
    "notes" varchar(255),
    "adoptivemotherid" integer,
    "adoptivefatherid" integer,
    "isssaapproved" boolean,
    "ssaapproveddate" timestamp,
    "isoriginal" boolean,
    "approvaldate" timestamp,
    "approvalstatustypekey" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "isspeacialneeds" boolean,
    "specialneedtypekey" varchar(50),
    "specialneedremarks" varchar(200),
    "adoptionagreementrateid" uuid,
    "isapproval" integer,
    "childrelationship" varchar(50),
    "effectivedate" timestamp,
    "status" varchar(50),
    PRIMARY KEY ("adoptionrevisionid")
);

-- Model(s): Adoptioncasesuspension
CREATE TABLE IF NOT EXISTS "cjams"."adoptioncasesuspension" (
    "adoptionsuspensionid" uuid DEFAULT gen_random_uuid(),
    "adoptioncaseid" uuid,
    "transactiondate" date,
    "suspensionreasontypekey" varchar(15),
    "suspensionreasonremarks" text,
    "suspensionbegindate" date,
    "suspensionenddate" date,
    "suspensionremarks" varchar(500),
    "approvalstatustypekey" varchar(5),
    "approvaldate" date,
    "isoriginal" varchar(1),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "adoptionagreementid" uuid,
    PRIMARY KEY ("adoptionsuspensionid")
);

-- Model(s): Adoptioncasesuspensionrevision
CREATE TABLE IF NOT EXISTS "cjams"."adoptioncasesuspensionrevision" (
    "adoptionsuspensionrevisionid" uuid DEFAULT gen_random_uuid(),
    "adoptionsuspensionid" uuid,
    "adoptionagreementid" uuid,
    "transactiondate" date,
    "suspensionreasontypekey" varchar(15),
    "suspensionreasonremarks" text,
    "suspensionbegindate" date,
    "suspensionenddate" date,
    "suspensionremarks" varchar(500),
    "approvalstatustypekey" varchar(5),
    "approvaldate" date,
    "isoriginal" varchar(1),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "adoptioncaseid" uuid,
    PRIMARY KEY ("adoptionsuspensionrevisionid")
);

-- Model(s): Adoptionchecklist
CREATE TABLE IF NOT EXISTS "cjams"."adoptionchecklist" (
    "adoptionchecklistid" uuid DEFAULT gen_random_uuid(),
    "adoptionplanningid" uuid,
    "disclosuredate" timestamp,
    "personinfomation" varchar(100),
    "worker" varchar(50),
    "localdepartment" varchar(50),
    "nonstaffmember" varchar(50),
    "siblingage" integer,
    "siblinginformation" varchar(100),
    "remarks" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("adoptionchecklistid")
);

-- Model(s): Adoptionchecklistdetails
CREATE TABLE IF NOT EXISTS "cjams"."adoptionchecklistdetails" (
    "adoptionchecklistdetailsid" uuid DEFAULT gen_random_uuid(),
    "adoptionchecklistid" uuid,
    "checklistid" uuid,
    "isselected" integer,
    "remarks" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("adoptionchecklistdetailsid")
);

-- Model(s): Adoptionefforts
CREATE TABLE IF NOT EXISTS "cjams"."adoptionefforts" (
    "adoptioneffortsid" uuid DEFAULT gen_random_uuid(),
    "adoptionplanningid" uuid,
    "notes" varchar(255),
    "effortdate" timestamp,
    "efforttype" varchar(100),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("adoptioneffortsid")
);

-- Model(s): Adoptionemotional
CREATE TABLE IF NOT EXISTS "cjams"."adoptionemotional" (
    "adoptionemotionalid" uuid DEFAULT gen_random_uuid(),
    "adoptionplanningid" uuid,
    "notes" text,
    "isfosterparents" integer,
    "isadoptivefamily" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("adoptionemotionalid")
);

-- Model(s): Adoptionemotionaldetails
CREATE TABLE IF NOT EXISTS "cjams"."adoptionemotionaldetails" (
    "adoptionemotionaldetailsid" uuid DEFAULT gen_random_uuid(),
    "adoptionemotionalid" uuid,
    "intakeservicerequestactorid" uuid,
    "childimportance" varchar(50),
    "remarks" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("adoptionemotionaldetailsid")
);

-- Model(s): Adoptionemotionalties
CREATE TABLE IF NOT EXISTS "cjams"."adoptionemotionalties" (
    "emotionaltieid" uuid DEFAULT gen_random_uuid(),
    "fmprefixtypekey" varchar(255),
    "fmfirstname" varchar(255),
    "fmmiddlename" varchar(255),
    "fmlastname" varchar(255),
    "fmsuffixtypekey" varchar(255),
    "relationshiptochildtx" varchar(255),
    "importancetochildtx" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "adoptionplanningid" uuid,
    "old_id" varchar(255),
    "providerid" integer,
    PRIMARY KEY ("emotionaltieid")
);

-- Model(s): Adoptioniverenewal
CREATE TABLE IF NOT EXISTS "cjams"."adoptioniverenewal" (
    "adoptioniverenewalid" uuid DEFAULT gen_random_uuid(),
    "adoptionid" uuid,
    "assessmentdate" timestamp,
    "staffid" integer,
    "childminortypekey" varchar(50),
    "specialneedstypekey" varchar(50),
    "parentslegaltypekey" varchar(50),
    "renewalagreementsignedtypekey" varchar(50),
    "comments" text,
    "fatheragreementdate" timestamp,
    "motheragreementdate" timestamp,
    "designeeagreementdate" timestamp,
    "paytill22medchk" text,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedon" timestamp,
    "parentsupportflag" integer,
    "schoolenrollflag" integer,
    "immunizationflag" integer,
    "mededuvoccertflag" integer,
    "paytill22educhkflag" integer,
    "paytill22enrollchkflag" integer,
    "paytill22emppgmchkflag" integer,
    "paytill22emp80hrchkflag" integer,
    "paytill22medchkflag" integer,
    "approvalstatustypekey" varchar(50),
    "ischilddisability" integer,
    "ischildspecialneed" integer,
    "isparentlegalresponsible" integer,
    "isrenewalsigned" integer,
    PRIMARY KEY ("adoptioniverenewalid")
);

-- Model(s): Adoptionplanning
CREATE TABLE IF NOT EXISTS "cjams"."adoptionplanning" (
    "adoptionplanningid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "intakeservicerequestactorid" uuid,
    "permanencyplanid" uuid,
    "isnoeffort" integer,
    "isexceptiongranted" integer,
    "dateofexceptiongranted" timestamp,
    "remarks" text,
    "narrative" text,
    "adoptiondate" timestamp,
    "servicecaseid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("adoptionplanningid")
);

-- Model(s): Adoptionrevision
CREATE TABLE IF NOT EXISTS "cjams"."adoptionrevision" (
    "adoptionrevisionid" uuid DEFAULT gen_random_uuid(),
    "subsidyagreementid" uuid,
    "subsidyagreementrateid" uuid,
    "adoptionid" uuid,
    "transactiondate" timestamp,
    "agreementtypetypekey" varchar(50),
    "providerid" bigint,
    "agreementstartdate" timestamp,
    "agreementenddate" timestamp,
    "paymentamt" numeric,
    "comments" varchar(255),
    "adoptivemotherid" integer,
    "adoptivefatherid" integer,
    "isssaapproval" boolean,
    "ssaapprovaldate" timestamp,
    "isoriginal" boolean,
    "approvaldate" timestamp,
    "approvalstatustypekey" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("adoptionrevisionid")
);

-- Model(s): Adoptionsuspension
CREATE TABLE IF NOT EXISTS "cjams"."adoptionsuspension" (
    "adoptionsuspensionid" uuid DEFAULT gen_random_uuid(),
    "adoptionagreementid" uuid,
    "adoptionplanningid" uuid,
    "transactiondate" date,
    "suspensionreasontypekey" varchar(15),
    "suspensionreasonremarks" varchar(100),
    "suspensionbegindate" date,
    "suspensionenddate" date,
    "suspensionremarks" varchar(500),
    "approvalstatustypekey" varchar(5),
    "approvaldate" date,
    "isoriginal" varchar(1),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("adoptionsuspensionid")
);

-- Model(s): Adoptionsuspensionrevision
CREATE TABLE IF NOT EXISTS "cjams"."adoptionsuspensionrevision" (
    "adoptionsuspensionrevisionid" uuid DEFAULT gen_random_uuid(),
    "adoptionagreementid" uuid,
    "adoptionplanningid" uuid,
    "transactiondate" date,
    "suspensionreasontypekey" varchar(15),
    "suspensionreasonremarks" varchar(100),
    "suspensionbegindate" date,
    "suspensionenddate" date,
    "suspensionremarks" varchar(500),
    "approvalstatustypekey" varchar(5),
    "approvaldate" date,
    "isoriginal" varchar(1),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "adoptionsuspensionid" uuid,
    PRIMARY KEY ("adoptionsuspensionrevisionid")
);

-- Model(s): Agency
CREATE TABLE IF NOT EXISTS "cjams"."agency" (
    "agencyid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "agencytypekey" varchar(15),
    "agencyname" varchar(100),
    "phonenumber" varchar(32),
    "participationstatuskey" varchar(15),
    "specialtytypekey" varchar(15),
    "facilityid" varchar(35),
    "federaltaxid" varchar(35),
    "websiteaddress" varchar(512),
    "reversephonenumber" varchar(32),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea,
    "agencynumber" varchar(50),
    "parentagencyid" uuid,
    "email" varchar(50),
    "facilitytypechangedate" timestamp,
    "officestatustypekey" varchar(15),
    "agencystatustypekey" varchar(15),
    "agencycategorykey" varchar(15),
    "affiliations" varchar(512),
    "agencysubtypekey" varchar(50),
    "billname" varchar(50),
    "mailname" varchar(50),
    "agencygroupid" uuid,
    PRIMARY KEY ("agencyid")
);

-- Model(s): Agencyaddress
CREATE TABLE IF NOT EXISTS "cjams"."agencyaddress" (
    "agencyaddressid" uuid DEFAULT gen_random_uuid(),
    "agencyid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "agencyaddresstypekey" varchar(255),
    "address" varchar(255),
    "zipcode" varchar(255),
    "city" varchar(255),
    "state" varchar(255),
    "country" varchar(255),
    "county" varchar(255),
    "direction" varchar(255),
    "old_id" varchar(255),
    "address2" varchar(255),
    PRIMARY KEY ("agencyaddressid")
);

-- Model(s): Agencyaddresstype
CREATE TABLE IF NOT EXISTS "cjams"."agencyaddresstype" (
    "sequencenumber" integer,
    "agencyaddresstypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("agencyaddresstypekey")
);

-- Model(s): Agencyalias
CREATE TABLE IF NOT EXISTS "cjams"."agencyalias" (
    "agencyaliasid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "agencyid" uuid,
    "name" varchar(100),
    "description" varchar(500),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("agencyaliasid")
);

-- Model(s): Agencycategory
CREATE TABLE IF NOT EXISTS "cjams"."agencycategory" (
    "agencycategorykey" varchar(15),
    "description" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "sequencenumber" integer,
    PRIMARY KEY ("agencycategorykey")
);

-- Model(s): Agencyconfig
CREATE TABLE IF NOT EXISTS "cjams"."agencyconfig" (
    "agencyconfigid" uuid DEFAULT gen_random_uuid(),
    "teamtypekey" varchar(50),
    "ismanualrouting" boolean,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("agencyconfigid")
);

-- Model(s): Agencyphonenumbertype
CREATE TABLE IF NOT EXISTS "cjams"."agencyphonenumbertype" (
    "sequencenumber" integer,
    "agencyphonenumbertypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("agencyphonenumbertypekey")
);

-- Model(s): Agencyprogramarea
CREATE TABLE IF NOT EXISTS "cjams"."agencyprogramarea" (
    "agencyprogramareaid" uuid,
    "programname" varchar(50),
    "programkey" varchar(15),
    "effectivedate" timestamp,
    "enddate" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(12),
    PRIMARY KEY ("programkey")
);

-- Model(s): Agencyroletype
CREATE TABLE IF NOT EXISTS "cjams"."agencyroletype" (
    "sequencenumber" integer,
    "agencyroletypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("agencyroletypekey")
);

-- Model(s): Agencyservcassessmenttemplatemap
CREATE TABLE IF NOT EXISTS "cjams"."agencyservcassessmenttemplatemap" (
    "servcassessmenttemplatemapid" uuid,
    "intakeagencyservid" uuid,
    "assessmenttemplateid" uuid,
    "external_templateid" text,
    "description" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer
);

-- Model(s): Agencyservice
CREATE TABLE IF NOT EXISTS "cjams"."agencyservice" (
    "agencyserviceid" uuid DEFAULT gen_random_uuid(),
    "agencyid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "name" varchar(255),
    "shortname" varchar(255),
    "servicetypekey" varchar(255),
    "serviceid" uuid,
    "startdate" timestamp,
    "enddate" timestamp,
    PRIMARY KEY ("agencyserviceid")
);

-- Model(s): Agencystatustype
CREATE TABLE IF NOT EXISTS "cjams"."agencystatustype" (
    "sequencenumber" integer,
    "agencystatustypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("agencystatustypekey")
);

-- Model(s): Agencysubtype
CREATE TABLE IF NOT EXISTS "cjams"."agencysubtype" (
    "sequencenumber" uuid,
    "agencysubtypekey" varchar(50),
    "agencytypekey" varchar(15),
    "activeflag" uuid,
    "datavalue" uuid,
    "editable" uuid,
    "typedescription" varchar(256),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea,
    PRIMARY KEY ("agencysubtypekey")
);

-- Model(s): Agencytype
CREATE TABLE IF NOT EXISTS "cjams"."agencytype" (
    "sequencenumber" integer,
    "agencytypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "agencycategorykey" varchar(15),
    "displayorder" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("agencytypekey")
);

-- Model(s): Alerteventtype
CREATE TABLE IF NOT EXISTS "cjams"."alerteventtype" (
    "sequencenumber" integer,
    "alerteventkey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("alerteventkey")
);

-- Model(s): Alias
CREATE TABLE IF NOT EXISTS "cjams"."alias" (
    "aliasid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "personid" uuid,
    "firstname" varchar(50),
    "lastname" varchar(50),
    "middlename" varchar(512),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "sfxname" varchar(255),
    "prefixtypekey" varchar(255),
    "dcn" varchar(255),
    "ssn" varchar(255),
    "licenseno" varchar(50),
    "akatypetypekey" varchar(500),
    PRIMARY KEY ("aliasid")
);

-- Model(s): Allegation
CREATE TABLE IF NOT EXISTS "cjams"."allegation" (
    "allegationid" uuid DEFAULT gen_random_uuid(),
    "name" varchar(250),
    "self" boolean,
    "rulesetid" uuid,
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "edl" boolean,
    "financial" boolean,
    "workload" integer,
    "intakeservicereqtypeid" uuid,
    "intakeservicereqsubtypeid" uuid,
    "allegationcode" varchar(50),
    "class" varchar(20),
    "status" varchar(20),
    "mcaprequired" boolean,
    "referralreasontype" varchar(30),
    "offensetype" varchar(30),
    "offensecategory" integer,
    "agecutoff" integer,
    "felony" boolean,
    "msdmnr" boolean,
    "voilent" boolean,
    "isenablesextraffic" integer,
    "isvictimrequired" boolean,
    PRIMARY KEY ("allegationid")
);

-- Model(s): Allegationprovidermaltreatment
CREATE TABLE IF NOT EXISTS "cjams"."allegationprovidermaltreatment" (
    "allegationprovidermaltreatmentid" uuid,
    "investigationallegationid" uuid,
    "providermaltreatmenttypekey" varchar(15),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "updatedby" varchar(255),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("providermaltreatmenttypekey")
);

-- Model(s): Allegationstatestatutes
CREATE TABLE IF NOT EXISTS "cjams"."allegationstatestatutes" (
    "allegationstatestatutesid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "allegationid" uuid,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "statestatuteid" uuid,
    "templateid" uuid,
    "sequence" integer,
    PRIMARY KEY ("allegationstatestatutesid")
);

-- Model(s): Amactivity
CREATE TABLE IF NOT EXISTS "cjams"."amactivity" (
    "amactivityid" uuid DEFAULT gen_random_uuid(),
    "name" varchar(100),
    "description" text,
    "activitytypekey" varchar(50),
    "iscontinue" boolean,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "workload" integer,
    PRIMARY KEY ("amactivityid")
);

-- Model(s): Amgoal
CREATE TABLE IF NOT EXISTS "cjams"."amgoal" (
    "amgoalid" uuid DEFAULT gen_random_uuid(),
    "name" varchar(50),
    "description" text,
    "activitytypekey" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    PRIMARY KEY ("amgoalid")
);

-- Model(s): Amgoaldisposition
CREATE TABLE IF NOT EXISTS "cjams"."amgoaldisposition" (
    "amgoaldispositionid" uuid,
    "amgoalstatusid" uuid,
    "activitygoaldispositiontypekey" varchar(15),
    "availabletouser" boolean,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "timestamp" bytea
);

-- Model(s): Amgoalstatus
CREATE TABLE IF NOT EXISTS "cjams"."amgoalstatus" (
    "amgoalstatusid" uuid DEFAULT gen_random_uuid(),
    "activitygoaltypekey" varchar(50),
    "activitygoalstatustypekey" varchar(15),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "timestamp" bytea,
    PRIMARY KEY ("amgoalstatusid")
);

-- Model(s): Ammapping
CREATE TABLE IF NOT EXISTS "cjams"."ammapping" (
    "ammappingid" uuid DEFAULT gen_random_uuid(),
    "amactivityid" uuid,
    "rulesetid" uuid,
    "rulesetsourceid" uuid,
    "name" varchar(100),
    "description" text,
    "activitytypekey" varchar(50),
    "sequence" integer,
    "helptext" text,
    "iseditable" boolean,
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "ondemand" boolean,
    "isreviewactivity" boolean,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "groupsequence" integer,
    "teamtypekey" varchar(50),
    "workload" integer,
    PRIMARY KEY ("ammappingid")
);

-- Model(s): Ammappinggoal
CREATE TABLE IF NOT EXISTS "cjams"."ammappinggoal" (
    "ammappinggoalid" uuid DEFAULT gen_random_uuid(),
    "ammappingid" uuid,
    "amgoalid" uuid,
    "required" boolean,
    "helptext" text,
    "sequence" integer,
    "duedateoffset" integer,
    "activitygoaltypekey" varchar(50),
    "activityprioritytypekey" varchar(50),
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    PRIMARY KEY ("ammappinggoalid")
);

-- Model(s): Ammappingtask
CREATE TABLE IF NOT EXISTS "cjams"."ammappingtask" (
    "ammappingtaskid" uuid DEFAULT gen_random_uuid(),
    "ammappingid" uuid,
    "amtaskid" uuid,
    "required" boolean,
    "helptext" text,
    "sequence" integer,
    "duedateoffset" integer,
    "activitytasktypekey" varchar(50),
    "activityprioritytypekey" varchar(50),
    "objectid" uuid,
    "activeflag" integer,
    "ismandatory" boolean,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "duedatebasetypekey" varchar(15),
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "objecttypekey" varchar(50),
    "intakeservreqtypeid" uuid,
    "servicerequestsubtypeid" uuid,
    "intakeserreqstatustypeid" uuid,
    "intakeservreqinputtypeid" uuid,
    "duedatetype" varchar(30),
    PRIMARY KEY ("ammappingtaskid")
);

-- Model(s): Amtask
CREATE TABLE IF NOT EXISTS "cjams"."amtask" (
    "amtaskid" uuid DEFAULT gen_random_uuid(),
    "name" varchar(256),
    "description" text,
    "activitytypekey" varchar(50),
    "iskinship" integer,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    PRIMARY KEY ("amtaskid")
);

-- Model(s): Ancillaryservices
CREATE TABLE IF NOT EXISTS "cjams"."ancillaryservices" (
    "ancillaryservicesid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    PRIMARY KEY ("ancillaryservicesid")
);

-- Model(s): Announcement
CREATE TABLE IF NOT EXISTS "cjams"."announcement" (
    "announcementid" uuid DEFAULT gen_random_uuid(),
    "details" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "isallusers" boolean,
    PRIMARY KEY ("announcementid")
);

-- Model(s): Apgtpetition
CREATE TABLE IF NOT EXISTS "cjams"."apgtpetition" (
    "apgtpetitionid" uuid DEFAULT gen_random_uuid(),
    "intakeservicerequestpetitionid" uuid,
    "activeflag" smallint,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    PRIMARY KEY ("apgtpetitionid")
);

-- Model(s): Apgtpetitionchildren
CREATE TABLE IF NOT EXISTS "cjams"."apgtpetitionchildren" (
    "apgtpetitionchildrenid" uuid DEFAULT gen_random_uuid(),
    "apgtpetitionid" uuid,
    "interestedpersons" jsonb,
    "intakeservicerequestactorid" uuid,
    "personid" uuid,
    "placementid" uuid,
    "firstcertificationdate" timestamp,
    "disabilitynarrative" text,
    "vabenefits" boolean,
    "vabenefitscomment" text,
    "financialsummary" text,
    "secondcertificationbyactorid" uuid,
    "secondcertificationappointment" timestamp,
    "activeflag" smallint,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    PRIMARY KEY ("apgtpetitionchildrenid")
);

-- Model(s): Appointmenttitletype
CREATE TABLE IF NOT EXISTS "cjams"."appointmenttitletype" (
    "appointmenttitletypeid" uuid,
    "appointmenttitletypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("appointmenttitletypekey")
);

-- Model(s): Areateammemberservicerequest
CREATE TABLE IF NOT EXISTS "cjams"."areateammemberservicerequest" (
    "areateammemberservicerequestid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "teammemberid" uuid,
    "intakeserviceid" uuid,
    "routingstatustypekey" varchar(50),
    "routedby" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "previousloadnumber" bigint,
    "assigmentchangedate" timestamp,
    "note" text,
    PRIMARY KEY ("areateammemberservicerequestid")
);

-- Model(s): Assessment
CREATE TABLE IF NOT EXISTS "cjams"."assessment" (
    "assessmentid" uuid DEFAULT gen_random_uuid(),
    "assessmenttemplateid" uuid,
    "personid" uuid,
    "agencyid" uuid,
    "securityusersid" varchar(50),
    "assessmentstatustypekey" varchar(50),
    "assessmentsubmissiontypekey" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "objectid" uuid,
    "objectname" varchar(100),
    "disposition" text,
    "executerules" boolean,
    "requiredind" boolean,
    "submissionid" varchar(50),
    "submissiondata" json,
    "actualdata" json,
    "score" integer,
    "intakenumber" varchar(50),
    "ischildsafe" boolean,
    "ismigrated" integer,
    "intakeservicerequestactorid" uuid,
    "servicecaseid" uuid,
    PRIMARY KEY ("assessmentid")
);

-- Model(s): Assessmentactor
CREATE TABLE IF NOT EXISTS "cjams"."assessmentactor" (
    "assessmentactorid" uuid DEFAULT gen_random_uuid(),
    "assessmentid" uuid,
    "intakeservicerequestactorid" uuid,
    "issafe" integer,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("assessmentactorid")
);

-- Model(s): Assessmentcomments
CREATE TABLE IF NOT EXISTS "cjams"."assessmentcomments" (
    "assessmentcommentsid" uuid,
    "assessmentid" uuid,
    "comments" varchar(250),
    "status" varchar(15),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp
);

-- Model(s): Assessmentdocumentconfig
CREATE TABLE IF NOT EXISTS "cjams"."assessmentdocumentconfig" (
    "assessmentdocumentconfigid" uuid DEFAULT gen_random_uuid(),
    "assessmenttemplateid" uuid,
    "intakeserviceid" uuid,
    "documentpropertiesid" uuid,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("assessmentdocumentconfigid")
);

-- Model(s): Assessmentscoretype
CREATE TABLE IF NOT EXISTS "cjams"."assessmentscoretype" (
    "sequencenumber" integer,
    "assessmentscoretypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("assessmentscoretypekey")
);

-- Model(s): Assessmentscoringmethod
CREATE TABLE IF NOT EXISTS "cjams"."assessmentscoringmethod" (
    "assessmentscoringmethodid" uuid,
    "scoringmethod" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "timestamp" bytea,
    PRIMARY KEY ("scoringmethod")
);

-- Model(s): Assessmentstatustype
CREATE TABLE IF NOT EXISTS "cjams"."assessmentstatustype" (
    "sequencenumber" integer,
    "assessmentstatustypekey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "old_id" varchar(250),
    "updatedby" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    PRIMARY KEY ("sequencenumber")
);

-- Model(s): Assessmentsubmission
CREATE TABLE IF NOT EXISTS "cjams"."assessmentsubmission" (
    "assessmentsubmissionid" uuid DEFAULT gen_random_uuid(),
    "assessmentid" uuid,
    "submissionid" varchar(50),
    "dataindex" integer,
    "datakey" varchar(250),
    "datavalue" varchar(250),
    "datatype" varchar(50),
    "iscollection" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("assessmentsubmissionid")
);

-- Model(s): Assessmentsubmissiontype
CREATE TABLE IF NOT EXISTS "cjams"."assessmentsubmissiontype" (
    "sequencenumber" integer,
    "assessmentsubmissiontypekey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("sequencenumber")
);

-- Model(s): Assessmenttemplate
CREATE TABLE IF NOT EXISTS "cjams"."assessmenttemplate" (
    "assessmenttemplateid" uuid DEFAULT gen_random_uuid(),
    "name" text,
    "description" text,
    "version" numeric(5,2),
    "titleheadertext" text,
    "assessmenttextpositiontypekey" varchar(50),
    "instructions" text,
    "targetroletypekey" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea,
    "helptext" text,
    "datamappingenabled" boolean,
    "ismandatory" boolean,
    "duedays" integer,
    "enableassessmentscore" boolean,
    "scoringname" varchar(255),
    "calculationmethod" varchar(50),
    "assessmentscoresetupid" uuid,
    "external_templateid" varchar(50),
    "isvisible" boolean,
    PRIMARY KEY ("assessmenttemplateid")
);

-- Model(s): Assessmenttemplatecategory
CREATE TABLE IF NOT EXISTS "cjams"."assessmenttemplatecategory" (
    "assessmenttemplatecategoryid" uuid DEFAULT gen_random_uuid(),
    "category" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea,
    PRIMARY KEY ("assessmenttemplatecategoryid")
);

-- Model(s): Assessmenttemplatecategoryfilter
CREATE TABLE IF NOT EXISTS "cjams"."assessmenttemplatecategoryfilter" (
    "assessmenttemplatecategoryfilterid" uuid DEFAULT gen_random_uuid(),
    "assessmenttemplatecategoryid" uuid,
    "assessmenttemplatesubcategoryid" uuid,
    "assessmenttemplatetargetid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "agencycode" varchar(50),
    "timestamp" bytea,
    PRIMARY KEY ("assessmenttemplatecategoryfilterid")
);

-- Model(s): Assessmenttemplatecategoryfiltermap
CREATE TABLE IF NOT EXISTS "cjams"."assessmenttemplatecategoryfiltermap" (
    "assessmenttemplatecategoryfiltermapid" uuid,
    "assessmenttemplateid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "repeatable" boolean,
    "timestamp" bytea,
    "intakeservicerequesttypeid" uuid,
    "intakeservicerequestsubtypeid" uuid,
    "assessmenttemplatetargetid" uuid,
    "teamtypekey" varchar(255)
);

-- Model(s): Assessmenttemplatescoremapping
CREATE TABLE IF NOT EXISTS "cjams"."assessmenttemplatescoremapping" (
    "assessmenttemplatescoremappingid" uuid DEFAULT gen_random_uuid(),
    "assessmentscoretypekey" varchar(15),
    "scoringmethod" varchar(50),
    "assessmenttemplateid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "timestamp" bytea,
    PRIMARY KEY ("assessmenttemplatescoremappingid")
);

-- Model(s): Assessmenttemplatesubcategory
CREATE TABLE IF NOT EXISTS "cjams"."assessmenttemplatesubcategory" (
    "assessmenttemplatesubcategoryid" uuid DEFAULT gen_random_uuid(),
    "subcategory" varchar(250),
    "activeflag" integer,
    "updatedby" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea,
    PRIMARY KEY ("assessmenttemplatesubcategoryid")
);

-- Model(s): Assessmenttemplatetarget
CREATE TABLE IF NOT EXISTS "cjams"."assessmenttemplatetarget" (
    "assessmenttemplatetargetid" uuid DEFAULT gen_random_uuid(),
    "target" varchar(250),
    "activeflag" integer,
    "updatedby" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea,
    PRIMARY KEY ("assessmenttemplatetargetid")
);

-- Model(s): Assessmenttextpositiontype
CREATE TABLE IF NOT EXISTS "cjams"."assessmenttextpositiontype" (
    "assessmenttextpositiontypekey" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" text,
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    PRIMARY KEY ("assessmenttextpositiontypekey")
);

-- Model(s): Assignedassessment
CREATE TABLE IF NOT EXISTS "cjams"."assignedassessment" (
    "assignedassessmentid" uuid DEFAULT gen_random_uuid(),
    "assessmenttemplateid" uuid,
    "securityusersid" varchar(50),
    "status" varchar(255),
    "intakeserviceid" uuid,
    "intakenumber" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("assignedassessmentid")
);

-- Model(s): Associatedpetitionsconfig
CREATE TABLE IF NOT EXISTS "cjams"."associatedpetitionsconfig" (
    "associatedpetitionsconfigid" uuid DEFAULT gen_random_uuid(),
    "intakenumber" varchar(50),
    "intakeservicerequestpetitionid" uuid,
    "associatedpetitionid" uuid,
    "associatedevalfieldid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    PRIMARY KEY ("associatedpetitionsconfigid")
);

-- Model(s): Attachmentclassificationtype
CREATE TABLE IF NOT EXISTS "cjams"."attachmentclassificationtype" (
    "sequencenumber" integer,
    "attachmentclassificationtypekey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "subcategory" varchar(255),
    PRIMARY KEY ("attachmentclassificationtypekey")
);

-- Model(s): Attachmenttype
CREATE TABLE IF NOT EXISTS "cjams"."attachmenttype" (
    "sequencenumber" integer,
    "attachmenttypekey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("attachmenttypekey")
);

-- Model(s): Attorneyaddress
CREATE TABLE IF NOT EXISTS "cjams"."attorneyaddress" (
    "attorneyaddressid" uuid DEFAULT gen_random_uuid(),
    "attorneyname" varchar(50),
    "addressline1" varchar(50),
    "attorneyphonenumber" varchar(50),
    "attorneyfax" varchar(50),
    "attorneyemail" varchar(50),
    "addressline2" varchar(50),
    "county" varchar(50),
    "statekey" varchar(50),
    "zipcode" numeric(5,2),
    "division" varchar(50),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" varchar(255),
    PRIMARY KEY ("attorneyaddressid")
);

-- Model(s): Auditlog
CREATE TABLE IF NOT EXISTS "cjams"."auditlog" (
    "logid" uuid DEFAULT gen_random_uuid(),
    "logtypekey" varchar(10),
    "intakeserviceid" uuid,
    "servicerequestnumber" varchar(50),
    "ipaddress" varchar(50),
    "referenceid" uuid,
    "description" text,
    "isdelete" boolean,
    "isnew" boolean,
    "isedit" boolean,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "metadata" json,
    "modifieddata" json,
    "objectid" varchar(50),
    "objecttype" varchar(50),
    PRIMARY KEY ("logid")
);

-- Model(s): Auditlogtype
CREATE TABLE IF NOT EXISTS "cjams"."auditlogtype" (
    "logtypeid" uuid DEFAULT gen_random_uuid(),
    "logtypekey" varchar(10),
    "logtype" varchar(30),
    "modulename" varchar(30),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    PRIMARY KEY ("logtypeid")
);

-- Model(s): AwsapiKeys
CREATE TABLE IF NOT EXISTS "cjams"."awsapikeys" (

);

-- Model(s): beaconrealtimedata
CREATE TABLE IF NOT EXISTS "cjams"."beaconrealtimedata" (

);

-- Model(s): beacon
CREATE TABLE IF NOT EXISTS "cjams"."beaconrequestdetails" (
    "beaconrequestdetailsid" uuid,
    "personid" uuid,
    "caseobjecttype" varchar(255),
    "caseobjectid" varchar(250),
    "ssn" varchar(255),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer
);

-- Model(s): Calendardetails
CREATE TABLE IF NOT EXISTS "cjams"."calendardetails" (
    "calendardetailsid" uuid DEFAULT gen_random_uuid(),
    "casenumber" uuid,
    "personid" varchar(50),
    "objectid" varchar(50),
    "objecttype" varchar(50),
    "securityusersid" varchar(50),
    "title" varchar(50),
    "appointmenttype" varchar(50),
    "appointmentdate" timestamp,
    "starttime" varchar(50),
    "endtime" varchar(50),
    "other" varchar(500),
    "isinperson" boolean,
    "attendees" json,
    "appointmentdetails" text,
    "address" varchar(50),
    "eventtimstamp" timestamptz,
    "insertedby" varchar(50),
    "insertedon" timestamptz,
    "updatedby" varchar(50),
    "updatedon" timestamptz,
    "activeflag" varchar(255),
    "locationtype" text,
    PRIMARY KEY ("calendardetailsid")
);

-- Model(s): Caregiveraddresstype
CREATE TABLE IF NOT EXISTS "cjams"."caregiveraddresstype" (
    "sequencenumber" integer,
    "caregiveraddresstypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("caregiveraddresstypekey")
);

-- Model(s): Caregiverphonetype
CREATE TABLE IF NOT EXISTS "cjams"."caregiverphonetype" (
    "sequencenumber" integer,
    "caregiverphonetypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("caregiverphonetypekey")
);

-- Model(s): Caseassignment
CREATE TABLE IF NOT EXISTS "cjams"."caseassignment" (
    "caseassignmentid" uuid,
    "eventidno_fk" uuid,
    "activeflag" integer,
    "fromworkeridno" varchar(50),
    "fromsupervisoridno" varchar(50),
    "fromofficecode" varchar(4),
    "toworkeridno" varchar(50),
    "tosupervisoridno" varchar(50),
    "toofficecode" varchar(4),
    "caseassigncode" varchar(3),
    "objecttypekey" varchar(50),
    "objectid" uuid,
    "responsibilitytypekey" varchar(50),
    "effectivedate" timestamp,
    "effectivetime" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "startdate" timestamp,
    "enddate" timestamp,
    "fromteamid" uuid,
    "toteamid" uuid,
    "remarks" varchar(250),
    "statustypekey" varchar(50),
    "fromldssid" uuid,
    "toldssid" uuid,
    "assignmenttype" varchar(5),
    "fk_id" varchar(12),
    "assigndate" timestamp,
    "isrestricted" integer,
    "assigndescription" varchar(100),
    "summary" varchar(250),
    "isnew" integer,
    "expungementflag" integer,
    "entityopendate" timestamp
);

-- Model(s): Caseassignmentactor
CREATE TABLE IF NOT EXISTS "cjams"."caseassignmentactor" (
    "caseassignmentactorid" uuid DEFAULT gen_random_uuid(),
    "caseassignmentid" uuid,
    "intakeservicerequestactorid" uuid,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("caseassignmentactorid")
);

-- Model(s): Caseaudittrail
CREATE TABLE IF NOT EXISTS "cjams"."caseaudittrail" (

);

-- Model(s): Caseclosureparticipant
CREATE TABLE IF NOT EXISTS "cjams"."caseclosureparticipant" (
    "caseclosureparticipantid" uuid DEFAULT gen_random_uuid(),
    "caseclosuresummaryid" uuid,
    "intakeservicerequestactorid" uuid,
    "ischild" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("caseclosureparticipantid")
);

-- Model(s): Caseclosureservice
CREATE TABLE IF NOT EXISTS "cjams"."caseclosureservice" (
    "caseclosureserviceid" uuid DEFAULT gen_random_uuid(),
    "caseclosuresummaryid" uuid,
    "interventiontypekey" varchar(15),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("caseclosureserviceid")
);

-- Model(s): Caseclosuresummary
CREATE TABLE IF NOT EXISTS "cjams"."caseclosuresummary" (
    "caseclosuresummaryid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "reason" varchar(200),
    "referralreason" varchar(200),
    "riskissues" varchar(200),
    "recommendation" varchar(200),
    "interventionissues" varchar(200),
    "clientrefrdservices" varchar(200),
    "closuretypekey" varchar(15),
    "closuresubtypekey" varchar(15),
    "notes" varchar(250),
    "closuredate" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("caseclosuresummaryid")
);

-- Model(s): CaseEvaluation
CREATE TABLE IF NOT EXISTS "cjams"."caseevaluation" (
    "caseevaluationid" uuid,
    "caseid" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp
);

-- Model(s): CaseEvaluationService
CREATE TABLE IF NOT EXISTS "cjams"."caseevaluationservice" (
    "caseevaluationserviceid" uuid,
    "caseevaluationid" uuid,
    "servicelogid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "personid" uuid,
    "servicetypekey" varchar(50),
    "startdate" timestamp,
    "enddate" timestamp,
    "datavalidflag" varchar(255),
    "clientmergeid" uuid
);

-- Model(s): Caseplan
CREATE TABLE IF NOT EXISTS "cjams"."caseplan" (

);

-- Model(s): Caseplan1
CREATE TABLE IF NOT EXISTS "cjams"."caseplan1" (
    "caseplan1id" uuid,
    "actorid" uuid,
    "safetyassessmentid" uuid,
    "riskassessmentid" uuid,
    "insertedby" uuid,
    "insertedon" timestamp,
    "updatedby" uuid,
    "updatedon" timestamp,
    "activeflag" integer,
    "old_id" varchar(50),
    "personid" uuid,
    "caseplan1date" timestamp,
    "timeframetypekey" varchar(5),
    "statustypekey" varchar(5),
    "nextduedate" timestamp,
    "placement" varchar(2000),
    "familyhistory" varchar(2000),
    "childdesc" varchar(2000),
    "caseid" uuid,
    "datavalidflag" integer,
    "clientmergeid" uuid,
    "fk_id" varchar(10)
);

-- Model(s): CaseplanCaseeValuationClients
CREATE TABLE IF NOT EXISTS "cjams"."caseplancaseevaluationclients" (
    "caseevaluationclientid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "personid" uuid
);

-- Model(s): Caseplanlegacy
CREATE TABLE IF NOT EXISTS "cjams"."caseplanlegacy" (

);

-- Model(s): Casereview
CREATE TABLE IF NOT EXISTS "cjams"."casereview" (
    "casereviewid" uuid,
    "reviewtypekey" varchar(50),
    "reviewdate" timestamptz,
    "reviewtime" timestamptz,
    "nextreviewdate" timestamptz,
    "panelworkerid" integer,
    "panelsupervisorid" integer,
    "otherpanelmembers" varchar(500),
    "caseid" uuid,
    "otherparticipants" varchar(500),
    "continuedneedtypekey" varchar(50),
    "carequalitytypekey" varchar(50),
    "permanencyplantypekey" varchar(50),
    "recommendations" varchar(500),
    "crbrecmdtypekey" varchar(50),
    "crbresponsetypekey" varchar(50),
    "comments" varchar(500),
    "insertedby" varchar(50),
    "insertedon" timestamptz,
    "updatedby" varchar(50),
    "updatedon" timestamptz,
    "activeflag" varchar(255),
    "placementplantypekey" varchar(50),
    "waiverreuinontypekey" varchar(50),
    "tprtypekey" varchar(50),
    "safetyassessmenttypekey" varchar(50),
    "adequacyprogresstypekey" varchar(50),
    "datavalidflag" integer,
    "clientmergeid" uuid,
    "old_id" varchar(50),
    "personid" uuid
);

-- Model(s): Checklist
CREATE TABLE IF NOT EXISTS "cjams"."checklist" (
    "checklistid" uuid DEFAULT gen_random_uuid(),
    "checklistname" varchar(256),
    "description" text,
    "checklisttypekey" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("checklistid")
);

-- Model(s): Childcharacteristictype
CREATE TABLE IF NOT EXISTS "cjams"."childcharacteristictype" (
    "childcharacteristictypeid" uuid,
    "childcharacteristictypekey" varchar(50),
    "childcharacteristicdescription" varchar(250),
    "activeflag" integer,
    "effectivedate" uuid,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    PRIMARY KEY ("childcharacteristictypekey")
);

-- Model(s): Cinapetition
CREATE TABLE IF NOT EXISTS "cjams"."cinapetition" (
    "cinapetitionid" uuid,
    "intakeservicerequestpetitionid" uuid,
    "insertedby" uuid,
    "insertedon" timestamp,
    "updatedby" uuid,
    "updatedon" timestamp,
    "activeflag" integer,
    "isnew" boolean,
    "isemergency" boolean,
    "policecomplaintnumber" varchar(20),
    "color" varchar(20),
    "legalservicefilenumber" varchar(20),
    "childname" uuid,
    "isfosterhome" boolean,
    "isgrouphome" boolean,
    "fosterhomename" varchar(30),
    "grouphomename" varchar(30),
    "kinhomename" varchar(30),
    "kinaddress" varchar(50),
    "kinrelation" varchar(50),
    "personwithlegalcustody" varchar(100),
    "personphysicalcustody" varchar(100),
    "legalcustodianrelationship" varchar(100),
    "parent1name" varchar(100),
    "parent1address" varchar(300),
    "isparent1notifiedbyacdss" boolean,
    "reasonforparent1notnotified" varchar(300),
    "parent2name" varchar(100),
    "parent2address" varchar(300),
    "isparent2notifiedbyacdss" boolean,
    "reasonforparent2notnotified" varchar(300),
    "caseworker" varchar(40),
    "supervisorname" varchar(40),
    "daterequestcompleted" timestamp,
    "childinsheltercareon" timestamp,
    "dateofemergencysheltercare" timestamp,
    "ispreviousjuvenilecourt" integer,
    "ischildorsibling" boolean,
    "physicalabusenature" varchar(50),
    "physicalabusemedicalexam" varchar(50),
    "physicalabusedocumentation" varchar(50),
    "physicalabusefailedtoprotect" varchar(50),
    "physicalabusedisclosedto" varchar(50),
    "sexualabusenature" varchar(50),
    "sexualabusemedicalexam" varchar(50),
    "sexualabusedocumentation" varchar(50),
    "sexualabusefailedtoprotect" varchar(50),
    "sexualabusedisclosedto" varchar(50),
    "neglectabusenature" varchar(50),
    "legalstatusreason" varchar(50),
    "childrelationshipwithparentsreason" varchar(50),
    "neglectabusemedicalexam" varchar(50),
    "neglectabusedocumentation" varchar(50),
    "neglectabusefailedtoprotect" varchar(50),
    "neglectabusedisclosedto" varchar(50),
    "within12months" integer,
    "severechronicdisability" integer,
    "mentalhealthdisorder" integer,
    "physicalissues" varchar(100),
    "bornsubstanceexposed" integer,
    "currentlocation" varchar(50),
    "cinachildmedical" boolean,
    "psychological" boolean,
    "disability" boolean,
    "childrelationshipwithparents" varchar(50),
    "legalstatus" varchar(50),
    "homeconditiondescription" varchar(100),
    "inadequatehousing" integer,
    "isparentcannotidentified" boolean,
    "parentcannotidentified" varchar(100),
    "parentcannotidentifiedreason" varchar(100),
    "isparentlocationunknown" boolean,
    "parentlocationunknown" varchar(100),
    "parentlocationunknownreason" varchar(100),
    "isdepartmentattempttolocateparents" boolean,
    "departmentattempttolocateparents" varchar(100),
    "isparentphysicalmentalissues" boolean,
    "parentphysicalmentalissues" varchar(100),
    "isparentincarcerated" boolean,
    "parentincarcerated" varchar(100),
    "isparenteconomicstatus" boolean,
    "parenteconomicstatus" varchar(100),
    "isparentnotcareforchild" boolean,
    "parentnotcareforchild" varchar(100),
    "isparentsubstance" boolean,
    "parentsubstance" varchar(100),
    "isparentadmitted" boolean,
    "parentadmitted" varchar(100),
    "isparentrefused" boolean,
    "parentrefused" varchar(100),
    "isparentnotcompletetreatment" boolean,
    "parentnotcompletetreatment" varchar(100),
    "isparentuncooperative" boolean,
    "parentuncooperative" varchar(100),
    "isparentsafetyplan" boolean,
    "parentsafetyplan" varchar(100),
    "parentcps" varchar(100),
    "parentchildwelfareservices" varchar(100),
    "parentcriminal" varchar(100),
    "parentcina" varchar(100),
    "activechildwelfare" integer,
    "effortsforpreventremoval" varchar(100),
    "ismonitoredchildsafety" boolean,
    "monitoredchildsafety" varchar(100),
    "isofferedchildwelfareservices" boolean,
    "offeredchildwelfareservices" varchar(100),
    "ismedicalservices" boolean,
    "medicalservices" varchar(100),
    "isparentingclasses" boolean,
    "parentingclasses" varchar(100),
    "isdisorderscreening" boolean,
    "disorderscreening" varchar(100),
    "ismentalhealth" boolean,
    "mentalhealth" varchar(100),
    "isexploredrelative" boolean,
    "exploredrelative" varchar(100),
    "isotherreasons" boolean,
    "otherreasons" varchar(100),
    "werereasonableeffortsmade" boolean,
    "reasonableeffortsmade" varchar(100),
    "wasfamilymeetingheld" boolean,
    "familymeetingdate" timestamp,
    "familymeetingparticipants" varchar(100),
    "familymeetingoutcome" varchar(100),
    "dateofremoval" timestamp,
    "timeofremoval" varchar(50),
    "typeofplacement" varchar(100),
    "otherinformation" varchar(100),
    "isphotoinformationexists" boolean,
    "whohasevidence" varchar(100),
    "typeofrecord" varchar(50),
    "isparent1notified" boolean,
    "isparent2notified" boolean,
    "caseworkerphonenumber" varchar(15),
    "supervisorphonenumber" varchar(15),
    "personwithlegalcustodyname" varchar(50),
    "personphysicalcustodyname" varchar(50),
    "nameofthechild" varchar(50),
    "childdob" varchar(20),
    "childrace" varchar(20),
    "childgender" varchar(20),
    "iskinhome" boolean
);

-- Model(s): Cinasibling
CREATE TABLE IF NOT EXISTS "cjams"."cinasibling" (
    "cinasiblingid" uuid,
    "intakeservicerequestpetitionid" uuid,
    "cinapetitionid" uuid,
    "insertedby" uuid,
    "insertedon" timestamp,
    "updatedby" uuid,
    "updatedon" timestamp,
    "activeflag" integer,
    "siblingname" varchar(50),
    "issibinginchildcare" boolean,
    "whysiblinginchildcare" varchar(100),
    "isabuseneglect" boolean,
    "isother" boolean,
    "otherreason" varchar(100),
    "siblingcps" varchar(100),
    "siblingchildwelfareservices" varchar(100),
    "sibingcina" varchar(100),
    "siblingrelationshipstatus" varchar(100),
    "narrative" text
);

-- Model(s): Cinasubpoenad
CREATE TABLE IF NOT EXISTS "cjams"."cinasubpoenad" (
    "cinasubpoenadid" uuid,
    "intakeservicerequestpetitionid" uuid,
    "cinapetitionid" uuid,
    "insertedby" uuid,
    "insertedon" timestamp,
    "updatedby" uuid,
    "updatedon" timestamp,
    "activeflag" integer,
    "institution" varchar(100),
    "custodianname" varchar(50),
    "typeofrecord" varchar(50),
    "address" varchar(100),
    "zipcode" varchar(20),
    "personto" varchar(50),
    "filedetails" varchar(100),
    "isreleasenecessary" boolean,
    "isitinfile" boolean
);

-- Model(s): City
CREATE TABLE IF NOT EXISTS "cjams"."city" (
    "cinasiblingid" varchar(100),
    "town" varchar(100),
    "amount" integer,
    "insertedby" uuid,
    "insertedon" timestamp,
    "updatedby" uuid,
    "updatedon" timestamp,
    "activeflag" integer,
    "old_id" varchar(50)
);

-- Model(s): Clientunder5yearsinfo
CREATE TABLE IF NOT EXISTS "cjams"."clientunder5yearsinfo" (
    "clientunder5yearsinfoid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "providedbyclientid" integer,
    "providedbycollateralid" integer,
    "infoclienttypekey" varchar(50),
    "prenatalcaretypekey" varchar(50),
    "deliverytypekey" varchar(50),
    "deliverytypetx" varchar(500),
    "deliverycomplicationnotes" varchar(500),
    "u5notes" varchar(500),
    "providerid" uuid,
    "insertedon" timestamp,
    "insertedby" varchar(50),
    "updatedon" timestamp,
    "updatedby" varchar(50),
    "activeflag" integer,
    "hospitalname" varchar(50),
    "addresstypekey" varchar(100),
    "formattypekey" varchar(100),
    "streetnumber" integer,
    "boxnumber" integer,
    "predirtypekey" varchar(50),
    "streetname" varchar(100),
    "streetsuffixtypekey" varchar(50),
    "postdirtypekey" varchar(50),
    "unittypekey" varchar(50),
    "unitnumbertx" varchar(100),
    "cityname" varchar(100),
    "countytypekey" varchar(50),
    "statetypekey" varchar(50),
    "zip5no" numeric(5,0),
    "zip4no" numeric(4,0),
    "directionnotes" varchar(500),
    "foreignnotes" varchar(500),
    "workphone" varchar(10),
    "workphoneextn" varchar(10),
    "homephone" varchar(50),
    "pager" varchar(200),
    "email" varchar(100),
    "fax" varchar(50),
    "mobile" varchar(50),
    "url" varchar(100),
    "othercontacts" varchar(50),
    "foreignstatetx" varchar(50),
    "country" varchar(50),
    "postalcode" varchar(50),
    "street" varchar(50),
    "providedby" varchar(300),
    "providerbyrelationtypekey" varchar(50),
    "expungementflag" integer,
    "datavalidflag" integer,
    "clientmergeid" uuid,
    "old_id" varchar(50),
    PRIMARY KEY ("clientunder5yearsinfoid")
);

-- Model(s): Closingcodetype
CREATE TABLE IF NOT EXISTS "cjams"."closingcodetype" (
    "closingcodetypeid" uuid,
    "closingcodetypekey" varchar(15),
    "description" varchar(100),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("closingcodetypekey")
);

-- Model(s): Closuresubtype
CREATE TABLE IF NOT EXISTS "cjams"."closuresubtype" (
    "closuresubtypeid" uuid,
    "closuresubtypekey" varchar(50),
    "closuretypekey" varchar(50),
    "typedescription" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50)
);

-- Model(s): Closuretype
CREATE TABLE IF NOT EXISTS "cjams"."closuretype" (
    "closuretypeid" uuid,
    "closuretypekey" varchar(50),
    "typedescription" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("closuretypekey")
);

-- Model(s): Collateral
CREATE TABLE IF NOT EXISTS "cjams"."collateral" (
    "collateralid" uuid DEFAULT gen_random_uuid(),
    "referralid" uuid,
    "caseid" uuid,
    "prefixtypekey" varchar(255),
    "firstname" varchar(255),
    "middlename" varchar(255),
    "lastname" varchar(255),
    "suffixtypekey" varchar(255),
    "primaryracetypekey" varchar(255),
    "relationshiptypekey" varchar(255),
    "testifyflag" integer,
    "attestableinfo" varchar(255),
    "familyknowledge" varchar(255),
    "comments" varchar(255),
    "workphone" varchar(255),
    "workextn" varchar(255),
    "homephone" varchar(255),
    "pager" varchar(255),
    "email" varchar(255),
    "fax" varchar(255),
    "mobile" varchar(255),
    "url" varchar(255),
    "othercontacts" varchar(255),
    "clientnotes" varchar(255),
    "legalclientid" integer,
    "expungementflag" integer,
    "datavalidflag" integer,
    "clientmergeid" uuid,
    "agencyname" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(255),
    "datenotified" timestamp,
    "dob" timestamp,
    "ssn" numeric(5,2),
    "intakenumber" varchar(255),
    "title" varchar(255),
    "objecttype" varchar(255),
    PRIMARY KEY ("collateralid")
);

-- Model(s): Collateraladdress
CREATE TABLE IF NOT EXISTS "cjams"."collateraladdress" (
    "collateraladdressid" uuid DEFAULT gen_random_uuid(),
    "collateralid" uuid,
    "addresstypekey" varchar(255),
    "streetnumber" integer,
    "boxnumber" integer,
    "formattypekey" varchar(255),
    "predirtypekey" varchar(255),
    "address1" varchar(255),
    "streetsuffixtypekey" varchar(255),
    "postdirtypekey" varchar(255),
    "unittypekey" varchar(255),
    "unitnumbertx" varchar(255),
    "cityname" varchar(255),
    "countytypekey" varchar(255),
    "statetypekey" varchar(255),
    "zip5no" integer,
    "zip4no" integer,
    "direction" varchar(255),
    "foreignaddress" varchar(255),
    "foreignstate" varchar(255),
    "country" varchar(255),
    "postalcode" varchar(255),
    "defaultflag" integer,
    "startdate" timestamp,
    "enddate" timestamp,
    "address2" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(255),
    PRIMARY KEY ("collateraladdressid")
);

-- Model(s): Collateralroleconfig
CREATE TABLE IF NOT EXISTS "cjams"."collateralroleconfig" (
    "collateralroleconfigid" uuid DEFAULT gen_random_uuid(),
    "collateralid" uuid,
    "actortypekey" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(255),
    PRIMARY KEY ("collateralroleconfigid")
);

-- Model(s): Complaintstatustype
CREATE TABLE IF NOT EXISTS "cjams"."complaintstatustype" (
    "complaintstatustypeid" uuid,
    "complaintstatustypekey" varchar(15),
    "description" varchar(100),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp
);

-- Model(s): Conditiontype
CREATE TABLE IF NOT EXISTS "cjams"."conditiontype" (
    "conditiontypeid" uuid,
    "conditiontypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("conditiontypekey")
);

-- Model(s): Configurablelinks
CREATE TABLE IF NOT EXISTS "cjams"."configurablelinks" (
    "configurablelinksid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "name" varchar(256),
    "links" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    PRIMARY KEY ("configurablelinksid")
);

-- Model(s): Configurationsetting
CREATE TABLE IF NOT EXISTS "cjams"."configurationsetting" (
    "configurationsettingid" uuid DEFAULT gen_random_uuid(),
    "category" varchar(50),
    "name" varchar(50),
    "value" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "timestamp" bytea,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    PRIMARY KEY ("configurationsettingid")
);

-- Model(s): Consultreviewusertype
CREATE TABLE IF NOT EXISTS "cjams"."consultreviewusertype" (
    "consultreviewusertypeid" uuid DEFAULT gen_random_uuid(),
    "consultreviewusertypekey" varchar(100),
    "description" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("consultreviewusertypeid")
);

-- Model(s): Contactparticipant
CREATE TABLE IF NOT EXISTS "cjams"."contactparticipant" (
    "contactparticipantid" uuid DEFAULT gen_random_uuid(),
    "progressnoteid" uuid,
    "participanttypekey" varchar(15),
    "intakeservicerequestactorid" uuid,
    "participantid" uuid,
    "firstname" varchar(50),
    "lastname" varchar(50),
    "address1" varchar(100),
    "address2" varchar(100),
    "city" varchar(32),
    "state" varchar(32),
    "zipcode" varchar(32),
    "email" varchar(32),
    "phonenumber" varchar(32),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "old_id" varchar(25),
    PRIMARY KEY ("contactparticipantid")
);

-- Model(s): Contactroletype
CREATE TABLE IF NOT EXISTS "cjams"."contactroletype" (
    "sequencenumber" integer,
    "contactroletypekey" varchar(20),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("contactroletypekey")
);

-- Model(s): Contacttrialvisit
CREATE TABLE IF NOT EXISTS "cjams"."contacttrialvisit" (
    "contacttrialvisitid" uuid DEFAULT gen_random_uuid(),
    "progressnoteid" uuid,
    "issuedesc" varchar(500),
    "safetydesc" varchar(500),
    "services_childdesc" varchar(500),
    "services_parentdesc" varchar(500),
    "permanencystepdesc" varchar(500),
    "placementdesc" varchar(500),
    "educationdesc" varchar(500),
    "healthdesc" varchar(500),
    "socialareadesc" varchar(500),
    "financialliteracydesc" varchar(500),
    "familyplanningdesc" varchar(500),
    "skillissuedesc" varchar(500),
    "transitionplandesc" varchar(500),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("contacttrialvisitid")
);

-- Model(s): County
CREATE TABLE IF NOT EXISTS "cjams"."county" (
    "countyid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "binticountyname" varchar(100),
    "countyname" varchar(100),
    "regionid" uuid,
    "statecountycode" varchar(100),
    "fipscode" integer,
    "oldcountyid" integer,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "expirationdate" timestamp,
    "effectivedate" timestamp,
    "longitude" real,
    "latitude" real,
    "state" varchar(50),
    "apsregion" integer,
    "ltcregion" integer,
    "zipcode" integer,
    "city" varchar(50),
    "locationcode" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "countycode" varchar(10),
    PRIMARY KEY ("countyid")
);

-- Model(s): County_fcrate
CREATE TABLE IF NOT EXISTS "cjams"."county_fcrate" (
    "county_id" uuid,
    "stg_rate_id" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp
);

-- Model(s): Countyareateammember
CREATE TABLE IF NOT EXISTS "cjams"."countyareateammember" (
    "countyareateammemberid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "countyid" uuid,
    "teammemberid" uuid,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedon" timestamp,
    "updatedon" timestamp,
    PRIMARY KEY ("countyareateammemberid")
);

-- Model(s): Courtactionallegationconfig
CREATE TABLE IF NOT EXISTS "cjams"."courtactionallegationconfig" (
    "courtactionallegationconfigid" uuid,
    "intakeservicerequestcourtactionid" uuid,
    "allegationid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "expirationdate" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    "intakeservicerequestevaluationconfigid" uuid,
    "adjudicateddecisiontypekey" varchar(50)
);

-- Model(s): Courtactiontype
CREATE TABLE IF NOT EXISTS "cjams"."courtactiontype" (
    "courtactiontypeid" uuid,
    "hearingtypekey" varchar(50),
    "courtactiontypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp
);

-- Model(s): Courtnumbers
CREATE TABLE IF NOT EXISTS "cjams"."courtnumbers" (
    "courtnumberid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "courtcaseno" varchar(50),
    "startdate" timestamp,
    "enddate" timestamp,
    "orderdate" timestamp,
    "courtorderdetails" varchar(5000),
    "insertedon" timestamp,
    "insertedby" varchar(50),
    "updatedon" timestamp,
    "updatedby" varchar(50),
    "activeflag" integer,
    "caseid" uuid,
    "datavalidflag" integer,
    "clientmergeid" uuid,
    "old_id" varchar(50),
    PRIMARY KEY ("courtnumberid")
);

-- Model(s): Courtordertype
CREATE TABLE IF NOT EXISTS "cjams"."courtordertype" (
    "courtordertypeid" uuid,
    "courtordertypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("courtordertypekey")
);

-- Model(s): Cpsresponsetimeractions
CREATE TABLE IF NOT EXISTS "cjams"."cpsresponsetimeractions" (
    "cpsresponsetimeractionsid" uuid DEFAULT gen_random_uuid(),
    "insertedon" timestamp,
    "insertedby" varchar(50),
    "updatedon" timestamp,
    "updatedby" varchar(50),
    "activeflag" integer,
    PRIMARY KEY ("cpsresponsetimeractionsid")
);

-- Model(s): Dentalspecialtytype
CREATE TABLE IF NOT EXISTS "cjams"."dentalspecialtytype" (
    "dentalspecialtytypeid" uuid,
    "dentalspecialtytypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp
);

-- Model(s): Dispositioncode
CREATE TABLE IF NOT EXISTS "cjams"."dispositioncode" (
    "dispositioncodeid" uuid DEFAULT gen_random_uuid(),
    "intakeservreqtypeid" uuid,
    "dispositioncode" varchar(15),
    "description" text,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "sequencenumber" integer,
    PRIMARY KEY ("dispositioncodeid")
);

-- Model(s): Documentattachment
CREATE TABLE IF NOT EXISTS "cjams"."documentattachment" (
    "documentattachmentid" uuid,
    "documentpropertiesid" uuid,
    "attachmenttypekey" varchar(50),
    "attachmentclassificationtypekey" varchar(50),
    "attachmentclassificationsubtypekey" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "timestamp" bytea,
    "attachmentid" varchar(255),
    "attachmentdate" timestamp,
    "sourceauthor" varchar(260),
    "sourceposition" varchar(260),
    "sourceaddress" varchar(260),
    "sourcephonenumber" varchar(260),
    "attachmentsubject" varchar(260),
    "attachmentpurpose" text,
    "acquisitionmethod" text,
    "locationoforiginal" text,
    "note" text,
    "activeflag" integer,
    "old_id" varchar(255),
    "expirationdate" timestamp,
    "assessmenttemplateid" uuid
);

-- Model(s): Documentproperties
CREATE TABLE IF NOT EXISTS "cjams"."documentproperties" (
    "documentpropertiesid" uuid DEFAULT gen_random_uuid(),
    "objecttypekey" varchar(50),
    "objectid" uuid,
    "documenttypekey" varchar(15),
    "documentdate" timestamp,
    "actualdocumentdate" timestamp,
    "clientid" uuid,
    "servicerequestid" uuid,
    "servicecaseid" uuid,
    "thirdpartysourceid" varchar(260),
    "filename" varchar(260),
    "originalfilename" varchar(260),
    "tag" varchar(150),
    "title" varchar(100),
    "description" varchar(150),
    "other" varchar(150),
    "mime" varchar(500),
    "meta" varchar(150),
    "encoding" varchar(50),
    "numberofbytes" integer,
    "intakenumber" varchar(255),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" integer,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "rootobjectid" uuid,
    "rootobjecttypekey" varchar(50),
    "additionalobjectid" varchar(50),
    "additionalobjecttype" varchar(50),
    "uploadstatus" varchar(50),
    "finalstatus" varchar(50),
    "filesize" varchar(50),
    "s3bucketpathname" varchar(5000),
    "ecmsdocumentid" varchar(255),
    PRIMARY KEY ("documentpropertiesid")
);

-- Model(s): Documenttemplate
CREATE TABLE IF NOT EXISTS "cjams"."documenttemplate" (
    "documenttemplateid" uuid,
    "documenttemplatekey" varchar(50),
    "documentname" varchar(50),
    "s3bucketpathname" varchar(5000),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("documenttemplatekey")
);

-- Model(s): Documenttype
CREATE TABLE IF NOT EXISTS "cjams"."documenttype" (
    "sequencenumber" integer,
    "documenttypekey" varchar(255),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(255),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("sequencenumber")
);

-- Model(s): Educationtype
CREATE TABLE IF NOT EXISTS "cjams"."educationtype" (
    "educationtypeid" uuid,
    "educationtypekey" varchar(15),
    "typedescription" varchar(250),
    "activeflag" integer,
    "displayorder" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "isspecialeducation" boolean,
    PRIMARY KEY ("educationtypekey")
);

-- Model(s): Emergencycontactperson
CREATE TABLE IF NOT EXISTS "cjams"."emergencycontactperson" (
    "emergencycontactpersonid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "contactpersonid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(255),
    PRIMARY KEY ("emergencycontactpersonid")
);

-- Model(s): Employeetype
CREATE TABLE IF NOT EXISTS "cjams"."employeetype" (
    "activeflag" integer,
    "datavalue" integer,
    "effectivedate" timestamp,
    "employeetypeid" uuid DEFAULT gen_random_uuid(),
    "employeetypename" varchar(50),
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "sequencenumber" integer,
    PRIMARY KEY ("employeetypeid")
);

-- Model(s): Equipment
CREATE TABLE IF NOT EXISTS "cjams"."equipment" (
    "equipmentid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "equipmenttypekey" varchar(15),
    "description" varchar(255),
    "manufacturer" varchar(255),
    "locationcode" varchar(255),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "model" varchar(255),
    "serialnumber" varchar(255),
    "whitetagnumber" varchar(255),
    "yellowtagnumber" varchar(255),
    "sutnumber" varchar(50),
    "roomnumber" varchar(255),
    "comments" varchar(255),
    "primarymachine" boolean,
    "found" boolean,
    "notfound" boolean,
    "transfer" boolean,
    "upforreplacement" boolean,
    "disposed" boolean,
    "dh60date" timestamp,
    "unit" varchar(255),
    PRIMARY KEY ("equipmentid")
);

-- Model(s): Equipmenttype
CREATE TABLE IF NOT EXISTS "cjams"."equipmenttype" (
    "sequencenumber" integer,
    "equipmenttypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("equipmenttypekey")
);

-- Model(s): Ethnicgrouptype
CREATE TABLE IF NOT EXISTS "cjams"."ethnicgrouptype" (
    "sequencenumber" integer,
    "ethnicgrouptypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("ethnicgrouptypekey")
);

-- Model(s): Evaluationdocument
CREATE TABLE IF NOT EXISTS "cjams"."evaluationdocument" (
    "evaluationdocumentid" uuid DEFAULT gen_random_uuid(),
    "documenttemplatekey" varchar(50),
    "intakeservicerequestevaluationid" uuid,
    "intakenumber" varchar(50),
    "intakeserviceid" uuid,
    "versionno" integer,
    "documentpath" varchar(5000),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("evaluationdocumentid")
);

-- Model(s): Evaluationsource
CREATE TABLE IF NOT EXISTS "cjams"."evaluationsource" (
    "evaluationsourceid" uuid DEFAULT gen_random_uuid(),
    "evaluationsourceagencykey" varchar(25),
    "evaluationsourcekey" varchar(25),
    "title" varchar(50),
    "badgeno" varchar(10),
    "firstname" varchar(50),
    "lastname" varchar(50),
    "streetno" varchar(10),
    "street1" varchar(100),
    "street2" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("evaluationsourceid")
);

-- Model(s): Evaluationsourceagency
CREATE TABLE IF NOT EXISTS "cjams"."evaluationsourceagency" (
    "evaluationsourceagencyid" uuid DEFAULT gen_random_uuid(),
    "evaluationsourcetypekey" varchar(25),
    "evaluationsourceagencykey" varchar(25),
    "description" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("evaluationsourceagencyid")
);

-- Model(s): Evaluationsourcetype
CREATE TABLE IF NOT EXISTS "cjams"."evaluationsourcetype" (
    "evaluationsourcetypeid" uuid DEFAULT gen_random_uuid(),
    "evaluationsourcetypekey" varchar(25),
    "description" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("evaluationsourcetypeid")
);

-- Model(s): Exitreasontype
CREATE TABLE IF NOT EXISTS "cjams"."exitreasontype" (
    "exitreasontypeid" uuid,
    "exitreasontypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "displayorder" bigint,
    "old_id" varchar(50),
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("exitreasontypekey")
);

-- Model(s): Expungement
CREATE TABLE IF NOT EXISTS "cjams"."expungement" (
    "expungementid" uuid DEFAULT gen_random_uuid(),
    "investigationfindingid" uuid,
    "isunsubstansiated" boolean,
    "isindicated" boolean,
    "isremovemaltreator" boolean,
    "donotexpunge" boolean,
    "manualexpunge" boolean,
    "unsubstansiateddate" timestamp,
    "indicateddate" timestamp,
    "removemaltreatordate" timestamp,
    "resultoflawenforcement" varchar(1000),
    "investigationnarrative" varchar(1000),
    "investigationfinding" varchar(50),
    "appealfinding" varchar(50),
    "finalfinding" varchar(50),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" integer,
    "maltreatmentid" uuid,
    "isremoverofindings" boolean,
    "reason" varchar(1000),
    "justification" varchar(1000),
    PRIMARY KEY ("expungementid")
);

-- Model(s): Commonapi
CREATE TABLE IF NOT EXISTS "cjams"."externalapilogs" (

);

-- Model(s): Familyinvolvementmeeting
CREATE TABLE IF NOT EXISTS "cjams"."familyinvolvementmeeting" (
    "familyinvolvementmeetingid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "meetingdate" timestamp,
    "meetingtypekey" varchar(50),
    "persontype" varchar(20),
    "personname" varchar(150),
    "meetingdescription" varchar(500),
    "meetingcomments" text,
    "isfollowupmeeting" integer,
    "parentmeetingid" uuid,
    "iscompleted" integer,
    "activeflag" integer,
    "effectivedate" timestamp,
    "updatedby" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "old_id" varchar(25),
    PRIMARY KEY ("familyinvolvementmeetingid")
);

-- Model(s): Familyinvolvementmeetingactor
CREATE TABLE IF NOT EXISTS "cjams"."familyinvolvementmeetingactor" (
    "familyinvolvementmeetingactorid" uuid DEFAULT gen_random_uuid(),
    "familyinvolvementmeetingid" uuid,
    "intakeservicerequestactorid" uuid,
    "personid" uuid,
    "isinvited" integer,
    "isattended" integer,
    "isaccpted" integer,
    "signurl" varchar(300),
    "activeflag" integer,
    "effectivedate" timestamp,
    "updatedby" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "old_id" varchar(25),
    PRIMARY KEY ("familyinvolvementmeetingactorid")
);

-- Model(s): Familymeetingsubtype
CREATE TABLE IF NOT EXISTS "cjams"."familymeetingsubtype" (
    "familymeetingsubtypeid" uuid,
    "familymeetingsubtypekey" varchar(15),
    "familymeetingtypekey" varchar(15),
    "typedescription" varchar(50),
    "displayorder" integer,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp
);

-- Model(s): Familymeetingtype
CREATE TABLE IF NOT EXISTS "cjams"."familymeetingtype" (
    "familymeetingtypeid" uuid,
    "familymeetingtypekey" varchar(15),
    "typedescription" varchar(50),
    "displayorder" integer,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    PRIMARY KEY ("familymeetingtypekey")
);

-- Model(s): Fileoutput
CREATE TABLE IF NOT EXISTS "cjams"."fileoutput" (

);

-- Model(s): Findingtype
CREATE TABLE IF NOT EXISTS "cjams"."findingtype" (
    "findingtypeid" uuid,
    "findingtypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("findingtypekey")
);

-- Model(s): Focuspersoncasestatus
CREATE TABLE IF NOT EXISTS "cjams"."focuspersoncasestatus" (
    "focuspersoncasestatusid" uuid,
    "personid" uuid,
    "intakeserviceid" uuid,
    "intakenumber" varchar(50),
    "focuspersonstatustypekey" varchar(15),
    "status" varchar(15),
    "startdate" timestamp,
    "enddate" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "opennotes" text,
    "closenotes" text,
    PRIMARY KEY ("focuspersonstatustypekey")
);

-- Model(s): Folderreasontype
CREATE TABLE IF NOT EXISTS "cjams"."folderreasontype" (
    "folderreasontypeid" uuid,
    "folderreasontypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("folderreasontypekey")
);

-- Model(s): Foldertype
CREATE TABLE IF NOT EXISTS "cjams"."foldertype" (
    "foldertypeid" uuid,
    "foldertypekey" varchar(50),
    "description" varchar(250),
    "s3bucketpathname" varchar(5000),
    "foldertypecategory" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "isprovidertyperesidential" boolean,
    PRIMARY KEY ("foldertypekey")
);

-- Model(s): Foldertypeproviderconfig
CREATE TABLE IF NOT EXISTS "cjams"."foldertypeproviderconfig" (
    "foldertypeproviderconfigid" uuid,
    "foldertypekey" varchar(50),
    "providerid" uuid,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("foldertypekey")
);

-- Model(s): Form1080a
CREATE TABLE IF NOT EXISTS "cjams"."form1080a" (
    "form1080aid" uuid DEFAULT gen_random_uuid(),
    "objectid" uuid,
    "objecttype" varchar(255),
    "ischildfatality" boolean,
    "isseriousphysicalinjury" boolean,
    "ismaltreatment" boolean,
    "justificationforchange" text,
    "dateofthiscfspicriticalincidentreport" timestamptz,
    "countyjurisdictionwheretheincidentoccurred" varchar(255),
    "datewhentheincidentoccurred" timestamptz,
    "dateldssbecameawareofincident" timestamptz,
    "jurisdictionwithchildresponsibility" varchar(255),
    "intakereferral" varchar(255),
    "screen" varchar(255),
    "status" varchar(255),
    "submitforapproval" varchar(255),
    "supervisorcomments" varchar(255),
    "providereason" varchar(255),
    "personid" varchar(255),
    "cjamspid" varchar(255),
    "dob" timestamptz,
    "dod" timestamptz,
    "sex" varchar(255),
    "race" varchar(255),
    "enthnicity" varchar(255),
    "wasthereanyotheropencaseinvolvingthischildatthetimeofincident" boolean,
    "wasthereacaseinvolvingthischildclosedwithin12monthsofincident" boolean,
    "wasthechildeverplacedoutsideofhomebeforetheincident" boolean,
    "didmostrecentoohplacementend12monthsofincident" boolean,
    "wasthechilddiagnosedwithamentalorphysicaldisability" boolean,
    "wasthechildbornsubstanceexposed" boolean,
    "wasthechildrecordupdatedwiththedateofdeathincjams" boolean,
    "locationtypewhereincidentoccurred" varchar(255),
    "specifylocation" varchar(255),
    "wasthechildinanoutofhomeplacementatthetimeoftheincident" boolean,
    "placementprovideratthetimeoftheincident" varchar(255),
    "allegedmaltreatername" varchar(255),
    "isthisalsothecasehead" boolean,
    "aliases" varchar(255),
    "dob1" timestamptz,
    "cjamspid1" varchar(255),
    "relationshiptovictim" varchar(255),
    "anychildwelfarehistoryinvolvingthisperson" boolean,
    "narrativesummaryofhistory" varchar(255),
    "isthislocationthechildprimaryresidence" boolean,
    "releventinformation" varchar(255),
    "parentname" varchar(255),
    "parentrole" timestamptz,
    "aliases1" timestamptz,
    "dob2" timestamptz,
    "cjamspid2" timestamptz,
    "relationshiptovictim1" timestamptz,
    "anychildwelfarehistoryinvolvingthisperson1" boolean,
    "narrativesummaryofhistory1" timestamptz,
    "didthechildresideprimarilyatthislocation" boolean,
    "dateldssheldtherapidresponsereview" timestamptz,
    "additionalrelevantinformation" varchar(255),
    "whatistheextentofanycurrentorpotentialmediainvolvementrelease" varchar(255),
    "signatureofpersoncompletingthisreport" varchar(255),
    "datecompleted" timestamptz,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("form1080aid")
);

-- Model(s): Form1080b
CREATE TABLE IF NOT EXISTS "cjams"."form1080b" (
    "form1080bid" uuid DEFAULT gen_random_uuid(),
    "objectid" varchar(255),
    "objecttype" varchar(255),
    "personid" varchar(255),
    "casenumber" varchar(255),
    "provideasummaryoftheinvestigationandidentifyanybarriestheldss" varchar(255),
    "whatisthemedicalexaminerspreliminaryfinding" varchar(255),
    "signatureofpersoncompletingthisreport" varchar(255),
    "datecompleted" timestamptz,
    "activeflag" integer,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "submitforapproval" varchar(255),
    "supervisorcomments" varchar(255),
    "status" varchar(255),
    PRIMARY KEY ("form1080bid")
);

-- Model(s): Form1080c
CREATE TABLE IF NOT EXISTS "cjams"."form1080c" (
    "form1080cid" uuid DEFAULT gen_random_uuid(),
    "objectid" varchar(255),
    "objecttype" varchar(255),
    "doesmaltreatmentappeartohavebeenacontributingfactor" varchar(255),
    "ifincidentoccurredinlicensedsettingindicateactiontaken" varchar(255),
    "specify" varchar(255),
    "legaloutcomeinthisincident" varchar(255),
    "wasthisincidentrelatedtosleeporanunsafesleepenvironment" varchar(255),
    "inthe72hoursbeforethefatalincidentwasthechildinjured" varchar(255),
    "personid" uuid,
    "fullname" varchar(255),
    "physicalabuse" varchar(255),
    "physicalabuseradio" varchar(255),
    "sexualabuse" varchar(255),
    "sexualabuseradio" varchar(255),
    "neglect" varchar(255),
    "neglectradio" varchar(255),
    "mentalinjuryabuse" varchar(255),
    "mentalinjuryabuseradio" varchar(255),
    "mentalinjuryneglect" varchar(255),
    "mentalinjuryneglectradio" varchar(255),
    "summaryoffactsandfindingincludingtheeventdateinthecase" varchar(255),
    "theallegedlymaltreatedchild" varchar(255),
    "siblingsoftheallegedlymaltreatedchild" varchar(255),
    "otherchildinhouseholdfamilyorincaseofallegedmaltreater" varchar(255),
    "substanceusechild" varchar(255),
    "substanceusefamily" varchar(255),
    "substanceusecaregiver" varchar(255),
    "mentalillnesschild" varchar(255),
    "mentalillnessfamily" varchar(255),
    "mentalillnesscaregiver" varchar(255),
    "domesticviolencechild" varchar(255),
    "domesticviolencefamily" varchar(255),
    "domesticviolencecaregiver" varchar(255),
    "prenatalexposurechild" varchar(255),
    "prenatalexposurefamily" varchar(255),
    "prenatalexposurecaregiver" varchar(255),
    "noprenatalcarechild" varchar(255),
    "noprenatalcarefamily" varchar(255),
    "noprenatalcarecaregiver" varchar(255),
    "childfatalitychild" varchar(255),
    "childfatalityfamily" varchar(255),
    "childfatalitycaregiver" varchar(255),
    "medicalconditionchild" varchar(255),
    "medicalconditionfamily" varchar(255),
    "medicalconditioncaregiver" varchar(255),
    "healthinsurancechild" varchar(255),
    "healthinsurancefamily" varchar(255),
    "healthinsurancecaregiver" varchar(255),
    "otherchild" varchar(255),
    "otherfamily" varchar(255),
    "othercaregiver" varchar(255),
    "otherriskfactors" json,
    "describehowtheselectedriskfactorsfromchartaboveinfluencedtheinc" varchar(255),
    "signatureofpersoncompletingthisreport" varchar(255),
    "personcompletingthisreport" varchar(255),
    "supervisor" varchar(255),
    "phonenumber" varchar(255),
    "supervisorphonenumber" varchar(255),
    "email" varchar(255),
    "supervisoremail" varchar(255),
    "submitforapproval" varchar(255),
    "supervisorcomments" varchar(255),
    "status" varchar(255),
    "datecompleted" timestamptz,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("form1080cid")
);

-- Model(s): Gapagreement
CREATE TABLE IF NOT EXISTS "cjams"."gapagreement" (
    "gapagreementid" uuid DEFAULT gen_random_uuid(),
    "gapid" uuid,
    "iscomprehensivehomestudy" boolean,
    "iscgawardedcustody" boolean,
    "isplacementenddate" boolean,
    "ischildreceivetca" boolean,
    "tcaamount" varchar(50),
    "startdate" timestamp,
    "enddate" timestamp,
    "signaturedate" timestamp,
    "guardianonedate" timestamp,
    "guardiantwodate" timestamp,
    "guardian1signature" varchar(255),
    "guardian2signature" text,
    "ldssdirectorsignature" text,
    "ldssdate" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "signaturecheck" boolean,
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "isfianotified" integer,
    "isrcnotifiedcontact" integer,
    "iscsnotifiedtocustody" integer,
    "fianotifieddate" timestamp,
    "agreementtyperefid" varchar(50),
    PRIMARY KEY ("gapagreementid")
);

-- Model(s): Gapagreementrate
CREATE TABLE IF NOT EXISTS "cjams"."gapagreementrate" (
    "gapagreementrateid" uuid DEFAULT gen_random_uuid(),
    "gapagreementid" uuid,
    "provider_id" integer,
    "startdate" timestamp,
    "negotiateddate" timestamp,
    "enddate" timestamp,
    "paymentamout" numeric,
    "isoverride" boolean,
    "ssaapprovaldate" timestamp,
    "paymenttypekey" text,
    "notes" text,
    "status" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "alternateid" integer,
    PRIMARY KEY ("gapagreementrateid")
);

-- Model(s): Gapagreementrevision
CREATE TABLE IF NOT EXISTS "cjams"."gapagreementrevision" (
    "gapagreementrevisionid" uuid,
    "gapagreementid" uuid,
    "gapid" uuid,
    "iscomprehensivehomestudy" boolean,
    "iscgawardedcustody" boolean,
    "isplacementenddate" boolean,
    "ischildreceivetca" boolean,
    "tcaamount" varchar(50),
    "startdate" timestamp,
    "enddate" timestamp,
    "signaturedate" timestamp,
    "guardianonedate" timestamp,
    "guardiantwodate" timestamp,
    "ldssdate" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "isfianotified" integer,
    "isrcnotifiedcontact" integer,
    "iscsnotifiedtocustody" integer,
    "fianotifieddate" timestamp,
    "approvalstatustypekey" varchar(255),
    "approvaldate" timestamp
);

-- Model(s): Gapannualreview
CREATE TABLE IF NOT EXISTS "cjams"."gapannualreview" (
    "gapannualreviewid" uuid DEFAULT gen_random_uuid(),
    "gapid" uuid,
    "gapagreementid" uuid,
    "reviewdate" timestamp,
    "isguardianresponsible" boolean,
    "isguardiansupportfinance" boolean,
    "ischildwithguardian" boolean,
    "ischildattendingschool" boolean,
    "isdocumentprovided" boolean,
    "ischildreacheighteen" boolean,
    "ischilddisability" boolean,
    "istrainingenrolled" boolean,
    "isunemployment" boolean,
    "isformcomplete" boolean,
    "cgprimarydate" timestamp,
    "cgsecondarydate" timestamp,
    "directorsigndate" timestamp,
    "ismanualentry" integer,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("gapannualreviewid")
);

-- Model(s): Gapapplication
CREATE TABLE IF NOT EXISTS "cjams"."gapapplication" (
    "gapapplicationid" uuid DEFAULT gen_random_uuid(),
    "gapid" uuid,
    "planmeetingdate" timestamp,
    "guardianonedate" timestamp,
    "guardiantwodate" timestamp,
    "ldssdirectordate" timestamp,
    "guardian1signature" varchar(255),
    "guardian2signature" text,
    "ldssdirectorsignature" text,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("gapapplicationid")
);

-- Model(s): Gapdisclosure
CREATE TABLE IF NOT EXISTS "cjams"."gapdisclosure" (
    "gapdisclosureid" uuid DEFAULT gen_random_uuid(),
    "gapid" uuid,
    "disclosuredate" timestamp,
    "ischildplacedsixmonths" boolean,
    "isproviderapprovedgap" boolean,
    "iscourthearingcustody" boolean,
    "isreunificationremoved" boolean,
    "isadoptionremoved" boolean,
    "iscgprovidesafe" boolean,
    "isothergapfinsupport" boolean,
    "iscgattendedorientation" boolean,
    "orientationmeetingdate" timestamp,
    "dateofplanning" timestamp,
    "isrequirementdiscussed" boolean,
    "iscgparticipategap" boolean,
    "iscgenteredagreement" boolean,
    "iscgcompleteauthorization" boolean,
    "iscgaftercareservice" boolean,
    "isneedadditionalservices" boolean,
    "iscgcompleteannualreview" boolean,
    "issuspendedfromguardian" boolean,
    "status" integer,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "issuccessorguardianexists" boolean,
    "isconsultationchildage" boolean,
    "isguardianattach" boolean,
    "isguardiantwoattach" boolean,
    PRIMARY KEY ("gapdisclosureid")
);

-- Model(s): Gapratesrevision
CREATE TABLE IF NOT EXISTS "cjams"."gapratesrevision" (
    "gapratesrevisionid" uuid DEFAULT gen_random_uuid(),
    "gaprateid" uuid,
    "guardiansubsidyid" uuid,
    "transactiondate" timestamp,
    "providerid" integer,
    "ratestartdate" timestamp,
    "rateenddate" timestamp,
    "paymentamt" numeric,
    "isoriginal" boolean,
    "comments" varchar(255),
    "approvalstatustypekey" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("gapratesrevisionid")
);

-- Model(s): Gapsuspension
CREATE TABLE IF NOT EXISTS "cjams"."gapsuspension" (
    "gapsuspensionid" uuid DEFAULT gen_random_uuid(),
    "gapid" uuid,
    "suspensionreasontypekey" varchar(15),
    "startdate" timestamp,
    "enddate" timestamp,
    "notes" text,
    "isdraft" integer,
    "suspensiondesc" text,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "dateofdeath" timestamp,
    "otherreason" varchar(100),
    "approvalstatustypekey" varchar(12000),
    PRIMARY KEY ("gapsuspensionid")
);

-- Model(s): Gapsuspensionrevision
CREATE TABLE IF NOT EXISTS "cjams"."gapsuspensionrevision" (
    "gapsuspensionrevisionid" uuid DEFAULT gen_random_uuid(),
    "suspensionid" uuid,
    "transactiondate" timestamp,
    "reasontypekey" varchar(50),
    "startdate" timestamp,
    "enddate" timestamp,
    "suspensiondesc" varchar(255),
    "approvalstatustypekey" varchar(50),
    "approvaldate" timestamp,
    "isoriginal" boolean,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "guardiansubsidyid" uuid,
    PRIMARY KEY ("gapsuspensionrevisionid")
);

-- Model(s): Gendertype
CREATE TABLE IF NOT EXISTS "cjams"."gendertype" (
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "gendertypekey" varchar(15),
    "sequencenumber" integer,
    "typedescription" varchar(250),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("gendertypekey")
);

-- Model(s): getdocdetails
CREATE TABLE IF NOT EXISTS "cjams"."getdocdetails" (
    "TeamNo" numeric,
    "ActiveFlag" numeric,
    "ActiveFlag1" numeric,
    "PageSize" numeric,
    "PageNumber" numeric,
    "OfficePhone" varchar(255),
    "City" varchar(255),
    "County" varchar(255),
    "ZipCode" varchar(255),
    "Region" varchar(255),
    "Count" numeric,
    "StateCellPhoneNumber" varchar(255),
    "SecurityUsersId" varchar(255)
);

-- Model(s): getusersearch
CREATE TABLE IF NOT EXISTS "cjams"."getusersearch" (
    "TeamNo" numeric,
    "ActiveFlag" numeric,
    "ActiveFlag1" numeric,
    "PageSize" numeric,
    "PageNumber" numeric,
    "OfficePhone" varchar(255),
    "City" varchar(255),
    "County" varchar(255),
    "ZipCode" varchar(255),
    "Region" varchar(255),
    "Count" numeric,
    "StateCellPhoneNumber" varchar(255),
    "SecurityUsersId" varchar(255)
);

-- Model(s): Gradetype
CREATE TABLE IF NOT EXISTS "cjams"."gradetype" (
    "gradetypeid" uuid,
    "gradetypekey" varchar(15),
    "typedescription" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "ishighergrade" boolean,
    "displayorder" integer,
    PRIMARY KEY ("gradetypekey")
);

-- Model(s): Guardianship
CREATE TABLE IF NOT EXISTS "cjams"."guardianship" (
    "gapid" uuid DEFAULT gen_random_uuid(),
    "placement_id" integer,
    "intakeserviceid" uuid,
    "servicecaseid" uuid,
    "permanencyplanid" uuid,
    "guardianoneid" varchar(50),
    "guardiantwoid" varchar(50),
    "guardianonename" varchar(255),
    "guardiantwoname" varchar(255),
    "guardianoneproviderid" integer,
    "guardiantwoproviderid" integer,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "successionaddendumdate" timestamp,
    "cofinaldate" timestamp,
    "successorguardianname" varchar(250),
    "empprogramstartdate" timestamp,
    "empprogramname" varchar(50),
    "primaryrelationshipkey" varchar(50),
    "secondaryrelationshipkey" varchar(50),
    "fosterhomeapprover" varchar(50),
    "isrcgunderstandpurpose" boolean,
    "isrcgacknowledgedruledoutplans" boolean,
    "isrcgapprovedhomeforsixmonths" boolean,
    "isrcgcomprehensivestudycompleted" boolean,
    "isrcgcompletedprotectiveclearance" boolean,
    "isrcgauthorizedmentalinfo" boolean,
    "isrcgshowpermanentcommitment" boolean,
    "isrcgwillstablehome" boolean,
    "isrcgprovidesupervision" boolean,
    "iscgcompletedannualreconsideration" boolean,
    "isrcghavefinancialsupport" boolean,
    "isrcgagreestoapplyssn" boolean,
    "isrcgnotifybehalfofchild" boolean,
    "isrcgnotifylocaldeptforchanges" boolean,
    "isrcgguardianshipassistancepayment" boolean,
    "isrcgunderstandgacanbeterminated" boolean,
    "iscgenteredagreement" boolean,
    "isapprovedresourceparent" boolean,
    "isapprovedkinshipplacement" boolean,
    "documentsigned" boolean,
    "effectiveswitchdate" timestamp,
    "switchprovider" boolean,
    "switchproviderreason" varchar(500),
    "isrcgandcwdiscussedrequirements" boolean,
    PRIMARY KEY ("gapid")
);

-- Model(s): Guardinmeetingboardmembers
CREATE TABLE IF NOT EXISTS "cjams"."guardinmeetingboardmembers" (
    "guardinmeetingboardmembersid" uuid DEFAULT gen_random_uuid(),
    "guardinshipmeetingid" uuid,
    "boardmembertype" varchar(50),
    "firstname" varchar(50),
    "lastname" varchar(50),
    "email" varchar(50),
    "phoneno" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("guardinmeetingboardmembersid")
);

-- Model(s): Guardinshipmeeting
CREATE TABLE IF NOT EXISTS "cjams"."guardinshipmeeting" (
    "guardinshipmeetingid" uuid DEFAULT gen_random_uuid(),
    "countyid" uuid,
    "dateofmeeting" timestamp,
    "starttime" timestamp,
    "endtime" timestamp,
    "meetingstatus" varchar(50),
    "meetingtype" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("guardinshipmeetingid")
);

-- Model(s): Healthassessmenttype
CREATE TABLE IF NOT EXISTS "cjams"."healthassessmenttype" (
    "healthassessmenttypeid" uuid,
    "healthassessmenttypekey" varchar(50),
    "description" varchar(250),
    "healthdomaintypekey" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("healthassessmenttypekey")
);

-- Model(s): Healthdomaintype
CREATE TABLE IF NOT EXISTS "cjams"."healthdomaintype" (
    "healthdomaintypeid" uuid,
    "healthdomaintypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("healthdomaintypekey")
);

-- Model(s): Healthprofessiontype
CREATE TABLE IF NOT EXISTS "cjams"."healthprofessiontype" (
    "healthprofessiontypeid" uuid,
    "healthprofessiontypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("healthprofessiontypekey")
);

-- Model(s): Hearingclients
CREATE TABLE IF NOT EXISTS "cjams"."hearingclients" (
    "hearingclientid" uuid DEFAULT gen_random_uuid(),
    "courthearingid" uuid,
    "personid" uuid,
    "courtcasenotx" varchar(50),
    "annualnoticebenefitdt" timestamp,
    "otherclientflag" integer,
    "insertedon" timestamp,
    "insertedby" varchar(50),
    "updatedon" timestamp,
    "updatedby" varchar(50),
    "activeflag" integer,
    "datavalidflag" integer,
    "clientmergeid" uuid,
    "old_id" varchar(50),
    PRIMARY KEY ("hearingclientid")
);

-- Model(s): Hearingstatustype
CREATE TABLE IF NOT EXISTS "cjams"."hearingstatustype" (
    "hearingstatustypeid" uuid,
    "hearingstatustypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp,
    PRIMARY KEY ("hearingstatustypekey")
);

-- Model(s): Hearingtype
CREATE TABLE IF NOT EXISTS "cjams"."hearingtype" (
    "hearingtypeid" uuid,
    "hearingtypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "teamtypekey" varchar(15),
    PRIMARY KEY ("hearingtypekey")
);

-- Model(s): Helptext
CREATE TABLE IF NOT EXISTS "cjams"."helptext" (
    "helptextid" uuid DEFAULT gen_random_uuid(),
    "formkey" text,
    "controlindex" integer,
    "helptext" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("helptextid")
);

-- Model(s): Hospitaldetail
CREATE TABLE IF NOT EXISTS "cjams"."hospitaldetails" (
    "id" uuid,
    "name" varchar(500),
    "addresss1" varchar(500),
    "addresss2" varchar(500),
    "city" varchar(500),
    "state" varchar(500),
    "zipcode" varchar(500),
    "county" varchar(500),
    "phoneno" varchar(500),
    "insertedby" varchar(50),
    "insertedon" timestamptz,
    "updatedby" varchar(50),
    "updatedon" timestamptz,
    "activeflag" integer,
    "objecttype" varchar(255)
);

-- Model(s): Householdtype
CREATE TABLE IF NOT EXISTS "cjams"."householdtype" (
    "displayorder" integer,
    "householdtypeid" uuid,
    "householdtypekey" varchar(15),
    "activeflag" integer,
    "typedescription" varchar(50),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("householdtypekey")
);

-- Model(s): Ihasprovidedmonthlyreportdaysconfig
CREATE TABLE IF NOT EXISTS "cjams"."ihasprovidedmonthlyreportdaysconfig" (
    "ihasprovidedmonthlyreportdaysconfigid" uuid DEFAULT gen_random_uuid(),
    "ihasprovidermonthlyreportid" uuid,
    "activitykey" varchar(100),
    "day01" varchar(100),
    "day02" varchar(100),
    "day03" varchar(100),
    "day04" varchar(100),
    "day05" varchar(100),
    "day06" varchar(100),
    "day07" varchar(100),
    "day08" varchar(100),
    "day09" varchar(100),
    "day10" varchar(100),
    "day11" varchar(100),
    "day12" varchar(100),
    "day13" varchar(100),
    "day14" varchar(100),
    "day15" varchar(100),
    "day16" varchar(100),
    "day17" varchar(100),
    "day18" varchar(100),
    "day19" varchar(100),
    "day20" varchar(100),
    "day21" varchar(100),
    "day22" varchar(100),
    "day23" varchar(100),
    "day24" varchar(100),
    "day25" varchar(100),
    "day26" varchar(100),
    "day27" varchar(100),
    "day28" varchar(100),
    "day29" varchar(100),
    "day30" varchar(100),
    "day31" varchar(100),
    "total" varchar(100),
    "version" varchar(100),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("ihasprovidedmonthlyreportdaysconfigid")
);

-- Model(s): Ihasprovidermonthlyreport
CREATE TABLE IF NOT EXISTS "cjams"."ihasprovidermonthlyreport" (
    "ihasprovidermonthlyreportid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "providername" varchar(100),
    "provideraddress" varchar(100),
    "providercity" varchar(100),
    "providerstate" varchar(100),
    "providerzipcode" varchar(100),
    "providerphoneno" varchar(100),
    "categoryihasfamily" boolean,
    "categoryihasadults" boolean,
    "categoryeligible" boolean,
    "categoryihasanothereservice" boolean,
    "providerihasfamily" boolean,
    "providerihasadults" boolean,
    "providereligible" boolean,
    "providerihasanothereservice" boolean,
    "pca" varchar(100),
    "agencyobject" varchar(100),
    "ldsssignature" varchar(100),
    "aidesignature" varchar(100),
    "caregiversignature" varchar(100),
    "caregiversigndate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "totalinvoiceamount" varchar(100),
    "reportstatus" varchar(100),
    "ldsssignaturedate" timestamp,
    "aidesignaturedate" timestamp,
    "accountclerksign" varchar(100),
    "providerssn" varchar(100),
    "reportedmonthyear" varchar(255),
    PRIMARY KEY ("ihasprovidermonthlyreportid")
);

-- Model(s): Incidentlocationtype
CREATE TABLE IF NOT EXISTS "cjams"."incidentlocationtype" (
    "incidentlocationtypeid" uuid DEFAULT gen_random_uuid(),
    "incidentlocationtypekey" varchar(15),
    "typename" varchar(50),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(25),
    PRIMARY KEY ("incidentlocationtypeid")
);

-- Model(s): Incometype
CREATE TABLE IF NOT EXISTS "cjams"."incometype" (
    "sequencenumber" integer,
    "incometypekey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("incometypekey")
);

-- Model(s): Indicator
CREATE TABLE IF NOT EXISTS "cjams"."indicator" (
    "indicatorid" uuid DEFAULT gen_random_uuid(),
    "allegationid" uuid,
    "indicatorname" varchar(250),
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    PRIMARY KEY ("indicatorid")
);

-- Model(s): Informationsourcetype
CREATE TABLE IF NOT EXISTS "cjams"."informationsourcetype" (
    "informationsourcetypeid" uuid,
    "informationsourcetypekey" varchar(15),
    "description" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    PRIMARY KEY ("informationsourcetypekey")
);

-- Model(s): Injurycharactersticstype
CREATE TABLE IF NOT EXISTS "cjams"."injurycharactersticstype" (
    "injurycharactersticstypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "displayorder" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("injurycharactersticstypekey")
);

-- Model(s): Injurytype
CREATE TABLE IF NOT EXISTS "cjams"."injurytype" (
    "injurytypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "displayorder" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("injurytypekey")
);

-- Model(s): Intakeagency
CREATE TABLE IF NOT EXISTS "cjams"."intakeagency" (
    "agencyid" uuid DEFAULT gen_random_uuid(),
    "agencykey" varchar(15),
    "description" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("agencyid")
);

-- Model(s): Intakeagencypurpose
CREATE TABLE IF NOT EXISTS "cjams"."intakeagencypurpose" (
    "intakeagencypurposeid" uuid DEFAULT gen_random_uuid(),
    "intakeservreqtypeid" uuid,
    "teamtypekey" varchar(15),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("intakeagencypurposeid")
);

-- Model(s): Intakeagencypurposeroleconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeagencypurposeroleconfig" (
    "intakeagencypurposeroleconfigid" uuid DEFAULT gen_random_uuid(),
    "intakeservreqtypeid" uuid,
    "teamtypekey" varchar(15),
    "roletypecode" varchar(15),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("intakeagencypurposeroleconfigid")
);

-- Model(s): Intakeagencyrequesttype
CREATE TABLE IF NOT EXISTS "cjams"."intakeagencyrequesttype" (
    "intakeagencyreqtypeid" uuid DEFAULT gen_random_uuid(),
    "agencyid" varchar(15),
    "intakeservreqtypeid" varchar(15),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("intakeagencyreqtypeid")
);

-- Model(s): Intakeagencyserv
CREATE TABLE IF NOT EXISTS "cjams"."intakeagencyserv" (
    "intakeagencyservid" uuid DEFAULT gen_random_uuid(),
    "intakeservid" uuid,
    "teamtypekey" varchar(255),
    "intakeservreqtypeid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "plantypekey" varchar(50),
    PRIMARY KEY ("intakeagencyservid")
);

-- Model(s): Intakeappeal
CREATE TABLE IF NOT EXISTS "cjams"."intakeappeal" (
    "appealid" uuid DEFAULT gen_random_uuid(),
    "intakenumber" varchar(25),
    "appealdate" timestamp,
    "appealstatus" varchar(50),
    "remarks" varchar(500),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("appealid")
);

-- Model(s): Intakedastaging
CREATE TABLE IF NOT EXISTS "cjams"."intakedastaging" (
    "id" integer,
    "intakenumber" varchar(50),
    "daterecieved" timestamp,
    "narrative" varchar(256),
    "teamtypekey" varchar(10),
    "raname" varchar(128),
    "entityname" varchar(128),
    "cruworkername" varchar(128),
    "data" varchar(255),
    "insertedon" timestamp,
    "insertedby" varchar(50),
    "timerecieved" varchar(10),
    "updatedon" timestamp,
    "updatedby" varchar(50),
    "status" varchar(50),
    "activeflag" integer,
    "jsondata" varchar(255),
    "versionnumber" varchar(255),
    "isclw" boolean,
    "clwstatus" integer,
    "focuspersonid" uuid,
    "ispreintake" boolean,
    "dispositiondescription" varchar(250),
    "statusdescription" varchar(250),
    "isrestricteditem" boolean,
    PRIMARY KEY ("id")
);

-- Model(s): Intakedastatus
CREATE TABLE IF NOT EXISTS "cjams"."intakedastatus" (
    "intakedastatusid" uuid DEFAULT gen_random_uuid(),
    "intakenumber" varchar(50),
    "status" integer,
    "jsondata" varchar(255),
    "submitteddate" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "ispreintake" boolean,
    "assigneddate" timestamp,
    "assignedto" varchar(50),
    "receiveddelayreason" varchar(250),
    "submissiondelayreason" varchar(250),
    "teamtypekey" varchar(25),
    "isclw" boolean,
    "signedoffdate" timestamp,
    "userprofileaddressid" uuid,
    "reasonforassignmenttypekey" varchar(15),
    PRIMARY KEY ("intakedastatusid")
);

-- Model(s): Intakedocument
CREATE TABLE IF NOT EXISTS "cjams"."intakedocument" (
    "intakedocumentid" uuid DEFAULT gen_random_uuid(),
    "documenttemplatekey" varchar(50),
    "intakeserviceid" uuid,
    "intakenumber" varchar(50),
    "versionno" integer,
    "documentpath" varchar(5000),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("intakedocumentid")
);

-- Model(s): Intakerecomendationtype
CREATE TABLE IF NOT EXISTS "cjams"."intakerecomendationtype" (
    "intakerecomendationtypeid" uuid,
    "intakerecomendationtypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("intakerecomendationtypekey")
);

-- Model(s): Intakeserreqinterstate
CREATE TABLE IF NOT EXISTS "cjams"."intakeserreqinterstate" (
    "intakeserreqinterstateid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "intakenumber" varchar(50),
    "demandingstate" varchar(30),
    "maxdateofexpiration" timestamp,
    "countyid" uuid,
    "requisitiontypekey" varchar(15),
    "iswritwarrant" boolean,
    "warranttype" varchar(15),
    "isdetaintheyouth" boolean,
    "notes" text,
    "contentofrequisitionform" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("intakeserreqinterstateid")
);

-- Model(s): Intakeserreqinterstateresidingconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeserreqinterstateresidingconfig" (
    "intakeserreqinterstateresidingconfigid" uuid DEFAULT gen_random_uuid(),
    "intakeserreqinterstateid" uuid,
    "intakeservicerequestactorid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("intakeserreqinterstateresidingconfigid")
);

-- Model(s): Intakeserreqinterstatewarranttypeconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeserreqinterstatewarranttypeconfig" (
    "intakeserreqinterstatewarranttypeconfigid" uuid DEFAULT gen_random_uuid(),
    "intakeserreqinterstateid" uuid,
    "warranttype" varchar(15),
    "warranttypekey" varchar(15),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("intakeserreqinterstatewarranttypeconfigid")
);

-- Model(s): Intakeserreqrestitution
CREATE TABLE IF NOT EXISTS "cjams"."intakeserreqrestitution" (
    "intakeserreqrestitutionid" uuid DEFAULT gen_random_uuid(),
    "restitutionno" varchar(50),
    "intakeserviceid" uuid,
    "intakenumber" varchar(50),
    "youthpersonid" uuid,
    "victimpersonid" uuid,
    "countyid" uuid,
    "restitutiontype" varchar(50),
    "ismultipleinvolvedpersons" boolean,
    "payment" numeric(5,2),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("intakeserreqrestitutionid")
);

-- Model(s): Intakeserreqrestitutionpayment
CREATE TABLE IF NOT EXISTS "cjams"."intakeserreqrestitutionpayment" (
    "intakeserreqrestitutionpaymentid" uuid DEFAULT gen_random_uuid(),
    "intakeserreqrestitutionid" uuid,
    "paymentamount" numeric(5,2),
    "payerfirstname" varchar(50),
    "payerlastname" varchar(50),
    "payeraddress" varchar(50),
    "payercity" varchar(50),
    "payerstatekey" varchar(50),
    "payerzipcode" varchar(50),
    "depositnumber" varchar(50),
    "accountarea" varchar(50),
    "memofirstname" varchar(50),
    "memolastname" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "documentpath" varchar(5000),
    PRIMARY KEY ("intakeserreqrestitutionpaymentid")
);

-- Model(s): Intakeserreqstatustype
CREATE TABLE IF NOT EXISTS "cjams"."intakeserreqstatustype" (
    "intakeserreqstatustypeid" uuid DEFAULT gen_random_uuid(),
    "intakeserreqstatustypekey" varchar(15),
    "description" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("intakeserreqstatustypeid")
);

-- Model(s): Intakeserv
CREATE TABLE IF NOT EXISTS "cjams"."intakeserv" (
    "intakeservid" uuid DEFAULT gen_random_uuid(),
    "description" text,
    "intakeservtypekey" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("intakeservid")
);

-- Model(s): Intakeserviceagencyroletype
CREATE TABLE IF NOT EXISTS "cjams"."intakeserviceagencyroletype" (
    "intakeserviceagencyroletypeid" uuid,
    "intakeservicerequestagencyid" uuid,
    "agencyroletypekey" varchar(15),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "timestamp" bytea,
    "activeflag" integer,
    "expirationdate" timestamp,
    "effectivedate" timestamp
);

-- Model(s): Intakeservicerequest
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequest" (
    "intakeserviceid" uuid DEFAULT gen_random_uuid(),
    "servicerequestnumber" varchar(50),
    "servicerequestincidenttypekey" varchar(15),
    "narrative" text,
    "title" varchar(50),
    "description" varchar(4000),
    "reporteddate" timestamp,
    "reportedtime" timestamp,
    "reportedarea" varchar(20),
    "reportedtypekey" varchar(15),
    "reportedbyself" boolean,
    "sourcearea" varchar(20),
    "intakeservreqinputtypeid" uuid,
    "intakeservreqtypeid" uuid,
    "inputtypevalue" varchar(50),
    "intakeserreqstatustypeid" uuid,
    "intakeservicerequestclassid" uuid,
    "crossreferencewith" varchar(50),
    "priorityid" uuid,
    "statuschangedate" timestamp,
    "statuschangedescription" text,
    "dangerlevel" integer,
    "dangerreason" varchar(500),
    "accesslevel" boolean,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "archiveon" timestamp,
    "archiveby" varchar(50),
    "timestamp" bytea,
    "old_id" varchar(50),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "suspiciousdeath" boolean,
    "missingpersons" boolean,
    "sharedcaretaxcredit" boolean,
    "sharedcaretaxcredityear" integer,
    "agencyname" varchar(256),
    "notes" text,
    "externalagencyphone" boolean,
    "externalagencyfax" boolean,
    "externalagencyemail" boolean,
    "investigatable" boolean,
    "visitinfo" text,
    "illegalactivity" boolean,
    "intakeservicerequestillegalactivitytypekey" varchar(15),
    "targetcompletedate" timestamp,
    "supervisorreview" boolean,
    "rarejectedmedicaidstatus" boolean,
    "moneyfollowsperson" boolean,
    "im54adate" timestamp,
    "hcb" boolean,
    "adverseactiondate" timestamp,
    "applicationhearingreceiveddate" timestamp,
    "reversaladverseactiondate" timestamp,
    "monumber" varchar(50),
    "isanonymousreporter" boolean,
    "isappealed" boolean,
    "iscps" boolean,
    "intakenumber" varchar(50),
    "foldertypekey" varchar(50),
    "folderreasontypekey" varchar(50),
    "folderopendatetime" timestamp,
    "foldernotes" text,
    "exitdate" timestamp,
    "islocalreferal" integer,
    "referalcomments" varchar(300),
    "nonreferalreason" varchar(300),
    "servicecaseid" uuid,
    "countyid" uuid,
    "intakeservreqpurposeid" uuid,
    "teamtypekey" varchar(25),
    "isotheragency" boolean,
    "isunknownreporter" boolean,
    "reporterfirstname" varchar(200),
    "reporterlastname" varchar(200),
    "offenselocation" varchar(100),
    "requesterphone" varchar(100),
    "requesterzipcode" varchar(20),
    "requesteraddress1" varchar(100),
    "requesteraddress2" varchar(100),
    "requestercity" varchar(32),
    "requesterstate" varchar(2),
    "requestercounty" varchar(32),
    "isacknowledgementletter" integer,
    "iszipcoderefuse" boolean,
    "constentreceiveddate" timestamp,
    "searchworkername" varchar(100),
    "historyclearanceinfo" varchar(1000),
    "clearancereasontypekey" varchar(50),
    "isnoticedthirdparty" integer,
    "isnoticedindividual" integer,
    "isclosecpshistory" integer,
    "histclearanceenteredtimestamp" timestamp,
    "reporterincidentdate" timestamp,
    "reporterisacknowledgementletter" integer,
    "reportermiddlename" varchar(50),
    "reporterphonenumber" varchar(50),
    "reporterphonenumberext" varchar(10),
    "reporterroletypekey" varchar(50),
    "reporterzipcode" varchar(50),
    "reporteremail" varchar(50),
    "reporterincidentlocation" varchar(50),
    "reporterorganization" varchar(120),
    "reportertitle" varchar(150),
    "reporternarrative" text,
    "reporteraddress1" varchar(500),
    "reporteraddress2" varchar(500),
    "reportercity" varchar(50),
    "reporterstate" varchar(50),
    "reporterisapproximate" boolean,
    "reporterisanonymousreporter" boolean,
    "reporterisunknownreporter" boolean,
    "reporterrefusetosharezip" boolean,
    "cissuid" varchar(50),
    PRIMARY KEY ("intakeserviceid")
);

-- Model(s): Intakeservicerequestactor
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestactor" (
    "intakeservicerequestactorid" uuid DEFAULT gen_random_uuid(),
    "actorid" uuid,
    "intakeservicerequestpersontypekey" varchar(15),
    "rapersontypekey" varchar(15),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "intakeserviceid" uuid,
    "routingaddressid" uuid,
    "employeetypeid" uuid,
    "employeetypename" varchar(50),
    "medicaideligibility" boolean,
    "blockgranteligibility" boolean,
    "livingarrangementtypekey" varchar(50),
    "guardianname" varchar(512),
    "isheadofhousehold" boolean,
    "guardianinfo" varchar(126),
    "ramentalhealth" boolean,
    "ramentalretarted" boolean,
    "ramentalretartedtype" varchar(50),
    "refusessn" boolean,
    "refusedob" boolean,
    "activeflag" integer,
    "reported" boolean,
    "isprimary" boolean,
    "ismaltreator" boolean,
    "isvictim" integer,
    "probationsearchconductedflag" integer,
    "sexoffenderregisteredflag" integer,
    "drugexposednewbornflag" integer,
    "fetalalcoholspctrmdisordflag" integer,
    "personid" uuid,
    "servicecaseid" uuid,
    "spexpungementflag" integer,
    PRIMARY KEY ("intakeservicerequestactorid")
);

-- Model(s): Intakeservicerequestagency
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestagency" (
    "intakeservicerequestagencyid" uuid DEFAULT gen_random_uuid(),
    "agencyid" uuid,
    "description" text,
    "agencyroletypekey" varchar(15),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "timestamp" bytea,
    "intakeserviceid" uuid,
    "routingaddressid" uuid,
    "expirationdate" timestamp,
    "activeflag" integer,
    "agencytypekey" varchar(15),
    "old_id" varchar(50),
    "referralid" varchar(50),
    "servicereferralflag" integer,
    "reasonnoref" varchar(500),
    "comments" varchar(500),
    "roacpsstatetypekey" varchar(5),
    "screeningid" varchar(50),
    "statecountycode" varchar(100),
    "otherresource" varchar(250),
    "resourcetypes" json,
    "servicerequesttypekey" varchar(50),
    PRIMARY KEY ("intakeservicerequestagencyid")
);

-- Model(s): Intakeservicerequestappeal
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestappeal" (
    "appealid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "appealdate" timestamp,
    "servicerequesttypeconfigdispostionid" uuid,
    "effectivedate" timestamp,
    "remarks" varchar(500),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("appealid")
);

-- Model(s): Intakeservicerequestclearingdata
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestclearingdata" (
    "intakeservicerequestclearingid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "activeflag" integer,
    "entitytype" varchar(50),
    "entitytypeid" varchar(50),
    "clearingtype" varchar(20),
    "result" varchar(20),
    "medicaidtype" varchar(20),
    "eligibilitydate" timestamp,
    "enddate" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "fromentitytypeid" uuid,
    "clearingdata" text,
    PRIMARY KEY ("intakeservicerequestclearingid")
);

-- Model(s): Intakeservicerequestconsultreview
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestconsultreview" (
    "intakeservicerequestconsultreviewid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "objectid" uuid,
    "objecttypekey" varchar(255),
    "name" varchar(100),
    "date" timestamp,
    "notes" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("intakeservicerequestconsultreviewid")
);

-- Model(s): Intakeservicerequestconsultreviewconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestconsultreviewconfig" (
    "intakeservicerequestconsultreviewconfigid" uuid DEFAULT gen_random_uuid(),
    "intakeservicerequestconsultreviewid" uuid,
    "name" varchar(100),
    "consultreviewusertypekey" varchar(100),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("intakeservicerequestconsultreviewconfigid")
);

-- Model(s): Intakeservicerequestcourtaction
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestcourtaction" (
    "intakeservicerequestcourtactionid" uuid DEFAULT gen_random_uuid(),
    "intakeservicerequestid" uuid,
    "legalcounselname" varchar(500),
    "magistratename" varchar(500),
    "workername" varchar(500),
    "hearingdatetime" timestamp,
    "courtordertypekey" varchar(50),
    "courtorderdatetime" timestamp,
    "conditiontypekey" varchar(50),
    "conditiontypedescription" text,
    "conditiontypecompletiondatetime" timestamp,
    "terminationdatetime" timestamp,
    "adjudicationdatetime" timestamp,
    "adjudicationdecision" varchar(500),
    "allegationid" uuid,
    "intakeservicerequestpetitionid" uuid,
    "courtcasenumber" varchar(50),
    "jurisdiction" varchar(50),
    "hearingstatustypekey" varchar(50),
    "decisionnotes" varchar(500),
    "nexthearingdate" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "courtactiontypekey" varchar(500),
    "courtorderedlanguage" varchar(500),
    "hearingoutcome" varchar(500),
    "intakenumber" varchar(50),
    "intakeservicerequestcourthearingid" uuid,
    "othercourtactiontypenotes" text,
    "saocountyid" uuid,
    "saotransfernotes" varchar(5000),
    "isdispositioncreated" boolean,
    "expirationdate" timestamp,
    "issendtoccu" boolean,
    "restitutiondocpath" varchar(500),
    PRIMARY KEY ("intakeservicerequestcourtactionid")
);

-- Model(s): Intakeservicerequestcourtactiontype
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestcourtactiontype" (
    "intakeservicerequestcourtactiontypeid" uuid DEFAULT gen_random_uuid(),
    "intakeservicerequestcourtactionid" uuid,
    "courtactiontypekey" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "courtactionallegationconfigid" uuid,
    PRIMARY KEY ("intakeservicerequestcourtactiontypeid")
);

-- Model(s): Intakeservicerequestcourtconditiontypeconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestcourtconditiontypeconfig" (
    "intakeservicerequestcourtconditiontypeconfigid" uuid DEFAULT gen_random_uuid(),
    "intakeservicerequestcourtactionid" uuid,
    "conditiontypekey" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "courtactionallegationconfigid" uuid,
    "conditiontypedescription" text,
    "completiondate" timestamp,
    PRIMARY KEY ("intakeservicerequestcourtconditiontypeconfigid")
);

-- Model(s): Intakeservicerequestcourthearing
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestcourthearing" (
    "intakeservicerequestcourthearingid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "servicecaseid" uuid,
    "intakeservicerequestpetitionid" uuid,
    "courtcasenumber" varchar(50),
    "hearingtypekey" varchar(50),
    "hearingtype" json,
    "hearingdatetime" timestamp,
    "statekey" varchar(50),
    "countyid" uuid,
    "focusname" varchar(200),
    "judgename" varchar(200),
    "hearingstatustypekey" varchar(50),
    "changeofpermanency" boolean,
    "datenoticehearing" date,
    "hearingnotes" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "intakenumber" varchar(50),
    "associatedattorneys" varchar(500),
    "transferpetitionid" varchar(50),
    "transfernotes" text,
    "otherhearingtypenotes" text,
    "nofurtherinvolvementflag" integer,
    "exceptionappealfiledflag" integer,
    "exceptionappealflag" integer,
    "nexthearingdate" timestamp,
    "nexthearingtime" timestamp,
    "nexthearingtype" json,
    "benefitsdate" timestamp,
    "parent1actorid" uuid,
    "parent1personid" uuid,
    "parent1name" varchar(255),
    "parent1unknown" boolean,
    "parent2actorid" uuid,
    "parent2personid" uuid,
    "parent2name" varchar(255),
    "parent2unknown" boolean,
    PRIMARY KEY ("intakeservicerequestcourthearingid")
);

-- Model(s): Intakeservicerequestcourthearingconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestcourthearingconfig" (
    "intakeservicerequestcourthearingconfigid" uuid,
    "intakeservicerequestcourthearingid" uuid,
    "nexthearingtypekey" varchar(50),
    "nexthearingdatetime" timestamp,
    "nexthearingnotes" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp
);

-- Model(s): Intakeservicerequestcourtordertypeconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestcourtordertypeconfig" (
    "intakeservicerequestcourtordertypeconfigid" uuid DEFAULT gen_random_uuid(),
    "intakeservicerequestcourtactionid" uuid,
    "courtordertypekey" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "courtactionallegationconfigid" uuid,
    PRIMARY KEY ("intakeservicerequestcourtordertypeconfigid")
);

-- Model(s): Intakeservicerequestcrossreference
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestcrossreference" (
    "fromintakeservicerequestid" uuid,
    "withintakeservicerequestid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "timestamp" bytea,
    "intakeservicerequestcrossreferencereasontypekey" varchar(15),
    "coreferred" boolean,
    "ogcreferred" boolean,
    "intakeservicerequestcrossrefernceid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    PRIMARY KEY ("intakeservicerequestcrossrefernceid")
);

-- Model(s): Intakeservicerequestcrossreferencereasontype
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestcrossreferencereasontype" (
    "sequencenumber" integer,
    "intakeservicerequestcrossreferencereasontypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("intakeservicerequestcrossreferencereasontypekey")
);

-- Model(s): Intakeservicerequestdispositioncode
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestdispositioncode" (
    "intakeservicerequestdispositioncodeid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "statusdate" timestamp,
    "description" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "expirationdate" timestamp,
    "effectivedate" timestamp,
    "intakeserreqstatustypeid" uuid,
    "servicerequesttypeconfigiddispostionid" uuid,
    "dateofsubpoena" timestamp,
    "subpoenareason" varchar(255),
    "lastfacetofacedate" timestamp,
    "seenwithin" integer,
    "dateseen" timestamp,
    "timestamp" bytea,
    "reviewcomments" text,
    "closingcodetypekey" varchar(255),
    PRIMARY KEY ("intakeservicerequestdispositioncodeid")
);

-- Model(s): Intakeservicerequestevaluation
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestevaluation" (
    "intakeservicerequestevaluationid" uuid DEFAULT gen_random_uuid(),
    "objectid" uuid,
    "intakenumber" varchar(50),
    "isdetention" boolean,
    "isdrai" boolean,
    "ismcasp" boolean,
    "countyid" uuid,
    "complaintid" varchar(100),
    "evaluationsourcetypeid" uuid,
    "evaluationsourceagencyid" uuid,
    "yearsofage" numeric(5,2),
    "complaintreceiveddate" timestamp,
    "arrestdate" timestamp,
    "zipcode" integer,
    "unknownrange" integer,
    "offensedate" timestamp,
    "begindate" timestamp,
    "enddate" timestamp,
    "evaluationsourceid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "expirationdate" timestamp,
    "complaintstatustypekey" varchar(15),
    "offencelocationtypekey" varchar(15),
    PRIMARY KEY ("intakeservicerequestevaluationid")
);

-- Model(s): Intakeservicerequestevaluationadjudicateconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestevaluationadjudicateconfig" (
    "intakeservicerequestevaluationadjudicateconfigid" uuid DEFAULT gen_random_uuid(),
    "intakeservicerequestevaluationconfigid" uuid,
    "adjudicateddecisiontypekey" varchar(255),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("intakeservicerequestevaluationadjudicateconfigid")
);

-- Model(s): Intakeservicerequestevaluationconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestevaluationconfig" (
    "intakeservicerequestevaluationconfigid" uuid,
    "intakeservicerequestevaluationid" uuid,
    "allegationid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "expirationdate" timestamp,
    "effectivedate" timestamp,
    "offenceaddedtype" varchar(255)
);

-- Model(s): Intakeservicerequestgroup
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestgroup" (
    "groupid" uuid DEFAULT gen_random_uuid(),
    "groupnumber" varchar(50),
    "groupsummary" text,
    "description" varchar(256),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "expirationdate" timestamp,
    "effectivedate" timestamp,
    "timestamp" bytea,
    "groupreasontypekey" varchar(50),
    "dispositioncode" varchar(15),
    PRIMARY KEY ("groupid")
);

-- Model(s): Intakeservicerequestgroupdetails
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestgroupdetails" (
    "groupdetlid" uuid DEFAULT gen_random_uuid(),
    "groupid" uuid,
    "intakeserviceid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "expirationdate" timestamp,
    "effectivedate" timestamp,
    "timestamp" bytea,
    PRIMARY KEY ("groupdetlid")
);

-- Model(s): Intakeservicerequestillegalactivity
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestillegalactivity" (
    "intakeservicerequestillegalactivityid" uuid DEFAULT gen_random_uuid(),
    "intakeservicerequestillegalactivitytypekey" varchar(15),
    "intakeservicerequestid" uuid,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "timestamp" bytea,
    PRIMARY KEY ("intakeservicerequestillegalactivityid")
);

-- Model(s): Intakeservicerequestillegalactivitytype
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestillegalactivitytype" (
    "sequencenumber" integer,
    "intakeservicerequestillegalactivitytypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("intakeservicerequestillegalactivitytypekey")
);

-- Model(s): Intakeservicerequestinputsource
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestinputsource" (
    "intakeservreqinputsourceid" uuid DEFAULT gen_random_uuid(),
    "intakeservreqinputsourcekey" varchar(15),
    "description" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("intakeservreqinputsourceid")
);

-- Model(s): Intakeservicerequestinputtype
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestinputtype" (
    "intakeservreqinputtypeid" uuid DEFAULT gen_random_uuid(),
    "intakeservreqinputtypekey" varchar(15),
    "description" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "archiveon" timestamp,
    "archiveby" varchar(50),
    "timestamp" bytea,
    "activeflag" integer,
    "isdjs" boolean,
    PRIMARY KEY ("intakeservreqinputtypeid")
);

-- Model(s): Intakeservicerequestpetition
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestpetition" (
    "intakeservicerequestpetitionid" uuid DEFAULT gen_random_uuid(),
    "intakeservicerequestid" uuid,
    "servicecaseid" uuid,
    "intakenumber" varchar(50),
    "petitionid" varchar(50),
    "associatedattorneys" varchar(500),
    "complaintid" varchar(500),
    "transferpetitionid" varchar(50),
    "petitionfiled" boolean,
    "hearingdatetime" timestamp,
    "hearingtypekey" varchar(50),
    "hearingnotes" varchar(500),
    "teamtypekey" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "petitionfocusname" varchar(200),
    "petitiontypekey" varchar(50),
    "petitionstatustypekey" varchar(50),
    "courtcasenumber" varchar(20),
    "petitiondate" timestamp,
    "vopversion" integer,
    "aggravatedtypekey" varchar(25),
    "witness1" varchar(50),
    "clientactorsid" uuid,
    PRIMARY KEY ("intakeservicerequestpetitionid")
);

-- Model(s): Intakeservicerequestpetitionactor
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestpetitionactor" (
    "intakeservicerequestpetitionactorid" uuid DEFAULT gen_random_uuid(),
    "intakeservicerequestpetitionid" uuid,
    "intakeservicerequestactorid" uuid,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "petitionactortype" varchar(20),
    PRIMARY KEY ("intakeservicerequestpetitionactorid")
);

-- Model(s): Intakeservicerequestplantype
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestplantype" (
    "sequencenumber" integer,
    "intakeservicerequestplantypekey" varchar(50),
    "activeflag" integer,
    "typedescription" varchar(100),
    "datavalue" integer,
    "editable" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("intakeservicerequestplantypekey")
);

-- Model(s): Intakeservicerequestpurpose
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestpurpose" (
    "intakeservreqpurposeid" uuid DEFAULT gen_random_uuid(),
    "intakeservreqpurposekey" varchar(15),
    "description" text,
    "intakeagencyid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("intakeservreqpurposeid")
);

-- Model(s): Intakeservicerequestreferral
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestreferral" (
    "referralid" uuid,
    "intakeserviceid" uuid,
    "danumber" varchar(15),
    "documentdate" timestamp,
    "reason" varchar(150),
    "referredto" varchar(150),
    "status" varchar(50),
    "disposition" varchar(150),
    "assignedto" varchar(250),
    "referralnote" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp
);

-- Model(s): Intakeservicerequestreferraldetail
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestreferraldetail" (
    "intakeservicerequestreferraldetailid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "referralreasontypekey" varchar(50),
    "referralorgtypekey" varchar(15),
    "description" varchar(250),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "referreddate" timestamp,
    "referalnote" text,
    "activeflag" integer,
    PRIMARY KEY ("intakeservicerequestreferraldetailid")
);

-- Model(s): Intakeservicerequestsafetyplan
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestsafetyplan" (
    "safetyplanid" uuid DEFAULT gen_random_uuid(),
    "versionid" uuid,
    "intakeserviceid" uuid,
    "external_templateid" varchar(50),
    "assessmenttemplateid" uuid,
    "plandate" timestamp,
    "dangerinfluencenumber" varchar(250),
    "dangerinfluencedesc" text,
    "completiondate" timestamp,
    "partiesname" varchar(250),
    "submissionid" varchar(250),
    "reevaluationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("safetyplanid")
);

-- Model(s): Intakeservicerequestsafetyplanaction
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestsafetyplanaction" (
    "safetyplanactionid" uuid DEFAULT gen_random_uuid(),
    "safetyplanid" uuid,
    "actiondescription" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("safetyplanactionid")
);

-- Model(s): Intakeservicerequestsdm
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestsdm" (
    "intakeservicerequestsdmid" uuid,
    "intakeserviceid" uuid,
    "referralname" varchar(100),
    "referraldob" varchar(255),
    "referralid" varchar(100),
    "countyid" uuid,
    "ismalpa_suspeciousdeath" boolean,
    "ismaltreatment" boolean,
    "ismalpa_nonaccident" boolean,
    "ismalpa_injuryinconsistent" boolean,
    "ismalpa_insjury" boolean,
    "ismalpa_childtoxic" boolean,
    "ismalpa_caregiver" boolean,
    "ismalpa_labortrafficking" boolean,
    "ismalsa_sexualmolestation" boolean,
    "ismalsa_sexualact" boolean,
    "ismalsa_sexualexploitation" boolean,
    "ismalsa_physicalindicators" boolean,
    "isneggn_suspiciousdeath" boolean,
    "isneggn_signsordiagnosis" boolean,
    "isneggn_inadequatefood" boolean,
    "isneggn_exposuretounsafe" boolean,
    "isneggn_inadequateclothing" boolean,
    "isneggn_inadequatesupervision" boolean,
    "isnegrh_treatmenthealthrisk" boolean,
    "isneggn_childdischarged" boolean,
    "isnegfp_cargiverintervene" boolean,
    "isneguc_leftunsupervised" boolean,
    "isneguc_leftaloneinappropriatecare" boolean,
    "isneguc_leftalonewithoutsupport" boolean,
    "isnegrh_priordeath" boolean,
    "isnegrh_sexualperpetrator" boolean,
    "isnegrh_basicneedsunmet" boolean,
    "isnegrh_sex_offender" boolean,
    "isnegrh_risk_dv" boolean,
    "isnegrh_sex_trafficking" boolean,
    "isnegrh_fatality_can" boolean,
    "isnegrh_indicated_unsub" boolean,
    "isnegrh_survivor" boolean,
    "isnegrh_birth_match" boolean,
    "isnegmn_unreasonabledelay" boolean,
    "ismenab_psycologicalability" boolean,
    "ismenng_psycologicalability" boolean,
    "isrecsc_screenout" boolean,
    "isrecsc_scrrenin" boolean,
    "isrecovr_no" boolean,
    "isrecovr_scrrenin" boolean,
    "isreccps_screenout" boolean,
    "isrec_imlist" boolean,
    "isrec_reportallegtion" boolean,
    "isrec_noimmediate" boolean,
    "officerfirstname" varchar(150),
    "officermiddlename" varchar(150),
    "officerlastname" varchar(150),
    "badgenumber" varchar(150),
    "recordnumber" varchar(150),
    "workerdate" varchar(255),
    "supervisordate" varchar(255),
    "worker" varchar(150),
    "supervisor" varchar(150),
    "reportdate" varchar(255),
    "issexualabuse" boolean,
    "isoutofhome" boolean,
    "isdeathorserious" boolean,
    "islabortrafficking" boolean,
    "isrisk" boolean,
    "isreportmeets" boolean,
    "issignordiagonises" boolean,
    "ismaltreatment3yrs" boolean,
    "ismaltreatment12yrs" boolean,
    "ismaltreatment24yrs" boolean,
    "isactiveinvestigation" boolean,
    "isreportedhistory" boolean,
    "ismultiple" boolean,
    "isdomesticvoilence" boolean,
    "isthread" boolean,
    "islawenforcement" boolean,
    "iscourtiinvestigation" boolean,
    "isar" boolean,
    "isir" boolean,
    "isscrninrecovr_courtorder" boolean,
    "isscrninrecovr_otherspecify" boolean,
    "isscrnoutrecovr_insufficient" boolean,
    "isscrnoutrecovr_information" boolean,
    "isscrnoutrecovr_historicalinformation" boolean,
    "isscrnoutrecovr_otherspecify" boolean,
    "isimmed_childfaatility" boolean,
    "isimmed_seriousinjury" boolean,
    "isimmed_childleftalone" boolean,
    "isimmed_allegation" boolean,
    "isimmed_otherspecify" boolean,
    "iscriminalhistory" boolean,
    "isnoimmed_physicalabuse" boolean,
    "isnoimmed_sexualabuse" boolean,
    "isnoimmed_neglectresponse" boolean,
    "isnoimmed_mentalinjury" boolean,
    "iscps" boolean,
    "isfinalscreenin" boolean,
    "yesdatadescription" varchar(200),
    "old_id" varchar(50),
    "intakenumber" varchar(20),
    "comments" varchar(250),
    "scrnin_description" varchar(255),
    "scrnout_description" varchar(255),
    "status" integer,
    "isfcplacementsetting" boolean,
    "isprivateplacement" boolean,
    "islicenseddaycare" boolean,
    "isschool" boolean,
    "isfclivingarrangement" boolean,
    "ischildfatality" boolean,
    "linkschidresid" boolean,
    "lawenforcementid" integer,
    "selectedplacement" varchar(255),
    "lawenfmtreferralid" integer,
    "lawenfmtdispatcherflag" integer,
    "lawenfmtofficerprefixtypekey" varchar(5),
    "lawenfmtofficersuffixtypekey" varchar(5),
    "lawenfmtext" varchar(20),
    "lawdistrict" varchar(20),
    "lawenfmtofficerphone" varchar(20),
    "lawenfmtinsertedby" varchar(10),
    "lawenfmtupdatedby" varchar(10),
    "cpsscreeningname" varchar(50),
    "cpsscreenoutother" varchar(500),
    "cpsscreeniher" varchar(500),
    "childabandoned" varchar(500),
    "immediateother" varchar(500),
    "cpsagencyname" varchar(50),
    "adrformattypekey" varchar(5),
    "adrpredirtypekey" varchar(5),
    "adrstreetname" varchar(50),
    "adrstreetsuffixtypekey" varchar(5),
    "adrpostdirtypekey" varchar(5),
    "adrunittypekey" varchar(5),
    "adrunitno" varchar(5),
    "adrcityname" varchar(50),
    "adrstatetypekey" varchar(5),
    "adrdirection" varchar(500),
    "adrforeign" varchar(500),
    "adrforeignstate" varchar(50),
    "adrcountry" varchar(50),
    "adrpostalcode" varchar(50),
    "adrworkphone" varchar(50),
    "adrworkxtn" varchar(50),
    "adremail" varchar(100),
    "adrfax" varchar(50),
    "adrurl" varchar(100),
    "adrothercontact" varchar(100),
    "adrstreettext" varchar(500),
    "oohmaltsettingtypekey" varchar(5),
    "associatedentitytypekey" varchar(5),
    "screeninglawofficerprefixtypekey" varchar(5),
    "screeninglawofficersuffixtypekey" varchar(5),
    "screeningext" varchar(20),
    "screeninglawdistrict" varchar(20),
    "screeningofficerphone" varchar(10),
    "screeninginsertedby" varchar(10),
    "screeningupdatedby" varchar(10),
    "old_cps_id" varchar(10),
    "screeningupdatedon" varchar(255),
    "screeninginsertedon" varchar(255),
    "screeninglawifiedttime" varchar(255),
    "screeninglawifieddate" varchar(255),
    "intinvfinaldate" varchar(255),
    "allegedmaltreatmentdate" varchar(255),
    "lawenfmtupdatedon" varchar(255),
    "lawenfmtinsertedon" varchar(255),
    "lawifiedtime" varchar(255),
    "lawifieddate" varchar(255),
    "lawenfmtactiveflag" integer,
    "lawenfmtcaseid" integer,
    "drugexposednewbornflag" integer,
    "maltreatmentcompleteflag" integer,
    "cpsscreenoutotherflag" integer,
    "newnoncpsrefflag" integer,
    "cpsscreeniherflag" integer,
    "adrstreetno" integer,
    "adrboxno" integer,
    "immediateotherflag" integer,
    "screeninoverrideflag" integer,
    "noscreeninoverridesflag" integer,
    "screenoutascpsflag" integer,
    "screeninonemalflag" integer,
    "adrzip5no" integer,
    "adrzip4no" integer,
    "outofhomeflag" integer,
    "communicationastncrqrdflag" integer,
    "cpslawifiedflag" integer,
    "cpscomplaintno" integer,
    "lawofficerassignedflag" integer,
    "cpsproviderid" integer,
    "intinvfinalflag" integer,
    "orderofshelterflag" integer,
    "maltscreencompleteflag" integer,
    "decisioncompleteflag" integer,
    "physicalabusesdflag" integer,
    "malnegchildabandonedflag" integer,
    "noimdrspscninovrdeflag" integer,
    "finalscreenoutonemalflag" integer,
    "doassociateflag" integer,
    "associatedentitykeyid" integer,
    "duplicatereportflag" integer,
    "initrecommrohonlyncpsflag" integer,
    "finalrecommrohonlyncpsflag" integer,
    "resptimerohonlysenflag" integer,
    "resptimerohonlynonsenflag" integer,
    "substantialriskofharmflag" integer,
    "physicaltreatmentriskflag" integer,
    "screeninglawenforcementid" integer,
    "screeninglawenfmtid" integer,
    "screeningdispatcherflag" integer,
    "screeningactiveflag" integer,
    "issubexpnewborn" integer,
    "isriskcso" integer,
    "isriskvoilence" integer,
    "iscgimpairment" integer,
    "islivinginhome" integer,
    "isdeathan" integer,
    "issextrafficking" integer,
    "isadultsurvivor" integer,
    "isbirthmatchtpr" integer,
    "isbirthmatchcriminal" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp
);

-- Model(s): Intakeservicerequesttype
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequesttype" (
    "intakeservreqtypeid" uuid DEFAULT gen_random_uuid(),
    "intakeservreqtypekey" varchar(15),
    "description" varchar(250),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "archiveon" timestamp,
    "archiveby" varchar(50),
    "workloadweight" integer,
    "investigatable" boolean,
    "activeflag" integer,
    PRIMARY KEY ("intakeservreqtypeid")
);

-- Model(s): Intakeservicerequestweaver
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestweaver" (
    "intakeservicerequestweaverid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "intakeservicerequestweavertypekey" varchar(15),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "archiveon" timestamp,
    "archiveby" varchar(50),
    "timestamp" bytea,
    "activeflag" integer,
    PRIMARY KEY ("intakeservicerequestweaverid")
);

-- Model(s): Intakeservicerequestweavertype
CREATE TABLE IF NOT EXISTS "cjams"."intakeservicerequestweavertype" (
    "sequencenumber" integer,
    "intakeservicerequestweavertypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("intakeservicerequestweavertypekey")
);

-- Model(s): Intakeservreqadultscreentool
CREATE TABLE IF NOT EXISTS "cjams"."intakeservreqadultscreentool" (
    "intakeservreqadultscreentoolid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "astdate" timestamp,
    "intakeworker" varchar(200),
    "countyid" uuid,
    "referralname" varchar(200),
    "referralphone" varchar(200),
    "referraladdress1" varchar(200),
    "referraladdress2" varchar(200),
    "referralremainanonymous" varchar(200),
    "referralrelationship" varchar(200),
    "clientinfoname" varchar(200),
    "clientinfodob" timestamp,
    "clientinfoage" varchar(200),
    "gendertypekey" varchar(200),
    "racetypekey" varchar(200),
    "ethnicitytypekey" varchar(200),
    "clientinfoaddress1" varchar(200),
    "clientinfoaddress2" varchar(200),
    "clientinfophone" varchar(200),
    "maritalstatuskey" varchar(200),
    "monthlyincome" varchar(200),
    "monthlyincomesource" varchar(200),
    "totalassets" varchar(200),
    "totalassetssource" varchar(200),
    "additionalinfo" varchar(200),
    "riskaggrpets" varchar(200),
    "riskhomehazards" varchar(200),
    "riskfireharms" varchar(200),
    "riskpsychiatric" varchar(200),
    "riskcdsabuse" varchar(200),
    "riskmedical" varchar(200),
    "riskdomviolence" varchar(200),
    "riskother" varchar(200),
    "riskcomments" varchar(200),
    "detailsofreferralcomments" varchar(200),
    "healthcarekey" varchar(200),
    "transportationkey" varchar(200),
    "cluttertypekey" varchar(200),
    "foodtypekey" varchar(200),
    "housingtypekey" varchar(200),
    "supervisiontypekey" varchar(200),
    "IndividualVulnerable" varchar(200),
    "eatingfeedingkey" varchar(200),
    "takingmedicationkey" varchar(200),
    "walkingkey" varchar(200),
    "bathingkey" varchar(200),
    "dressingkey" varchar(200),
    "toiletkey" varchar(200),
    "physicalrisksnotes" varchar(200),
    "dementiakey" varchar(200),
    "thoughtdisorderskey" varchar(200),
    "substanceabusekey" varchar(200),
    "mooddisorderskey" varchar(200),
    "behavioralissueskey" varchar(200),
    "mentalchallengesnotes" varchar(200),
    "supportnetworkkey" varchar(200),
    "supportnetworknotes" varchar(200),
    "riskscore" varchar(200),
    "risklevel" varchar(200),
    "intakerecommendation" varchar(200),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("intakeservreqadultscreentoolid")
);

-- Model(s): Intakeservreqchildremoval
CREATE TABLE IF NOT EXISTS "cjams"."intakeservreqchildremoval" (
    "intakeservreqchildremovalid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "assessmentid" uuid,
    "intakeservicerequestactorid" uuid,
    "personid" uuid,
    "rmvdfrmisractorid" uuid,
    "agencytypekey" varchar(15),
    "fathername" varchar(150),
    "mothername" varchar(150),
    "rmvdfrmpersonname" varchar(150),
    "removalreasontypeid" uuid,
    "removaladd1" varchar(150),
    "removaladd2" varchar(150),
    "removalzip" varchar(25),
    "removalstatecd" varchar(10),
    "removalcity" varchar(100),
    "removaldate" timestamp,
    "removaltime" timestamp,
    "familystructuretypekey" varchar(5),
    "primarycaregiverid" integer,
    "vpabegindate" date,
    "parent1id" bigint,
    "vpaparentssigneddate" date,
    "agencysigneddate" timestamp,
    "isbothparentssigned" integer,
    "reasonableeffortsmade" varchar(50),
    "childfactorsentry" varchar(250),
    "removaltypekey" varchar(50),
    "environmentatremovalkey" varchar(50),
    "removalid" bigint,
    "primarycaregiveractorid" uuid,
    "seccaregiveractorid" uuid,
    "seccaregiveradd" varchar(50),
    "primarycaregiveradd" varchar(50),
    "volrelinquishment" integer,
    "isverifiedreporteradd" integer,
    "isverifiedcaregiver1add" integer,
    "isverifiedcaregiver2add" integer,
    "relativeactorid" uuid,
    "isdisability" integer,
    "servicecaseid" uuid,
    "vpaenddate" date,
    "vpayouthsigneddate" date,
    "parent2id" bigint,
    "guardianid" bigint,
    "parent2signeddate" date,
    "vpaguardiansigneddate" date,
    "comments" varchar(255),
    "justification" varchar(255),
    "specifiedrelativedatechildlastlivedwith" date,
    "specifiedrelativename" varchar(50),
    "showcontactpage" boolean,
    "parent2comments" varchar(255),
    "returndate" timestamp,
    "returntime" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "ischildaddressasprimaryaddress" integer,
    "childphysicalremovaladdress" varchar(50),
    "ischildphysicalremovaladdressverified" integer,
    "isuploadedmanually" integer,
    "isshelterauthcompleted" integer,
    "exitdate" timestamp,
    "returntransts" date,
    "removalexitreason" varchar(250),
    "actualdata" json,
    "removalcircumstances" json,
    PRIMARY KEY ("intakeservreqchildremovalid")
);

-- Model(s): Intakeservreqchildremovalreason
CREATE TABLE IF NOT EXISTS "cjams"."intakeservreqchildremovalreason" (
    "intakeservreqchildremovalreasonid" uuid,
    "intakeservreqchildremovalid" uuid,
    "removalreasontypekey" varchar(150),
    "inputtypekey" varchar(15),
    "otherdescription" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp
);

-- Model(s): Intakeservreqcohearingoutcome
CREATE TABLE IF NOT EXISTS "cjams"."intakeservreqcohearingoutcome" (
    "intakeservreqcohearingoutcomeid" uuid DEFAULT gen_random_uuid(),
    "intakeservreqcourtorderid" uuid,
    "hearingoutcometypekey" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("intakeservreqcohearingoutcomeid")
);

-- Model(s): Intakeservreqcourtorder
CREATE TABLE IF NOT EXISTS "cjams"."intakeservreqcourtorder" (
    "intakeservreqcourtorderid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "servicecaseid" uuid,
    "intakeservicerequestpetitionid" uuid,
    "hearingoutcometypekey" varchar(25),
    "courtorderdate" timestamp,
    "remarks" varchar(250),
    "courtorderdelayremoval" boolean,
    "courtorderdelaytimeframe" smallint,
    "childpermanencyplankey" varchar(20),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "coreceiveddate" timestamp,
    "intakeservicerequesthearingid" uuid,
    "removalid" bigint,
    "intakeservicerequestactorid" uuid,
    "dob" timestamp,
    "county" varchar(255),
    "clientname" varchar(255),
    "personsappeared" json,
    "courtreview" varchar(255),
    "childsneed" varchar(255),
    "childneedcantmet" boolean,
    "childpermanencyplan" boolean,
    "childmosteffplan" boolean,
    "qrtpapproval" varchar(255),
    "judgedate" timestamp,
    "judgename" varchar(255),
    "judgeid" varchar(255),
    "qrtpapprovaldecision" varchar(255),
    "otherpersonsappeared" varchar(255),
    PRIMARY KEY ("intakeservreqcourtorderid")
);

-- Model(s): Intakeservreqcourtorderdetails
CREATE TABLE IF NOT EXISTS "cjams"."intakeservreqcourtorderdetails" (
    "intakeservreqcourtorderdetailsid" uuid DEFAULT gen_random_uuid(),
    "intakeservreqcourtorderid" uuid,
    "checklistid" uuid,
    "checklisttypekey" varchar(50),
    "isselected" integer,
    "remarks" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("intakeservreqcourtorderdetailsid")
);

-- Model(s): Intakeservreqdispclosingcodeconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeservreqdispclosingcodeconfig" (
    "intakeservreqdispclosingcodeconfigid" uuid DEFAULT gen_random_uuid(),
    "intakeservicerequestdispositioncodeid" uuid,
    "closingcodetypekey" varchar(150),
    "issupport" boolean,
    "supporttypekey" varchar(150),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("intakeservreqdispclosingcodeconfigid")
);

-- Model(s): Intakeservreqdispprogramcodeconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeservreqdispprogramcodeconfig" (
    "intakeservreqdispprogramcodeconfigid" uuid DEFAULT gen_random_uuid(),
    "intakeservicerequestdispositioncodeid" uuid,
    "programcodetypekey" varchar(150),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("intakeservreqdispprogramcodeconfigid")
);

-- Model(s): Intakeservreqevalactorconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeservreqevalactorconfig" (
    "intakeservreqevalactorconfigid" uuid,
    "intakeservicerequestevaluationid" uuid,
    "intakeservicerequestactorid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp
);

-- Model(s): Intakeservreqevalpetitionconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeservreqevalpetitionconfig" (
    "intakeservreqevalpetitionconfigid" uuid,
    "intakeservicerequestevaluationid" uuid,
    "intakeservicerequestpetitionid" uuid,
    "intakenumber" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "forwardcomplaintstatustype" varchar(255)
);

-- Model(s): Intakeservreqevaluationconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeservreqevaluationconfig" (
    "intakeservreqevaluationconfigid" uuid,
    "intakeserviceid" uuid,
    "intakeservicerequestevaluationid" uuid,
    "intakenumber" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp
);

-- Model(s): Intakeservreqguradmeetingconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeservreqguradmeetingconfig" (
    "intakeservreqguradmeetingconfigid" uuid DEFAULT gen_random_uuid(),
    "guardinshipmeetingid" uuid,
    "intakeserviceid" uuid,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("intakeservreqguradmeetingconfigid")
);

-- Model(s): Intakeservreqinputtypeagency
CREATE TABLE IF NOT EXISTS "cjams"."intakeservreqinputtypeagency" (
    "intakeservreqinputtypeagencyid" uuid DEFAULT gen_random_uuid(),
    "agencykey" varchar(15),
    "description" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("intakeservreqinputtypeagencyid")
);

-- Model(s): Intakeservreqpetitioncourtconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeservreqpetitioncourtconfig" (
    "intakeservreqpetitioncourtconfigid" uuid,
    "intakeservicerequestpetitionid" uuid,
    "intakeservicerequestcourtactionid" uuid,
    "intakenumber" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp
);

-- Model(s): Intakeservreqpetitionhearingconfig
CREATE TABLE IF NOT EXISTS "cjams"."intakeservreqpetitionhearingconfig" (
    "intakeservreqpetitionhearingconfigid" uuid,
    "intakeservicerequestpetitionid" uuid,
    "intakeservicerequestcourthearingid" uuid,
    "intakenumber" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp
);

-- Model(s): Intakeservsubtype
CREATE TABLE IF NOT EXISTS "cjams"."intakeservsubtype" (
    "intakeservsubtypeid" uuid DEFAULT gen_random_uuid(),
    "intakeservid" uuid,
    "intakeservsubtypekey" varchar(15),
    "typedescription" varchar(250),
    "displayorder" numeric,
    "activeflag" integer,
    PRIMARY KEY ("intakeservsubtypeid")
);

-- Model(s): Intaketransfers
CREATE TABLE IF NOT EXISTS "cjams"."intaketransfers" (
    "intakeserviceid" varchar(100),
    "transferdate" timestamp,
    "sendingcountyid" uuid,
    "requestedby" uuid,
    "receivingcountyid" integer,
    "approvedby" uuid,
    "receivingcountyworker" uuid,
    "transferreason" varchar(255),
    "rejectionreason" varchar(255),
    "approvalstatus" varchar(255),
    "approvedon" timestamp,
    "insertedby" uuid,
    "insertedon" timestamp,
    "updatedby" uuid,
    "updatedon" timestamp,
    "activeflag" integer,
    "old_id" varchar(50)
);

-- Model(s): Investigation
CREATE TABLE IF NOT EXISTS "cjams"."investigation" (
    "investigationid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "fatalitycommentaudittrail" varchar(255),
    "intakeserviceid" uuid,
    "riskscore" integer,
    "reviewdate" timestamp,
    "targetcompletiondate" timestamp,
    "completiondate" timestamp,
    "investigationsummary" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "cursoryreviewid" uuid,
    "edl" boolean,
    "financial" boolean,
    "jointinvestigation" boolean,
    "investigationreviewtypekey" varchar(50),
    "investigationreviewtypedate" timestamp,
    PRIMARY KEY ("investigationid")
);

-- Model(s): Investigationallegation
CREATE TABLE IF NOT EXISTS "cjams"."investigationallegation" (
    "investigationallegationid" uuid DEFAULT gen_random_uuid(),
    "investigationid" uuid,
    "allegationid" uuid,
    "investigationmaltreatmentactorid" uuid,
    "name" varchar(256),
    "reported" boolean,
    "indicators" text,
    "sextrafficking" integer,
    "isproviderinvolved" integer,
    "ischildfatality" integer,
    "fatalitycomments" varchar(50),
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "financial" boolean,
    "incidentdate" timestamp,
    "maltreatmentid" uuid,
    "comments" text,
    "injurycomments" text,
    "enddate" timestamp,
    "isapproximatedate" integer,
    "timeofincidence" timestamp,
    "incidentlocationtypekey" varchar(255),
    "investigationallegationstatus" varchar(50),
    "outcome" varchar(250),
    "relationshiptypekey" varchar(50),
    "victim_explanation" varchar(500),
    "sibling_explanation" varchar(500),
    "guardian_explanation" varchar(500),
    "maltreator_explanation" varchar(500),
    "med_assessmnts" varchar(500),
    "expert_assessmnts" varchar(500),
    "collateral_interviews" varchar(500),
    "criminal_history_inv" varchar(500),
    "home_conditions" varchar(500),
    "law_enforcement_inv" text,
    PRIMARY KEY ("investigationallegationid")
);

-- Model(s): Investigationallegationactor
CREATE TABLE IF NOT EXISTS "cjams"."investigationallegationactor" (
    "investigationallegationactorid" uuid DEFAULT gen_random_uuid(),
    "investigationallegationid" uuid,
    "personid" uuid,
    "maltreatmentid" uuid,
    "investigationallegationstatustypekey" varchar(15),
    "intakeservicerequestactorid" uuid,
    "statementofevidence" text,
    "soemodified" boolean,
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "edl" boolean,
    "addedindicators" text,
    PRIMARY KEY ("investigationallegationactorid")
);

-- Model(s): Investigationallegationcharacterstics
CREATE TABLE IF NOT EXISTS "cjams"."investigationallegationcharacterstics" (
    "investigationallegationcharactersticsid" uuid,
    "investigationallegationid" uuid,
    "maltreatmentcharactersticstypekey" varchar(150),
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp
);

-- Model(s): Investigationallegationindicator
CREATE TABLE IF NOT EXISTS "cjams"."investigationallegationindicator" (
    "investigationallegationindicatorid" uuid DEFAULT gen_random_uuid(),
    "investigationallegationid" uuid,
    "indicatorid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("investigationallegationindicatorid")
);

-- Model(s): Investigationallegationinjury
CREATE TABLE IF NOT EXISTS "cjams"."investigationallegationinjury" (
    "investigationallegationinjuryid" uuid DEFAULT gen_random_uuid(),
    "investigationallegationid" uuid,
    "injurytypekey" varchar(15),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("investigationallegationinjuryid")
);

-- Model(s): Investigationallegationinjurycharacterstics
CREATE TABLE IF NOT EXISTS "cjams"."investigationallegationinjurycharacterstics" (
    "investigationallegationinjurycharactersticsid" uuid,
    "investigationallegationid" uuid,
    "injurycharactersticstypekey" varchar(150),
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp
);

-- Model(s): Investigationallegationmaltreators
CREATE TABLE IF NOT EXISTS "cjams"."investigationallegationmaltreators" (
    "investigationallegationmaltreatorsid" uuid DEFAULT gen_random_uuid(),
    "investigationallegationid" uuid,
    "intakeservicerequestactorid" uuid,
    "othermaltreator" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "finalizeddate" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "oaicesentdate" timestamp,
    "oahearingdatesetflag" integer,
    "oahearingdate" timestamp,
    "oanorhearingreason" varchar(500),
    "oahearingdecision" varchar(500),
    "oahearingdecisiondate" timestamp,
    "oadetails" varchar(500),
    "ccstayrequestedflag" integer,
    "ccstaygrantedflag" integer,
    "ccappealedflag" integer,
    "cchearingdecisiontypekey" varchar(5),
    "cchearingdecisiondate" timestamp,
    "ccdetails" varchar(500),
    "csastayrequestedflag" integer,
    "csastaygrantedflag" integer,
    "csaappealedflag" integer,
    "csahearingdecisiontypekey" varchar(5),
    "csahearingdecisiondate" timestamp,
    "oaappealedflag" integer,
    "csadetails" varchar(500),
    "oacasenumber" varchar(50),
    "cccasenumber" varchar(50),
    "csacasenumber" varchar(50),
    "scicesentdate" timestamp,
    "scconfheldflag" integer,
    "scdecisiontypekey" varchar(5),
    "scconferencedetail" varchar(500),
    "scconferencedate" timestamp,
    "overridefindingtypekey" varchar(5),
    "overridecomments" varchar(500),
    "cccompileddate" timestamp,
    "overrideapprflag" integer,
    "cccourtdecisionflag" integer,
    "csacourtdecisionflag" integer,
    "coastayreqflag" integer,
    "coastaygrantedflag" integer,
    "coaappealedflag" integer,
    "coacourtdecisionflag" integer,
    "coahearingdecisiontypekey" varchar(5),
    "coadetails" varchar(500),
    "coacasenumber" varchar(50),
    "coacompileddate" timestamp,
    "coahearingdecisiondate" timestamp,
    "old_id" varchar(50),
    "scisappealed" boolean,
    "scappealedby" varchar(50),
    "oaldssname" varchar(50),
    "oaappellentatrny" varchar(50),
    "oalocaldept" varchar(50),
    "oarunningmotion" varchar(50),
    "oahearingdateset" varchar(50),
    "ccldssname" varchar(50),
    "ccappellentatrny" varchar(50),
    "coaldssname" varchar(50),
    "coaappellentatrny" varchar(50),
    "csaldssname" varchar(50),
    "csaappellentatrny" varchar(50),
    "csanotifiedtodirector" boolean,
    "csacertiorari" boolean,
    "scappealeddate" timestamp,
    "ccwhoappealed" varchar(255),
    "ccnotifiedtodirector" boolean,
    "scsummarymailed" boolean,
    "csawhoappealed" varchar(255),
    "cccicuitcourtkey" varchar(255),
    "ccldssnotifieddate" timestamp,
    "csaldssnotifieddate" timestamp,
    "csacompileddate" timestamp,
    "scappealedsetdate" timestamp,
    "oahearingheld" integer,
    "oalocationofhearing" integer,
    "oahearingnarrative" integer,
    "oamodificationsmade" integer,
    "oatranslator" boolean,
    "oarunningmotiondate" timestamp,
    "oahearingheldreason" integer,
    "oasummarydecisionfileddate" varchar(255),
    "oacompiledwithoah" varchar(255),
    "oasummarydecisionfiledflag" varchar(255),
    "scisappealformsent" varchar(255),
    "cclocationofhearing" varchar(50),
    "cchearingheld" varchar(50),
    "cchearingheldreason" varchar(255),
    "csaarguementheld" varchar(50),
    "csaarguementnotheldreason" varchar(50),
    "coacertioraristatus" varchar(50),
    "coacertgranteddate" timestamp,
    "coacertdenieddate" timestamp,
    "oahmaltreatmenttypeid" uuid,
    "ccmaltreatmenttypeid" uuid,
    "csmaltreatmenttypeid" uuid,
    "coamaltreatmenttypeid" uuid,
    "scmaltreatmenttypeid" uuid,
    PRIMARY KEY ("investigationallegationmaltreatorsid")
);

-- Model(s): Investigationallegationstatustype
CREATE TABLE IF NOT EXISTS "cjams"."investigationallegationstatustype" (
    "sequencenumber" integer,
    "investigationallegationstatustypekey" varchar(255),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(255),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("investigationallegationstatustypekey")
);

-- Model(s): Investigationfinding
CREATE TABLE IF NOT EXISTS "cjams"."investigationfinding" (
    "investigationfindingid" uuid DEFAULT gen_random_uuid(),
    "investigationmaltreatmentactorid" uuid,
    "investigationallegationid" uuid,
    "personid" uuid,
    "investigationfindingtypekey" varchar(15),
    "findingcomments" varchar(500),
    "isharm" integer,
    "isharmsubstantial" integer,
    "harmdesc" varchar(500),
    "intentionalinjurydesc" varchar(500),
    "activeflag" integer,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "intakeserviceid" uuid,
    "invsfindingjurisdiction" varchar(500),
    "invsfindingaddress" varchar(500),
    "socialhistorydesc" varchar(500),
    "familyhistorydesc" varchar(500),
    "educationalfactors" varchar(500),
    "psychiatricdesc" varchar(500),
    "assetdetailsdesc" varchar(500),
    "legalinfopoa" varchar(500),
    "legalinforeppayee" varchar(500),
    "legalinfocourtinvolved" varchar(500),
    "legalinfodesc" varchar(500),
    "clentcapacitydesc" varchar(500),
    "reasonclosingdesc" varchar(500),
    "investigationfindingdate" timestamp,
    "apsworkersigndate" timestamp,
    "supervisorsigndate" timestamp,
    "psychiatricimportinfo" boolean,
    "financialimportinfo" boolean,
    "omissiondesc" text,
    PRIMARY KEY ("investigationfindingid")
);

-- Model(s): Investigationfindingassessors
CREATE TABLE IF NOT EXISTS "cjams"."investigationfindingassessors" (
    "investigationfindingassessorsid" uuid DEFAULT gen_random_uuid(),
    "investigationfindingid" uuid,
    "professiontypekey" varchar(255),
    "isassessor" integer,
    "securityusersid" varchar(255),
    "firstname" varchar(50),
    "lastname" varchar(50),
    "comments" varchar(200),
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("investigationfindingassessorsid")
);

-- Model(s): Investigationfindingguardian
CREATE TABLE IF NOT EXISTS "cjams"."investigationfindingguardian" (
    "investigationfindingguardianid" uuid DEFAULT gen_random_uuid(),
    "investigationfindingid" uuid,
    "intakeservicerequestactorid" uuid,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(255),
    PRIMARY KEY ("investigationfindingguardianid")
);

-- Model(s): Investigationfindingtype
CREATE TABLE IF NOT EXISTS "cjams"."investigationfindingtype" (
    "investigationfindingtypeid" uuid,
    "investigationfindingtypekey" varchar(15),
    "description" varchar(255),
    "activeflag" integer,
    "displayorder" integer,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "teamtypekey" varchar(255),
    PRIMARY KEY ("investigationfindingtypekey")
);

-- Model(s): Investigationfindingtypeperson
CREATE TABLE IF NOT EXISTS "cjams"."investigationfindingtypeperson" (
    "investigationfindingtypepersonid" uuid DEFAULT gen_random_uuid(),
    "investigationfindingid" uuid,
    "intakeservicerequestactorid" uuid,
    "invesfindingpersonname" varchar(255),
    "invsfindingpersonsupporttype" varchar(255),
    "invesfindingpersondesc" varchar(255),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "investigationfindingpersontype" varchar(255),
    PRIMARY KEY ("investigationfindingtypepersonid")
);

-- Model(s): Investigationmaltreatment
CREATE TABLE IF NOT EXISTS "cjams"."investigationmaltreatment" (
    "maltreatmentid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "householdkey" varchar(255),
    "isjurisdiction" integer,
    "countyid" uuid,
    "enddate" timestamp,
    "isapproximatedate" integer,
    "timeofincidence" timestamp,
    "incidentlocationtypekey" varchar(255),
    "investigationid" uuid,
    "notes" text,
    "supervisorname" varchar(255),
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "isreported" boolean,
    "providerid" integer,
    "providername" varchar(100),
    "providerphonenumber" varchar(100),
    "isnotapplicable" integer,
    "notapplicablecomments" varchar(20),
    PRIMARY KEY ("maltreatmentid")
);

-- Model(s): Investigationmaltreatmentactor
CREATE TABLE IF NOT EXISTS "cjams"."investigationmaltreatmentactor" (
    "investigationmaltreatmentactorid" uuid,
    "maltreatmentid" uuid,
    "intakeservicerequestactorid" uuid,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp
);

-- Model(s): Investigationmapping
CREATE TABLE IF NOT EXISTS "cjams"."investigationmapping" (
    "investigationmappingid" uuid DEFAULT gen_random_uuid(),
    "ammappingid" uuid,
    "activeflag" integer,
    "objectid" uuid,
    "objecttype" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "isreviewactivity" boolean,
    PRIMARY KEY ("investigationmappingid")
);

-- Model(s): Investigationreqforservconfig
CREATE TABLE IF NOT EXISTS "cjams"."investigationreqforservconfig" (
    "investigationreqforservconfigid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "intakeservtypekey" varchar(150),
    "reqforservstatus" varchar(255),
    "reqforservdispostion" varchar(50),
    "programtype" varchar(50),
    "removalreasontypekey" varchar(50),
    "removalreasonother" varchar(250),
    "receiveddate" timestamp,
    "closeddate" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("investigationreqforservconfigid")
);

-- Model(s): Investigationreviewtype
CREATE TABLE IF NOT EXISTS "cjams"."investigationreviewtype" (
    "sequencenumber" integer,
    "investigationreviewtypekey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("investigationreviewtypekey")
);

-- Model(s): Investigationtask
CREATE TABLE IF NOT EXISTS "cjams"."investigationtask" (
    "investigationtaskid" uuid,
    "activitytaskid" uuid,
    "taskexceptiontypekey" varchar(15),
    "exceptionrequestdate" timestamp,
    "taskexceptionreasontypekey" varchar(15),
    "exceptionreason" text,
    "taskexceptionstatustypekey" varchar(15),
    "exceptiondecisionby" varchar(50),
    "exceptiondecisiondate" timestamp,
    "exceptionreviewnote" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea
);

-- Model(s): Itemstable
CREATE TABLE IF NOT EXISTS "cjams"."itemstable" (
    "itemid" integer,
    "applicationid" integer,
    "name" varchar(255),
    "description" varchar(1024),
    "itemtype" smallint,
    "bizruleid" integer,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("itemid")
);

-- Model(s): IVEADOPTION
CREATE TABLE IF NOT EXISTS "cjams"."iveadoption" (

);

-- Model(s): IVEGAP
CREATE TABLE IF NOT EXISTS "cjams"."ivegap" (

);

-- Model(s): IVEReferrals
CREATE TABLE IF NOT EXISTS "cjams"."ivereferrals" (

);

-- Model(s): Kinshipcare
CREATE TABLE IF NOT EXISTS "cjams"."kinshipcare" (
    "kinshipcareid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "primaryisractorid" uuid,
    "secondaryisractorid" uuid,
    "acceptcharacteristics" varchar(250),
    "cpsclearance" varchar(250),
    "cjsinfo" varchar(250),
    "dhhreport" varchar(250),
    "isreceiveddisciplinepolicy" integer,
    "isapproveddisciplinepolicy" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("kinshipcareid")
);

-- Model(s): Kinshipcarechecklist
CREATE TABLE IF NOT EXISTS "cjams"."kinshipcarechecklist" (
    "kinshipcarechecklistid" uuid DEFAULT gen_random_uuid(),
    "amtaskid" uuid,
    "checklistid" uuid,
    "kinshipcareid" uuid,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("kinshipcarechecklistid")
);

-- Model(s): Kinshipcaredocuments
CREATE TABLE IF NOT EXISTS "cjams"."kinshipcaredocuments" (
    "kinshipcaredocumentsid" uuid DEFAULT gen_random_uuid(),
    "documentpropertiesid" uuid,
    "kinshipcareid" uuid,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("kinshipcaredocumentsid")
);

-- Model(s): Kinshipcareprogram
CREATE TABLE IF NOT EXISTS "cjams"."kinshipcareprogram" (
    "kinshipcareprogramid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "programareakey" varchar(25),
    "subprogramareakey" varchar(25),
    "startdate" timestamp,
    "enddate" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("kinshipcareprogramid")
);

-- Model(s): Languagetype
CREATE TABLE IF NOT EXISTS "cjams"."languagetype" (
    "languagetypeid" uuid DEFAULT gen_random_uuid(),
    "sequencenumber" integer,
    "datavalue" integer,
    "languagetypename" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("languagetypeid")
);

-- Model(s): Ldsslocations
CREATE TABLE IF NOT EXISTS "cjams"."ldsslocations" (
    "ldsslocationid" uuid DEFAULT gen_random_uuid(),
    "countycd" varchar(50),
    "regioncd" varchar(50),
    "location" varchar(50),
    "formattypekey" varchar(50),
    "streetnumber" integer,
    "boxnumber" integer,
    "predirtypekey" varchar(50),
    "streetname" varchar(100),
    "streetsuffixtypekey" varchar(50),
    "postdirtypekey" varchar(50),
    "unittypekey" varchar(50),
    "unitnumbertx" varchar(500),
    "cityname" varchar(100),
    "adrcountytypekey" varchar(50),
    "statetypekey" varchar(50),
    "zip5no" numeric(5,2),
    "zip4no" numeric(5,2),
    "direction" varchar(500),
    "foreignaddress" varchar(500),
    "foreignstate" varchar(50),
    "country" varchar(50),
    "postalcode" varchar(50),
    "workphone" varchar(10),
    "workextn" varchar(10),
    "email" varchar(100),
    "fax" varchar(20),
    "url" varchar(100),
    "othercontacts" varchar(20),
    "defaultflag" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "street" varchar(20),
    "old_id" varchar(50),
    PRIMARY KEY ("ldsslocationid")
);

-- Model(s): Legalcustody
CREATE TABLE IF NOT EXISTS "cjams"."legalcustody" (
    "legalcustodyid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "intakeservicerequestactorid" uuid,
    "Permanencyplanid" uuid,
    "legalcustodytypekey" varchar(25),
    "reason" varchar(250),
    "fromdate" timestamp,
    "todate" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "servicecaseid" uuid,
    "permanencyplanid" uuid,
    "personid" uuid,
    PRIMARY KEY ("legalcustodyid")
);

-- Model(s): Legislative
CREATE TABLE IF NOT EXISTS "cjams"."legislative" (
    "legislativeid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "isapprovedsafec" boolean,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "isinitialfacetoface" boolean,
    "isapprovedmfira" boolean,
    "isapprovecansf" boolean,
    "isvictimperpetrator" boolean,
    "isallpersons" boolean,
    "isallegedvicitm" boolean,
    "islegislativereporting" varchar(100),
    "isdataentrynotes" text,
    "isemergency" varchar(100),
    "isreasonnotprovided" varchar(100),
    "islateinitialcontact" boolean,
    "validations" text /* unmapped type:  for validations */,
    "relations" text /* unmapped type:  for relations */,
    "acls" text /* unmapped type:  for acls */,
    "methods" text /* unmapped type:  for methods */,
    PRIMARY KEY ("legislativeid")
);

-- Model(s): Livingarrangement
CREATE TABLE IF NOT EXISTS "cjams"."livingarrangement" (
    "livingid" uuid DEFAULT gen_random_uuid(),
    "livingpriortoplacement" boolean,
    "livingarrangementtypekey" varchar(50),
    "livingcomment" varchar(500),
    "placementid" uuid,
    "personid" uuid,
    "livingstartdate" varchar(255),
    "livingenddate" varchar(255),
    "primarycaregiver" varchar(255),
    "secondarycaregiver" varchar(255),
    "caregiverclientid" uuid,
    "partnerid" uuid,
    "primaryrelationship" varchar(50),
    "homephone" varchar(20),
    "workphone" varchar(20),
    "streetname" varchar(100),
    "streettext" varchar(500),
    "cityname" varchar(100),
    "countytypekey" varchar(50),
    "statetypekey" varchar(50),
    "zip5no" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "country" varchar(20),
    "tribalservicearea" varchar(10),
    "whereabouts" varchar(10),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "runawayreported" boolean,
    "runawayreportnumber" varchar(50),
    "fostercarehome" varchar(50),
    "fostercarenonfoster" varchar(50),
    "hotelorother" varchar(50),
    "agency1to1" boolean,
    "agency1to1desc" varchar(50),
    "agency1to1explaination" varchar(50),
    "dailyrate" numeric,
    "ratetype" varchar(50),
    "agency1to1rate" numeric,
    "fostercomments" varchar(50),
    "laluggagecomments" varchar(50),
    "livingarrangementluggage" boolean,
    "laluggagepurchased" boolean,
    "ladisposableortrashbag" boolean,
    PRIMARY KEY ("livingid")
);

-- Model(s): Livingarrangementtype
CREATE TABLE IF NOT EXISTS "cjams"."livingarrangementtype" (
    "sequencenumber" integer,
    "livingarrangementtypekey" varchar(50),
    "activeflag" integer,
    "description" text,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "expirationdate" timestamp,
    "effectivedate" timestamp,
    PRIMARY KEY ("livingarrangementtypekey")
);

-- Model(s): Locationfromtype
CREATE TABLE IF NOT EXISTS "cjams"."locationfromtype" (
    "locationfromtypeid" uuid DEFAULT gen_random_uuid(),
    "locationfromtypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("locationfromtypeid")
);

-- Model(s): Locationtotype
CREATE TABLE IF NOT EXISTS "cjams"."locationtotype" (
    "locationtotypeid" uuid DEFAULT gen_random_uuid(),
    "locationtotypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("locationtotypeid")
);

-- Model(s): Maltreatmentcharactersticstype
CREATE TABLE IF NOT EXISTS "cjams"."maltreatmentcharactersticstype" (
    "maltreatmentcharactersticstypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "displayorder" integer,
    PRIMARY KEY ("maltreatmentcharactersticstypekey")
);

-- Model(s): Maltreatmentjurisdictionuser
CREATE TABLE IF NOT EXISTS "cjams"."maltreatmentjurisdictionuser" (
    "maltreatmentjurisdictionuserid" uuid DEFAULT gen_random_uuid(),
    "roletypekey" varchar(50),
    "maltreatmentid" uuid,
    "username" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    PRIMARY KEY ("maltreatmentjurisdictionuserid")
);

-- Model(s): Maritalstatustype
CREATE TABLE IF NOT EXISTS "cjams"."maritalstatustype" (
    "sequencenumber" integer,
    "maritalstatustypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("maritalstatustypekey")
);

-- Model(s): mdmgoldenpersonaddress
CREATE TABLE IF NOT EXISTS "cjams"."mdmgoldenpersonaddress" (
    "mdmgoldenpersonaddressid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "mdmid" varchar(50),
    "addresstype" varchar(50),
    "addressline1" varchar(250),
    "addressline2" varchar(250),
    "addresscity" varchar(50),
    "addressstate" varchar(50),
    "addresscounty" varchar(50),
    "addresszip" varchar(50),
    "addresscountry" varchar(50),
    "addressprimary" varchar(50),
    "addresseffectivebegindate" timestamp,
    "addresseffectiveenddate" timestamp,
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "mdmgolderpersondetailsid" uuid,
    PRIMARY KEY ("mdmgoldenpersonaddressid")
);

-- Model(s): Mdmgoldenpersondetails
CREATE TABLE IF NOT EXISTS "cjams"."mdmgoldenpersondetails" (
    "mdmgolderpersondetailsid" uuid DEFAULT gen_random_uuid(),
    "mdmid" varchar(50),
    "personid" uuid,
    "sourcesystem" varchar(50),
    "sourcekey" varchar(50),
    "rolekey" numeric,
    "dob" timestamp,
    "ssnno" varchar(50),
    "tinnumber" varchar(50),
    "aliennumber" varchar(50),
    "ssnreferralcd" varchar(50),
    "ssnverificationdate" timestamp,
    "eyecolortypekey" varchar(50),
    "haircolortypekey" varchar(50),
    "racetypekey" varchar(50),
    "ethnicgrouptypekey" varchar(50),
    "gendertypekey" varchar(50),
    "maritalstatustypekey" date,
    "domesticviolenceind" varchar(50),
    "incarcerationind" varchar(50),
    "dateofdeath" timestamp,
    "deathstatecd" varchar(50),
    "deceasedindicator" varchar(50),
    "ssnverificationcd" varchar(50),
    "idfctnbirthdistinct" varchar(50),
    "hearingimpaircd" varchar(50),
    "visualimpaircd" varchar(50),
    "dateofentry" timestamp,
    "languagecd" varchar(50),
    "immigrationstatuscd" varchar(15),
    "isuscitizen" varchar(15),
    "driverlicensenumber" varchar(50),
    "veteranstatus" varchar(15),
    "driverlicensestate" varchar(15),
    "irn" varchar(15),
    "maid" varchar(15),
    "maidsuffix" varchar(15),
    "medicaidindicator" varchar(50),
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "is_mdm_sync" boolean,
    PRIMARY KEY ("mdmgolderpersondetailsid")
);

-- Model(s): mdmgoldenpersonemails
CREATE TABLE IF NOT EXISTS "cjams"."mdmgoldenpersonemails" (
    "mdmgoldenpersonemailsid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "mdmid" varchar(50),
    "emailtype" varchar(50),
    "emailaddress" varchar(50),
    "emaildonotcontact" varchar(50),
    "emailprimary" varchar(50),
    "emaileffectivebegindate" timestamp,
    "emaileffectiveenddate" timestamp,
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "mdmgolderpersondetailsid" uuid,
    PRIMARY KEY ("mdmgoldenpersonemailsid")
);

-- Model(s): mdmgoldenpersonnames
CREATE TABLE IF NOT EXISTS "cjams"."mdmgoldenpersonnames" (
    "mdmgoldenpersonnamesid" uuid DEFAULT gen_random_uuid(),
    "nametypecode" varchar(50),
    "prefixcode" varchar(255),
    "lastname" varchar(50),
    "middlename" varchar(50),
    "firstname" varchar(50),
    "suffixcode" varchar(15),
    "fullname" varchar(50),
    "nameeffectivestartdate" timestamp,
    "nameeffectiveenddate" timestamp,
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "personid" uuid,
    "mdmgolderpersondetailsid" uuid,
    PRIMARY KEY ("mdmgoldenpersonnamesid")
);

-- Model(s): mdmgoldenpersonphones
CREATE TABLE IF NOT EXISTS "cjams"."mdmgoldenpersonphones" (
    "mdmgoldenpersonphonesid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "mdmid" varchar(50),
    "phonetype" varchar(50),
    "phonenumber" varchar(50),
    "phonecountry" varchar(50),
    "phoneextension" varchar(50),
    "phoneeffectivebegindate" timestamp,
    "phoneeffectiveenddate" timestamp,
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "mdmgolderpersondetailsid" uuid,
    PRIMARY KEY ("mdmgoldenpersonphonesid")
);

-- Model(s): Medicalconditiontype
CREATE TABLE IF NOT EXISTS "cjams"."medicalconditiontype" (
    "medicalconditiontypeid" uuid,
    "medicalconditiontypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("medicalconditiontypekey")
);

-- Model(s): Medicationtype
CREATE TABLE IF NOT EXISTS "cjams"."medicationtype" (
    "medicationtypeid" uuid,
    "medicationtypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp
);

-- Model(s): Meetingfimdetails
CREATE TABLE IF NOT EXISTS "cjams"."meetingfimdetails" (
    "meetingfimdetailsid" uuid,
    "meetingrecordingid" uuid,
    "familymeetingsubtypekey" varchar(15),
    "familymeetingtypekey" varchar(15),
    "displayorder" integer,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp
);

-- Model(s): Meetingparticipants
CREATE TABLE IF NOT EXISTS "cjams"."meetingparticipants" (
    "meetingparticipantsid" uuid DEFAULT gen_random_uuid(),
    "meetingrecordingid" uuid,
    "participanttype" varchar(100),
    "participantkey" varchar(100),
    "participantroledesc" varchar(100),
    "firstname" varchar(100),
    "lastname" varchar(100),
    "emailid" varchar(300),
    "personid" integer,
    "isinvited" integer,
    "isattended" integer,
    "isaccpted" integer,
    "signurl" varchar(300),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "electronicsignature" text,
    PRIMARY KEY ("meetingparticipantsid")
);

-- Model(s): Meetingrecording
CREATE TABLE IF NOT EXISTS "cjams"."meetingrecording" (
    "meetingrecordingid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "meetingdate" timestamp,
    "meetingtypekey" varchar(50),
    "persontype" varchar(50),
    "personname" varchar(150),
    "meetingdescription" varchar(255),
    "meetingcomments" text,
    "isfollowupmeeting" integer,
    "parentmeetingid" uuid,
    "iscompleted" integer,
    "activeflag" integer,
    "effectivedate" timestamp,
    "uploadedfile" json,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "servicecaseid" uuid,
    "adoptioncaseid" uuid,
    "ismeetingdecision" integer,
    "followupdate" timestamp,
    "meetingdecision" text,
    "placementid" uuid,
    PRIMARY KEY ("meetingrecordingid")
);

-- Model(s): Meetingrecordingactor
CREATE TABLE IF NOT EXISTS "cjams"."meetingrecordingactor" (
    "meetingrecordingactorid" uuid DEFAULT gen_random_uuid(),
    "meetingrecordingid" uuid,
    "intakeservicerequestactorid" uuid,
    "adoptioncaseactorid" uuid,
    "personid" uuid,
    "isinvited" integer,
    "isattended" integer,
    "isaccpted" integer,
    "signurl" varchar(300),
    "isfollowupmeeting" integer,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("meetingrecordingactorid")
);

-- Model(s): meetingrecordinghearingdetail
CREATE TABLE IF NOT EXISTS "cjams"."meetingrecordinghearingdetail" (
    "meetingrecordinghearingdetailid" uuid DEFAULT gen_random_uuid(),
    "meetingrecordingid" uuid,
    "clientid" uuid,
    "intakeservicerequestcourthearingid" uuid,
    "activeflag" integer,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    PRIMARY KEY ("meetingrecordinghearingdetailid")
);

-- Model(s): Meetingtype
CREATE TABLE IF NOT EXISTS "cjams"."meetingtype" (
    "meetingtypeid" uuid,
    "meetingtypekey" varchar(15),
    "typedescription" varchar(50),
    "displayorder" integer,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    PRIMARY KEY ("meetingtypekey")
);

-- Model(s): Nationalitytype
CREATE TABLE IF NOT EXISTS "cjams"."nationalitytype" (
    "nationalitytypeid" uuid,
    "nationalitytypekey" varchar(15),
    "description" varchar(250),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("nationalitytypekey")
);

-- Model(s): News
CREATE TABLE IF NOT EXISTS "cjams"."news" (
    "newsid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "shorttext" varchar(100),
    "longtext" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    PRIMARY KEY ("newsid")
);

-- Model(s): Nextnumber
CREATE TABLE IF NOT EXISTS "cjams"."nextnumber" (
    "nextnumber_id" integer,
    "application" varchar(50),
    "next_number" bigint,
    "start_number" bigint,
    "end_number" bigint,
    "timestamp" bytea,
    "fiscalyear" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("nextnumber_id")
);

-- Model(s): notificationconfig
CREATE TABLE IF NOT EXISTS "cjams"."notificationconfig" (
    "notificationconfigid" uuid DEFAULT gen_random_uuid(),
    "teamtypekey" varchar(255),
    "notificationtypekey" varchar(255),
    "objectid" uuid,
    "workflowstatuscd" varchar(255),
    "datefieldname" varchar(25),
    "notificationoffset" integer,
    "frequencytype" varchar(10),
    "offsetminutes" integer,
    "isnotifyemail" boolean,
    "isnotifyapp" boolean,
    "isnotifysms" boolean,
    "notificationmessage" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("notificationconfigid")
);

-- Model(s): Notificationlog
CREATE TABLE IF NOT EXISTS "cjams"."notificationlog" (
    "notificationlogid" uuid DEFAULT gen_random_uuid(),
    "objectid" varchar(50),
    "objecttypekey" varchar(50),
    "personid" uuid,
    "ldssuserid" varchar(50),
    "emailid" varchar(50),
    "message" text,
    "ismailsent" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("notificationlogid")
);

-- Model(s): notificationtype
CREATE TABLE IF NOT EXISTS "cjams"."notificationtype" (
    "notificationtypeid" uuid DEFAULT gen_random_uuid(),
    "notificationtypekey" varchar(255),
    "description" varchar(1024),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("notificationtypeid")
);

-- Model(s): NytdDataElements
CREATE TABLE IF NOT EXISTS "cjams"."nytddataelements" (
    "elementid" uuid DEFAULT gen_random_uuid(),
    "elementdesc" varchar(255),
    "elementpath" varchar(255),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "elementxmltag" varchar(255),
    "old_id" varchar(255),
    PRIMARY KEY ("elementid")
);

-- Model(s): Oasactionletter
CREATE TABLE IF NOT EXISTS "cjams"."oasactionletter" (
    "oasactionletterid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "countyid" uuid,
    "comarvalues" text,
    "immediateaction" boolean,
    "notice" boolean,
    "workername" varchar(255),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("oasactionletterid")
);

-- Model(s): Oasactionletterprogramactionconfig
CREATE TABLE IF NOT EXISTS "cjams"."oasactionletterprogramactionconfig" (
    "programactionconfigid" uuid DEFAULT gen_random_uuid(),
    "oasactionletterid" uuid,
    "programtypekey" varchar(100),
    "actiontypekey" varchar(100),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("programactionconfigid")
);

-- Model(s): Objecttype
CREATE TABLE IF NOT EXISTS "cjams"."objecttype" (
    "sequencenumber" integer,
    "objecttypekey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("objecttypekey")
);

-- Model(s): Offencelocationtype
CREATE TABLE IF NOT EXISTS "cjams"."offencelocationtype" (
    "offencelocationtypeid" uuid,
    "offencelocationtypekey" varchar(25),
    "description" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("offencelocationtypekey")
);

-- Model(s): Offensecategory
CREATE TABLE IF NOT EXISTS "cjams"."offensecategory" (
    "offensecategoryid" uuid DEFAULT gen_random_uuid(),
    "offensecategorykey" varchar(15),
    "description" text,
    "mcaspcategory" integer,
    "draicategory" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("offensecategoryid")
);

-- Model(s): overridepopup
CREATE TABLE IF NOT EXISTS "cjams"."overridepopup" (

);

-- Model(s): Participantsubtype
CREATE TABLE IF NOT EXISTS "cjams"."participantsubtype" (
    "participantsubtypeid" uuid DEFAULT gen_random_uuid(),
    "participantsubtypekey" varchar(15),
    "participanttypekey" varchar(15),
    "typedescription" varchar(250),
    "displayorder" bigint,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("participantsubtypeid")
);

-- Model(s): Participanttype
CREATE TABLE IF NOT EXISTS "cjams"."participanttype" (
    "participanttypeid" uuid,
    "participanttypekey" varchar(15),
    "typedescription" varchar(250),
    "displayorder" bigint,
    "activeflag" integer,
    "objecttypekey" varchar(50),
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "old_id" varchar(50)
);

-- Model(s): Permanencyplan
CREATE TABLE IF NOT EXISTS "cjams"."permanencyplan" (
    "permanencyplanid" uuid DEFAULT gen_random_uuid(),
    "intakeservicerequestactorid" uuid,
    "intakeserviceid" uuid,
    "servicecaseid" uuid,
    "placementid" uuid,
    "projecteddate" timestamp,
    "courtorderreceived" boolean,
    "permanencyplanremainssame" boolean,
    "permanencyplanremainssamedate" timestamp,
    "reviewdate" timestamp,
    "actualdata" json,
    "achieveddate" timestamp,
    "establisheddate" timestamp,
    "caseworkername" varchar(50),
    "primarypermanencytype" varchar(25),
    "concurrentpermanencytype" varchar(25),
    "primaryarrangetype" varchar(25),
    "concurrentarrangetype" varchar(25),
    "remarks" text,
    "concurrentcomments" text,
    "reviseddate" timestamp,
    "resourcename" varchar(100),
    "address1" varchar(100),
    "address2" varchar(100),
    "state" varchar(32),
    "city" varchar(32),
    "countyid" uuid,
    "country" varchar(50),
    "zipcode" varchar(32),
    "primaryrelativename" varchar(50),
    "primarynonrelativename" varchar(50),
    "primaryprovidercode" integer,
    "ispriresourceidentified" integer,
    "concurrentrelativename" varchar(50),
    "concurrentnonrelativename" varchar(50),
    "concurrentprovidercode" integer,
    "isconresourceidentified" integer,
    "effectivedate" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "permplanquestdata" json,
    "enddate" timestamp,
    "reason" varchar(255),
    "parentname" uuid,
    "parent2name" uuid,
    PRIMARY KEY ("permanencyplanid")
);

-- Model(s): Permanencyplandetail
CREATE TABLE IF NOT EXISTS "cjams"."permanencyplandetail" (
    "permanencyplandetailid" uuid DEFAULT gen_random_uuid(),
    "permanencyplanid" uuid,
    "plantype" varchar(5),
    "permanencyplantypekey" varchar(15),
    "permanencyplansubtypekey" varchar(15),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("permanencyplandetailid")
);

-- Model(s): Permanencyplanhistory
CREATE TABLE IF NOT EXISTS "cjams"."permanencyplanhistory" (
    "permanencyplanhistoryid" uuid DEFAULT gen_random_uuid(),
    "permanencyplanid" uuid,
    "intakeservicerequestactorid" uuid,
    "intakeserviceid" uuid,
    "servicecaseid" uuid,
    "placementid" uuid,
    "projecteddate" timestamp,
    "establisheddate" timestamp,
    "caseworkername" varchar(50),
    "permanencyplanremainssame" boolean,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "enddate" timestamp,
    "status" varchar(20),
    PRIMARY KEY ("permanencyplanhistoryid")
);

-- Model(s): Permanencyplansubtype
CREATE TABLE IF NOT EXISTS "cjams"."permanencyplansubtype" (
    "permanencyplansubtypeid" uuid DEFAULT gen_random_uuid(),
    "permanencyplansubtypekey" varchar(50),
    "permanencyplantypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "displayorder" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(25),
    PRIMARY KEY ("permanencyplansubtypeid")
);

-- Model(s): Permanencyplantype
CREATE TABLE IF NOT EXISTS "cjams"."permanencyplantype" (
    "permanencyplantypeid" uuid,
    "permanencyplantypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "displayorder" bigserial,
    "updatedby" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(25),
    PRIMARY KEY ("permanencyplantypekey")
);

-- Model(s): Permissiongroup
CREATE TABLE IF NOT EXISTS "cjams"."permissiongroup" (
    "permissiongroupid" uuid DEFAULT gen_random_uuid(),
    "permissiongroupname" varchar(255),
    "description" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("permissiongroupid")
);

-- Model(s): Person
CREATE TABLE IF NOT EXISTS "cjams"."person" (
    "activeflag" varchar(255),
    "safehavenbabyflag" integer,
    "dangerlevel" integer,
    "dangerreason" varchar(500),
    "deceaseddate" timestamptz,
    "dob" timestamptz,
    "effectivedate" timestamptz,
    "ethnicgrouptypekey" varchar(15),
    "expirationdate" timestamptz,
    "firstname" varchar(50),
    "firstnamesoundex" varchar(50),
    "gendertypekey" varchar(15),
    "incometypekey" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamptz,
    "interpreterrequired" varchar(256),
    "lastname" varchar(50),
    "lastnamesoundex" varchar(50),
    "maritalstatustypekey" varchar(15),
    "middlename" varchar(32),
    "old_id" varchar(50),
    "personid" uuid DEFAULT gen_random_uuid(),
    "primarylanguageid" varchar(25),
    "principalident" varchar(32),
    "racetypekey" varchar(15),
    "religiontypekey" varchar(15),
    "salutation" varchar(32),
    "secondarylanguageid" varchar(255),
    "ssnverified" varchar(1),
    "timestamp" bytea,
    "updatedby" varchar(50),
    "updatedon" timestamptz,
    "userphoto" text,
    "refusessn" boolean,
    "refusedob" boolean,
    "senstatusflag" integer,
    "dangertoself" integer,
    "dangertoselfreason" varchar(500),
    "personphysicalattributetypeid" uuid,
    "maidenname" varchar(50),
    "tribalassociation" varchar(50),
    "socialmediasource" varchar(250),
    "dateofdeath" timestamptz,
    "isapproxdob" integer,
    "isapproxdod" integer,
    "suffix" varchar(20),
    "prefx" varchar(20),
    "occupation" varchar(150),
    "stateid" varchar(150),
    "fein" varchar(50),
    "complaintnumber" varchar(50),
    "cjisnumber" varchar(50),
    "petitionid" varchar(50),
    "strengths" varchar(50),
    "needs" varchar(50),
    "cjamspid" varchar(50),
    "nationalitytypekey" varchar(15),
    "livingsituationkey" varchar(50),
    "licensedfacilitykey" varchar(50),
    "otherlicensedfacility" varchar(50),
    "livingsituationdesc" varchar(50),
    "livingarrangementdesc" text,
    "livingarrangementkey" varchar(50),
    "otherprimarylanguagetypekey" varchar(50),
    "otherreligion" varchar(50),
    "citizenalenageflag" integer,
    "othergendertypekey" integer,
    "sdmpersonapprovalflag" varchar(255),
    "isqualifiedalien" integer,
    "verificationremarks" varchar(255),
    "alienregistrationtext" varchar(500),
    "alienstatustypekey" varchar(15),
    "ssnno" varchar(12),
    "everbeenadoptedflag" integer,
    "cferesourcehomechild" boolean,
    "limitedenglishproficiency" boolean,
    "needtranslatorinterpreter" boolean,
    "readingproficiency" boolean,
    "writingproficiency" boolean,
    "speakingproficiency" boolean,
    "aname" boolean,
    "primarycitizenshiptypekey" varchar(10),
    "seccitizenshiptypekey" varchar(10),
    "cisclientid" varchar(10),
    "clientflag" integer,
    "preadoptiondate" timestamp,
    "haircolortypekey" varchar(50),
    "hairtexturetypekey" varchar(50),
    "eyecolortypekey" varchar(50),
    "physicalbuildtypekey" varchar(50),
    "skintonetypekey" varchar(50),
    "hairtextureotherdesc" varchar(50),
    "haircolorotherdesc" varchar(50),
    "isglasses" boolean,
    "employername" varchar(50),
    "clienttitle" varchar(50),
    "biologicalmothermarriedsw" integer,
    "icwastatusinquiry" varchar(255),
    "icwaeligibleformembership" varchar(255),
    "icwatribename" varchar(255),
    "icwaunderdefinition" varchar(255),
    "icwanotification" date,
    "icwatribelegalnotice" varchar(255),
    "intercountryadoption" integer,
    "priorlegalguardianship" integer,
    "preplacementguardianshipdate" timestamp,
    "substanceexposednewbornflag" integer,
    "substanceexposednewbornsourceid" varchar(255),
    "substanceexposednewbornsourcetypekey" integer,
    "substanceexposednewborntimetamp" timestamptz,
    "sencriteria" varchar(255),
    "birthinghospital" varchar(255),
    "substanceclasses" json,
    "othersubstances" varchar(255),
    PRIMARY KEY ("personid")
);

-- Model(s): Personabusehistory
CREATE TABLE IF NOT EXISTS "cjams"."personabusehistory" (
    "personabusehistoryid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "isneglect" boolean,
    "isphysicalabuse" boolean,
    "isemotionalabuse" boolean,
    "issexualabuse" boolean,
    "isselfneglect" boolean,
    "isfinancialexploitation" boolean,
    "neglectnotes" varchar(250),
    "physicalnotes" varchar(250),
    "emotionalnotes" varchar(250),
    "sexualnotes" varchar(250),
    "selfneglectnotes" varchar(250),
    "financialexploitationnotes" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personabusehistoryid")
);

-- Model(s): Personabusesubstance
CREATE TABLE IF NOT EXISTS "cjams"."personabusesubstance" (
    "personabusesubstanceid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "isusetobacco" boolean,
    "isusedrugoralcohol" boolean,
    "isusedrug" boolean,
    "isusealcohol" boolean,
    "drugfrequencydetails" varchar(500),
    "drugageatfirstuse" varchar(50),
    "alcoholfrequencydetails" varchar(50),
    "alcoholageatfirstuse" varchar(50),
    "drugoralcoholproblems" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "tobaccoageatfirstuse" varchar(50),
    "tobaccofrequencydetails" varchar(50),
    "drugfrequencytypekey" varchar(50),
    "alcoholfrequencytypekey" varchar(50),
    "tobaccofrequencytypekey" varchar(50),
    "drugtimes" integer,
    "alcoholtimes" integer,
    "tobaccotimes" integer,
    PRIMARY KEY ("personabusesubstanceid")
);

-- Model(s): Personabusesubstancefrequencytype
CREATE TABLE IF NOT EXISTS "cjams"."personabusesubstancefrequencytype" (
    "personabusesubstancefrequencytypeid" uuid,
    "personabusesubstancefrequencytypekey" varchar(250),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personabusesubstancefrequencytypekey")
);

-- Model(s): Personaccomplishment
CREATE TABLE IF NOT EXISTS "cjams"."personaccomplishment" (
    "personaccomplishmentid" uuid DEFAULT gen_random_uuid(),
    "personid" varchar(15),
    "highestgradetypekey" varchar(15),
    "accomplishmentdate" timestamp,
    "isrecordreceived" boolean,
    "receiveddate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("personaccomplishmentid")
);

-- Model(s): Personaddress
CREATE TABLE IF NOT EXISTS "cjams"."personaddress" (
    "personaddressid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "activeflag" integer,
    "personaddresstypekey" varchar(15),
    "address" varchar(100),
    "zipcode" varchar(32),
    "city" varchar(32),
    "state" varchar(2),
    "country" varchar(32),
    "county" varchar(32),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea,
    "address2" varchar(100),
    "directions" text,
    "danger" boolean,
    "currentlocationflag" integer,
    "dangerreason" varchar(512),
    "changereason" varchar(250),
    "durationday" varchar(25),
    "ishouseholdmember" boolean,
    "addressstartdate" timestamp,
    "personadrenddate" timestamp,
    PRIMARY KEY ("personaddressid")
);

-- Model(s): Personaddresstype
CREATE TABLE IF NOT EXISTS "cjams"."personaddresstype" (
    "sequencenumber" integer,
    "personaddresstypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personaddresstypekey")
);

-- Model(s): Personalert
CREATE TABLE IF NOT EXISTS "cjams"."personalert" (
    "personid" uuid,
    "alerttype" varchar(50),
    "status" varchar(50),
    "startdatetime" timestamp,
    "enddatetime" timestamp,
    "notes" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "personalertid" uuid,
    "alertid" uuid,
    PRIMARY KEY ("alerttype")
);

-- Model(s): Personalerttype
CREATE TABLE IF NOT EXISTS "cjams"."personalerttype" (
    "sequencenumber" integer,
    "personalerttypekey" varchar(50),
    "activeflag" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("personalerttypekey")
);

-- Model(s): Personallchildreninfo
CREATE TABLE IF NOT EXISTS "cjams"."personallchildreninfo" (
    "personallchildreninfoid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "infoprovidedbypersonid" integer,
    "infoprovidedbycollateralid" integer,
    "infopersontypekey" varchar(50),
    "motherusedrug" varchar(500),
    "childhooddisease" varchar(50),
    "birthdisease" varchar(500),
    "birthdefects" varchar(500),
    "accomments" varchar(500),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "infoprovidedby" varchar(300),
    "infoprovidedbyrelationtypekey" varchar(50),
    "expungementflag" integer,
    "datavalidflag" integer,
    "clientmergeid" uuid,
    "fk_id" varchar(50),
    "old_id" varchar(50),
    PRIMARY KEY ("personallchildreninfoid")
);

-- Model(s): Personbehavioralhealth
CREATE TABLE IF NOT EXISTS "cjams"."personbehavioralhealth" (
    "personbehavioralhealthid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "clinicianname" varchar(50),
    "currentdiagnoses" varchar(100),
    "phone" varchar(25),
    "address1" varchar(100),
    "address2" varchar(100),
    "reportname" varchar(100),
    "city" varchar(50),
    "state" varchar(10),
    "countyid" uuid,
    "zip" varchar(50),
    "personservicetypekey" varchar(100),
    "isbehavioralhealth" boolean,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personbehavioralhealthid")
);

-- Model(s): Persondentalinfo
CREATE TABLE IF NOT EXISTS "cjams"."persondentalinfo" (
    "persondentalinfoid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "isdentalinfo" boolean,
    "dentistname" varchar(50),
    "dentalspecialtytypekey" varchar(100),
    "phone" varchar(25),
    "email" varchar(50),
    "address1" varchar(100),
    "address2" varchar(100),
    "city" varchar(50),
    "state" varchar(10),
    "countyid" uuid,
    "zip" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("persondentalinfoid")
);

-- Model(s): Persondisability
CREATE TABLE IF NOT EXISTS "cjams"."persondisability" (
    "persondisabilityid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "disabilityconditiontypekey" varchar(32),
    "disabilityflag" varchar(255),
    "diagnoiseddisabilitynotes" varchar(100),
    "startdate" timestamp,
    "enddate" timestamp,
    "evaluationdate" timestamp,
    "evaluatorname" varchar(50),
    "comments" varchar(500),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" integer,
    "disabilitytypekey" varchar(25),
    "specialkey" varchar(25),
    "hygienekey" varchar(25),
    "old_id" varchar(50),
    "expungementflag" integer,
    "startdateunknown" boolean,
    "doesnotapply" boolean,
    "existingcondition" boolean,
    "previouscondition" boolean,
    "selectdisability" varchar(255),
    PRIMARY KEY ("persondisabilityid")
);

-- Model(s): Personeducation
CREATE TABLE IF NOT EXISTS "cjams"."personeducation" (
    "personeducationid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "educationname" varchar(200),
    "educationtypekey" varchar(15),
    "countyid" varchar(255),
    "statecode" varchar(15),
    "startdate" timestamp,
    "enddate" timestamp,
    "lastgradetypekey" varchar(15),
    "currentgradetypekey" varchar(15),
    "isspecialeducation" boolean,
    "specialeducationtypekey" varchar(15),
    "absentdate" timestamp,
    "isreceived" boolean,
    "isverified" boolean,
    "isexcuesed" boolean,
    "extracurricular" text,
    "old_id" varchar(50),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "schoolid" uuid,
    "clientid" integer,
    "contactname" varchar(5),
    "schoolsettingtypekey" varchar(5),
    "schoolschedule" varchar(5),
    "schooladjustment" varchar(5),
    "functioninggradetypekey" varchar(5),
    "intensitylevelno" varchar(10),
    "comments" varchar(500),
    "performance" varchar(100),
    "statustypekey" varchar(100),
    "strengths" varchar(100),
    "weaknesses" varchar(100),
    "adrformattypekey" varchar(5),
    "adrstreetno" integer,
    "adrboxno" integer,
    "adrpredirtypekey" varchar(5),
    "adrstreetname" varchar(100),
    "adrstreetsuffixtypekey" varchar(5),
    "adrpostdirtypekey" varchar(255),
    "adrunitno" varchar(255),
    "schooladdress1" varchar(255),
    "schooladdress2" varchar(255),
    "schoolzipcode" varchar(255),
    "adrcityname" varchar(255),
    "adrzip5no" integer,
    "adrzip4no" integer,
    "adrdirection" varchar(100),
    "adrforeign" varchar(100),
    "adrworkphone" varchar(20),
    "adrworkxtn" varchar(20),
    "adrhomephone" varchar(20),
    "adrpager" varchar(20),
    "adremail" varchar(100),
    "adrfax" varchar(10),
    "adrcellphone" varchar(10),
    "adrurl" varchar(100),
    "adrothercontact" varchar(100),
    "lastiepdate" varchar(100),
    "enrollmentdate" timestamp,
    "lastattendeddate" timestamp,
    "withdrawaldate" timestamp,
    "educationstatustypekey" varchar(100),
    "secondaryby19flag" integer,
    "adrforeignstate" varchar(20),
    "adrcountry" varchar(20),
    "adrpostalcode" varchar(20),
    "classtypetypekey" varchar(5),
    "firstqtrperformancetypekey" varchar(5),
    "secondqtrperformancetypekey" varchar(5),
    "thirdqtrperformancetypekey" varchar(5),
    "fourthqtrperformancetypekey" varchar(5),
    "extracurricularactivities" varchar(500),
    "educationproggoal" varchar(500),
    "adrstreet" varchar(100),
    "paytill22typekey" varchar(5),
    "expungementflag" integer,
    "datavalidflag" integer,
    "clientmergeid" integer,
    "educationstatusdate" timestamp,
    "schoolchangeforplcmnttypekey" varchar(5),
    "schoolchangereason" varchar(500),
    "hospitaledusrv" varchar(500),
    "schoolexitcomments" varchar(500),
    "transportmodetypekey" integer,
    "paytill22emp80hrchkflag" integer,
    "paytill22medchkflag" integer,
    "paytill22educhkflag" integer,
    "paytill22enrollchkflag" integer,
    "paytill22emppgmchkflag" integer,
    "paytill22medchk" integer,
    "delayinenrollment" varchar(1),
    "delayinenrollmentdetail" varchar(2000),
    PRIMARY KEY ("personeducationid")
);

-- Model(s): Personeducationhistory
CREATE TABLE IF NOT EXISTS "cjams"."personeducation_history" (
    "personeducationhistoryid" uuid,
    "modifieddata" json,
    "rowtype" varchar(20),
    "personeducationid" uuid,
    "personid" uuid,
    "educationname" varchar(200),
    "educationtypekey" varchar(15),
    "countyid" varchar(255),
    "statecode" varchar(15),
    "startdate" timestamp,
    "enddate" timestamp,
    "lastgradetypekey" varchar(15),
    "currentgradetypekey" varchar(15),
    "isspecialeducation" boolean,
    "specialeducationtypekey" varchar(15),
    "absentdate" timestamp,
    "isreceived" boolean,
    "isverified" boolean,
    "isexcuesed" boolean,
    "extracurricular" text,
    "old_id" varchar(50),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "schoolid" uuid,
    "clientid" integer,
    "contactname" varchar(5),
    "schoolsettingtypekey" varchar(5),
    "schoolschedule" varchar(5),
    "schooladjustment" varchar(5),
    "functioninggradetypekey" varchar(5),
    "intensitylevelno" varchar(10),
    "comments" varchar(500),
    "performance" varchar(100),
    "statustypekey" varchar(100),
    "strengths" varchar(100),
    "weaknesses" varchar(100),
    "adrformattypekey" varchar(5),
    "adrstreetno" integer,
    "adrboxno" integer,
    "adrpredirtypekey" varchar(5),
    "adrstreetname" varchar(100),
    "adrstreetsuffixtypekey" varchar(5),
    "adrpostdirtypekey" varchar(255),
    "adrunitno" varchar(255),
    "schooladdress1" varchar(255),
    "schooladdress2" varchar(255),
    "schoolzipcode" varchar(255),
    "adrcityname" varchar(255),
    "adrzip5no" integer,
    "adrzip4no" integer,
    "adrdirection" varchar(100),
    "adrforeign" varchar(100),
    "adrworkphone" varchar(20),
    "adrworkxtn" varchar(20),
    "adrhomephone" varchar(20),
    "adrpager" varchar(20),
    "adremail" varchar(100),
    "adrfax" varchar(10),
    "adrcellphone" varchar(10),
    "adrurl" varchar(100),
    "adrothercontact" varchar(100),
    "lastiepdate" varchar(100),
    "enrollmentdate" timestamp,
    "lastattendeddate" timestamp,
    "withdrawaldate" timestamp,
    "educationstatustypekey" varchar(100),
    "secondaryby19flag" integer,
    "adrforeignstate" varchar(20),
    "adrcountry" varchar(20),
    "adrpostalcode" varchar(20),
    "classtypetypekey" varchar(5),
    "firstqtrperformancetypekey" varchar(5),
    "secondqtrperformancetypekey" varchar(5),
    "thirdqtrperformancetypekey" varchar(5),
    "fourthqtrperformancetypekey" varchar(5),
    "extracurricularactivities" varchar(500),
    "educationproggoal" varchar(500),
    "adrstreet" varchar(100),
    "paytill22typekey" varchar(5),
    "expungementflag" integer,
    "datavalidflag" integer,
    "clientmergeid" integer,
    "educationstatusdate" timestamp,
    "schoolchangeforplcmnttypekey" varchar(5),
    "schoolchangereason" varchar(500),
    "hospitaledusrv" varchar(500),
    "schoolexitcomments" varchar(500),
    "transportmodetypekey" integer,
    "paytill22emp80hrchkflag" integer,
    "paytill22medchkflag" integer,
    "paytill22educhkflag" integer,
    "paytill22enrollchkflag" integer,
    "paytill22emppgmchkflag" integer,
    "paytill22medchk" integer,
    "delayinenrollment" varchar(1),
    "delayinenrollmentdetail" varchar(2000)
);

-- Model(s): Personeducationtesting
CREATE TABLE IF NOT EXISTS "cjams"."personeducationtesting" (
    "personeducationtestingid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "testingtypekey" varchar(100),
    "readinglevel" integer,
    "readingtestdate" timestamp,
    "mathlevel" integer,
    "mathtestdate" timestamp,
    "testingprovider" varchar(15),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "testinginfotype" varchar(50),
    "nameoftester" varchar(100),
    "pretestdate" timestamp,
    "pretestscore" integer,
    "posttestdate" timestamp,
    "posttestscore" integer,
    PRIMARY KEY ("personeducationtestingid")
);

-- Model(s): Personeducationvocation
CREATE TABLE IF NOT EXISTS "cjams"."personeducationvocation" (
    "personeducationvocationid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "vocationinterest" varchar(150),
    "vocationaptitude" varchar(150),
    "isvocationaltest" boolean,
    "certificatename" varchar(150),
    "certificatepath" varchar(250),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("personeducationvocationid")
);

-- Model(s): Personemail
CREATE TABLE IF NOT EXISTS "cjams"."personemail" (
    "personemailid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "activeflag" integer,
    "personemailtypekey" varchar(15),
    "email" varchar(50),
    "commentsemail" text,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea,
    "startdate" timestamp,
    "enddate" timestamp,
    PRIMARY KEY ("personemailid")
);

-- Model(s): Personemailtype
CREATE TABLE IF NOT EXISTS "cjams"."personemailtype" (
    "sequencenumber" integer,
    "personemailtypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personemailtypekey")
);

-- Model(s): Personemployerdetail
CREATE TABLE IF NOT EXISTS "cjams"."personemployerdetail" (
    "personemployerdetailid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "currentemployer" boolean,
    "employername" varchar(50),
    "noofhours" varchar(100),
    "duties" varchar(50),
    "startdate" timestamp,
    "enddate" timestamp,
    "reasonforleaving" varchar(250),
    "careergoals" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personemployerdetailid")
);

-- Model(s): Personemployment
CREATE TABLE IF NOT EXISTS "cjams"."personemployment" (
    "personemploymentid" uuid DEFAULT gen_random_uuid(),
    "employername" varchar(100),
    "supervisorprefixtypekey" varchar(100),
    "supervisorfirstname" varchar(100),
    "supervisormiddlename" varchar(100),
    "supervisorlastname" varchar(100),
    "supervisorsuffixtypekey" varchar(100),
    "clienttitle" varchar(100),
    "startdate" timestamp,
    "workschedule" varchar(100),
    "emplymenttypekey" varchar(100),
    "income" integer,
    "wagefreqtypekey" varchar(100),
    "addresstypekey" varchar(100),
    "formattypekey" varchar(100),
    "insertedby" uuid,
    "insertedon" timestamp,
    "updatedby" uuid,
    "updatedon" timestamp,
    "activeflag" integer,
    "streetnotes" varchar(2000),
    "promotedemploymentprogramname" varchar(100),
    "promotedemploymentprogramstartdate" timestamp,
    "enddate" timestamp,
    "clientmergeid" uuid,
    "personid" uuid,
    "personemployerdetailsid" uuid,
    "address1" varchar(2000),
    "address2" varchar(2000),
    "workphone" json,
    PRIMARY KEY ("personemploymentid")
);

-- Model(s): Personexamination
CREATE TABLE IF NOT EXISTS "cjams"."personexamination" (
    "personexaminationid" uuid DEFAULT gen_random_uuid(),
    "fk_id" varchar(50),
    "appointkeptflag" integer,
    "appoinmentdate" timestamp,
    "nextappointmentdate" timestamp,
    "authformcompletion" integer,
    "notcompletedauthform" varchar(2000),
    "provcaremissed" varchar(2000),
    "otherreasony" varchar(2000),
    "examinationtypekey" varchar(50),
    "comments" varchar(2000),
    "medicalreferrals" varchar(2000),
    "specialityexamtypekey" varchar(50),
    "labtesttypekey" varchar(50),
    "hivconsentflag" integer,
    "recommendations" varchar(2000),
    "providerid" uuid,
    "insertedon" timestamp,
    "insertedby" varchar(50),
    "updatedon" timestamp,
    "updatedby" varchar(50),
    "activeflag" integer,
    "motherflag" integer,
    "fatherflag" integer,
    "otherflag" integer,
    "othernotes" varchar(2000),
    "infocomments" varchar(500),
    "exprovidedtypekey" varchar(50),
    "providedbyclientid" uuid,
    "collateralid" uuid,
    "infoclienttypekey" varchar(50),
    "physicianname" varchar(20),
    "physicianspeciality" varchar(20),
    "affiliateorg" varchar(20),
    "addresstypekey" varchar(50),
    "formattypekey" varchar(50),
    "streetnumber" integer,
    "boxnumber" integer,
    "streetname" varchar(50),
    "streetsuffixtypekey" varchar(50),
    "postdirtypekey" varchar(50),
    "unittypekey" varchar(50),
    "unitnumbertx" varchar(500),
    "cityname" varchar(100),
    "countytypekey" varchar(50),
    "statetypekey" varchar(50),
    "zip5no" integer,
    "zip4no" integer,
    "direction" varchar(500),
    "foreignaddress" varchar(20),
    "workphone" varchar(10),
    "workextn" varchar(10),
    "homephone" varchar(20),
    "pager" varchar(10),
    "email" varchar(100),
    "fax" varchar(20),
    "mobile" varchar(20),
    "url" varchar(100),
    "othercontacts" varchar(20),
    "foreignstate" varchar(20),
    "country" varchar(20),
    "postalcode" varchar(20),
    "streetnotes" varchar(2000),
    "providedbynotes" varchar(2000),
    "providedbyrelationtypekey" varchar(50),
    "expungementflag" integer,
    "datavalidflag" integer,
    "clientmergeid" uuid,
    "old_id" varchar(50),
    "personid" uuid,
    PRIMARY KEY ("personexaminationid")
);

-- Model(s): Personfamilyinfo
CREATE TABLE IF NOT EXISTS "cjams"."personfamilyinfo" (
    "personid" uuid DEFAULT gen_random_uuid(),
    "numofsiblings" integer,
    "numofpersons" integer,
    "grossincome" numeric(5,2),
    "primarysource" varchar(50),
    "timestamp" bytea,
    "titleiveeligible" boolean,
    "amoutwillpay" numeric(5,2),
    "notes" text,
    "placeofbirth" varchar(50),
    "historyfamilyprob" boolean,
    "runaway" boolean,
    "ungovernable" boolean,
    "stealing" boolean,
    "truancy" boolean,
    "assaultive" boolean,
    "residential" boolean,
    "outpatient" boolean,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personid")
);

-- Model(s): Personguardian
CREATE TABLE IF NOT EXISTS "cjams"."personguardian" (
    "personguardianid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "guadianpersonid" uuid,
    "guardianpersontypekey" varchar(15),
    "startdate" timestamp,
    "enddate" timestamp,
    "typeofperson" varchar(50),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("personguardianid")
);

-- Model(s): Personguardiancode
CREATE TABLE IF NOT EXISTS "cjams"."personguardiancode" (
    "personguardiancodeid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "codestatustypekey" varchar(50),
    "othercodestatus" varchar(250),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("personguardiancodeid")
);

-- Model(s): Personguardiandetails
CREATE TABLE IF NOT EXISTS "cjams"."personguardiandetails" (
    "personguardiandetailsid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "hhsclientid" integer,
    "notes" text,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("personguardiandetailsid")
);

-- Model(s): Personguardianfuneral
CREATE TABLE IF NOT EXISTS "cjams"."personguardianfuneral" (
    "personguardianfuneralid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "contact" varchar(250),
    "contactnumber" varchar(10),
    "arrangementsdescription" text,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("personguardianfuneralid")
);

-- Model(s): Personhealthexamination
CREATE TABLE IF NOT EXISTS "cjams"."personhealthexamination" (
    "personhealthexaminationid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "healthexamname" varchar(50),
    "practitionername" varchar(50),
    "outcomeresults" varchar(50),
    "healthdomaintypekey" varchar(50),
    "healthassessmenttypekey" varchar(50),
    "assessmentdate" timestamp,
    "healthprofessiontypekey" varchar(50),
    "notes" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personhealthexaminationid")
);

-- Model(s): Personhealthinsurance
CREATE TABLE IF NOT EXISTS "cjams"."personhealthinsurance" (
    "personhealthinsuranceid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "ismedicaidmedicare" boolean,
    "providertype" varchar(50),
    "policyholdername" varchar(50),
    "address1" varchar(100),
    "address2" varchar(100),
    "city" varchar(50),
    "state" varchar(10),
    "countyid" uuid,
    "zip" varchar(50),
    "providerphone" varchar(25),
    "patientpolicyholderrelation" varchar(50),
    "policyname" varchar(50),
    "groupnumber" varchar(50),
    "providertypeother" varchar(50),
    "insurancetype" varchar(15),
    "medicarenumber" varchar(50),
    "caresmatypekey" varchar(50),
    "isinsuranceavailable" boolean,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "medicalinsuranceprovider" varchar(50),
    "infoclienttypekey" varchar(50),
    "providedbynotes" varchar(2000),
    PRIMARY KEY ("personhealthinsuranceid")
);

-- Model(s): Personhealthpassport
CREATE TABLE IF NOT EXISTS "cjams"."personhealthpassport" (
    "personhealthpassportid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "placementid" uuid,
    "haspassportprovidedtocaregiver" boolean,
    "effectivedate" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personhealthpassportid")
);

-- Model(s): Personhospitalization
CREATE TABLE IF NOT EXISTS "cjams"."personhospitalization" (
    "hospitalizationid" uuid DEFAULT gen_random_uuid(),
    "typekey" varchar(100),
    "reasontypekey" varchar(100),
    "adrfaxtx" varchar(20),
    "startdt" timestamp,
    "enddt" timestamp,
    "diagnosistx" varchar(500),
    "commentstx" varchar(500),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "notificationdate" timestamp,
    "adrdirectiontx" varchar(500),
    "insertedby" varchar(50),
    "adrzip4no" numeric(4,0),
    "insertedon" timestamp,
    "activeflag" integer,
    "adrzip5no" numeric(5,0),
    "adrstatetypekey" varchar(50),
    "personid" uuid,
    "adrcitynm" varchar(50),
    "adrforeignstatetx" varchar(50),
    "providerid" uuid,
    "adrunitnotx" varchar(100),
    "adrcountrytx" varchar(50),
    "adrunittypetypekey" varchar(50),
    "adrpostdirtypekey" varchar(50),
    "adrstreetsuffixtypekey" varchar(50),
    "adrstreetnm" varchar(50),
    "adrpredirtypekey" varchar(50),
    "adrpostalcodetx" varchar(10),
    "adrboxno" integer,
    "adrstreetno" integer,
    "adrcellphonetx" varchar(10),
    "adrformattypekey" varchar(50),
    "hospitalnm" varchar(50),
    "adrcountytypekey" varchar(50),
    "adrforeigntx" varchar(500),
    "adremailtx" varchar(100),
    "infocommentstx" varchar(500),
    "adrpagertx" varchar(20),
    "infomotherflag" integer,
    "infofatherflag" integer,
    "adrhomephonetx" varchar(10),
    "infootherflag" integer,
    "infoothertx" varchar(50),
    "adrworkxtntx" varchar(10),
    "adrworkphonetx" varchar(10),
    "adrurltx" varchar(100),
    "adrothercontacttx" varchar(100),
    "hoinfoprovidedtypekey" varchar(50),
    "infoprovidedbyclientid" integer,
    "infoprovidedbycollateralid" integer,
    "infoclienttypekey" varchar(50),
    "adrtypetypekey" varchar(50),
    "adrstreettx" varchar(100),
    "infoprovidedbytx" varchar(300),
    "infoprovidedbyrelationctypekey" varchar(50),
    "expungementflag" integer,
    "datavalidflag" integer,
    "clientmergeid" uuid,
    "old_id" varchar(50),
    PRIMARY KEY ("hospitalizationid")
);

-- Model(s): Personidentifier
CREATE TABLE IF NOT EXISTS "cjams"."personidentifier" (
    "personidentifierid" uuid,
    "personid" uuid,
    "personidentifiertypekey" varchar(15),
    "personidentifiervalue" varchar(50),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea
);

-- Model(s): Personidentifiertype
CREATE TABLE IF NOT EXISTS "cjams"."personidentifiertype" (
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "personidentifiertypekey" varchar(15),
    "sequencenumber" integer,
    "typedescription" varchar(250),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personidentifiertypekey")
);

-- Model(s): Personimmunization
CREATE TABLE IF NOT EXISTS "cjams"."personimmunization" (
    "personimmunizationid" uuid,
    "personid" uuid,
    "reportedby" varchar(100),
    "immunizationdocname" varchar(50),
    "immunizationdocpath" text,
    "isimmunefileavail" boolean,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "activeflag" integer,
    "immunizationtypekey" varchar(50),
    "immunizationdate" timestamp,
    "nextduedate" timestamp,
    "comments" varchar(500),
    "certifiedcopyflag" integer,
    "direction" varchar(500),
    "zip4no" integer,
    "fk_id" varchar(50),
    "zip5no" integer,
    "statetypekey" varchar(50),
    "providerid" text /* unmapped type:  for providerid */
);

-- Model(s): Personimmunizationconfig
CREATE TABLE IF NOT EXISTS "cjams"."personimmunizationconfig" (
    "personimmunizationconfigid" uuid DEFAULT gen_random_uuid(),
    "value_text" varchar(100),
    "description" varchar(100),
    "uiconfig" jsonb,
    "insertedon" varchar(30),
    "insertedby" varchar(50),
    "updatedon" varchar(50),
    "updatedby" varchar(50),
    "recordstatus" integer,
    PRIMARY KEY ("personimmunizationconfigid")
);

-- Model(s): Lifeskillsassessment
CREATE TABLE IF NOT EXISTS "cjams"."personlifeskillassessment" (
    "activeflag" varchar(255),
    "lifeskillassessid" uuid,
    "assessmentdate" timestamptz,
    "assessmenttypekey" varchar(50),
    "assessmentlocation" varchar(128),
    "insertedby" varchar(10),
    "updatedby" varchar(10),
    "insertedon" timestamptz,
    "updatedon" timestamptz,
    "fk_id" varchar(50),
    "old_id" varchar(50),
    "personid" uuid
);

-- Model(s): Personmaritalstatus
CREATE TABLE IF NOT EXISTS "cjams"."personmaritalstatus" (
    "personmaritalstatusid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "personid" uuid,
    "startdate" timestamptz,
    "enddate" timestamptz,
    "marriageplace" varchar(50),
    "divorceplace" varchar(50),
    "prefixtypekey" varchar(20),
    "firstname" varchar(50),
    "middlename" varchar(32),
    "lastname" varchar(50),
    "suffixtypekey" varchar(20),
    "informallivingcomments" varchar(500),
    "childrenno" integer,
    "statustypekey" varchar(50),
    "adrhomephone" integer,
    "adrworkxtn" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personmaritalstatusid")
);

-- Model(s): Personmedicalcondition
CREATE TABLE IF NOT EXISTS "cjams"."personmedicalcondition" (
    "personmedicalconditionid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "begindate" timestamp,
    "enddate" timestamp,
    "recordedby" varchar(100),
    "medicalconditiontypekey" varchar(50),
    "medicalconditionother" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personmedicalconditionid")
);

-- Model(s): Personmedicalconditioninfo
CREATE TABLE IF NOT EXISTS "cjams"."personmedicalconditioninfo" (
    "personmedicalconditioninfoid" uuid,
    "personmedicalconditionid" uuid,
    "medicalconditiontypekey" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("medicalconditiontypekey")
);

-- Model(s): Personmedication
CREATE TABLE IF NOT EXISTS "cjams"."personmedications" (
    "personmedicationsid" uuid DEFAULT gen_random_uuid(),
    "medicationname" varchar(50),
    "startdate" timestamp,
    "frequency" varchar(20),
    "stopdate" timestamp,
    "stoppeddate" timestamp,
    "reason" varchar(20),
    "appointmentdate" timestamp,
    "nextappointmentdate" timestamp,
    "fk_id" varchar(50),
    "providerid" uuid,
    "insertedon" timestamp,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "infomotherflag" integer,
    "infofatherflag" integer,
    "infoother" varchar(20),
    "infocomments" varchar(500),
    "mdinfoprovdedtypekey" varchar(50),
    "infoprovidedbyclientid" integer,
    "infoprovidedbycollateralid" integer,
    "infoclienttypekey" varchar(50),
    "physicianname" varchar(50),
    "affliateorg" varchar(20),
    "adrtypekey" varchar(50),
    "adrformattypekey" varchar(50),
    "adrstreetno" integer,
    "adrboxno" integer,
    "adrpredirtypekey" varchar(50),
    "adrstreetname" varchar(100),
    "adrstreetsuffixtypekey" varchar(50),
    "adrpostdirtypekey" varchar(50),
    "adrunittypekey" varchar(50),
    "adrunitno" varchar(10),
    "adrcityname" varchar(100),
    "adrcountytypekey" varchar(50),
    "adrstatetypekey" varchar(50),
    "adrzip5no" numeric,
    "adrzip4no" numeric,
    "adrdirection" varchar(500),
    "adrforeign" varchar(20),
    "adrworkphone" varchar(10),
    "adrworkxtn" varchar(10),
    "adrhomephone" varchar(20),
    "adrpager" varchar(10),
    "adremail" varchar(100),
    "adrfax" varchar(20),
    "adrcellphone" varchar(20),
    "adrurl" varchar(100),
    "adrothercontact" varchar(20),
    "adrforeignstate" varchar(20),
    "adrcountry" varchar(20),
    "adrpostalcode" varchar(20),
    "pharmacyname" varchar(50),
    "pharmacyphone" varchar(20),
    "adrstreet" varchar(20),
    "infoprovidedby" varchar(50),
    "infoprovidedbyrelationtypekey" varchar(50),
    "expungementflag" integer,
    "datavalidflag" integer,
    "clientmergeid" uuid,
    "old_id" varchar(50),
    PRIMARY KEY ("personmedicationsid")
);

-- Model(s): Personmedicpshychotropic
CREATE TABLE IF NOT EXISTS "cjams"."personmedicpshychotropic" (
    "personmedicpshychotropicid" uuid,
    "personid" uuid,
    "medicationname" varchar(50),
    "medicationeffectivedate" timestamp,
    "medicationexpirationdate" timestamp,
    "dosage" varchar(100),
    "frequency" varchar(100),
    "prescribingdoctor" varchar(100),
    "lastdosetakendate" timestamp,
    "prescriptionreasontypekey" varchar(50),
    "informationsourcetypekey" varchar(50),
    "medicationcomments" varchar(100),
    "medicationtypekey" varchar(100),
    "reportedby" varchar(100),
    "compliant" integer,
    "startdate" timestamp,
    "enddate" timestamp,
    "monitoring" varchar(150),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "personmedicpshychotropicparentid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp
);

-- Model(s): Personmilitaryservices
CREATE TABLE IF NOT EXISTS "cjams"."personmilitaryservices" (
    "personmilitaryserviceid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "personid" uuid,
    "branchkey" varchar(5),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("personmilitaryserviceid")
);

-- Model(s): Personnickname
CREATE TABLE IF NOT EXISTS "cjams"."personnickname" (
    "personnicknameid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "personid" uuid,
    "nickname" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("personnicknameid")
);

-- Model(s): PersonNytdDetail
CREATE TABLE IF NOT EXISTS "cjams"."personnytddetail" (
    "summaryid" uuid,
    "elementid" uuid,
    "elementvalue" varchar(255),
    "validatedflag" integer,
    "validatedtime" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "old_id" varchar(255)
);

-- Model(s): PersonNytdSummary
CREATE TABLE IF NOT EXISTS "cjams"."personnytdsummary" (
    "summaryid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "reportingperiod" varchar(255),
    "reporttypekey" varchar(255),
    "surveyloaddate" timestamp,
    "reportextractdtate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "validationflag" integer,
    "verifiedstaffid" integer,
    "old_id" varchar(255),
    "etl_userid" varchar(255),
    "etl_load_date" timestamp,
    PRIMARY KEY ("summaryid")
);

-- Model(s): Personphonenumber
CREATE TABLE IF NOT EXISTS "cjams"."personphonenumber" (
    "personphonenumberid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "activeflag" integer,
    "personphonetypekey" varchar(15),
    "phonenumber" varchar(32),
    "commentsphone" text,
    "phoneextension" varchar(8),
    "reversephonenumber" varchar(32),
    "isprimary" boolean,
    "ismobile" boolean,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea,
    "startdate" timestamp,
    "enddate" timestamp,
    PRIMARY KEY ("personphonenumberid")
);

-- Model(s): Personphonetype
CREATE TABLE IF NOT EXISTS "cjams"."personphonetype" (
    "sequencenumber" integer,
    "personphonetypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personphonetypekey")
);

-- Model(s): Personphycisianinfo
CREATE TABLE IF NOT EXISTS "cjams"."personphycisianinfo" (
    "personphycisianinfoid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "isprimaryphycisian" boolean,
    "name" varchar(50),
    "facility" varchar(100),
    "physicianspecialtytypekey" varchar(100),
    "phone" varchar(25),
    "email" varchar(50),
    "address1" varchar(100),
    "address2" varchar(100),
    "city" varchar(50),
    "state" varchar(10),
    "countyid" uuid,
    "zip" varchar(50),
    "startdate" timestamp,
    "enddate" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personphycisianinfoid")
);

-- Model(s): Personphysicalattribute
CREATE TABLE IF NOT EXISTS "cjams"."personphysicalattribute" (
    "personphysicalattributeid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "physicalattributetypekey" varchar(15),
    "attributevalue" varchar(50),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("personphysicalattributeid")
);

-- Model(s): Personprogramarea
CREATE TABLE IF NOT EXISTS "cjams"."personprogramarea" (
    "personprogramid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "startdate" timestamp,
    "enddate" timestamp,
    "datavalidflag" integer,
    "clientmergeid" integer,
    "ifpsatriskflag" integer,
    "endreasonkey" varchar(12),
    "programkey" varchar(15),
    "subprogramkey" varchar(15),
    "objecttypekey" varchar(25),
    "objectid" varchar(50),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" integer,
    "old_id" varchar(50),
    "entityid" varchar(50),
    "datatransferflag" varchar(1),
    "alternateid" bigint,
    "sourcetype" varchar(10),
    PRIMARY KEY ("personprogramid")
);

-- Model(s): Personrelation
CREATE TABLE IF NOT EXISTS "cjams"."personrelation" (
    "personrelationid" uuid,
    "personid" uuid,
    "personrelativeid" uuid,
    "personrelationtypeid" uuid,
    "actorrelationshipkey" varchar(50),
    "relationcategory" varchar(15),
    "incustody" boolean,
    "livingwith" boolean,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer
);

-- Model(s): Personrelationtype
CREATE TABLE IF NOT EXISTS "cjams"."personrelationtype" (
    "personrelationtypeid" uuid DEFAULT gen_random_uuid(),
    "personrelationtypekey" varchar(50),
    "description" varchar(250),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "relationcategory" varchar(15),
    "incustody" boolean,
    "livingwith" boolean,
    PRIMARY KEY ("personrelationtypeid")
);

-- Model(s): Personrepresentativepayee
CREATE TABLE IF NOT EXISTS "cjams"."personrepresentativepayee" (
    "personrepresentativepayeeid" uuid,
    "personid" uuid,
    "personrepresentativepersonid" uuid,
    "personrepresentativeworkerid" varchar(255),
    "entityid" uuid,
    "persontypekey" varchar(15),
    "representativetypekey" varchar(15),
    "startdate" timestamp,
    "enddate" timestamp,
    "entitytypekey" varchar(15),
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "old_id" varchar(50)
);

-- Model(s): Personresultfield
CREATE TABLE IF NOT EXISTS "cjams"."personresultfield" (
    "personresultfieldid" uuid DEFAULT gen_random_uuid(),
    "personresultfieldkey" varchar(50),
    "personresultfielddesc" varchar(150),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personresultfieldid")
);

-- Model(s): Personrole
CREATE TABLE IF NOT EXISTS "cjams"."personrole" (
    "personroleid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "personid" uuid,
    "ishouseholdmember" integer,
    "iscollateralcontact" integer,
    "drugexposednewbornflag" integer,
    "drugexposedtypekey" varchar(255),
    "otherdrugs" varchar(255),
    "safehavenbabyflag" integer,
    "probationsearchconductedflag" integer,
    "sexoffenderregisteredflag" integer,
    "dangertoself" integer,
    "dangertoselfreason" varchar(255),
    "isdangertoworker" integer,
    "dangertoworkerreason" varchar(255),
    "ismentalillness" integer,
    "mentalillnessdetail" varchar(255),
    "ismentalimpair" integer,
    "mentalimpairdetail" varchar(255),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "intakenumber" varchar(255),
    "intakeserviceid" uuid,
    "servicecaseid" uuid,
    "initialresponse" integer,
    "initialresponseupdatedby" varchar(50),
    "initialresponseupdatedon" timestamp,
    PRIMARY KEY ("personroleid")
);

-- Model(s): Personroletype
CREATE TABLE IF NOT EXISTS "cjams"."personroletype" (
    "personroletypeid" uuid DEFAULT gen_random_uuid(),
    "personroleid" uuid,
    "activeflag" integer,
    "roletype" varchar(255),
    "isprimary" varchar(255),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personroletypeid")
);

-- Model(s): Personservicetype
CREATE TABLE IF NOT EXISTS "cjams"."personservicetype" (
    "personservicetypeid" uuid,
    "personservicetypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp
);

-- Model(s): Personsexualinfo
CREATE TABLE IF NOT EXISTS "cjams"."personsexualinfo" (
    "personsexualinfoid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "infoprovidedbypersonid" uuid,
    "infoprovidedbycollateralid" uuid,
    "infoclientkey" varchar(50),
    "sexualactiveflag" integer,
    "sexualorientationkey" varchar(50),
    "pregnancyno" integer,
    "childrenno" integer,
    "birthcontrol" varchar(20),
    "sicomments" varchar(500),
    "insertedon" timestamp,
    "insertedby" varchar(50),
    "updatedon" timestamp,
    "updatedby" varchar(50),
    "activeflag" integer,
    "sextransdis" varchar(20),
    "infoprovidedby" varchar(10),
    "infoprovidedbyrelationkey" varchar(50),
    "expungementflag" integer,
    "datavalidflag" integer,
    "clientmergeid" uuid,
    "fk_id" varchar(50),
    "old_id" varchar(50),
    PRIMARY KEY ("personsexualinfoid")
);

-- Model(s): Personspouseaddress
CREATE TABLE IF NOT EXISTS "cjams"."personspouseaddress" (
    "personspouseaddressid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "personid" uuid,
    "adr1" varchar(500),
    "adr2" varchar(500),
    "city" varchar(32),
    "state" varchar(2),
    "county" varchar(32),
    "zip5no" varchar(32),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personspouseaddressid")
);

-- Model(s): Personsupport
CREATE TABLE IF NOT EXISTS "cjams"."personsupport" (
    "personsupportid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "personid" uuid,
    "intakenumber" varchar(255),
    "personsupporttypekey" varchar(255),
    "supportername" varchar(255),
    "description" varchar(255),
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "old_id" varchar(50),
    PRIMARY KEY ("personsupportid")
);

-- Model(s): Persontransportation
CREATE TABLE IF NOT EXISTS "cjams"."persontransportation" (
    "persontransportationid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "personid" uuid,
    "dateoftransport" timestamp,
    "pickuptime" timestamp,
    "droptime" timestamp,
    "youthname" varchar(100),
    "dob" timestamp,
    "courttime" timestamp,
    "courtlocation" varchar(50),
    "chargereason" varchar(50),
    "locationfromtypekey" varchar(50),
    "locationtotypekey" varchar(50),
    "otherlocationfrom" varchar(50),
    "otherlocationto" varchar(50),
    "notes" text,
    "appointmentdate" timestamp,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "old_id" varchar(50),
    "allegationid" uuid,
    PRIMARY KEY ("persontransportationid")
);

-- Model(s): Personworkcarrergoal
CREATE TABLE IF NOT EXISTS "cjams"."personworkcarrergoal" (
    "personworkcarrergoalid" uuid DEFAULT gen_random_uuid(),
    "personid" uuid,
    "careergoals" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("personworkcarrergoalid")
);

-- Model(s): Petitiontype
CREATE TABLE IF NOT EXISTS "cjams"."petitiontype" (
    "petitiontypeid" uuid,
    "petitiontypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("petitiontypekey")
);

-- Model(s): Petitionwitness
CREATE TABLE IF NOT EXISTS "cjams"."petitionwitness" (
    "petitionwitnessid" uuid,
    "personid" uuid,
    "petitionid" uuid,
    "petitiontypekey" varchar(50),
    "genwitnessflag" integer,
    "gencertflag" integer,
    "petitionmaildate" date,
    "insertedby" varchar(30),
    "insertedon" timestamp,
    "updatedby" varchar(30),
    "updatedon" timestamp,
    "activeflag" integer,
    "datavalidflag" integer,
    "clientmergeid" uuid,
    "old_id" varchar(50),
    "petitionwitnessaddress" varchar(100)
);

-- Model(s): Pgresource
CREATE TABLE IF NOT EXISTS "cjams"."pgresource" (
    "pgresourceid" uuid DEFAULT gen_random_uuid(),
    "permissiongroupid" uuid,
    "resourceid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "isallowed" boolean,
    "isvisible" boolean,
    "isenabled" boolean,
    PRIMARY KEY ("pgresourceid")
);

-- Model(s): Physicalattributetype
CREATE TABLE IF NOT EXISTS "cjams"."physicalattributetype" (
    "physicalattributetypeid" uuid,
    "physicalattributetypekey" varchar(100),
    "description" varchar(250),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("physicalattributetypekey")
);

-- Model(s): Physicianspecialtytype
CREATE TABLE IF NOT EXISTS "cjams"."physicianspecialtytype" (
    "physicianspecialtytypeid" uuid,
    "physicianspecialtytypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp
);

-- Model(s): Placement
CREATE TABLE IF NOT EXISTS "cjams"."placement" (
    "placementid" uuid DEFAULT gen_random_uuid(),
    "providerid" uuid,
    "providerorganizationid" integer,
    "contractprogramid" integer,
    "intakeserviceid" uuid,
    "intakenumber" varchar(50),
    "personid" uuid,
    "intakeservicerequestactorid" uuid,
    "startdatetime" timestamp,
    "enddatetime" timestamp,
    "exitreasontypekey" varchar(15),
    "remarks" text,
    "leastrestrictiveplacement" text,
    "justification" text,
    "statustypekey" varchar(255),
    "exittypekey" varchar(15),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "placementadmissionclassificationkey" varchar(50),
    "placementadmissiontypekey" varchar(50),
    "parentorg" varchar(50),
    "addate" timestamp,
    "adtime" timestamp,
    "releasedate" timestamp,
    "detainer" varchar(50),
    "placementadmissionauthorizationtypekey" varchar(50),
    "placementprimaryadmissionreasontypekey" varchar(50),
    "placementprimaryapprovedalttypekey" varchar(50),
    "county" varchar(50),
    "jlocation" varchar(50),
    "jcounty" varchar(50),
    "fieldworker" varchar(50),
    "resourceworker" varchar(50),
    "lrstatus" varchar(50),
    "isprovidertyperesidential" boolean,
    "isoperatedbydjs" boolean,
    "cop" boolean,
    "certifiedad" varchar(50),
    "istempplacement" boolean,
    "servicecaseid" uuid,
    "intakeservreqchildremovalid" uuid,
    "placementtypekey" varchar(50),
    "service_id" integer,
    "ratestructureid" integer,
    "starttime" varchar(20),
    "endtime" varchar(20),
    "providersentdate" timestamp,
    "providerdesc" varchar(250),
    "responseacceptedkey" varchar(50),
    "rejectreasonkey" varchar(50),
    "isssaapproval" integer,
    "ifcapprovaldate" timestamp,
    "altproviderid" integer,
    "isvoided" integer,
    "voidreasontypekey" varchar(15),
    "voidremarks" varchar(200),
    "voiddate" timestamp,
    "ischildplacedoutside" boolean,
    "primaryrelationship" varchar(50),
    "fostercomments" varchar(100),
    "plluggagecomments" varchar(50),
    "placementluggage" boolean,
    "plluggagepurchased" boolean,
    "placementdisposableortrashbag" boolean,
    "exitluggagecomments" varchar(50),
    "exitluggage" boolean,
    "exitluggageprovided" boolean,
    "exitdisposableortrashbag" boolean,
    PRIMARY KEY ("placementid")
);

-- Model(s): Tb_placement_cpa_homes
CREATE TABLE IF NOT EXISTS "cjams"."placementcpahomes" (
    "placementcpahomeid" uuid,
    "placementid" uuid,
    "altplacementid" integer,
    "altproviderid" integer,
    "entrydt" date,
    "entrytm" varchar(30),
    "exitdt" date,
    "exittm" varchar(30),
    "exittypecd" varchar(5),
    "exitreasoncd" varchar(5),
    "commentstx" varchar(500),
    "createts" varchar(30),
    "createuserid" varchar(10),
    "updatets" varchar(30),
    "updateuserid" varchar(10)
);

-- Model(s): Placementleavereturn
CREATE TABLE IF NOT EXISTS "cjams"."placementleavereturn" (
    "placementleavereturnid" uuid,
    "placementid" uuid,
    "departeddate" timestamp,
    "departedtime" timestamp,
    "leavetypekey" varchar(15),
    "releasedby" varchar(15),
    "releasedto" varchar(15),
    "projectedreturndate" timestamp,
    "leavecomments" varchar(15),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "actualreturndate" timestamp,
    "actualreturntime" timestamp,
    "returnby" varchar(15),
    "returncomments" varchar(150),
    "leavenotes" varchar(50),
    "providerid" uuid
);

-- Model(s): Placementrelease
CREATE TABLE IF NOT EXISTS "cjams"."placementrelease" (
    "placementreleaseid" uuid,
    "placementid" uuid,
    "releasedate" timestamp,
    "releasetime" timestamp,
    "releasetoname" varchar(15),
    "releasereason" varchar(15),
    "whereabouts" varchar(15),
    "releasecategory" varchar(15),
    "releasecomments" varchar(15),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp
);

-- Model(s): Placementrevision
CREATE TABLE IF NOT EXISTS "cjams"."placementrevision" (
    "placementrevisionid" uuid,
    "placementid" uuid,
    "transactiondate" timestamp,
    "entrydate" timestamp,
    "entrytime" varchar(30),
    "exitdate" timestamp,
    "exittime" varchar(30),
    "exittypetypkey" varchar(5),
    "exitreasontypkey" varchar(5),
    "exitexplanation" varchar(500),
    "approvalstatustypkey" varchar(5),
    "approvaldate" timestamp,
    "isoriginal" boolean,
    "insertedon" timestamp,
    "insertedby" varchar(50),
    "updatedon" timestamp,
    "updatedby" varchar(50),
    "activeflag" integer,
    "alternateid" integer,
    "deletesw" boolean
);

-- Model(s): Prescriptionreasontype
CREATE TABLE IF NOT EXISTS "cjams"."prescriptionreasontype" (
    "prescriptionreasontypeid" uuid,
    "prescriptionreasontypekey" varchar(15),
    "description" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    PRIMARY KEY ("prescriptionreasontypekey")
);

-- Model(s): Priority
CREATE TABLE IF NOT EXISTS "cjams"."priority" (
    "priorityid" uuid DEFAULT gen_random_uuid(),
    "priority" varchar(50),
    "description" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "timestamp" bytea,
    "activeflag" integer,
    PRIMARY KEY ("priorityid")
);

-- Model(s): Professiontype
CREATE TABLE IF NOT EXISTS "cjams"."professiontype" (
    "professiontypeid" uuid,
    "professiontypekey" varchar(50),
    "typedescription" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("professiontypekey")
);

-- Model(s): Programareaconfig
CREATE TABLE IF NOT EXISTS "cjams"."programareaconfig" (
    "programareaconfigid" uuid DEFAULT gen_random_uuid(),
    "programkey" varchar(15),
    "subprogramkey" varchar(25),
    "servicerequestsubtypekey" varchar(25),
    "isdefault" integer,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("programareaconfigid")
);

-- Model(s): Progressnote
CREATE TABLE IF NOT EXISTS "cjams"."progressnote" (
    "progressnoteid" uuid,
    "intakeserviceid" uuid,
    "servicecaseid" uuid,
    "progressnotetypeid" uuid,
    "isintake" text,
    "otherpersonname" text,
    "description" text,
    "entitytype" varchar(50),
    "entitytypeid" varchar(50),
    "pagetitle" varchar(50),
    "pageurl" text,
    "islatest" integer,
    "versionof" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "archivedby" varchar(50),
    "archivedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "timestamp" bytea,
    "savemode" boolean,
    "progressnotesubtypeid" uuid,
    "contactdate" timestamp,
    "contactname" varchar(50),
    "progressnotetypekey" varchar(15),
    "contactroletypekey" varchar(15),
    "contactphone" varchar(15),
    "contactemail" varchar(15),
    "attemptindicator" boolean,
    "initiationindicator" boolean,
    "activeflag" integer,
    "documentpropertiesid" uuid,
    "starttime" timestamp,
    "endtime" timestamp,
    "stafftypekey" varchar(50),
    "instantresults" integer,
    "contactstatus" boolean,
    "drugscreen" boolean,
    "progressnotepurposetypekey" varchar(50),
    "progressnotereasontypekey" varchar(15),
    "traveltime" varchar(15),
    "totaltime" varchar(15),
    "uploadedfile" json,
    "focusperson" json,
    "locationname" varchar(50),
    "notesid" varchar(50)
);

-- Model(s): Progressnoteactor
CREATE TABLE IF NOT EXISTS "cjams"."progressnoteactor" (
    "progressnoteactorid" uuid DEFAULT gen_random_uuid(),
    "progressnoteid" uuid,
    "intakeservicerequestactorid" uuid,
    "personname" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "old_id" varchar(25),
    PRIMARY KEY ("progressnoteactorid")
);

-- Model(s): Progressnoteclassificationtype
CREATE TABLE IF NOT EXISTS "cjams"."progressnoteclassificationtype" (
    "sequencenumber" integer,
    "progressnoteclassificationtypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("progressnoteclassificationtypekey")
);

-- Model(s): Progressnotedetail
CREATE TABLE IF NOT EXISTS "cjams"."progressnotedetail" (
    "progressnotedetailid" uuid DEFAULT gen_random_uuid(),
    "progressnoteid" varchar(50),
    "description" text,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "isaddendum" integer,
    PRIMARY KEY ("progressnotedetailid")
);

-- Model(s): Progressnotepurposetype
CREATE TABLE IF NOT EXISTS "cjams"."progressnotepurposetype" (
    "progressnotepurposetypeid" uuid,
    "progressnotepurposetypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("progressnotepurposetypekey")
);

-- Model(s): Progressnotereasontype
CREATE TABLE IF NOT EXISTS "cjams"."progressnotereasontype" (
    "progressnotereasontypeid" uuid DEFAULT gen_random_uuid(),
    "progressnotereasontypekey" varchar(100),
    "activeflag" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "old_id" varchar(25),
    PRIMARY KEY ("progressnotereasontypeid")
);

-- Model(s): Progressnotereasontypeconfig
CREATE TABLE IF NOT EXISTS "cjams"."progressnotereasontypeconfig" (
    "progressnotereasontypeconfigid" uuid DEFAULT gen_random_uuid(),
    "progressnoteid" uuid,
    "personid" uuid,
    "name" varchar(50),
    "primaryphoneno" varchar(50),
    "email" varchar(50),
    "relationship" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("progressnotereasontypeconfigid")
);

-- Model(s): Progressnoteroletype
CREATE TABLE IF NOT EXISTS "cjams"."progressnoteroletype" (
    "progressnoteroletypeid" uuid,
    "progressnoteid" uuid,
    "contactroletypekey" varchar(20),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "expirationdate" timestamp,
    "effectivedate" timestamp
);

-- Model(s): Progressnotesubtype
CREATE TABLE IF NOT EXISTS "cjams"."progressnotesubtype" (
    "progressnotesubtypeid" uuid DEFAULT gen_random_uuid(),
    "progressnotesubtypekey" varchar(50),
    "activeflag" integer,
    "description" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "parentid" uuid,
    "progressnoteclassificationtypekey" varchar(15),
    PRIMARY KEY ("progressnotesubtypeid")
);

-- Model(s): Progressnotetype
CREATE TABLE IF NOT EXISTS "cjams"."progressnotetype" (
    "progressnotetypeid" uuid DEFAULT gen_random_uuid(),
    "progressnotetypekey" varchar(50),
    "activeflag" integer,
    "description" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "parentid" uuid,
    "progressnoteclassificationtypekey" varchar(15),
    PRIMARY KEY ("progressnotetypeid")
);

-- Model(s): Provider
CREATE TABLE IF NOT EXISTS "cjams"."provider" (
    "providerid" uuid DEFAULT gen_random_uuid(),
    "providercategorytypekey" varchar(15),
    "providerstatustypekey" varchar(15),
    "providername" varchar(100),
    "countyid" uuid,
    "rank" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "updatedby" varchar(50),
    "activeflag" integer,
    "firstname" varchar(50),
    "middlename" varchar(50),
    "lastname" varchar(50),
    "prefix" varchar(50),
    "old_id" varchar(50),
    "providercode" varchar(15),
    "bedsapproved" integer,
    "bedsvacant" integer,
    "age" integer,
    "gendertypekey" varchar(15),
    "racetypekey" varchar(15),
    "levelofcare" varchar(100),
    "parentorg" varchar(50),
    "providerunit" varchar(50),
    "placementadmissionclassificationkey" varchar(50),
    "placementadmissiontypekey" varchar(50),
    "bponumber" varchar(50),
    PRIMARY KEY ("providerid")
);

-- Model(s): Provideraddress
CREATE TABLE IF NOT EXISTS "cjams"."provideraddress" (
    "provideraddressid" uuid DEFAULT gen_random_uuid(),
    "providerid" uuid,
    "provideraddresstypekey" varchar(20),
    "buildingno" varchar(20),
    "addressline1" varchar(100),
    "addressline2" varchar(100),
    "city" varchar(100),
    "state" varchar(100),
    "county" varchar(100),
    "latitude" varchar(20),
    "longitude" varchar(20),
    "effectivedate" timestamp,
    "expirydate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("provideraddressid")
);

-- Model(s): Provideraddresstype
CREATE TABLE IF NOT EXISTS "cjams"."provideraddresstype" (
    "sequencenumber" integer,
    "provideraddresstypekey" varchar(255),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("provideraddresstypekey")
);

-- Model(s): Provideragencytypeconfig
CREATE TABLE IF NOT EXISTS "cjams"."provideragencytypeconfig" (
    "provideragencytypeconfigid" uuid DEFAULT gen_random_uuid(),
    "providerid" uuid,
    "teamtypekey" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("provideragencytypeconfigid")
);

-- Model(s): Provideragreement
CREATE TABLE IF NOT EXISTS "cjams"."provideragreement" (
    "provideragreementid" uuid,
    "activeflag" integer,
    "organizationid" uuid,
    "provideragreementstatuskey" varchar(50),
    "provideragreementtypekey" varchar(50),
    "description" text,
    "statuschangereason" varchar(250),
    "caregiverid" uuid,
    "ersnumber" varchar(50),
    "bonding" varchar(50),
    "telephone" varchar(50),
    "startdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "ssbg" varchar(20),
    "medicaid_1" varchar(35),
    "medicaid_2" varchar(35),
    "npi_1" varchar(20),
    "npi_2" varchar(20),
    "officeadminnum" varchar(20),
    "federaltaxid" varchar(35),
    "moemployeridnum" varchar(20),
    "telephonyauthorized" boolean,
    "telephonyprovider" varchar(100),
    "telephonystartdate" timestamp,
    "telephonyenddate" timestamp,
    "fiscalyear" integer,
    "providername" varchar(100),
    "provideralias" varchar(50),
    "originalcontractdate" timestamp,
    "title19provider" boolean,
    "provideragreementbusinesstypekey" varchar(15),
    "medicaid_3" varchar(35),
    "npi_3" varchar(20),
    "fiscalyearmonth" integer
);

-- Model(s): Provideragreementdocumentruleconfig
CREATE TABLE IF NOT EXISTS "cjams"."provideragreementdocumentruleconfig" (
    "provideragreementdocumentruleconfigid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "questionname" text,
    "questiontext" text,
    "servicerequesttypeconfigroleid" uuid,
    "sequencenumber" integer,
    "statestatutesid" uuid
);

-- Model(s): Provideragreementdocumenttype
CREATE TABLE IF NOT EXISTS "cjams"."provideragreementdocumenttype" (
    "sequencenumber" integer,
    "provideragreementdocumenttypekey" varchar(50),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("provideragreementdocumenttypekey")
);

-- Model(s): Provideragreementtype
CREATE TABLE IF NOT EXISTS "cjams"."provideragreementtype" (
    "sequencenumber" integer,
    "provideragreementtypekey" varchar(50),
    "activeflag" integer,
    "provideragreementtypename" varchar(50),
    "description" varchar(250),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp
);

-- Model(s): Providerapprovalphaserecord
CREATE TABLE IF NOT EXISTS "cjams"."providerapprovalphaserecord" (
    "provider_approval_record_id" uuid DEFAULT gen_random_uuid(),
    "referral_id" varchar(50),
    "applicant_id" varchar(50),
    "provider_id" varchar(50),
    "is_referral_accepted" boolean,
    "is_pre_app_accepted" boolean,
    "is_application_accepted" boolean,
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    PRIMARY KEY ("provider_approval_record_id")
);

-- Model(s): Providerapprovetypeconfig
CREATE TABLE IF NOT EXISTS "cjams"."providerapprovetypeconfig" (
    "providerapprovetypeconfigid" uuid DEFAULT gen_random_uuid(),
    "providerid" varchar(50),
    "referralid" varchar(255),
    "applicantid" varchar(255),
    "comments" text,
    "approval_type" varchar(255),
    "communication" varchar(255),
    "requested_date" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    PRIMARY KEY ("providerapprovetypeconfigid")
);

-- Model(s): Providerchildcharacteristic
CREATE TABLE IF NOT EXISTS "cjams"."providerchildcharacteristic" (
    "providerchildcharacteristicid" uuid DEFAULT gen_random_uuid(),
    "childcharacteristictypekey" varchar(50),
    "providerid" uuid,
    "activeflag" integer,
    "effectivedate" uuid,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    PRIMARY KEY ("providerchildcharacteristicid")
);

-- Model(s): Providercontract, Publicprovider
CREATE TABLE IF NOT EXISTS "cjams"."providercontract" (
    "providercontractid" uuid,
    "providerid" uuid,
    "contracttypekey" varchar(255),
    "notes" varchar(250),
    "effectivedate" date,
    "expirydate" date,
    "programstatuskey" varchar(20),
    "capcitypercentage" integer,
    "contractedbeds" integer,
    "contractedvacancy" integer,
    "isperferredprovider" boolean,
    "programid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer
);

-- Model(s): Providercontracttype
CREATE TABLE IF NOT EXISTS "cjams"."providercontracttype" (
    "sequencenumber" integer,
    "providercontracttypekey" varchar(50),
    "activeflag" integer,
    "providercontracttypename" varchar(50),
    "description" varchar(250),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp
);

-- Model(s): Providerformconfig
CREATE TABLE IF NOT EXISTS "cjams"."providerformconfig" (
    "template_id" uuid DEFAULT gen_random_uuid(),
    "external_template_id" varchar(50),
    "template_nm" varchar(255),
    "template_description" varchar(50),
    "template_category" varchar(50),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    PRIMARY KEY ("template_id")
);

-- Model(s): Providerformdetails
CREATE TABLE IF NOT EXISTS "cjams"."providerformdetails" (
    "form_detail_id" uuid DEFAULT gen_random_uuid(),
    "template_id" uuid,
    "object_id" varchar(50),
    "provider_id" varchar(50),
    "form_data" json,
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    PRIMARY KEY ("form_detail_id")
);

-- Model(s): Providerincident
CREATE TABLE IF NOT EXISTS "cjams"."providerincident" (
    "incident_id" integer,
    "incident_no" varchar(255),
    "license_no" varchar(255),
    "program_nm" varchar(255),
    "incident_category" varchar(255),
    "youth_narrative" varchar(255),
    "provider_id" integer,
    "site_id" integer,
    "program_director_first_nm" varchar(255),
    "program_director_last_nm" varchar(255),
    "program_director_phone" varchar(255),
    "incident_date" timestamp,
    "incident_time" timestamp,
    "law_enforcement_notify_date" timestamp,
    "law_enforcement_notify_time" timestamp,
    "law_enforcement_police_report_no" varchar(255),
    "law_enforcement_first_nm" varchar(255),
    "law_enforcement_last_nm" varchar(255),
    "law_enforcement_phone" varchar(255),
    "create_user_id" varchar(50),
    "create_ts" timestamp,
    "update_user_id" varchar(50),
    "update_ts" timestamp,
    "delete_sw" char(1),
    PRIMARY KEY ("incident_id")
);

-- Model(s): Providerinfoconfig
CREATE TABLE IF NOT EXISTS "cjams"."providerinfoconfig" (
    "providerinfoconfigid" uuid DEFAULT gen_random_uuid(),
    "providerid" varchar(50),
    "program" varchar(255),
    "programtype" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    PRIMARY KEY ("providerinfoconfigid")
);

-- Model(s): Providerlicensesanctions
CREATE TABLE IF NOT EXISTS "cjams"."providerlicensesanctions" (
    "sanction_id" integer,
    "license_sanction_type" varchar(30),
    "license_no" varchar(25),
    "limitation_type" varchar(30),
    "limitation_min_age" integer,
    "limitation_max_age" integer,
    "limitation_gender" varchar(42),
    "limitation_reduced_youth_capacity" integer,
    "sanction_effective_dt" timestamp,
    "sanction_end_dt" timestamp,
    "site_id" integer,
    "provider_id" integer,
    "update_user_id" varchar(50),
    "update_ts" timestamp,
    "create_user_id" varchar(50),
    "create_ts" timestamp,
    "delete_sw" char(1),
    PRIMARY KEY ("sanction_id")
);

-- Model(s): Providermaltreatmenttype
CREATE TABLE IF NOT EXISTS "cjams"."providermaltreatmenttype" (
    "providermaltreatmenttypeid" uuid,
    "providermaltreatmenttypekey" varchar(15),
    "typedescription" varchar(255),
    "displayorder" integer,
    "activeflag" integer,
    "effectivedate" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("providermaltreatmenttypekey")
);

-- Model(s): Providernonagreementdetail
CREATE TABLE IF NOT EXISTS "cjams"."providernonagreementdetail" (
    "providernonagreementdetailid" uuid DEFAULT gen_random_uuid(),
    "agencyid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "specialtycd1" varchar(50),
    "speccd1stdt" timestamp,
    "speccd1endt" timestamp,
    "specialtycd2" varchar(50),
    "speccd2stdt" timestamp,
    "speccd2endt" timestamp,
    "specialtycd3" varchar(50),
    "speccd3stdt" timestamp,
    "speccd3endt" timestamp,
    "specialtycd4" varchar(50),
    "speccd4stdt" timestamp,
    "speccd4endt" timestamp,
    "specialtycd5" varchar(50),
    "speccd5stdt" timestamp,
    "speccd5endt" timestamp,
    "countycd" varchar(50),
    "licensenumber" varchar(50),
    "licensestate" varchar(50),
    "enrollstatus1" varchar(50),
    "enrollstdate1" timestamp,
    "enrollendate1" timestamp,
    "provacind" varchar(50),
    "provnpi" varchar(50),
    "expirationdate" timestamp,
    "effectivedate" timestamp,
    "timestamp" bytea,
    "providernonagreementtypekey" varchar(50),
    "npi2" varchar(50),
    "taxonomy1" varchar(50),
    "taxonomy2" varchar(50),
    "taxonomy3" varchar(50),
    "taxonomy4" varchar(50),
    "npi3" varchar(50),
    "npi4" varchar(50),
    "npi5" varchar(50),
    PRIMARY KEY ("providernonagreementdetailid")
);

-- Model(s): Providernonagreementmedicaiddetail
CREATE TABLE IF NOT EXISTS "cjams"."providernonagreementmedicaiddetail" (
    "providernonagreementmedicaiddetailid" uuid DEFAULT gen_random_uuid(),
    "agencyid" uuid,
    "medicaidtypekey" varchar(50),
    "activeflag" integer,
    "expirationdate" timestamp,
    "effectivedate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "value" varchar(50),
    PRIMARY KEY ("providernonagreementmedicaiddetailid")
);

-- Model(s): Providernonagreementtype
CREATE TABLE IF NOT EXISTS "cjams"."providernonagreementtype" (
    "sequencenumber" integer,
    "providernonagreementtypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("providernonagreementtypekey")
);

-- Model(s): Providerservice
CREATE TABLE IF NOT EXISTS "cjams"."providerservice" (
    "providerserviceid" uuid,
    "providerid" uuid,
    "programid" uuid,
    "serviceid" uuid,
    "effectivedate" timestamp,
    "expirydate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer
);

-- Model(s): Provideryouthinfo
CREATE TABLE IF NOT EXISTS "cjams"."provideryouthinfo" (
    "youth_id" integer,
    "object_id" varchar(50),
    "youth_first_name" varchar(50),
    "youth_last_name" varchar(50),
    "youth_dob" varchar(30),
    "youth_identifier_no" varchar(50),
    "youth_admitting_charge" varchar(100),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "delete_sw" varchar(1),
    "update_user_id" varchar(50),
    PRIMARY KEY ("youth_id")
);

-- Model(s): provprogramtype
CREATE TABLE IF NOT EXISTS "cjams"."provprogramtypename" (
    "programid" uuid DEFAULT gen_random_uuid(),
    "programtype" varchar(5),
    "programname" varchar(50),
    "providertype" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("programid")
);

-- Model(s): psychotropicmedications, psychotropicmedicationreport
CREATE TABLE IF NOT EXISTS "cjams"."psychotropicmedications" (
    "psychotropicid" uuid,
    "clientid" uuid,
    "casenumber" varchar(255),
    "medicationname" varchar(250),
    "classification" varchar(255),
    "dateprescribed" timestamp,
    "targetedsymptoms" varchar(20),
    "dosage" varchar(255),
    "frequency" varchar(255),
    "diagnosis" varchar(255),
    "prescribername" varchar(255),
    "prescribercontactinfo" varchar(255),
    "prescriberemail" varchar(255),
    "psychotropiccomments" varchar(255),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer
);

-- Model(s): Publicproviderhomeinfo
CREATE TABLE IF NOT EXISTS "cjams"."publicproviderhomeinfo" (
    "home_info_id" uuid DEFAULT gen_random_uuid(),
    "home_info_children_no" varchar(50),
    "home_info_bedroom_no" varchar(50),
    "is_home_water" boolean,
    "is_home_swimming_pool" boolean,
    "object_id" boolean,
    "home_is_other_agency" boolean,
    "home_info_pool_location" varchar(50),
    "home_info_agency_nm" varchar(50),
    "is_child_care_provider" boolean,
    "home_info_child_care_details" varchar(50),
    "home_phone" varchar(50),
    "interested_in" varchar(50),
    "explanatory_text" varchar(50),
    "is_previously_applied" boolean,
    "previous_state" varchar(50),
    "previous_source" varchar(50),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    "propertybuiltyear" varchar(50),
    "ownerorrenter" varchar(50),
    PRIMARY KEY ("home_info_id")
);

-- Model(s): Publicproviderhomeplacementspecification
CREATE TABLE IF NOT EXISTS "cjams"."publicproviderhomeplacementspecification" (
    "home_placement_specification_id" uuid DEFAULT gen_random_uuid(),
    "object_id" varchar(50),
    "gender" numeric,
    "min_age_yr" numeric,
    "max_age_yr" numeric,
    "min_age_months" numeric,
    "max_age_months" numeric,
    "capacity" numeric,
    "is_interested_respite" boolean,
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    PRIMARY KEY ("home_placement_specification_id")
);

-- Model(s): Publicproviderhomestudyhouseholdmapping
CREATE TABLE IF NOT EXISTS "cjams"."publicproviderhomestudyhouseholdmapping" (
    "mapping_id" uuid DEFAULT gen_random_uuid(),
    "home_study_visit_id" uuid,
    "household_member_id" varchar(255),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    "personid" uuid,
    PRIMARY KEY ("mapping_id")
);

-- Model(s): Publicproviderhomestudyvisit
CREATE TABLE IF NOT EXISTS "cjams"."publicproviderhomestudyvisit" (
    "home_study_visit_id" uuid DEFAULT gen_random_uuid(),
    "object_id" varchar(50),
    "interview_date" date,
    "interview_start_time" timestamp,
    "interview_end_time" timestamp,
    "duration" varchar(50),
    "interview_location" varchar(50),
    "islocationhome" boolean,
    "narrative" varchar(5000),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    PRIMARY KEY ("home_study_visit_id")
);

-- Model(s): Publicproviderhousehold
CREATE TABLE IF NOT EXISTS "cjams"."publicproviderhousehold" (
    "applicant_id" varchar(50),
    "checklist_task" varchar(50),
    "comment" varchar(500),
    "review_date" timestamp,
    "date_type" varchar(50),
    "status" varchar(50),
    "create_ts" varchar(50),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "personid" uuid,
    PRIMARY KEY ("applicant_id")
);

-- Model(s): Publicproviderhouseholdchecklist
CREATE TABLE IF NOT EXISTS "cjams"."publicproviderhouseholdchecklist" (
    "checklist_id" uuid,
    "checklist_task" varchar(50),
    "checklist_type" varchar(50),
    "date_type" varchar(50),
    "create_ts" varchar(50),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50)
);

-- Model(s): Publicproviderhouseholdmember
CREATE TABLE IF NOT EXISTS "cjams"."publicproviderhouseholdmember" (
    "household_member_id" integer,
    "applicant_id" varchar(50),
    "checklist_task" varchar(50),
    "comment" varchar(500),
    "review_date" timestamp,
    "date_type" varchar(50),
    "status" varchar(50),
    "create_ts" varchar(50),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "personid" uuid,
    PRIMARY KEY ("applicant_id")
);

-- Model(s): Publicproviderpetinfo
CREATE TABLE IF NOT EXISTS "cjams"."publicproviderpetinfo" (
    "provider_pet_id" uuid DEFAULT gen_random_uuid(),
    "object_id" varchar(50),
    "rabies_certificate_expiry_dt" date,
    "pet_type_tx" varchar(50),
    "pet_breed_tx" varchar(50),
    "pet_nm" varchar(50),
    "age_of_pet_tx" varchar(50),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    PRIMARY KEY ("provider_pet_id")
);

-- Model(s): Publicproviderreconsideration
CREATE TABLE IF NOT EXISTS "cjams"."publicproviderreconsideration" (
    "recon_id" integer,
    "object_id" varchar(50),
    "recon_number" varchar(50),
    "recon_type" varchar(50),
    "recon_date" date,
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    PRIMARY KEY ("recon_id")
);

-- Model(s): Publicproviderreferencecheck
CREATE TABLE IF NOT EXISTS "cjams"."publicproviderreferencecheck" (
    "reference_check_id" uuid DEFAULT gen_random_uuid(),
    "object_id" varchar(50),
    "reference_check_date" date,
    "is_relative" boolean,
    "is_school_recommends" boolean,
    "is_reference_recommends" boolean,
    "narrative" varchar(2500),
    "reference_first_nm" varchar(50),
    "reference_middle_nm" varchar(50),
    "reference_last_nm" varchar(50),
    "relationship_to_application" varchar(50),
    "type_of_contact" varchar(50),
    "household_member_id" json,
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    PRIMARY KEY ("reference_check_id")
);

-- Model(s): Publicproviderstatusmanagement
CREATE TABLE IF NOT EXISTS "cjams"."publicproviderstatusmanagement" (
    "provider_status_management_id" uuid DEFAULT gen_random_uuid(),
    "object_id" varchar(50),
    "narrative" varchar(5000),
    "provider_status" varchar(50),
    "dirty_status" boolean,
    "approval_status" varchar(50),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    PRIMARY KEY ("provider_status_management_id")
);

-- Model(s): Pubprovapphouseholdbgchecks
CREATE TABLE IF NOT EXISTS "cjams"."pubprovapphouseholdbgchecks" (
    "household_bg_id" integer,
    "household_member_id" integer,
    "submission_data" json,
    "criminal_history_check_data" json,
    "personid" uuid,
    "objectid" varchar(50),
    PRIMARY KEY ("household_bg_id")
);

-- Model(s): Quickperson
CREATE TABLE IF NOT EXISTS "cjams"."quickperson" (
    "quickpersonid" uuid DEFAULT gen_random_uuid(),
    "referralid" uuid,
    "caseid" uuid,
    "firstname" varchar(255),
    "middlename" varchar(255),
    "lastname" varchar(255),
    "legalclientid" integer,
    "expungementflag" integer,
    "gendertypekey" varchar(15),
    "substanceexposednewbornflag" integer,
    "substanceclasskey" integer,
    "datavalidflag" integer,
    "clientmergeid" uuid,
    "agencyname" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(255),
    "dob" timestamp,
    "ssn" numeric(5,2),
    "intakenumber" varchar(255),
    "objecttype" varchar(255),
    PRIMARY KEY ("quickpersonid")
);

-- Model(s): Quickpersonhistory
CREATE TABLE IF NOT EXISTS "cjams"."quickpersonhistory" (

);

-- Model(s): Quickpersonroleconfig
CREATE TABLE IF NOT EXISTS "cjams"."quickpersonroleconfig" (
    "quickpersonroleconfigid" uuid DEFAULT gen_random_uuid(),
    "quickpersonid" uuid,
    "actortypekey" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(255),
    PRIMARY KEY ("quickpersonroleconfigid")
);

-- Model(s): Quickpersonsubstconfig
CREATE TABLE IF NOT EXISTS "cjams"."quickpersonsubstconfig" (
    "quickpersonsubstconfigid" uuid DEFAULT gen_random_uuid(),
    "quickpersonid" uuid,
    "substanceclasskey" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(255),
    PRIMARY KEY ("quickpersonsubstconfigid")
);

-- Model(s): Racetype
CREATE TABLE IF NOT EXISTS "cjams"."racetype" (
    "sequencenumber" integer,
    "racetypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("racetypekey")
);

-- Model(s): Referencetype
CREATE TABLE IF NOT EXISTS "cjams"."referencetype" (
    "referencetypeid" integer,
    "typedescription" varchar(50),
    "tablename" varchar(150),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "activeflag" varchar(255),
    PRIMARY KEY ("referencetypeid")
);

-- Model(s): Referencevalues
CREATE TABLE IF NOT EXISTS "cjams"."referencevalues" (
    "ref_key" varchar(75),
    "referencetypeid" integer,
    "value_text" varchar(150),
    "description" varchar(1000),
    "teamtypekey" varchar(15),
    "activeflag" integer,
    "parentkey" varchar(15),
    "parenttypeid" integer,
    "displayorder" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "mdmcode" varchar(50)
);

-- Model(s): Refferalorgtype
CREATE TABLE IF NOT EXISTS "cjams"."referralorgtype" (
    "sequencenumber" integer,
    "referralorgtypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("referralorgtypekey")
);

-- Model(s): Refferedtotype
CREATE TABLE IF NOT EXISTS "cjams"."referredtotype" (
    "sequencenumber" integer,
    "referredtotypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "intakeservreqtypeid" uuid,
    "servicerequestsubtypeid" uuid,
    PRIMARY KEY ("referredtotypekey")
);

-- Model(s): Region
CREATE TABLE IF NOT EXISTS "cjams"."region" (
    "regionid" uuid DEFAULT gen_random_uuid(),
    "regionname" varchar(100),
    "oldregionid" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "timestamp" bytea,
    "activeflag" integer,
    PRIMARY KEY ("regionid")
);

-- Model(s): Relationshiptype
CREATE TABLE IF NOT EXISTS "cjams"."relationshiptype" (
    "sequencenumber" integer,
    "relationshiptypekey" varchar(50),
    "activeflag" integer,
    "description" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "expirationdate" timestamp,
    "effectivedate" timestamp,
    "timestamp" bytea,
    "personrelationship" boolean,
    PRIMARY KEY ("relationshiptypekey")
);

-- Model(s): Relationshiptypeagency
CREATE TABLE IF NOT EXISTS "cjams"."relationshiptypeagency" (
    "relationshiptypeagencyid" uuid DEFAULT gen_random_uuid(),
    "teamtypekey" varchar(50),
    "relationshiptypekey" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("relationshiptypeagencyid")
);

-- Model(s): Religionagencytypeconfig
CREATE TABLE IF NOT EXISTS "cjams"."religionagencytypeconfig" (
    "religionagencytypeconfigid" uuid DEFAULT gen_random_uuid(),
    "religiontypekey" varchar(15),
    "teamtypekey" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("religionagencytypeconfigid")
);

-- Model(s): Religiontype
CREATE TABLE IF NOT EXISTS "cjams"."religiontype" (
    "sequencenumber" integer,
    "religiontypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("religiontypekey")
);

-- Model(s): removalreasontype
CREATE TABLE IF NOT EXISTS "cjams"."removalreasontype" (
    "removalreasontypeid" varchar(255),
    "removalreasontypekey" varchar(15),
    "description" varchar(255),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    PRIMARY KEY ("removalreasontypeid")
);

-- Model(s): Repeatdaytype
CREATE TABLE IF NOT EXISTS "cjams"."repeatdaytype" (
    "repeatdaytypeid" uuid,
    "repeatdaytypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("repeatdaytypekey")
);

-- Model(s): Resource
CREATE TABLE IF NOT EXISTS "cjams"."resource" (
    "id" uuid DEFAULT gen_random_uuid(),
    "parentid" uuid,
    "resourcename" varchar(100),
    "parentkey" varchar(255),
    "modulekey" varchar(255),
    "resourceid" varchar(255),
    "resourcetype" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "tooltip" text,
    "description" text,
    PRIMARY KEY ("id")
);

-- Model(s): Resourcenarrative
CREATE TABLE IF NOT EXISTS "cjams"."resourcenarrative" (
    "resourceid" uuid DEFAULT gen_random_uuid(),
    "narrative" text,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("resourceid")
);

-- Model(s): Responsibilitytype
CREATE TABLE IF NOT EXISTS "cjams"."responsibilitytype" (
    "responsibilitytypekey" varchar(50),
    "activeflag" integer,
    "sequencenumber" integer,
    "typedescription" varchar(100),
    "old_id" varchar(50),
    "effectivedate" uuid,
    "expirationdate" varchar(256),
    "datavalue" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    PRIMARY KEY ("responsibilitytypekey")
);

-- Model(s): Restitutionpaymentflatfile
CREATE TABLE IF NOT EXISTS "cjams"."restitutionpaymentflatfile" (
    "restitutionpaymentflatfileid" uuid DEFAULT gen_random_uuid(),
    "filename" varchar(250),
    "pathname" text,
    "createddate" timestamp,
    "modifieddate" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("restitutionpaymentflatfileid")
);

-- Model(s): Restitutionpaymentflatfilecontent
CREATE TABLE IF NOT EXISTS "cjams"."restitutionpaymentflatfilecontent" (
    "restitutionpaymentflatfilecontentid" uuid DEFAULT gen_random_uuid(),
    "asofdate" timestamp,
    "lockboxno" varchar(300),
    "vakaccountnumber" timestamp,
    "firstname" varchar(50),
    "lastname" varchar(50),
    "addressline1" varchar(200),
    "addressline2" varchar(200),
    "city" varchar(50),
    "state" varchar(50),
    "zip" integer,
    "customernumber" varchar(300),
    "checkno" varchar(300),
    "checkamt" numeric(5,2),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("restitutionpaymentflatfilecontentid")
);

-- Model(s): Restitutionreport
CREATE TABLE IF NOT EXISTS "cjams"."restitutionreport" (

);

-- Model(s): Restricteditems
CREATE TABLE IF NOT EXISTS "cjams"."restricteditems" (
    "restricteditemsid" uuid DEFAULT gen_random_uuid(),
    "objecttypekey" varchar(50),
    "objectid" varchar(50),
    "activeflag" integer,
    "accessuserid" varchar(50),
    "description" text,
    "isadd" boolean,
    "isedit" boolean,
    "isdelete" boolean,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("restricteditemsid")
);

-- Model(s): Reverserelationship
CREATE TABLE IF NOT EXISTS "cjams"."reverserelationship" (
    "reverserelationshipid" uuid DEFAULT gen_random_uuid(),
    "relationshiptypekey" varchar(50),
    "relationgendercode" varchar(10),
    "malereverserelationshiptypekey" varchar(50),
    "femalereverserelationshiptypekey" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("reverserelationshipid")
);

-- Model(s): Reviewparticipants
CREATE TABLE IF NOT EXISTS "cjams"."reviewparticipants" (
    "reviewparticipantid" uuid DEFAULT gen_random_uuid(),
    "entitytypekey" varchar(50),
    "entitykeyid" uuid,
    "casereviewid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamptz,
    "updatedby" varchar(50),
    "updatedon" timestamptz,
    "activeflag" varchar(255),
    "datavalidflag" integer,
    "old_id" varchar(50),
    PRIMARY KEY ("reviewparticipantid")
);

-- Model(s): Reviewrecommendations
CREATE TABLE IF NOT EXISTS "cjams"."reviewrecommendations" (
    "reviewrecommendationid" uuid DEFAULT gen_random_uuid(),
    "casereviewid" uuid,
    "recommendation" varchar(5000),
    "goalcompletedate" timestamptz,
    "workerresponse" varchar(5000),
    "followup" varchar(5000),
    "followupdate" timestamptz,
    "insertedby" varchar(50),
    "insertedon" timestamptz,
    "updatedby" varchar(50),
    "updatedon" timestamptz,
    "activeflag" varchar(255),
    "recommendationstatustypekey" varchar(50),
    "old_id" varchar(50),
    PRIMARY KEY ("reviewrecommendationid")
);

-- Model(s): Reviewresulttemplate
CREATE TABLE IF NOT EXISTS "cjams"."reviewresulttemplate" (
    "reviewresulttemplateid" uuid DEFAULT gen_random_uuid(),
    "rulesetid" uuid,
    "requestedactionpath" text,
    "deficiency" boolean,
    "name" text,
    "reviewtypekey" varchar(15),
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    PRIMARY KEY ("reviewresulttemplateid")
);

-- Model(s): Role, approle, Environmentconfig
CREATE TABLE IF NOT EXISTS "cjams"."role" (
    "id" varchar(255),
    "name" varchar(255),
    "created" timestamp,
    "modified" timestamp,
    "description" varchar(50),
    "roletypekey" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "openamrole" varchar(255),
    "activeflag" integer,
    "env_variable_id" uuid
);

-- Model(s): Roleresource
CREATE TABLE IF NOT EXISTS "cjams"."role_resource" (
    "id" uuid DEFAULT gen_random_uuid(),
    "roleid" bigint,
    "resourceid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "isallowed" boolean,
    "isvisible" boolean,
    "isenabled" boolean,
    "permissiontype" numeric,
    PRIMARY KEY ("id")
);

-- Model(s): Rolemapping
CREATE TABLE IF NOT EXISTS "cjams"."rolemapping" (
    "id" integer,
    "principaltype" varchar(255),
    "principalid" varchar(255),
    "roleid" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "teamtypekey" varchar(15),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("id")
);

-- Model(s): Roletype
CREATE TABLE IF NOT EXISTS "cjams"."roletype" (
    "roletypeid" uuid DEFAULT gen_random_uuid(),
    "roletypecode" varchar(50),
    "roletypename" varchar(50),
    "shortname" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("roletypeid")
);

-- Model(s): Routing
CREATE TABLE IF NOT EXISTS "cjams"."routing" (
    "routingid" uuid DEFAULT gen_random_uuid(),
    "eventcode" varchar(10),
    "fromsecurityusersid" varchar(50),
    "tosecurityusersid" varchar(50),
    "teamid" uuid,
    "fromroleid" varchar(50),
    "toroleid" varchar(50),
    "objectid" uuid,
    "routingstatustypeid" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "isreviewrequest" boolean,
    "remarks" text,
    "old_id" varchar(50),
    "routeddescription" text,
    "servicerequestnumber" varchar(50),
    "actiondatetime" timestamp,
    PRIMARY KEY ("routingid")
);

-- Model(s): Rule
CREATE TABLE IF NOT EXISTS "cjams"."rule" (
    "ruleid" uuid DEFAULT gen_random_uuid(),
    "referenceid" varchar(50),
    "typeid" integer,
    "definition" text,
    "ruleinfo" json,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("ruleid")
);

-- Model(s): Safecareplan
CREATE TABLE IF NOT EXISTS "cjams"."safecareplan" (
    "safecareplanid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    PRIMARY KEY ("safecareplanid")
);

-- Model(s): Safetyplan
CREATE TABLE IF NOT EXISTS "cjams"."safetyplan" (
    "safetyplanid" uuid DEFAULT gen_random_uuid(),
    "intakeserviceid" uuid,
    "external_templateid" varchar(50),
    "assessmenttemplateid" uuid,
    "plandate" timestamp,
    "submissionid" varchar(250),
    "versionid" uuid,
    "savemode" integer,
    "status" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("safetyplanid")
);

-- Model(s): Safetyplanaction
CREATE TABLE IF NOT EXISTS "cjams"."safetyplanaction" (
    "safetyplanactionid" uuid DEFAULT gen_random_uuid(),
    "safetyplanid" uuid,
    "actiondescription" text,
    "dangerinfluencenumber" varchar(250),
    "dangerinfluencedesc" text,
    "completiondate" timestamp,
    "partiesname" varchar(250),
    "reevaluationdate" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("safetyplanactionid")
);

-- Model(s): Safetyplanactor
CREATE TABLE IF NOT EXISTS "cjams"."safetyplanactor" (
    "safetyplanactorid" uuid DEFAULT gen_random_uuid(),
    "safetyplanid" uuid,
    "intakeservicerequestactorid" uuid,
    "signimage" text,
    "activeflag" integer,
    "issignrefuse" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("safetyplanactorid")
);

-- Model(s): Saoresponse
CREATE TABLE IF NOT EXISTS "cjams"."saoresponse" (
    "saoresponseid" uuid DEFAULT gen_random_uuid(),
    "saoresponsedate" timestamp,
    "saoresponsestatustypekey" varchar(50),
    "saoresponseconditiontypekey" varchar(50),
    "intakenumber" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("saoresponseid")
);

-- Model(s): Saoresponseconditiontype
CREATE TABLE IF NOT EXISTS "cjams"."saoresponseconditiontype" (
    "saoresponseconditiontypeid" uuid,
    "saoresponseconditiontypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("saoresponseconditiontypekey")
);

-- Model(s): Saoresponsestatustype
CREATE TABLE IF NOT EXISTS "cjams"."saoresponsestatustype" (
    "saoresponsestatustypeid" uuid,
    "saoresponsestatustypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("saoresponsestatustypekey")
);

-- Model(s): School
CREATE TABLE IF NOT EXISTS "cjams"."school" (
    "schoolid" uuid DEFAULT gen_random_uuid(),
    "educationtypekey" varchar(15),
    "schoolcode" varchar(20),
    "schoolname" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "activeflag" integer,
    "address" varchar(100),
    "city" varchar(50),
    "statekey" varchar(50),
    "countyid" uuid,
    "zipcode" varchar(32),
    "phonenumber" varchar(32),
    PRIMARY KEY ("schoolid")
);

-- Model(s): Schoollistreference
CREATE TABLE IF NOT EXISTS "cjams"."schoollistreference" (
    "schoollistreferenceid" uuid,
    "schoolname" varchar(500),
    "address1" varchar(500),
    "address2" varchar(500),
    "city" varchar(500),
    "state" varchar(500),
    "zipcode" varchar(500),
    "county" varchar(500),
    "phoneno" varchar(500),
    "insertedby" varchar(50),
    "insertedon" timestamptz,
    "updatedby" varchar(50),
    "updatedon" timestamptz,
    "activeflag" integer
);

-- Model(s): Securityusers
CREATE TABLE IF NOT EXISTS "cjams"."securityusers" (
    "securityusersid" varchar(50),
    "username" varchar(50),
    "binaryvalue" bytea,
    "old_id" varchar(150),
    "lastactivitydate" timestamp,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("securityusersid")
);

-- Model(s): Service
CREATE TABLE IF NOT EXISTS "cjams"."service" (
    "serviceid" uuid DEFAULT gen_random_uuid(),
    "activeflag" text,
    "servicename" varchar(15),
    "description" uuid,
    "servicetypekey" uuid,
    "effectivedate" uuid,
    "expirationdate" varchar(256),
    "provideragreementtypekey" varchar(50),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    PRIMARY KEY ("serviceid")
);

-- Model(s): ServiceAgreement
CREATE TABLE IF NOT EXISTS "cjams"."serviceagreement" (
    "agreementid" uuid,
    "caseid" varchar(50),
    "agreementdate" timestamp,
    "signatureobtflag" integer,
    "activeflag" integer,
    "approvalstatustypekey" timestamp,
    "approvaldate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "staffid" uuid,
    "supervisorid" uuid,
    "associateid" uuid,
    "referralid" uuid,
    "old_id" varchar(50),
    "attentiontx" varchar(2000)
);

-- Model(s): ServiceAgreementList
CREATE TABLE IF NOT EXISTS "cjams"."serviceagreementlist" (
    "serviceagreementid" uuid,
    "agreementid" uuid,
    "personid" uuid,
    "signeddate" timestamp,
    "signagreementflag" integer,
    "collateralid" uuid,
    "staffid" uuid,
    "supervisorid" uuid,
    "associateid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp
);

-- Model(s): Servicecase
CREATE TABLE IF NOT EXISTS "cjams"."servicecase" (
    "servicecaseid" uuid DEFAULT gen_random_uuid(),
    "servicecasenumber" varchar(50),
    "caseheadid" uuid,
    "statustypekey" varchar(15),
    "caseheadname" varchar(100),
    "enddate" timestamp,
    "startdate" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    "dispositioncode" varchar(15),
    "effectivedate" timestamp,
    PRIMARY KEY ("servicecaseid")
);

-- Model(s): ServicecaseAffidavit
CREATE TABLE IF NOT EXISTS "cjams"."servicecaseaffidavit" (
    "servicecasedispositionid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("servicecasedispositionid")
);

-- Model(s): Servicecasedisposition
CREATE TABLE IF NOT EXISTS "cjams"."servicecasedisposition" (
    "servicecasedispositionid" uuid DEFAULT gen_random_uuid(),
    "servicecaseid" uuid,
    "statusdate" timestamp,
    "intakeserreqstatustypekey" varchar(15),
    "dispositioncode" varchar(15),
    "comments" text,
    "effectivedate" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "reopenreasonkey" varchar(10),
    PRIMARY KEY ("servicecasedispositionid")
);

-- Model(s): Servicecaserequest
CREATE TABLE IF NOT EXISTS "cjams"."servicecaserequest" (
    "servicecaserequestid" uuid DEFAULT gen_random_uuid(),
    "servicecaseid" uuid,
    "intakeservicerequesttypeid" uuid,
    "servicerequestsubtypeid" uuid,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("servicecaserequestid")
);

-- Model(s): Servicedictionary
CREATE TABLE IF NOT EXISTS "cjams"."servicedictionary" (

);

-- Model(s): Serviceintendedaction
CREATE TABLE IF NOT EXISTS "cjams"."serviceintendedaction" (
    "serviceintendedactionid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("serviceintendedactionid")
);

-- Model(s): Serviceplan
CREATE TABLE IF NOT EXISTS "cjams"."serviceplan" (
    "serviceplanid" uuid DEFAULT gen_random_uuid(),
    "objecttypekey" varchar(50),
    "objectid" varchar(50),
    "serviceplanstatustypekey" varchar(50),
    "approvalstatustypekey" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "targetenddate" timestamp,
    "approvaldate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "numberofdays" integer,
    "enddate" timestamp,
    "serviceplanname" varchar(100),
    "status" varchar(100),
    "serviceplanvisitation" json,
    "serviceplancandidacy" json,
    "serviceplansignatures" json,
    "involvedpersons" json,
    PRIMARY KEY ("serviceplanid")
);

-- Model(s): Serviceplanaction
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanaction" (
    "serviceplanactionid" uuid,
    "splanobjectiveid" uuid,
    "serviceplanactionname" varchar(500),
    "personresponsible" varchar(50),
    "startdate" timestamp,
    "enddate" timestamp,
    "status" varchar(50),
    "approvalstatustypekey" varchar(150),
    "serviceplanoutcome" varchar(100),
    "goalreason" varchar(100),
    "comments" varchar(255),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "autoflag" integer,
    "plantype" varchar(50),
    "planfor" varchar(50)
);

-- Model(s): Serviceplanactivity
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanactivity" (
    "serviceplanactivityid" uuid DEFAULT gen_random_uuid(),
    "objecttypekey" varchar(50),
    "objectid" varchar(50),
    "activity" varchar(100),
    "servicetypekey" varchar(50),
    "servicesubtypekey" varchar(50),
    "personinvolved" varchar(100),
    "responsibleperson" varchar(100),
    "reevaluationdate" timestamp,
    "completiondate" timestamp,
    "serviceplangoalid" uuid,
    "serviceplanactivitystatustypekey" varchar(50),
    "activitysubtypekey" varchar(50),
    "need" varchar(250),
    "otherservicetypedescription" varchar(100),
    "othersubtypedescription" varchar(100),
    "reasontypekey" varchar(15),
    "otherreason" varchar(100),
    "serviceunavailable" varchar(15),
    "initialcondition" varchar(100),
    "personsinvolvedid" uuid,
    "responsiblepersonid" varchar(50),
    "plannedstartdate" timestamp,
    "plannedenddate" timestamp,
    "progressnote" varchar(150),
    "responsiblepersontype" varchar(15),
    "otherresponsibleperson" varchar(100),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("serviceplanactivityid")
);

-- Model(s): Serviceplanactivitystatustype
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanactivitystatustype" (
    "serviceplanactivitystatustypeid" uuid,
    "serviceplanactivitystatustypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("serviceplanactivitystatustypekey")
);

-- Model(s): Serviceplanchild
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanchild" (
    "serviceplanchildid" uuid,
    "serviceplancaseid" uuid,
    "serviceplanname" varchar(100),
    "startdate" timestamp,
    "enddate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "numberofdays" integer
);

-- Model(s): Serviceplanfocus
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanfocus" (
    "serviceplanfocusid" uuid,
    "serviceplanid" uuid,
    "insertedby" varchar(50),
    "focusname" varchar(100),
    "approvalstatustypekey" varchar(150),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer
);

-- Model(s): Serviceplangoal
CREATE TABLE IF NOT EXISTS "cjams"."serviceplangoal" (
    "serviceplangoalid" uuid DEFAULT gen_random_uuid(),
    "objecttypekey" varchar(50),
    "objectid" varchar(50),
    "goaldate" timestamp,
    "goal" varchar(100),
    "strategy" varchar(250),
    "goaltypekey" varchar(50),
    "isprojecthome" boolean,
    "initialcondition" varchar(100),
    "goalscategorytype" varchar(15),
    "plannedstartdate" timestamp,
    "plannedenddate" timestamp,
    "challenges" varchar(250),
    "strengths" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("serviceplangoalid")
);

-- Model(s): Serviceplanlog
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanlog" (
    "serviceplanlogid" uuid DEFAULT gen_random_uuid(),
    "serviceplanactivityid" uuid,
    "objecttypekey" varchar(50),
    "objectid" varchar(50),
    "providerid" uuid,
    "providercontracttypekey" varchar(50),
    "providercontractrateid" uuid,
    "startdate" timestamp,
    "enddate" timestamp,
    "isrepeats" integer,
    "noofoccurence" integer,
    "rate" numeric,
    "reason" text,
    "serviceplanlogstatustypekey" varchar(50),
    "providertypekey" varchar(50),
    "familyworkername" varchar(100),
    "noofhours" integer,
    "noofweeks" integer,
    "servicecategorytypekey" varchar(50),
    "categorysubtypekey" varchar(15),
    "serviceplanvendorid" uuid,
    "careworkername" varchar(100),
    "countyid" uuid,
    "securityusersid" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("serviceplanlogid")
);

-- Model(s): Serviceplanlogoccurence
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanlogoccurence" (
    "serviceplanlogoccurenceid" uuid DEFAULT gen_random_uuid(),
    "serviceplanlogid" uuid,
    "starttime" timestamp,
    "endtime" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("serviceplanlogoccurenceid")
);

-- Model(s): Serviceplanlogrepeat
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanlogrepeat" (
    "serviceplanlogrepeatid" uuid DEFAULT gen_random_uuid(),
    "serviceplanlogid" uuid,
    "repeatdaytypekey" varchar(15),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("serviceplanlogrepeatid")
);

-- Model(s): Serviceplanlogscheduleexemption
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanlogscheduleexemption" (
    "serviceplanlogscheduleexemptionid" uuid DEFAULT gen_random_uuid(),
    "serviceplanlogid" uuid,
    "exemptiondate" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(255),
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("serviceplanlogscheduleexemptionid")
);

-- Model(s): Serviceplanneed
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanneed" (
    "serviceplanneedid" uuid DEFAULT gen_random_uuid(),
    "serviceplanfocusid" uuid,
    "serviceplanneedname" varchar(50),
    "serviceplanneedvalue" numeric(32,0),
    "intakeserviceid" uuid,
    "servicecaseid" uuid,
    "assessmentid" uuid,
    "assessmenttype" varchar(50),
    "serviceplanneedsection" varchar(150),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("serviceplanneedid")
);

-- Model(s): Serviceplanoutcome
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanoutcome" (
    "serviceplanoutcomeid" uuid,
    "serviceplanactionid" uuid,
    "serviceplanoutcomename" varchar(500),
    "actualserviceplanoutcomename" varchar(500),
    "insertedby" uuid,
    "insertedon" timestamp,
    "updatedby" uuid,
    "updatedon" timestamp,
    "activeflag" integer
);

-- Model(s): Serviceplanpersoninvolved
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanpersoninvolved" (
    "serviceplanpersoninvolvedid" uuid,
    "serviceplanactionid" uuid,
    "personinvolved" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer
);

-- Model(s): Serviceplanrepeat
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanrepeat" (
    "serviceplanrepeatid" uuid DEFAULT gen_random_uuid(),
    "serviceplanid" uuid,
    "repeatdaytypekey" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("serviceplanrepeatid")
);

-- Model(s): Serviceplanscheduleexemption
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanscheduleexemption" (
    "serviceplanscheduleexemptionid" uuid DEFAULT gen_random_uuid(),
    "serviceplanid" uuid,
    "exemptiondate" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("serviceplanscheduleexemptionid")
);

-- Model(s): Serviceplanstatustype
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanstatustype" (
    "serviceplanstatustypeid" uuid,
    "serviceplanstatustypekey" varchar(50),
    "description" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("serviceplanstatustypekey")
);

-- Model(s): Serviceplanstrength
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanstrength" (
    "serviceplanstrengthid" uuid,
    "serviceplanfocusid" uuid,
    "serviceplanstrengthname" varchar(50),
    "intakeserviceid" uuid,
    "servicecaseid" uuid,
    "assessmentid" uuid,
    "assessmenttype" varchar(50),
    "serviceplanstrengthsection" varchar(150),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer
);

-- Model(s): Serviceplanvendor
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanvendor" (
    "serviceplanvendorid" uuid DEFAULT gen_random_uuid(),
    "vendorname" varchar(100),
    "rank" integer,
    "bponumber" varchar(50),
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "updatedby" varchar(50),
    "activeflag" integer,
    "old_id" varchar(50),
    PRIMARY KEY ("serviceplanvendorid")
);

-- Model(s): Serviceplanvendorsubtypeconfig
CREATE TABLE IF NOT EXISTS "cjams"."serviceplanvendorsubtypeconfig" (
    "serviceplanvendorsubtypeconfigid" uuid DEFAULT gen_random_uuid(),
    "vendorsubtypekey" varchar(100),
    "rate" numeric(5,2),
    "serviceplanvendorid" uuid,
    "countyid" uuid,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "updatedby" varchar(50),
    "activeflag" integer,
    "old_id" varchar(50),
    PRIMARY KEY ("serviceplanvendorsubtypeconfigid")
);

-- Model(s): Servicerequestappointment
CREATE TABLE IF NOT EXISTS "cjams"."servicerequestappointment" (
    "servreqaptmtid" uuid,
    "intakeserviceid" uuid,
    "title" varchar(100),
    "appointmentstatus" varchar(50),
    "notes" text,
    "appointmentdate" timestamp,
    "appointmentid" varchar(50),
    "appointmentworkerid" uuid,
    "appointmentworkertype" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "appointmenttitletypekey" varchar(50)
);

-- Model(s): Servicerequestappointmentactor
CREATE TABLE IF NOT EXISTS "cjams"."servicerequestappointmentactor" (
    "servreqappointmentactorid" uuid DEFAULT gen_random_uuid(),
    "servreqaptmtid" uuid,
    "intakeservicerequestactorid" uuid,
    "isoptional" boolean,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("servreqappointmentactorid")
);

-- Model(s): Servicerequestincidenttype
CREATE TABLE IF NOT EXISTS "cjams"."servicerequestincidenttype" (
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "sequencenumber" integer,
    "servicerequestincidenttypekey" varchar(15),
    "timestamp" bytea,
    "typedescription" varchar(250),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("servicerequestincidenttypekey")
);

-- Model(s): Servicerequestsubtype
CREATE TABLE IF NOT EXISTS "cjams"."servicerequestsubtype" (
    "servicerequestsubtypeid" uuid DEFAULT gen_random_uuid(),
    "intakeservreqtypeid" uuid,
    "classkey" varchar(50),
    "description" varchar(250),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "workloadweight" integer,
    "investigatable" boolean,
    "isvisible" boolean,
    "activeflag" integer,
    PRIMARY KEY ("servicerequestsubtypeid")
);

-- Model(s): Servicerequesttypeconfig
CREATE TABLE IF NOT EXISTS "cjams"."servicerequesttypeconfig" (
    "servicerequesttypeconfigid" uuid DEFAULT gen_random_uuid(),
    "intakeservreqtypeid" uuid,
    "servicerequestsubtypeid" uuid,
    "activeflag" integer,
    "intakeservicerequestplantypekey" varchar(50),
    "workload" integer,
    "internalfile" boolean,
    "duedateoffset" integer,
    "limitedrouting" boolean,
    "intakeserreqstatustypeid" uuid,
    "focusroletype" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "category" varchar(50),
    "displaydatype" varchar(100),
    "displaydasubtype" varchar(100),
    "focusentitytype" varchar(50),
    "isreviewrequired" boolean,
    PRIMARY KEY ("servicerequesttypeconfigid")
);

-- Model(s): Servicerequesttypeconfigalert
CREATE TABLE IF NOT EXISTS "cjams"."servicerequesttypeconfigalert" (
    "servicerequesttypeconfigalertid" uuid DEFAULT gen_random_uuid(),
    "servicerequesttypeconfigid" uuid,
    "alerttimetype" varchar(20),
    "alerttimeinterval" integer,
    "teamtypekey" varchar(50),
    "alerteventkey" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("servicerequesttypeconfigalertid")
);

-- Model(s): Servicerequesttypeconfigdispositioncode
CREATE TABLE IF NOT EXISTS "cjams"."servicerequesttypeconfigdispositioncode" (
    "servicerequesttypeconfigiddispostionid" uuid DEFAULT gen_random_uuid(),
    "servicerequesttypeconfigid" uuid,
    "dispositioncode" varchar(15),
    "description" text,
    "intakeserreqstatustypeid" uuid,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "recommendationtype" varchar(10),
    PRIMARY KEY ("servicerequesttypeconfigiddispostionid")
);

-- Model(s): Servicerequesttypeconfigrole
CREATE TABLE IF NOT EXISTS "cjams"."servicerequesttypeconfigrole" (
    "servicerequesttypeconfigroleid" uuid DEFAULT gen_random_uuid(),
    "servicerequesttypeconfigid" uuid,
    "entityroletype" varchar(50),
    "entityroletypekey" varchar(50),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "isdefault" boolean,
    PRIMARY KEY ("servicerequesttypeconfigroleid")
);

-- Model(s): Servicesubtype
CREATE TABLE IF NOT EXISTS "cjams"."servicesubtype" (
    "servicesubtypeid" uuid,
    "servicesubtypekey" varchar(50),
    "serviceid" varchar(255),
    "activeflag" integer,
    "servicesubtypedescription" varchar(100),
    "effectivedate" uuid,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    PRIMARY KEY ("servicesubtypekey")
);

-- Model(s): Servicetype
CREATE TABLE IF NOT EXISTS "cjams"."servicetype" (
    "servicetypekey" varchar(50),
    "teamtypekey" varchar(50),
    "placementtypekey" varchar(30),
    "activeflag" integer,
    "sequencenumber" integer,
    "servicetypedescription" varchar(100),
    "shortname" varchar(50),
    "sortseq" char(1),
    "old_id" varchar(50),
    "effectivedate" uuid,
    "expirationdate" varchar(256),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "timestamp" bytea
);

-- Model(s): Settings
CREATE TABLE IF NOT EXISTS "cjams"."settings" (
    "settingname" varchar(255),
    "settingvalue" varchar(255),
    "activeflag" boolean,
    "insertedby" varchar(255),
    "updatedby" varchar(255),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "old_id" varchar(255),
    PRIMARY KEY ("settingname")
);

-- Model(s): Snapshothist
CREATE TABLE IF NOT EXISTS "cjams"."snapshothist" (
    "id" uuid,
    "objectid" varchar(50),
    "objecttype" varchar(30),
    "activeflag" integer,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "requesteddate" timestamp,
    "approvaldate" timestamp,
    "approvedby" varchar(50),
    "requestedby" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "snapshotdata" json,
    "approvalstatus" varchar(50),
    "versionupdatedby" varchar(50),
    "signatures" json,
    "fromdate" date,
    "todate" date,
    "personid" uuid,
    "comments" varchar(2500)
);

-- Model(s): Socialhistory
CREATE TABLE IF NOT EXISTS "cjams"."socialhistory" (
    "socialhistoryid" uuid,
    "personid_fk" uuid,
    "incomesourcecode" varchar(5),
    "maritalstatuscode" varchar(6),
    "siblingsnumb" numeric(17,17),
    "personsnumb" numeric(17,17),
    "familyincomeamnt" numeric(17,17),
    "iveeligibilityindc" varchar(1),
    "placementamnt" numeric(17,17),
    "notetext" varchar(255),
    "birthplacetext" varchar(100),
    "placement" varchar(255),
    "familyhistory" varchar(255),
    "childdesc" varchar(255),
    "familyproblemindc" varchar(1),
    "ungovernableindc" varchar(1),
    "truancyindc" varchar(1),
    "runawayindc" varchar(1),
    "stealingindc" varchar(1),
    "assaultiveindc" varchar(1),
    "mentalhealthindc" varchar(1),
    "residentialindc" varchar(1),
    "outpatientindc" varchar(1),
    "createdate" timestamp,
    "updatedate" timestamp,
    "createworkeridno" numeric(17,17),
    "updateworkeridno" numeric(17,17),
    "old_id" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp
);

-- Model(s): Splangoal
CREATE TABLE IF NOT EXISTS "cjams"."splangoal" (
    "splangoalid" uuid,
    "serviceplanid" uuid,
    "insertedby" varchar(50),
    "goalname" varchar(500),
    "approvalstatustypekey" varchar(150),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "autoflag" integer,
    "status" varchar(50)
);

-- Model(s): Splanobjective
CREATE TABLE IF NOT EXISTS "cjams"."splanobjective" (
    "splanobjectiveid" uuid,
    "splangoalid" uuid,
    "serviceplanid" uuid,
    "insertedby" varchar(50),
    "objectivename" varchar(500),
    "needs" jsonb,
    "strengths" jsonb,
    "approvalstatustypekey" varchar(150),
    "comments" varchar(255),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "autoflag" integer,
    "status" varchar(50)
);

-- Model(s): Sstastatustype
CREATE TABLE IF NOT EXISTS "cjams"."sstastatustype" (
    "sstastatustypeid" uuid,
    "sstastatustypekey" varchar(15),
    "description" varchar(100),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirydate" timestamp,
    PRIMARY KEY ("sstastatustypekey")
);

-- Model(s): State
CREATE TABLE IF NOT EXISTS "cjams"."state" (
    "stateid" integer,
    "statename" varchar(50),
    "stateabbr" varchar(8),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("stateid")
);

-- Model(s): Statementofdeficiency
CREATE TABLE IF NOT EXISTS "cjams"."statementofdeficiency" (
    "statementofdeficiencyid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "statementofdeficiencystatustypekey" varchar(15),
    "intakeserviceid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "timestamp" bytea,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "entrancedate" timestamp,
    "exitdate" timestamp,
    "parentid" uuid,
    "agencyid" uuid,
    "provideragreementid" uuid,
    "ssbg" varchar(20),
    PRIMARY KEY ("statementofdeficiencyid")
);

-- Model(s): Stateoffice
CREATE TABLE IF NOT EXISTS "cjams"."stateoffice" (
    "stateofficeid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "phonenumber" varchar(32),
    "address" varchar(255),
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "effectivedate" timestamp,
    "state" varchar(50),
    "zipcode" integer,
    "city" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "countycode" varchar(10),
    PRIMARY KEY ("stateofficeid")
);

-- Model(s): Statestatutes
CREATE TABLE IF NOT EXISTS "cjams"."statestatutes" (
    "activeflag" integer,
    "description" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "inputregulationstatestatue" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "librarytype" varchar(256),
    "possiblereferral" varchar(50),
    "possiblereferralflag" boolean,
    "possiblesanction" boolean,
    "possiblesanctionflag" boolean,
    "reasontobelieve" text,
    "statestatutesid" uuid DEFAULT gen_random_uuid(),
    "statestatuteskey" varchar(50),
    "statestatutetext" text,
    "suspected" text,
    "timestamp" bytea,
    "unsubstantiated" text,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("statestatutesid")
);

-- Model(s): Submissioncollection
CREATE TABLE IF NOT EXISTS "cjams"."submissioncollection" (
    "submissioncollectionid" uuid DEFAULT gen_random_uuid(),
    "assessmentsubmissionid" uuid,
    "dataindex" integer,
    "datakey" varchar(250),
    "datavalue" varchar(250),
    "datatype" varchar(50),
    "isprimitive" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("submissioncollectionid")
);

-- Model(s): Supervisorreport
CREATE TABLE IF NOT EXISTS "cjams"."supervisorreport" (

);

-- Model(s): Suspensionreasontype
CREATE TABLE IF NOT EXISTS "cjams"."suspensionreasontype" (
    "sequencenumber" integer,
    "suspensionreasontypekey" varchar(50),
    "datavalue" integer,
    "typedescription" varchar(250),
    "activeflag" integer,
    "old_id" varchar(50),
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("suspensionreasontypekey")
);

-- Model(s): Taskcommunicationtype
CREATE TABLE IF NOT EXISTS "cjams"."taskcommunicationtype" (
    "taskcommunicationtypeid" varchar(255),
    "taskcommunicationtypekey" varchar(50),
    "activeflag" integer,
    "description" varchar(250),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("taskcommunicationtypekey")
);

-- Model(s): Tb_account_fast_entry
CREATE TABLE IF NOT EXISTS "cjams"."tb_account_fast_entry" (
    "fast_entry_id" integer,
    "client_account_id" integer,
    "transaction_type_sw" char(1),
    "transaction_source_cd" varchar(5),
    "benefit_start_dt" date,
    "benefit_end_dt" date,
    "transaction_amount_no" numeric(10,2),
    "transaction_dt" date,
    "credit_debit_sw" char(1),
    "notes_tx" varchar(500),
    "post_sw" char(1),
    "post_dt" date,
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "transaction_id" integer,
    PRIMARY KEY ("fast_entry_id")
);

-- Model(s): Tb_account_transaction
CREATE TABLE IF NOT EXISTS "cjams"."tb_account_transaction" (
    "transaction_id" integer,
    "client_account_id" integer,
    "transaction_type_cd" varchar(5),
    "transaction_source_cd" varchar(5),
    "benefit_start_dt" date,
    "benefit_end_dt" date,
    "transaction_amount_no" numeric(10,2),
    "transaction_dt" date,
    "credit_debit_sw" char(1),
    "notes_tx" varchar(500),
    "frequency_cd" varchar(5),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "adjustment_approval_status_cd" varchar(5),
    "manual_db_approval_status_cd" varchar(5),
    "reference_transaction_id" integer,
    "post_sw" char(1),
    "payment_detail_id" integer,
    "authorization_id" integer,
    "late_entry_sw" char(1),
    PRIMARY KEY ("transaction_id")
);

-- Model(s): TbAfsInterfaces
CREATE TABLE IF NOT EXISTS "cjams"."tb_afs_interfaces" (
    "afs_interface_record_id" integer,
    "ldss_nm" varchar(2),
    "payment_method_cd" varchar(1),
    "payment_id" varchar(10),
    "payee_nbr" varchar(10),
    "payee_nm" varchar(40),
    "payee_alpha_sort_nm" varchar(40),
    "adr_line_1" varchar(40),
    "adr_line_2" varchar(40),
    "adr_city_nm" varchar(30),
    "adr_state_cd" varchar(2),
    "adr_zip5_no" varchar(10),
    "phone_tx" varchar(10),
    "taxpayer_type_cd" varchar(1),
    "taxpayer_id" varchar(9),
    "budget_cd" varchar(5),
    "ind_1099_sw" varchar(1),
    "type_1099_sw" varchar(1),
    "invoice_nbr_tx" varchar(20),
    "payment_amt" numeric(11,2),
    "payment_approval_dt" date,
    "payment_service_dt" date,
    "client_name" varchar(40),
    "create_ts" timestamp,
    "create_user_id" varchar(10),
    "update_ts" timestamp,
    "update_user_id" varchar(10),
    "delete_sw" varchar(1),
    "payment_type_cd" varchar(5),
    "payment_detail_id" integer,
    PRIMARY KEY ("afs_interface_record_id")
);

-- Model(s): TbAgencyProgramArea
CREATE TABLE IF NOT EXISTS "cjams"."tb_agency_program_area" (
    "agency_program_area_id" integer,
    "agency_program_nm" varchar(50),
    "active_sw" char(1),
    "start_dt" date,
    "end_dt" date,
    "create_ts" timestamp,
    "create_user_id" varchar(10),
    "update_ts" timestamp,
    "update_user_id" varchar(10),
    "delete_sw" char(1),
    PRIMARY KEY ("agency_program_area_id")
);

-- Model(s): Tb_child_account_disbursement
CREATE TABLE IF NOT EXISTS "cjams"."tb_child_account_disbursement" (
    "disbursement_id" integer,
    "client_account_id" integer,
    "disbursement_dt" date,
    "client_id" integer,
    "service_id" integer,
    "amount" numeric(10,2),
    "payment_id" integer,
    "funding_approval_status" varchar(5),
    "payment_approval_status" varchar(5),
    "payee_nm" varchar(50),
    "adr_type_cd" varchar(20),
    "adr_format_cd" varchar(20),
    "adr_pre_dir_cd" varchar(20),
    "adr_street_no" varchar(20),
    "adr_box_no" integer,
    "adr_street_nm" varchar(20),
    "adr_street_suffix_cd" varchar(20),
    "adr_state_cd" varchar(20),
    "adr_county_cd" varchar(20),
    "adr_city_nm" varchar(20),
    "adr_unit_no_tx" varchar(20),
    "adr_unit_type_cd" varchar(20),
    "adr_post_dir_cd" varchar(20),
    "adr_zip5_no" numeric(10,2),
    "adr_zip4_no" numeric(10,2),
    "adr_postal_code_tx" varchar(20),
    "adr_country_tx" varchar(20),
    "adr_foreign_state_tx" varchar(20),
    "adr_foreign_tx" varchar(20),
    "adr_direction_tx" varchar(20),
    "sprvsr_approval_status_cd" varchar(5),
    "ads_approval_status_cd" varchar(5),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "tax_id_no" varchar(20),
    "tax_type_cd" char(1),
    "adr_street_tx" char(1),
    "data_valid_sw" char(1),
    "client_acc_sw" char(1),
    PRIMARY KEY ("disbursement_id")
);

-- Model(s): Tb_client_account
CREATE TABLE IF NOT EXISTS "cjams"."tb_client_account" (
    "client_account_id" integer,
    "client_id" integer,
    "account_type_cd" varchar(5),
    "account_exists_sw" char(1),
    "bank_nm" varchar(50),
    "account_no_tx" varchar(20),
    "total_balance_no" numeric(10,2),
    "available_balance_no" numeric(10,2),
    "open_dt" date,
    "close_dt" date,
    "status_cd" varchar(5),
    "county_cd" varchar(5),
    "create_ts" timestamp,
    "create_user_id" varchar(50),
    "update_ts" timestamp,
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "bank_info_approval_status_cd" varchar(5),
    "comm_account_id" integer,
    "case_id" integer,
    "data_valid_sw" char(1),
    "client_merge_id" integer,
    "obligated_for_anc" numeric(10,2),
    "obligated_for_coc" numeric(10,2),
    PRIMARY KEY ("client_account_id")
);

-- Model(s): Tb_comm_acct_transactions
CREATE TABLE IF NOT EXISTS "cjams"."tb_comm_acct_transactions" (
    "comm_acct_trans_id" integer,
    "interest_start_dt" date,
    "interest_end_dt" date,
    "interest_amount_no" numeric(50,2),
    "mod_interest_amount_no" numeric(50,2),
    "notes_tx" varchar(500),
    "comm_account_id" integer,
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    PRIMARY KEY ("comm_acct_trans_id")
);

-- Model(s): Tb_commingled_account
CREATE TABLE IF NOT EXISTS "cjams"."tb_commingled_account" (
    "bank_nm" varchar(50),
    "account_no" varchar(20),
    "total_balance_no" numeric(10,2),
    "open_dt" date,
    "close_dt" date,
    "county_cd" varchar(5),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "approval_status_cd" varchar(5),
    "comm_account_id" integer
);

-- Model(s): fiscalCode, Tb_fiscal_category_master
CREATE TABLE IF NOT EXISTS "cjams"."tb_fiscal_category_master" (
    "fiscal_category_id" integer,
    "fiscal_category_cd" varchar(255),
    "fiscal_category_desc" varchar(100),
    "eligibility_cd" varchar(5),
    "ancillary_maintenance_sw" char(1),
    "payment_type_cd" varchar(5),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "start_dt" date,
    "end_dt" date,
    PRIMARY KEY ("fiscal_category_id")
);

-- Model(s): TbFmisPaymentDetailInterface
CREATE TABLE IF NOT EXISTS "cjams"."tb_fmis_payment_detail_interface" (
    "fmis_payment_detail_record_id" integer,
    "batch_agency_cd" varchar(3),
    "batch_dt" timestamp,
    "batch_type_cd" varchar(1),
    "batch_no" varchar(3),
    "batch_sequence_no" varchar(5),
    "user_operator_id" varchar(8),
    "tid" varchar(4),
    "effective_dt" timestamp,
    "appropriation_year" integer,
    "disbursement_method_ind" varchar(1),
    "capitalize_ind" varchar(1),
    "transaction_cd" varchar(3),
    "modifier_ind" varchar(1),
    "reverse_ind" varchar(1),
    "finance_agency_cd" varchar(3),
    "rti_cd" varchar(6),
    "index_cd" varchar(5),
    "appropriation_no" varchar(5),
    "fund_cd" varchar(4),
    "pca_cd" varchar(5),
    "comptroller_object_cd" varchar(4),
    "agency_object_cd" varchar(4),
    "project_no" varchar(6),
    "project_phase_cd" varchar(2),
    "grant_no" varchar(6),
    "grant_phase_cd" varchar(2),
    "sub_grantee_cd" varchar(14),
    "agency_1_cd" varchar(4),
    "agency_2_cd" varchar(4),
    "agency_3_cd" varchar(4),
    "agency_gl_acc_no" varchar(8),
    "multi_purpose_cd" varchar(10),
    "gl_acc_no" varchar(4),
    "vendor_tax_type_cd" varchar(10),
    "vendor_mail_code_tx" varchar(3),
    "irs_1099_sw" varchar(1),
    "invoice_nbr" varchar(15),
    "invoice_dt" timestamp,
    "document_dt" timestamp,
    "current_document_nbr_cd" varchar(8),
    "current_document_nbr_suffix" varchar(3),
    "reference_document_nbr" varchar(8),
    "reference_document_nbr_suffix" varchar(3),
    "due_dt" timestamp,
    "service_dt" timestamp,
    "warrant_no" varchar(9),
    "payment_dis_type_cd" varchar(2),
    "property_no" varchar(10),
    "debt_invesment_issue_no" varchar(9),
    "fund_control_override_cd" varchar(1),
    "contract_nbr" varchar(10),
    "transaction_amt" varchar(50),
    "discount_amt" varchar(13),
    "invoice_description_tx" varchar(30),
    "cash_receipt_payment_type_cd" varchar(1),
    "bank_no" varchar(13),
    "discount_dt" timestamp,
    "discount_terms_cd" varchar(2),
    "penalty_dt" timestamp,
    "penalty_terms_cd" varchar(2),
    "interest_terms_cd" varchar(5),
    "penalty_amt" varchar(13),
    "vendor_nm" varchar(50),
    "adr_line_1" varchar(50),
    "adr_line_2" varchar(50),
    "adr_line_3" varchar(50),
    "adr_line_4" varchar(50),
    "adr_city_nm" varchar(20),
    "adr_state_cd" varchar(2),
    "adr_zip5_no" varchar(5),
    "adr_zip4_no" varchar(4),
    "document_agency_cd" varchar(3),
    "original_vendor_no" varchar(10),
    "original_vendor_nbr_mail_cd" varchar(3),
    "filler_4_tx" varchar(69),
    "document_year" integer,
    "payment_type_sw" char(1),
    "create_user_id" varchar(10),
    "create_ts" timestamp,
    "update_user_id" varchar(10),
    "update_ts" timestamp,
    "delete_sw" char(1),
    "payment_type_cd" varchar(4),
    PRIMARY KEY ("fmis_payment_detail_record_id")
);

-- Model(s): TbFmisPaymentHeaderInterface
CREATE TABLE IF NOT EXISTS "cjams"."tb_fmis_payment_header_interface" (
    "fmis_payment_header_record_id" integer,
    "batch_agency_cd" varchar(3),
    "batch_dt" timestamp,
    "batch_type_cd" varchar(1),
    "batch_no" varchar(3),
    "batch_sequence_no" varchar(5),
    "batch_user_operator_id" varchar(8),
    "batch_operator_nm" varchar(20),
    "batch_operator_class" varchar(2),
    "batch_tid" varchar(4),
    "batch_effective_dt" timestamp,
    "batch_dis_method_ind" varchar(1),
    "batch_payment_dis_type_cd" varchar(2),
    "fast_entry_ind" varchar(1),
    "batch_doc_hold_flag_ind" varchar(1),
    "batch_amt_count_entered_ind" varchar(1),
    "batch_status_ind" varchar(1),
    "batch_header_count_ind" varchar(1),
    "batch_last_sequence_no" varchar(5),
    "batch_system_dt" timestamp,
    "batch_master_file_ind" varchar(1),
    "filler_1_tx" varchar(7),
    "batch_entered_count" varchar(50),
    "batch_entered_amt" varchar(50),
    "filler_2_tx" varchar(5),
    "batch_computed_cnt" varchar(5),
    "batch_computed_amt" varchar(13),
    "approval_to_post_ind" varchar(1),
    "all_documents_approval_ind" varchar(1),
    "batch_rti_error_ind" varchar(1),
    "fillter_3_tx" varchar(618),
    "create_user_id" varchar(10),
    "create_ts" timestamp,
    "update_user_id" varchar(10),
    "update_ts" timestamp,
    "delete_sw" char(1),
    "payment_type_cd" varchar(4)
);

-- Model(s): Fmis_payment_vendor_date
CREATE TABLE IF NOT EXISTS "cjams"."tb_fmis_pmnt_vendor_dt" (
    "fmis_pmnt_vendor_dt_id" numeric,
    "delete_sw" char(1),
    "year_no" numeric,
    "month_no" numeric,
    "vendor_file_1_dt" date,
    "pay_file_1_dt" date,
    "vendor_file_2_dt" date,
    "pay_file_2_dt" date,
    "comments_tx" varchar(500),
    "create_user_id" varchar(255),
    "create_ts" timestamp,
    "update_user_id" varchar(255),
    "update_ts" timestamp,
    "teamtypekey" varchar(50),
    PRIMARY KEY ("fmis_pmnt_vendor_dt_id")
);

-- Model(s): fmisResponse
CREATE TABLE IF NOT EXISTS "cjams"."tb_fmis_response" (
    "fmis_response_id" integer,
    "batch_dt" varchar(8),
    "batch_type" char(1),
    "batch_no" varchar(3),
    "batch_seq_no" varchar(255),
    "user_id" varchar(255),
    "terminal_id" varchar(255),
    "effective_date" varchar(255),
    "disburse_method_ind" char(1),
    "capitalize_ind" char(1),
    "transaction_code" varchar(3),
    "modifier" char(1),
    "reverse_ind" char(1),
    "agency_object_cd" varchar(4),
    "vendor_number" varchar(10),
    "invoice_no" varchar(14),
    "warrant_no" varchar(9),
    "trans_amt" varchar(16),
    "warrant_written_dt" varchar(8),
    "curr_doc_no" varchar(255),
    "curr_doc_no_suffix" varchar(255),
    "run_id" integer,
    "create_ts" varchar(255),
    "create_user_id" varchar(255),
    "update_ts" varchar(30),
    "delete_sw" char(1),
    "update_user_id" varchar(255)
);

-- Model(s): Tb_foster_care_rate
CREATE TABLE IF NOT EXISTS "cjams"."tb_foster_care_rate" (
    "rate_id" integer,
    "service_id" integer,
    "start_dt" date,
    "end_dt" date,
    "min_age_no" integer,
    "max_age_no" integer,
    "monthly_rate_no" numeric(10,2),
    "per_diem_rate_no" numeric(10,2),
    "monthly_clothing_no" numeric(10,2),
    "emergency_per_diem_no" numeric(10,2),
    "emergency_bed_fee" numeric(10,2),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "rate_type_cd" char(1),
    "difficulty_level_cd" char(5),
    "max_clothing_no" numeric(10,2),
    "monthly_stipend_no" numeric(10,2),
    "monthly_differential_no" numeric(10,2),
    "dirty_status" integer
);

-- Model(s): Tb_foster_care_rate_stg
CREATE TABLE IF NOT EXISTS "cjams"."tb_foster_care_rate_stg" (
    "rate_id" integer,
    "main_rate_id" integer,
    "service_id" integer,
    "start_dt" date,
    "end_dt" date,
    "min_age_no" integer,
    "max_age_no" integer,
    "monthly_rate_no" numeric(10,2),
    "per_diem_rate_no" numeric(10,2),
    "monthly_clothing_no" numeric(10,2),
    "emergency_per_diem_no" numeric(10,2),
    "emergency_bed_fee" numeric(10,2),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "rate_type_cd" char(1),
    "difficulty_level_cd" char(5),
    "max_clothing_no" numeric(10,2),
    "monthly_stipend_no" numeric(10,2),
    "monthly_differential_no" numeric(10,2),
    "rate_status" varchar(10)
);

-- Model(s): Tb_ive_adoption_audit
CREATE TABLE IF NOT EXISTS "cjams"."tb_ive_adoption_audit" (
    "transactionid" uuid DEFAULT gen_random_uuid(),
    "incompletespecalistname" text,
    "incompletedate" timestamp,
    "incompletespecalistsignature" text,
    "decisionsubmissionspecalistname" text,
    "decisionsubmissiondate" timestamp,
    "decisionsubmissionspecalistsignature" text,
    "decisionresubmissionspecalistname" text,
    "decisionresubmissiondate" timestamp,
    "decisionresubmissionspecalistsignature" text,
    "resubmissioncount" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "adoptionapplicable" varchar(50),
    "applicableandnonapplicable" varchar(50),
    "adoptionnonapplicable" varchar(50),
    "neitheranappnornonappchildfortitleivepurposes" varchar(50),
    "adoptionacasubmitted" boolean,
    PRIMARY KEY ("transactionid")
);

-- Model(s): Tb_ive_gapaudit
CREATE TABLE IF NOT EXISTS "cjams"."tb_ive_gapaudit" (
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp
);

-- Model(s): Tb_payment_header
CREATE TABLE IF NOT EXISTS "cjams"."tb_payment_header" (
    "payment_id" integer,
    "provider_id" integer,
    "authorization_id" integer,
    "payment_dt" date,
    "payment_type_cd" varchar(5),
    "check_status_cd" varchar(5),
    "check_status_dt" date,
    "payment_method_cd" varchar(5),
    "gross_amount_no" numeric(50,2),
    "offset_amount_no" numeric(50,2),
    "manual_sw" char(1),
    "approval_status_cd" varchar(5),
    "update_method_sw" char(1),
    "create_ts" varchar(30),
    "store_receipt_id" varchar(20),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "notes_tx" varchar(500),
    "payee_nm" varchar(100),
    "interface_to_cd" varchar(50),
    "adr_type_cd" varchar(50),
    "adr_format_cd" varchar(50),
    "adr_street_no" integer,
    "adr_box_no" integer,
    "adr_pre_dir_cd" varchar(5),
    "adr_street_nm" varchar(50),
    "adr_street_suffix_cd" varchar(5),
    "adr_post_dir_cd" varchar(5),
    "adr_unit_type_cd" varchar(5),
    "adr_unit_no_tx" varchar(5),
    "adr_city_nm" varchar(50),
    "adr_county_cd" varchar(5),
    "adr_state_cd" varchar(5),
    "adr_zip5_no" numeric(50,2),
    "adr_zip4_no" numeric(50,2),
    "adr_direction_tx" varchar(500),
    "adr_foreign_tx" varchar(500),
    "adr_home_phone_tx" varchar(10),
    "adr_work_phone_tx" varchar(10),
    "adr_work_xtn_tx" varchar(5),
    "adr_pager_tx" varchar(20),
    "adr_email_tx" varchar(100),
    "adr_fax_tx" varchar(10),
    "adr_cell_phone_tx" varchar(10),
    "adr_url_tx" varchar(100),
    "adr_other_contact_tx" varchar(100),
    "payment_start_dt" date,
    "payment_end_dt" date,
    "adr_foreign_state_tx" varchar(50),
    "adr_country_tx" varchar(50),
    "adr_postal_code_tx" varchar(10),
    "adr_default_sw" char(1),
    "adr_start_dt" date,
    "adr_end_dt" date,
    "client_account_id" integer,
    "adr_street_tx" varchar(10)
);

-- Model(s): Tb_payment_plan
CREATE TABLE IF NOT EXISTS "cjams"."tb_payment_plan" (
    "payment_plan_id" integer,
    "plan_dt" date,
    "receivable_id" integer,
    "amount_no" numeric(50,2),
    "percentage_no" numeric(50,2),
    "months_no" integer,
    "start_dt" date,
    "end_dt" date,
    "offset_sw" char(1),
    "payment_option_sw" varchar(500),
    "manual_sw" char(1),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    PRIMARY KEY ("payment_plan_id")
);

-- Model(s): Tb_payment_receipt
CREATE TABLE IF NOT EXISTS "cjams"."tb_payment_receipt" (
    "receipt_id" integer,
    "provider_id" integer,
    "payee_cd" varchar(5),
    "payment_method_cd" varchar(5),
    "payment_no_tx" varchar(20),
    "payment_amount_no" numeric(10,2),
    "receipt_dt" date,
    "notes_tx" varchar(500),
    "reason_tx" char(5),
    "status_cd" varchar(5),
    "approval_status_cd" varchar(5),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "approve_staff_id" integer,
    "action_dt" date,
    "payment_type_cd" varchar(5)
);

-- Model(s): Tb_payment_status
CREATE TABLE IF NOT EXISTS "cjams"."tb_payment_status" (
    "payment_status_id" integer,
    "payment_status_cd" varchar(5),
    "payment_status_dt" date,
    "payment_id" integer,
    "active_sw" char(1),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "approval_status_cd" char(5),
    PRIMARY KEY ("payment_status_id")
);

-- Model(s): Tb_picklist_values, Picklistvalues
CREATE TABLE IF NOT EXISTS "cjams"."tb_picklist_values" (
    "picklist_value_cd" varchar(5),
    "picklist_type_id" integer,
    "value_tx" varchar(150),
    "description_tx" varchar(1000),
    "active_sw" varchar(1),
    "sort_order_no" integer,
    "create_ts" varchar(30),
    "create_user_id" varchar(10),
    "update_ts" varchar(30),
    "update_user_id" varchar(10),
    "delete_sw" varchar(1),
    "category_tx" varchar(500)
);

-- Model(s): Tb_placement
CREATE TABLE IF NOT EXISTS "cjams"."tb_placement" (
    "placement_id" integer,
    "case_id" integer,
    "client_id" integer,
    "removal_id" integer,
    "provider_organization_id" integer,
    "provider_id" integer,
    "contract_program_id" integer,
    "facility_id" integer,
    "medicaid_paid_sw" char(1),
    "entry_dt" date,
    "entry_tm" varchar(30),
    "other_services_tx" varchar(500),
    "exit_dt" date,
    "exit_tm" varchar(30),
    "exit_explanation_tx" varchar(500),
    "exit_reason_cd" varchar(5),
    "over_under_sw" char(1),
    "approval_status_cd" varchar(5),
    "placement_structure_id" integer,
    "intakeservicerequestactorid" uuid,
    "void_sw" char(1),
    "void_reason_cd" varchar(5),
    "exit_type_cd" varchar(5),
    "court_ordered_sw" char(1),
    "icpc_approved_sw" char(1),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "short_list_id" integer,
    "payment_header_id" integer,
    "placement_change_dt" date,
    "fiscal_category_cd" char(5),
    "rate_structure_id" integer,
    "conversion_sw" char(1),
    "orig_placement_id" integer,
    "data_valid_sw" char(1),
    "client_merge_id" integer,
    "void_approval_status_cd" varchar(50),
    "void_approval_dt" date,
    "tfc_ifc_conversion_sw" char(1),
    PRIMARY KEY ("placement_id")
);

-- Model(s): Tb_placement_auto_validation_log
CREATE TABLE IF NOT EXISTS "cjams"."tb_placement_auto_validation_log" (
    "placement_auto_validation_log_id" integer,
    "placement_id" integer,
    "insert_updt_sw" char(5),
    "placement_validation_id" integer,
    "validation_start_dt" date,
    "validation_end_dt" date,
    "auto_valid_sw" char(5),
    "error_reasons" varchar(3000),
    "activeflag" integer,
    PRIMARY KEY ("placement_auto_validation_log_id")
);

-- Model(s): Tb_placement_providers
CREATE TABLE IF NOT EXISTS "cjams"."tb_placement_providers" (
    "placement_provider_id" integer,
    "placement_id" integer,
    "provider_id" integer,
    "contract_program_id" integer,
    "reject_reason_cd" varchar(5),
    "placed_with_sw" char(1),
    "accepted_cd" varchar(5),
    "reason_non_preferred_tx" varchar(500),
    "info_sent_dt" date,
    "info_description_tx" varchar(500),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "provider_organization_id" integer,
    "provider_service_id" integer,
    "service_id" integer,
    "rate_structure_id" integer,
    "entry_dt" date,
    "entry_tm" varchar(30),
    "ssa_ifc_approval_sw" char(1),
    "ssa_ifc_approval_dt" date,
    PRIMARY KEY ("placement_provider_id")
);

-- Model(s): Tb_placement_revision
CREATE TABLE IF NOT EXISTS "cjams"."tb_placement_revision" (
    "placement_revision_id" integer,
    "placement_id" integer,
    "transaction_dt" date,
    "entry_dt" date,
    "entry_tm" varchar(30),
    "exit_dt" date,
    "exit_tm" varchar(30),
    "exit_type_cd" varchar(5),
    "exit_explanation_tx" varchar(500),
    "exit_reason_cd" varchar(5),
    "approval_status_cd" varchar(5),
    "approval_dt" date,
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1)
);

-- Model(s): Tb_placement_stru_category_link
CREATE TABLE IF NOT EXISTS "cjams"."tb_placement_stru_category_link" (
    "placement_stru_cate_link_id" integer,
    "service_id" integer,
    "fiscal_category_id" integer,
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1)
);

-- Model(s): Tb_placement_validation
CREATE TABLE IF NOT EXISTS "cjams"."tb_placement_validation" (
    "placement_validation_id" integer,
    "placement_id" integer,
    "placement_entry_dt" date,
    "placement_exit_dt" date,
    "validation_status_cd" char(5),
    "comment_tx" varchar(500),
    "create_ts" timestamp,
    "create_user_id" varchar(50),
    "update_ts" timestamp,
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "validation_start_dt" date,
    "validation_end_dt" date,
    PRIMARY KEY ("placement_validation_id")
);

-- Model(s): Providerinfo
CREATE TABLE IF NOT EXISTS "cjams"."tb_provider" (
    "provider_id" bigint,
    "provider_category_cd" varchar(30),
    "provider_status_cd" varchar(30),
    "adr_work_phone_tx" numeric,
    "co_ssn_no" numeric,
    "business_start_tm" varchar(10),
    "business_end_tm" varchar(10),
    "medical_license_no_tx" varchar(20),
    "medical_speciality_tx" varchar(100),
    "admission_comments_tx" varchar(500),
    "dob_dt" date,
    "co_first_nm" varchar(100),
    "co_last_nm" varchar(100),
    "tax_id_no" numeric,
    "affiliate_provider_id" numeric,
    "provider_nm" varchar(30),
    "provider_first_nm" varchar(20),
    "provider_middle_nm" varchar(10),
    "provider_last_nm" varchar(20),
    "vacancy_no" integer,
    "county_cd" varchar(255),
    "withhold_payment_sw" char(1),
    "update_user_id" varchar(50),
    "update_ts" timestamp,
    "create_user_id" varchar(50),
    "create_ts" timestamp,
    "delete_sw" char(1),
    "county_cd_tx" varchar(50),
    PRIMARY KEY ("provider_id")
);

-- Model(s): Providerapplicant, Providerapplicantportal
CREATE TABLE IF NOT EXISTS "cjams"."tb_provider_applicant" (
    "applicant_id" varchar(30),
    "application_status" varchar(15),
    "contact_first_nm" varchar(30),
    "contact_last_nm" varchar(30),
    "contact_prefix_cd" varchar(30),
    "contact_suffix_cd" varchar(30),
    "program_tax_id_no" integer,
    "program_type" varchar(15),
    "program_name" varchar(30),
    "prgram" varchar(30),
    "mailing_address" varchar(50),
    "contact_email" varchar(42),
    "contact_phonenumber" varchar(44),
    "update_user_id" varchar(50),
    "update_ts" timestamp,
    "create_user_id" varchar(50),
    "corporation_name" varchar(50),
    "create_ts" timestamp,
    "license_no" varchar(15),
    "provider_id" varchar(15),
    "applicant_profile_id" varchar(15),
    "requested_license_effective_date" varchar(15),
    "requested_license_end_date" varchar(15),
    "delete_sw" char(1),
    "uploadsignature" text,
    "agency" text,
    "contact_person" varchar(30),
    PRIMARY KEY ("applicant_id")
);

-- Model(s): Updatechecklisttask
CREATE TABLE IF NOT EXISTS "cjams"."tb_provider_applicant_checklist" (
    "checklist_id" uuid DEFAULT gen_random_uuid(),
    "provider_applicant_id" varchar(255),
    "checklist_task" varchar(512),
    "agency" varchar(512),
    "programname" varchar(512),
    "commnts" text,
    "status" uuid,
    "category" text,
    "subcategory" text,
    "description" text,
    "monitoring_type" varchar(20),
    "monitoring_year" varchar(255),
    "time_of_visit" varchar(15),
    "visit_schedule" varchar(255),
    "monitoring_period" varchar(20),
    "completeddate" timestamp,
    "update_user_id" varchar(50),
    "update_ts" timestamp,
    "create_user_id" varchar(50),
    "create_ts" timestamp,
    "delete_sw" char(1),
    PRIMARY KEY ("checklist_id")
);

-- Model(s): Applicantstaff
CREATE TABLE IF NOT EXISTS "cjams"."tb_provider_applicant_staff" (
    "staff_id" uuid DEFAULT gen_random_uuid(),
    "provider_applicant_id" varchar(50),
    "staff_first_name" varchar(50),
    "staff_last_name" varchar(50),
    "staff_role" varchar(15),
    "staff_email" varchar(50),
    "staff_phone" varchar(10),
    "staff_background_status" varchar(15),
    "staff_ssn" varchar(9),
    "activeflag" integer,
    "update_user_id" varchar(50),
    "update_ts" timestamp,
    "create_user_id" varchar(50),
    "create_ts" timestamp,
    "delete_sw" char(1),
    "provider_staff_id" varchar(255),
    PRIMARY KEY ("staff_id")
);

-- Model(s): Providerapproval
CREATE TABLE IF NOT EXISTS "cjams"."tb_provider_approval" (
    "providerapprovalid" uuid DEFAULT gen_random_uuid(),
    "provider_id" varchar(50),
    "approval_type_cd" varchar(255),
    "approval_status_cd" varchar(50),
    "recommend_cd" varchar(50),
    "entry_dt" date,
    "effective_dt" date,
    "next_recon_dt" date,
    "approval_dt" date,
    "approved_beds_no" integer,
    "request_apprvoal_sw" varchar(50),
    "approval_comments_tx" varchar(2000),
    "no_household_sw" varchar(50),
    "no_pets_sw" varchar(50),
    "fire_request_dt" date,
    "fire_complete_dt" date,
    "health_request_dt" date,
    "original_mot_tx" varchar(1000),
    "change_mot_tx" varchar(1000),
    "home_desc_tx" varchar(1000),
    "app_person_info_cd" varchar(50),
    "co_personal_info_cd" varchar(50),
    "app_background_cd" varchar(50),
    "co_background_cd" varchar(50),
    "app_childhood_cd" varchar(50),
    "co_childhood_cd" varchar(50),
    "app_adulthood_cd" varchar(50),
    "co_adulthood_cd" varchar(50),
    "household_cd" varchar(50),
    "pets_cd" varchar(50),
    "checklist_cd" varchar(50),
    "motivation_cd" varchar(50),
    "child_eval_cd" varchar(50),
    "family_system_cd" varchar(50),
    "reference_cd" varchar(50),
    "backup_cd" varchar(50),
    "recon_check_cd" varchar(50),
    "recon_eval_cd" varchar(50),
    "ref_approval_id" integer,
    "app_clearance_cd" varchar(50),
    "co_clearance_cd" varchar(50),
    "fam_clearance_cd" varchar(50),
    "effective_end_dt" date,
    "comar_regulation_tx" varchar(50),
    "ha_approval_status_cd" varchar(50),
    "ha_approval_dt" date,
    "ha_revoke_approval_dt" date,
    "family_assessment_cd" varchar(50),
    "co_applicant_sw" varchar(50),
    "ha_revoke_approval_status_cd" varchar(50),
    "recommended_children_tx" varchar(2000),
    "daycare_ok_sw" varchar(50),
    "more_than_eight_sw" varchar(50),
    "checklist_comments_tx" varchar(2000),
    "approval_reason_cd" varchar(50),
    "active_sw" varchar(50),
    "training_completion_dt" date,
    "pre_revoke_status_cd" varchar(50),
    "pre_revoke_active_sw" varchar(50),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    PRIMARY KEY ("providerapprovalid")
);

-- Model(s): providerassignmentownership
CREATE TABLE IF NOT EXISTS "cjams"."tb_provider_assignment_ownership" (
    "providerassignmentownershipid" uuid DEFAULT gen_random_uuid(),
    "eventcode" varchar(10),
    "fromsecurityusersid" varchar(50),
    "tosecurityusersid" varchar(50),
    "fromroleid" varchar(50),
    "toroleid" varchar(50),
    "objectid" uuid,
    "assigneddate" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "isreviewrequest" boolean,
    "remarks" text,
    "status" varchar(255),
    PRIMARY KEY ("providerassignmentownershipid")
);

-- Model(s): Providerlicense
CREATE TABLE IF NOT EXISTS "cjams"."tb_provider_license" (
    "applicant_id" varchar(30),
    "contact_person" varchar(30),
    "program_type" varchar(15),
    "program_name" varchar(30),
    "corporation_name" varchar(255),
    "mailing_address" varchar(50),
    "contact_email" varchar(42),
    "contact_phonenumber" varchar(44),
    "update_user_id" varchar(50),
    "update_ts" timestamp,
    "create_user_id" varchar(50),
    "create_ts" timestamp,
    "delete_sw" char(1),
    PRIMARY KEY ("applicant_id")
);

-- Model(s): Providerreferral
CREATE TABLE IF NOT EXISTS "cjams"."tb_provider_referral" (
    "provider_referral_id" varchar(30),
    "provider_referral_nm" varchar(30),
    "provider_program_type" varchar(15),
    "provider_referral_med" varchar(30),
    "referral_dt" timestamp,
    "provider_referral_first_nm" varchar(50),
    "referral_decision" varchar(10),
    "referral_status" varchar(10),
    "provider_referral_last_nm" varchar(30),
    "is_son" varchar(5),
    "is_rfp" varchar(5),
    "parent_entity" varchar(50),
    "parent_entity_taxid" varchar(50),
    "corporation_entity" varchar(255),
    "corporation_entity_taxid" varchar(50),
    "adr_fax_tx" varchar(48),
    "adr_email_tx" varchar(42),
    "adr_cell_phone_tx" varchar(44),
    "adr_home_phone_tx" varchar(40),
    "narrative" varchar(100),
    "update_user_id" varchar(50),
    "update_ts" timestamp,
    "create_user_id" varchar(50),
    "create_ts" timestamp,
    "delete_sw" char(1),
    "referral_source_cd" varchar(50),
    "information_meeting_dt" timestamp,
    "application_sent_dt" timestamp,
    "approval_status_cd" varchar(50),
    "comments_tx" varchar(500),
    "outcome_cd" varchar(50),
    "outcome_dt" timestamp,
    "provider_id" integer,
    "county_cd" varchar(50),
    "provider_referral_suffix_cd" varchar(50),
    "provider_referral_middle_nm" varchar(50),
    "provider_referral_prefix_cd" varchar(50),
    "dob_dt" timestamp,
    "tax_id_no" integer,
    "co_prefix_cd" varchar(50),
    "co_first_nm" varchar(50),
    "co_middle_nm" varchar(50),
    "co_last_nm" varchar(50),
    "co_suffix_cd" varchar(50),
    "co_ssn_no" integer,
    "co_dob_dt" timestamp,
    "adm_contact_prefix_cd" varchar(50),
    "adm_contact_first_nm" varchar(50),
    "adm_contact_middle_nm" varchar(50),
    "adm_contact_suffix_cd" varchar(50),
    "adr_work_phone_tx" varchar(50),
    "adr_work_xtn_tx" varchar(50),
    "adr_pager_tx" varchar(50),
    "adr_url_tx" varchar(50),
    "adr_other_contact_tx" varchar(50),
    "tax_type_cd" varchar(50),
    "accept_status_cd" varchar(50),
    "screen_out_reason_cd" varchar(50),
    "formatted_first_nm" varchar(50),
    "formatted_last_nm" varchar(50),
    "formatted_provider_nm" varchar(50),
    "provider_nm_soundex" varchar(50),
    "provider_last_nm_soundex" varchar(50),
    "pnm_soundex" varchar(50),
    "lnm_soundex" varchar(50),
    "fnm_soundex" varchar(50),
    "provider_first_nm_soundex" varchar(50),
    "provider_program_name" varchar(50),
    "applicant_id" varchar(50),
    "is_taxid" varchar(50),
    "provider_referral_program" varchar(50),
    "agency" varchar(50),
    "provider_category" varchar(50),
    "county_cd_tx" varchar(50),
    PRIMARY KEY ("provider_referral_id")
);

-- Model(s): providerListSearch
CREATE TABLE IF NOT EXISTS "cjams"."tb_provider_services" (
    "provider_service_id" integer,
    "provider_id" integer,
    "program_id" integer,
    "service_nm" varchar(10),
    "service_id" integer
);

-- Model(s): Publicproviderapplicant
CREATE TABLE IF NOT EXISTS "cjams"."tb_public_provider_applicant" (
    "applicant_id" varchar(50),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "delete_sw" varchar(1),
    "update_user_id" varchar(50),
    "application_status" varchar(50),
    "phase" varchar(50),
    "organization_first_nm" varchar(100),
    "organization_tax_id" integer,
    "individual_applicant_first_nm" varchar(100),
    "individual_applicant_ssn" integer,
    "individual_applicant_dob" varchar(15),
    "application_received_date" timestamp,
    "home_study_completion_date" timestamp,
    "individual_applicant_background_check" varchar(10),
    "co_applicant_first_nm" varchar(50),
    "co_applicant_ssn" integer,
    "co_applicant_dob" varchar(15),
    "co_applicant_background_check" varchar(10),
    "medical_info_license_no" integer,
    "medical_info_speciality" varchar(150),
    "payment_info_medicaid_provider" boolean,
    "payment_info_payee_first_nm" varchar(100),
    "payment_info_1099_indicator" boolean,
    "individual_applicant_middle_nm" varchar(100),
    "individual_applicant_last_nm" varchar(100),
    "organization_middle_nm" varchar(100),
    "organization_last_nm" varchar(100),
    "co_applicant_middle_nm" varchar(100),
    "co_applicant_last_nm" varchar(100),
    "payment_info_payee_middle_nm" varchar(100),
    "payment_info_payee_last_nm" varchar(100),
    "prgram" varchar(100),
    "provider_program_type" varchar(500),
    "individual_applicant_prefix" varchar(50),
    "jurisdiction" varchar(50),
    "individual_applicant_suffix" varchar(50),
    "co_applicant_prefix" varchar(50),
    "co_applicant_suffix" varchar(50),
    "home_info_children_no" varchar(50),
    "home_info_bedroom_no" varchar(50),
    "is_home_water" boolean,
    "is_home_swimming_pool" boolean,
    "home_is_other_agency" boolean,
    "home_info_pool_location" varchar(50),
    "home_info_agency_nm" varchar(50),
    "is_child_care_provider" boolean,
    "home_info_child_care_details" varchar(50),
    "individual_applicant_hm_phone" varchar(50),
    "individual_applicant_cell_nm" varchar(50),
    "individual_applicant_email" varchar(50),
    "individual_applicant_employer_nm" varchar(50),
    "individual_applicant_phone_nm" varchar(50),
    "individual_applicant_us_citizen" boolean,
    "co_applicant_hm_phone" varchar(50),
    "co_applicant_cell_nm" varchar(50),
    "co_applicant_email" varchar(50),
    "co_applicant_employer_nm" varchar(50),
    "co_applicant_phone_nm" varchar(50),
    "placement_structures" json,
    "training_info" json,
    "co_applicant_us_citizen" boolean,
    "age_group" json,
    "inquiry_source" varchar(50),
    "inquiry_source_details" varchar(50),
    "individual_information" json,
    "co_app_information" json,
    "app_information" json,
    "home_information" json,
    "home_study_completed_by" varchar(50),
    "reason" text,
    "provisionstrtdate" timestamp,
    "provisionenddate" timestamp,
    "recommendation_status" varchar(50),
    PRIMARY KEY ("applicant_id")
);

-- Model(s): Publicproviderapplicanthousehold
CREATE TABLE IF NOT EXISTS "cjams"."tb_public_provider_applicant_household" (
    "household_member_id" integer,
    "object_id" varchar(50),
    "household_member_relation" varchar(25),
    "household_member_email" varchar(100),
    "household_member_dob" date,
    "household_member_phone" numeric,
    "household_member_ssn" numeric,
    "create_ts" varchar(255),
    "create_user_id" varchar(50),
    "update_ts" varchar(255),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "household_member_clearance_status" boolean,
    "household_member_first_name" varchar(50),
    "household_member_middle_name" varchar(50),
    "household_member_last_name" varchar(50),
    "household_member_suffix" varchar(50),
    "household_member_prefix" varchar(50),
    "bg_chk_state" boolean,
    "bg_chk_state_date" date,
    "bg_chk_national" boolean,
    "bg_chk_national_date" date,
    "bg_chk_child_abuse_maltreatment" boolean,
    "bg_chk_child_abuse_maltreatment_date" date,
    "bg_chk_oos" boolean,
    "bg_chk_child_abuse_maltreatment_oos" boolean,
    "bg_chk_child_abuse_maltreatment_oos_date" date,
    "alias" varchar(50),
    "household_member_race" varchar(10),
    "former_name" varchar(50),
    "household_member_ethnicity" varchar(10),
    "birthplace" varchar(50),
    "height" varchar(50),
    "annual_income" varchar(50),
    "household_member_gender" varchar(10),
    "weight" varchar(50),
    "additional_income_source" varchar(50),
    "hair" varchar(50),
    "household_member_maritalstatus" varchar(10),
    "eye_color" varchar(50),
    "religion" varchar(50),
    "tribal_affialiation" varchar(50),
    "education" varchar(50),
    "languages" varchar(50),
    "occupation" varchar(50),
    "is_school_attending" boolean,
    "employer" varchar(50),
    PRIMARY KEY ("household_member_id")
);

-- Model(s): Publicproviderapplicanthouseholdbgchecks
CREATE TABLE IF NOT EXISTS "cjams"."tb_public_provider_applicant_household_security" (
    "household_bg_id" integer,
    "household_member_id" integer,
    "security_question" varchar(150),
    "security_answer" varchar(1),
    "clearance_date" date
);

-- Model(s): Publicproviderreferral
CREATE TABLE IF NOT EXISTS "cjams"."tb_public_provider_referral" (
    "referral_id" varchar(50),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "delete_sw" varchar(1),
    "update_user_id" varchar(50),
    "referral_status" varchar(50),
    "referral_decision" varchar(50),
    "organization_first_nm" varchar(100),
    "organization_tax_id" integer,
    "individual_applicant_first_nm" varchar(100),
    "individual_applicant_ssn" integer,
    "individual_applicant_dob" varchar(15),
    "individual_applicant_background_check" varchar(10),
    "co_applicant_first_nm" varchar(50),
    "co_applicant_ssn" integer,
    "co_applicant_dob" varchar(15),
    "co_applicant_background_check" varchar(10),
    "medical_info_license_no" integer,
    "medical_info_speciality" varchar(150),
    "payment_info_medicaid_provider" boolean,
    "payment_info_payee_first_nm" varchar(100),
    "payment_info_1099_indicator" boolean,
    "individual_applicant_middle_nm" varchar(100),
    "individual_applicant_last_nm" varchar(100),
    "organization_middle_nm" varchar(100),
    "organization_last_nm" varchar(100),
    "co_applicant_middle_nm" varchar(100),
    "co_applicant_last_nm" varchar(100),
    "payment_info_payee_middle_nm" varchar(100),
    "payment_info_payee_last_nm" varchar(100),
    "date_of_contact" varchar(100),
    "communication_medium" varchar(100),
    "prgram" varchar(100),
    "provider_program_type" varchar(500),
    "individual_applicant_prefix" varchar(50),
    "individual_applicant_suffix" varchar(50),
    "co_applicant_prefix" varchar(50),
    "co_applicant_suffix" varchar(50),
    "home_info_children_no" varchar(50),
    "home_info_bedroom_no" varchar(50),
    "is_home_water" boolean,
    "is_home_swimming_pool" boolean,
    "home_is_other_agency" boolean,
    "home_info_pool_location" varchar(50),
    "home_info_agency_nm" varchar(50),
    "is_child_care_provider" boolean,
    "home_info_child_care_details" varchar(50),
    "individual_applicant_hm_phone" varchar(50),
    "individual_applicant_cell_nm" varchar(50),
    "individual_applicant_email" varchar(50),
    "individual_applicant_employer_nm" varchar(50),
    "individual_applicant_phone_nm" varchar(50),
    "individual_applicant_us_citizen" boolean,
    "co_applicant_hm_phone" varchar(50),
    "co_applicant_cell_nm" varchar(50),
    "co_applicant_email" varchar(50),
    "co_applicant_employer_nm" varchar(50),
    "co_applicant_phone_nm" varchar(50),
    "co_applicant_us_citizen" boolean,
    "age_group" json,
    "inquiry_source" varchar(50),
    "jurisdiction" varchar(50),
    "inquiry_source_details" varchar(50),
    PRIMARY KEY ("referral_id")
);

-- Model(s): Tb_receivable_collection_status
CREATE TABLE IF NOT EXISTS "cjams"."tb_receivable_collection_status" (
    "collection_status_id" integer,
    "collection_status_dt" date,
    "collection_status_cd" varchar(500),
    "receivable_detail_id" integer,
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "active_sw" char(1),
    PRIMARY KEY ("collection_status_id")
);

-- Model(s): Tb_receivable_detail
CREATE TABLE IF NOT EXISTS "cjams"."tb_receivable_detail" (
    "receivable_detail_id" integer,
    "payment_detail_id" integer,
    "receivable_id" integer,
    "amount_no" numeric(5,2),
    "receivable_balance_no" numeric(5,2),
    "written_off_amount_no" numeric(5,2),
    "written_off_request_amount_no" numeric(5,2),
    "receivable_ts" date,
    "receivable_status_dt" date,
    "start_dt" date,
    "end_dt" date,
    "receivable_status_cd" varchar(20),
    "comments_tx" text,
    "unit_no" numeric(5,2),
    "notes_tx" text,
    "approval_status_cd" char(1),
    "county_cd" varchar(20),
    "action_dt" date,
    "approve_staff_id" integer,
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "manual_sw" char(1),
    "receivable_type" varchar(50),
    "write_off_approval_status" varchar(50),
    "write_off_action_date" date,
    "approved_by" varchar(50),
    "write_off_request_date" date,
    "write_off_request_user_id" varchar(50),
    PRIMARY KEY ("receivable_detail_id")
);

-- Model(s): Tb_receivable_detail_history
CREATE TABLE IF NOT EXISTS "cjams"."tb_receivable_detail_history" (
    "receivable_detail_history_id" uuid,
    "receivable_detail_id" integer,
    "payment_detail_id" integer,
    "receivable_id" integer,
    "amount_no" numeric(5,2),
    "receivable_balance_no" numeric(5,2),
    "written_off_amount_no" numeric(5,2),
    "written_off_request_amount_no" numeric(5,2),
    "receivable_ts" date,
    "receivable_status_dt" date,
    "start_dt" date,
    "end_dt" date,
    "receivable_status_cd" varchar(20),
    "comments_tx" varchar(5),
    "unit_no" numeric(5,2),
    "notes_tx" char(1),
    "approval_status_cd" char(1),
    "county_cd" varchar(20),
    "action_dt" date,
    "approve_staff_id" integer,
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "manual_sw" char(1),
    "receivable_type" varchar(50),
    "write_off_approval_status" varchar(50),
    "write_off_action_date" date,
    "approved_by" varchar(50),
    "write_off_request_date" date,
    "write_off_request_user_id" varchar(50),
    "activeflag" integer
);

-- Model(s): Tb_receivable_liquidation
CREATE TABLE IF NOT EXISTS "cjams"."tb_receivable_liquidation" (
    "rcvbl_liquidation_id" integer,
    "collected_amount_no" numeric(5,2),
    "receipt_id" integer,
    "receivable_detail_id" integer,
    "offset_id" integer,
    "create_ts" timestamp,
    "create_user_id" varchar(50),
    "update_ts" timestamp,
    "update_user_id" varchar(50),
    "delete_sw" char(1)
);

-- Model(s): Tb_receivable_offset
CREATE TABLE IF NOT EXISTS "cjams"."tb_receivable_offset" (
    "offset_id" integer,
    "offset_dt" date,
    "payment_id" integer,
    "offset_amount_no" numeric(50,2),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "percentage_no" numeric(50,2),
    PRIMARY KEY ("offset_id")
);

-- Model(s): Tb_removal
CREATE TABLE IF NOT EXISTS "cjams"."tb_removal" (
    "removal_id" integer,
    "removal_dt" date,
    "return_dt" date,
    "removal_type_cd" char(5),
    "return_reason_cd" char(5),
    "comments_tx" varchar(500),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    PRIMARY KEY ("removal_id")
);

-- Model(s): serviceLog
CREATE TABLE IF NOT EXISTS "cjams"."tb_service_log" (
    "service_log_id" integer,
    "client_id" integer,
    "case_id" integer,
    "provider_service_id" integer,
    "agency_service_ldss_id" integer,
    "referred_dt" date,
    "start_dt" date,
    "end_dt" date,
    "description_tx" varchar(500),
    "outcome_tx" varchar(20),
    "no_service_reason_cd" varchar(5),
    "end_service_reason_cd" varchar(5),
    "purchase_type_cd" varchar(5),
    "create_ts" varchar(30),
    "ldss_cd" varchar(5),
    "create_user_id" varchar(10),
    "start_tm" varchar(255),
    "update_ts" varchar(255),
    "end_tm" varchar(255),
    "update_user_id" varchar(10),
    "delete_sw" char(1),
    "court_ordered_sw" char(1),
    "estimated_start_dt" date,
    "estimated_end_dt" date,
    "frequency_cd" varchar(5),
    "duration_cd" varchar(5),
    "agency_program_area_id" integer,
    "data_valid_sw" char(1),
    "client_merge_id" integer,
    "client_program_id" integer,
    "intakeservicerequestactorid" uuid,
    PRIMARY KEY ("service_log_id")
);

-- Model(s): purchaseAuthorization, Tb_service_purchase_authorization
CREATE TABLE IF NOT EXISTS "cjams"."tb_service_purchase_authorization" (
    "authorization_id" integer,
    "service_log_id" integer,
    "start_dt" date,
    "end_dt" date,
    "sprvsr_approval_dt" date,
    "ads_approval_dt" date,
    "funding_approval_dt" date,
    "payment_approval_dt" date,
    "funding_source_cd" varchar(5),
    "cost_no" integer,
    "funding_approval_f1" varchar(255),
    "payment_approval_f1" varchar(255),
    "final_amount_no" integer,
    "voucher_sw" char(1),
    "dedicated_ac_sw" char(1),
    "one_time_only_sw" char(1),
    "finance_category_cd" varchar(255),
    "sprvsr_approval_status_cd" varchar(255),
    "ads_approval_status_cd" varchar(255),
    "funding_approval_status_cd" varchar(255),
    "payment_approval_status_cd" varchar(255),
    "print_voucher_sw" char(1),
    "delete_sw" char(1),
    "create_ts" varchar(255),
    "create_user_id" varchar(255),
    "update_ts" varchar(255),
    "update_user_id" varchar(255),
    "fiscal_category_cd" varchar(255),
    "modified_fiscal_category_cd" varchar(255),
    "unit_no" integer,
    "client_account_id" integer,
    "justification_tx" varchar(500),
    PRIMARY KEY ("authorization_id")
);

-- Model(s): TbServices
CREATE TABLE IF NOT EXISTS "cjams"."tb_services" (
    "service_id" integer,
    PRIMARY KEY ("service_id")
);

-- Model(s): TbTempFmisVendorInterface
CREATE TABLE IF NOT EXISTS "cjams"."tb_temp_fmis_vendor_interface" (
    "temp_fmis_vendor_record_id" integer,
    "provider_id" integer,
    "address_id" integer,
    "create_user_id" varchar(10),
    "create_ts" timestamp,
    "update_user_id" varchar(10),
    "update_ts" timestamp,
    "delete_sw" char(1),
    "private_org_sw" char(1),
    PRIMARY KEY ("temp_fmis_vendor_record_id")
);

-- Model(s): Tb_vendor_addresses
CREATE TABLE IF NOT EXISTS "cjams"."tb_vendor_addresses" (
    "vendoraddressid" uuid DEFAULT gen_random_uuid(),
    "vendorapplicantid" uuid,
    "adr_1" varchar(50),
    "adr_2" varchar(50),
    "adr_city_nm" varchar(50),
    "adr_county_cd" varchar(5),
    "adr_state_cd" varchar(5),
    "adr_type_key" varchar(50),
    "adr_zip_no" numeric(5,2),
    "adr_start_dt" timestamp,
    "adr_end_dt" timestamp,
    "ispaymentaddress" boolean,
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    "isaddress" boolean,
    PRIMARY KEY ("vendoraddressid")
);

-- Model(s): Tb_vendor_applicant
CREATE TABLE IF NOT EXISTS "cjams"."tb_vendor_applicant" (
    "vendorapplicantid" uuid DEFAULT gen_random_uuid(),
    "org_nm" varchar(100),
    "primary_prefix_cd" varchar(5),
    "primary_first_nm" varchar(20),
    "primary_middle_nm" varchar(10),
    "primary_last_nm" varchar(20),
    "primary_suffix_cd" varchar(5),
    "isprimaryadmin" boolean,
    "admin_prefix_cd" varchar(5),
    "admin_first_nm" varchar(20),
    "admin_middle_nm" varchar(10),
    "admin_last_nm" varchar(20),
    "admin_suffix_cd" varchar(5),
    "taxidtype" varchar(5),
    "taxid" numeric(5,2),
    "is1099indicator" boolean,
    "ismedicalaidprov" boolean,
    "status" varchar(50),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    "vendorid" varchar(50),
    "regularfrom" varchar(50),
    "regularto" varchar(50),
    "approvaldate" date,
    "issamepaymentaddress" boolean,
    "approvalcomments" varchar(100),
    "providerid" varchar(50),
    "narrative" text,
    PRIMARY KEY ("vendorapplicantid")
);

-- Model(s): Tb_vendor_email
CREATE TABLE IF NOT EXISTS "cjams"."tb_vendor_email" (
    "vendoremailid" uuid DEFAULT gen_random_uuid(),
    "vendorapplicantid" uuid,
    "emailtypekey" varchar(15),
    "email" varchar(50),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    PRIMARY KEY ("vendoremailid")
);

-- Model(s): Tb_vendor_phone
CREATE TABLE IF NOT EXISTS "cjams"."tb_vendor_phone" (
    "vendorphoneid" uuid DEFAULT gen_random_uuid(),
    "vendorapplicantid" uuid,
    "phonetypekey" varchar(15),
    "phonenumber" varchar(32),
    "phoneextension" varchar(8),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    PRIMARY KEY ("vendorphoneid")
);

-- Model(s): Team
CREATE TABLE IF NOT EXISTS "cjams"."team" (
    "teamid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "teamname" varchar(50),
    "teamnumber" varchar(50),
    "teamtypekey" varchar(50),
    "description" text,
    "officetimingfrom" time,
    "officetimingto" time,
    "parentteamid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "region" integer,
    "regionid" uuid,
    "countyid" varchar(50),
    PRIMARY KEY ("teamid")
);

-- Model(s): Teammember
CREATE TABLE IF NOT EXISTS "cjams"."teammember" (
    "teammemberid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "teamid" uuid,
    "loadnumber" varchar(50),
    "roletypekey" varchar(50),
    "positioncode" varchar(15),
    "description" text,
    "isoncall" boolean,
    "supervisorid" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "linenumber" integer,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "rtfdate" timestamp,
    "coadate" timestamp,
    PRIMARY KEY ("teammemberid")
);

-- Model(s): Teammemberassignment
CREATE TABLE IF NOT EXISTS "cjams"."teammemberassignment" (
    "teammemberassignmentid" uuid DEFAULT gen_random_uuid(),
    "activeflag" integer,
    "teammemberid" uuid,
    "securityusersid" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "coadate" timestamp,
    "rtfdate" timestamp,
    PRIMARY KEY ("teammemberassignmentid")
);

-- Model(s): Teammemberequipment
CREATE TABLE IF NOT EXISTS "cjams"."teammemberequipment" (
    "teammemberequipmentid" uuid DEFAULT gen_random_uuid(),
    "teammemberid" uuid,
    "equipmentid" uuid,
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    PRIMARY KEY ("teammemberequipmentid")
);

-- Model(s): Teammemberrolecategory
CREATE TABLE IF NOT EXISTS "cjams"."teammemberrolecategory" (
    "teammemberrolecategoryoryid" uuid,
    "teammemberrolecategorykey" varchar(15),
    "description" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea,
    PRIMARY KEY ("teammemberrolecategorykey")
);

-- Model(s): Teammemberrolecategoryteammemberroletypemap
CREATE TABLE IF NOT EXISTS "cjams"."teammemberrolecategoryteammemberroletypemap" (
    "teammemberrolecategoryteammemberroletypemapid" uuid DEFAULT gen_random_uuid(),
    "teammemberrolecategorykey" varchar(15),
    "roletypekey" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "timestamp" bytea,
    PRIMARY KEY ("teammemberrolecategoryteammemberroletypemapid")
);

-- Model(s): Teammemberroletype
CREATE TABLE IF NOT EXISTS "cjams"."teammemberroletype" (
    "sequencenumber" integer,
    "roletypekey" varchar(50),
    "activeflag" integer,
    "description" text,
    "teamtypekey" varchar(50),
    "isroutable" boolean,
    "isupervisor" boolean,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "rolelevel" integer,
    PRIMARY KEY ("roletypekey")
);

-- Model(s): Teamtype
CREATE TABLE IF NOT EXISTS "cjams"."teamtype" (
    "sequencenumber" integer,
    "teamtypekey" varchar(50),
    "activeflag" integer,
    "description" text,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    PRIMARY KEY ("teamtypekey")
);

-- Model(s): Testingtype
CREATE TABLE IF NOT EXISTS "cjams"."testingtype" (
    "testingtypeid" uuid,
    "testingtypekey" varchar(15),
    "typedescription" varchar(250),
    "activeflag" integer,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "ishighergrade" boolean,
    "displayorder" integer,
    PRIMARY KEY ("testingtypekey")
);

-- Model(s): TitleIVE
CREATE TABLE IF NOT EXISTS "cjams"."titleive" (

);

-- Model(s): TitleIVEFC
CREATE TABLE IF NOT EXISTS "cjams"."titleivefc" (

);

-- Model(s): Tprdetails
CREATE TABLE IF NOT EXISTS "cjams"."tprdetails" (
    "tprdetailsid" uuid DEFAULT gen_random_uuid(),
    "intakeservicerequestactorid" uuid,
    "intakeserviceid" uuid,
    "tprrecommendationid" uuid,
    "serveddate" timestamp,
    "servicetypekey" varchar(25),
    "terminationtypekey" varchar(25),
    "isappealed" integer,
    "isdssappealed" integer,
    "appealdate" timestamp,
    "appealdecisiontypekey" varchar(25),
    "relationshiptypekey" varchar(50),
    "decisiondate" timestamp,
    "reason" varchar(250),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "servicecaseid" uuid,
    "tprdecisiondate" timestamp,
    "singleparent" boolean,
    "isdenied" boolean,
    "isgranted" boolean,
    PRIMARY KEY ("tprdetailsid")
);

-- Model(s): Tprrecommendation
CREATE TABLE IF NOT EXISTS "cjams"."tprrecommendation" (
    "tprrecommendationid" uuid DEFAULT gen_random_uuid(),
    "intakeservicerequestactorid" uuid,
    "intakeserviceid" uuid,
    "permanencyplanid" uuid,
    "isrecommended" boolean,
    "reasontypekey" varchar(50),
    "remarks" text,
    "intakeservreqcourtorderid" uuid,
    "activeflag" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "servicecaseid" uuid,
    PRIMARY KEY ("tprrecommendationid")
);

-- Model(s): Tprrecommendationchecklist
CREATE TABLE IF NOT EXISTS "cjams"."tprrecommendationchecklist" (
    "tprrecommendationchecklistid" uuid DEFAULT gen_random_uuid(),
    "tprrecommendationid" uuid,
    "checklistid" uuid,
    "permanencyplanid" uuid,
    "isselected" integer,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("tprrecommendationchecklistid")
);

-- Model(s): Typesagencymapping
CREATE TABLE IF NOT EXISTS "cjams"."typesagencymapping" (
    "typesagencymappingid" uuid DEFAULT gen_random_uuid(),
    "teamtypekey" varchar(50),
    "objecttypekey" varchar(100),
    "objecttype" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("typesagencymappingid")
);

-- Model(s): User, user
CREATE TABLE IF NOT EXISTS "cjams"."user" (
    "realm" varchar(255),
    "username" varchar(255),
    "password" varchar(255),
    "email" varchar(255)
);

-- Model(s): Userannouncement
CREATE TABLE IF NOT EXISTS "cjams"."userannouncement" (
    "userannouncementid" uuid,
    "announcementid" uuid,
    "userid" integer,
    "activeflag" integer,
    "isaccepted" integer,
    "acceptedon" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp
);

-- Model(s): Usercredentials
CREATE TABLE IF NOT EXISTS "cjams"."usercredentials" (
    "securityusersid" varchar(50),
    "password" varchar(100),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("securityusersid")
);

-- Model(s): Usernotification
CREATE TABLE IF NOT EXISTS "cjams"."usernotification" (
    "usernotificationid" uuid DEFAULT gen_random_uuid(),
    "securityusersid" varchar(50),
    "usernotificationtypekey" varchar(15),
    "teamtypekey" varchar(10),
    "objectid" varchar(255),
    "objecttype" varchar(255),
    "activeflag" integer,
    "url" text,
    "subject" varchar(255),
    "priorityleveltypekey" varchar(15),
    "body" text,
    "hasattachments" boolean,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "teammemberid" uuid,
    "attachmentlocation" varchar(255),
    "isread" boolean,
    "objectcasenumber" integer,
    PRIMARY KEY ("usernotificationid")
);

-- Model(s): Usernotificationgroup
CREATE TABLE IF NOT EXISTS "cjams"."usernotificationgroup" (
    "usernotificationgroupid" uuid DEFAULT gen_random_uuid(),
    "usernotificationgroupname" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("usernotificationgroupid")
);

-- Model(s): Usernotificationgroupdetail
CREATE TABLE IF NOT EXISTS "cjams"."usernotificationgroupdetail" (
    "usernotificationgroupdetailid" uuid DEFAULT gen_random_uuid(),
    "usernotificationgroupid" uuid,
    "teammemberid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    PRIMARY KEY ("usernotificationgroupdetailid")
);

-- Model(s): Usernotificationmap
CREATE TABLE IF NOT EXISTS "cjams"."usernotificationmap" (
    "usernotificationmapid" uuid DEFAULT gen_random_uuid(),
    "usernotificationid" uuid,
    "tosecurityusersid" varchar(50),
    "objectid" uuid,
    "activeflag" integer,
    "isreplied" boolean,
    "isforwarded" boolean,
    "iscarboncopy" boolean,
    "isread" boolean,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "teammemberid" uuid,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "fromsecurityusersid" varchar(50),
    PRIMARY KEY ("usernotificationmapid")
);

-- Model(s): Userpersonresultfield
CREATE TABLE IF NOT EXISTS "cjams"."userpersonresultfield" (
    "userpersonresultfieldid" uuid DEFAULT gen_random_uuid(),
    "userid" integer,
    "personresultfieldid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("userpersonresultfieldid")
);

-- Model(s): Userprofile
CREATE TABLE IF NOT EXISTS "cjams"."userprofile" (
    "securityusersid" uuid DEFAULT gen_random_uuid(),
    "firstname" varchar(50),
    "lastname" varchar(50),
    "displayname" varchar(100),
    "fullname" varchar(101),
    "ssn" varchar(10),
    "activeflag" integer,
    "otherfields" text,
    "onprobation" boolean,
    "expirationdate" timestamp,
    "email" varchar(50),
    "old_id" varchar(50),
    "title" varchar(50),
    "unavailableflag" boolean,
    "userworkstatustypekey" varchar(15),
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "calendarkey" uuid,
    "orgname" varchar(50),
    "orgnumber" varchar(50),
    "usertypekey" varchar(15),
    "autonotification" boolean,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "userphoto" text,
    "gendertypekey" varchar(15),
    "middlename" varchar(32),
    "dob" timestamptz,
    "teamtypekey" varchar(50),
    "cjamspid" integer,
    "usersignatureurl" varchar(50),
    "primarycountyid" uuid,
    "supervisorid" varchar(50),
    "entrydate" timestamptz,
    "exitdate" timestamptz,
    "primarycountycd" varchar(50),
    "primaryteamid" uuid,
    "primarylocationid" uuid,
    "secondarylocationid" uuid,
    "jobtitlecd" varchar(50),
    "unitsupervisorid" varchar(50),
    "cwlastlogindatetime" timestamp,
    PRIMARY KEY ("securityusersid")
);

-- Model(s): Userprofileaddress
CREATE TABLE IF NOT EXISTS "cjams"."userprofileaddress" (
    "userprofileaddressid" uuid,
    "securityusersid" uuid,
    "activeflag" integer,
    "userprofileaddresstypekey" varchar(15),
    "address" varchar(100),
    "zipcode" varchar(32),
    "pobox" integer,
    "city" varchar(32),
    "state" varchar(32),
    "country" varchar(32),
    "countyid" uuid,
    "updatedon" timestamp,
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "zipcodeplus" varchar(32),
    "county" varchar(32),
    "insertedby" varchar(50),
    "updatedby" varchar(50)
);

-- Model(s): Userprofileidentifier
CREATE TABLE IF NOT EXISTS "cjams"."userprofileidentifier" (
    "userprofileidentifierid" uuid,
    "securityusersid" uuid,
    "userprofileidentifiertypekey" varchar(15),
    "userprofileidentifiervalue" varchar(50),
    "activeflag" integer,
    "old_id" varchar(50),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp
);

-- Model(s): Userprofilephonenumber
CREATE TABLE IF NOT EXISTS "cjams"."userprofilephonenumber" (
    "userprofilephonenumberid" uuid,
    "securityusersid" uuid,
    "activeflag" integer,
    "userprofiletypekey" varchar(15),
    "phonenumber" varchar(32),
    "phoneextension" varchar(8),
    "reversephonenumber" varchar(32),
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid
);

-- Model(s): Userprofilephonetype
CREATE TABLE IF NOT EXISTS "cjams"."userprofilephonetype" (
    "sequencenumber" integer,
    "userprofiletypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "voidedby" varchar(50),
    "voidedon" timestamp,
    "voidreasonid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("userprofiletypekey")
);

-- Model(s): Userreference
CREATE TABLE IF NOT EXISTS "cjams"."userreference" (
    "userreferenceid" uuid DEFAULT gen_random_uuid(),
    "securityusersid" varchar(50),
    "objectid" varchar(50),
    "objecttypekey" varchar(25),
    "casenumber" varchar(25),
    "legalguardian" varchar(100),
    "worker" varchar(100),
    "receiveddate" timestamp,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("userreferenceid")
);

-- Model(s): Userresource
CREATE TABLE IF NOT EXISTS "cjams"."userresource" (
    "userresourceid" uuid DEFAULT gen_random_uuid(),
    "userid" uuid,
    "permissiongroupid" uuid,
    "roleid" uuid,
    "resourceid" uuid,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "isallowed" boolean,
    "isvisible" boolean,
    "old_id" varchar(50),
    PRIMARY KEY ("userresourceid")
);

-- Model(s): Usertype
CREATE TABLE IF NOT EXISTS "cjams"."usertype" (
    "sequencenumber" integer,
    "usertypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("usertypekey")
);

-- Model(s): Userworkstatustype
CREATE TABLE IF NOT EXISTS "cjams"."userworkstatustype" (
    "sequencenumber" integer,
    "userworkstatustypekey" varchar(15),
    "activeflag" integer,
    "datavalue" integer,
    "editable" integer,
    "typedescription" varchar(250),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" bytea,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    PRIMARY KEY ("userworkstatustypekey")
);

-- Model(s): Visitationlog
CREATE TABLE IF NOT EXISTS "cjams"."visitationlog" (
    "visitationlogid" uuid,
    "visitdate" timestamp,
    "courtorderedflag" integer,
    "visitstatustypekey" varchar(50),
    "otherparticipants" varchar(500),
    "supervisedflag" integer,
    "supervisecomments" varchar(500),
    "visitlocation" varchar(500),
    "visitcomments" varchar(500),
    "caseid" uuid,
    "insertedon" timestamp,
    "insertedby" varchar(50),
    "updatedon" timestamp,
    "updatedby" varchar(50),
    "referralid" uuid,
    "activeflag" integer,
    "personid" uuid,
    "datavalidflag" integer,
    "clientmergeid" uuid,
    "old_id" varchar(50)
);

-- Model(s): Visitationlogclient
CREATE TABLE IF NOT EXISTS "cjams"."visitationlogclient" (
    "visitlogclntid" uuid DEFAULT gen_random_uuid(),
    "visitationlogid" uuid,
    "personid" uuid,
    "collateralid" uuid,
    "insertedon" timestamp,
    "insertedby" varchar(50),
    "updatedon" timestamp,
    "updatedby" varchar(50),
    "activeflag" integer,
    "datavalidflag" integer,
    "clientmergeid" uuid,
    "old_id" varchar(50),
    PRIMARY KEY ("visitlogclntid")
);

-- Model(s): Visitationplan
CREATE TABLE IF NOT EXISTS "cjams"."visitationplan" (
    "visitationplanid" uuid,
    "personid" uuid,
    "clientmergeid" uuid,
    "caseid" uuid,
    "referralid" uuid,
    "visitfrequencytypekey" varchar(50),
    "visitdurationtypekey" varchar(50),
    "visittypekey" varchar(50),
    "planexplain" varchar(500),
    "planlocation" varchar(500),
    "supervisecomments" varchar(500),
    "childtransportationtypekey" varchar(50),
    "transportexplain" varchar(500),
    "visitortransportationtypekey" varchar(50),
    "visitortransportexplain" varchar(500),
    "frequencyexplain" varchar(500),
    "activeflag" integer,
    "courtorderedflag" integer,
    "supervisedflag" integer,
    "visitnotallowedflag" integer,
    "datavalidflag" integer,
    "establisheddate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "enddate" timestamp,
    "old_id" varchar(50)
);

-- Model(s): Visitationplanclients
CREATE TABLE IF NOT EXISTS "cjams"."visitationplanclients" (
    "visitationplanid" uuid,
    "personid" uuid,
    "clientmergeid" uuid,
    "visitplanclntid" uuid,
    "collateralid" uuid,
    "activeflag" integer,
    "datavalidflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "old_id" varchar(50)
);

-- Model(s): Withhold_eft_config
CREATE TABLE IF NOT EXISTS "cjams"."withhold_eft_config" (
    "withholdeftconfigid" uuid,
    "withhold_payment_sw" varchar(5),
    "eft_sw" varchar(5),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "provider_id" integer,
    "withhold_reason" text,
    "withhold_question" varchar(5)
);

-- Model(s): YouthTransitionPlan
CREATE TABLE IF NOT EXISTS "cjams"."youthtransitionplan" (
    "youthtransitionplanid" uuid,
    "startdate" timestamp,
    "enddate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "completiondate" timestamp,
    "approvaldate" timestamp,
    "nextduedate" timestamp,
    "summary_json" json,
    "new_summary_json" json,
    "new_education_json" json,
    "new_employ_json" json,
    "new_transportation_json" json,
    "new_documentation_json" json,
    "new_financial_empowerment_json" json,
    "new_housing_json" json,
    "new_community_json" json,
    "new_health_json" json,
    "new_connections_json" json,
    "new_meeting_json" json,
    "newfcgschecklistjson" json,
    "documentation_json" json,
    "sracc_json" json,
    "health_json" json,
    "moneymanagement_json" json,
    "housing_json" json,
    "education_json" json,
    "employment_json" json,
    "youththoughts_json" json,
    "copyofplanjson" json,
    "approvalstatuskey" varchar(2000),
    "returnreason" varchar(2000),
    "clientid" uuid,
    "intakeserviceid" uuid,
    "sevicecaseid" uuid
);

-- Model(s): YouthTransitionPlanServicePlanMap
CREATE TABLE IF NOT EXISTS "cjams"."youthtransitionplanserviceplanmap" (
    "youthtransitionplanid" uuid,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "serviceplanid" uuid
);

-- Model(s): Zipcode
CREATE TABLE IF NOT EXISTS "cjams"."zipcode" (
    "citycode" varchar(100),
    "zipcd" integer,
    "insertedby" uuid,
    "insertedon" timestamp,
    "updatedby" uuid,
    "updatedon" timestamp,
    "activeflag" integer,
    "old_id" varchar(50)
);

-- Model(s): helpdocuments
CREATE TABLE IF NOT EXISTS "defecttracking"."helpdocuments" (
    "helpdocumentsid" uuid,
    "title" text,
    "filename" text,
    "filetype" varchar(50),
    "category" varchar(50),
    "subcategory" varchar(50),
    "description" varchar(500),
    "filecontent" bytea,
    "mime" varchar(150),
    "meta" varchar(500),
    "encoding" varchar(50),
    "numberofbytes" integer,
    "effectivestartdate" timestamp,
    "searchkey" text,
    "insertedon" timestamp,
    "insertedby" text,
    "updatedon" timestamp,
    "updatedby" varchar(100),
    "activeflag" integer
);

-- Model(s): Supportlog, Releasenotes
CREATE TABLE IF NOT EXISTS "defecttracking"."supportlog" (
    "supportlogid" uuid,
    "application" varchar(10),
    "supportno" varchar(50),
    "jirarequestsent" text,
    "status" varchar(50),
    "ldssregion" varchar(50),
    "officelocation" varchar(50),
    "clientid" varchar(50),
    "subject" varchar(250),
    "notes" text,
    "priority" text,
    "jiraenv" text,
    "pageurl" varchar(500),
    "pagename" varchar(50),
    "severity" varchar(50),
    "issuetype" varchar(50),
    "jirarequestno" varchar(50),
    "environment" varchar(50),
    "buildname" varchar(255),
    "versionnumber" varchar(10),
    "frommailid" varchar(250),
    "tomailid" varchar(250),
    "emailbody" text,
    "emailsubject" varchar(500),
    "supportlogdate" timestamp,
    "ismailsent" integer,
    "requestdata" json,
    "responsedata" json,
    "tokenid" varchar(100),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    "expirationdate" timestamp,
    "caseid" varchar(50),
    "program" varchar(100),
    "focus" varchar(100),
    "approvedsupervisorid" uuid,
    "caseworkerdefaultsupervisorid" uuid
);

-- Model(s): Supportlogfiles
CREATE TABLE IF NOT EXISTS "defecttracking"."supportlogfiles" (
    "supportlogfilesid" uuid DEFAULT gen_random_uuid(),
    "supportlogid" uuid,
    "filaname" varchar(200),
    "filedata" bytea,
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "old_id" varchar(50),
    "expirationdate" timestamp,
    "fileurl" text,
    PRIMARY KEY ("supportlogfilesid")
);

-- Model(s): Welfarelog
CREATE TABLE IF NOT EXISTS "defecttracking"."welfarelog" (
    "id" integer,
    "request" varchar(255),
    "verb" varchar(50),
    "requestdata" text,
    "errormsg" text,
    "stacktrace" text,
    "responsestatuscode" varchar(50),
    "insertedon" timestamp,
    "tokenid" varchar(100),
    PRIMARY KEY ("id")
);

-- Model(s): Provider_uir
CREATE TABLE IF NOT EXISTS "prov"."provider_uir" (
    "provider_uir_id" uuid DEFAULT gen_random_uuid(),
    "provider_id" integer,
    "uir_no" varchar(50),
    "licence_type" varchar(255),
    "level_supervision" varchar(255),
    "location_incident" varchar(255),
    "location_area" varchar(255),
    "location_area_other" varchar(255),
    "incident_datetime" timestamp,
    "incident_date" timestamp,
    "incident_time" varchar(255),
    "is_classthreeincident" integer,
    "additional_youth_info" varchar(255),
    "class3_brief_desc" varchar(255),
    "program_nm" varchar(255),
    "discovered_datetime" timestamp,
    "active_flag" integer,
    "inserted_by" varchar(50),
    "inserted_on" timestamp,
    "updated_by" varchar(50),
    "updated_on" timestamp,
    "effective_date" timestamp,
    "old_id" varchar(50),
    "narrative_before_incident" text,
    "narrative_incident_occur" text,
    "narrative_during_incident" text,
    "narrative_after_incident" text,
    "role_incident" integer,
    "restraint_typekey" varchar(50),
    "duration_restraint" integer,
    "duration_restraint_other" text,
    "is_de_escalation" boolean,
    "is_seen_medical" boolean,
    "is_injury_sustained" boolean,
    "injury_severity_rating" integer,
    "is_injury_result" boolean,
    "is_seclusion" boolean,
    "duration_seclusion" integer,
    "is_staff_assaulted" boolean,
    "uir_status" varchar(50),
    "notifiy_is_attach" boolean,
    "notifiy_attach_other" varchar(50),
    "notification_comments" text,
    "notifiy_staff_member" varchar(50),
    "notifiy_signdatetime" timestamp,
    "precipitate_event" varchar(50),
    "gang_related_explain" text,
    "gang_incident_videotapped" integer,
    "gang_support_evidence" text,
    "notification" text,
    PRIMARY KEY ("provider_uir_id")
);

-- Model(s): Provider_uir_actor_detail
CREATE TABLE IF NOT EXISTS "prov"."provider_uir_actor_detail" (
    "provider_uir_actor_detail_id" uuid DEFAULT gen_random_uuid(),
    "provider_uir_id" uuid,
    "uir_actor_type" varchar(50),
    "first_name" varchar(255),
    "last_name" varchar(255),
    "title" varchar(255),
    "address" varchar(255),
    "phone_no" varchar(255),
    "gender" varchar(255),
    "dob" timestamp,
    "youth_identifier" varchar(255),
    "placing_agency" varchar(255),
    "inserted_by" varchar(50),
    "inserted_on" timestamp,
    "updated_by" varchar(50),
    "updated_on" timestamp,
    "active_flag" integer,
    "effective_date" timestamp,
    "old_id" varchar(50),
    "admitting_charge" varchar(255),
    "identifier_no" varchar(255),
    "provider_id" varchar(255),
    PRIMARY KEY ("provider_uir_actor_detail_id")
);

-- Model(s): Provider_uir_actor_involved
CREATE TABLE IF NOT EXISTS "prov"."provider_uir_actor_involved" (
    "provider_uir_actor_involved_id" uuid DEFAULT gen_random_uuid(),
    "provider_uir_id" uuid,
    "provider_staff_id" integer,
    "provider_uir_actor_detail_id" uuid,
    "role_incident" integer,
    "restraint_typekey" varchar(50),
    "duration_phiscial_restraint" integer,
    "duration_phiscial_restraint_other" text,
    "is_de_escalation" boolean,
    "is_intervention" boolean,
    "is_leaving_supervision" boolean,
    "is_prevention" boolean,
    "is_flexcuff" boolean,
    "is_legiron" boolean,
    "is_helmets" boolean,
    "is_handcuff_legiron" boolean,
    "is_protective_device" boolean,
    "is_seen_medical" boolean,
    "duration_mechanical_restraint" integer,
    "duration_mechanical_restraint_other" text,
    "is_injury_sustained" boolean,
    "injury_severity_rating" integer,
    "is_injury_result" boolean,
    "is_seclusion" boolean,
    "duration_seclusion" integer,
    "is_staff_assaulted" boolean,
    "is_primary_staff_involved" boolean,
    "inserted_by" varchar(50),
    "inserted_on" timestamp,
    "updated_by" varchar(50),
    "updated_on" timestamp,
    "active_flag" integer,
    "effective_date" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("provider_uir_actor_involved_id")
);

-- Model(s): Provider_uir_classincident
CREATE TABLE IF NOT EXISTS "prov"."provider_uir_classincident" (
    "provider_uir_classincident_id" uuid DEFAULT gen_random_uuid(),
    "provider_uir_id" uuid,
    "class1_typekey" varchar(50),
    "class2_typekey" varchar(50),
    "class3_typekey" varchar(50),
    "other_class3" varchar(50),
    "inserted_by" varchar(50),
    "inserted_on" timestamp,
    "updated_by" varchar(50),
    "updated_on" timestamp,
    "activeflag" integer,
    "effective_date" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("provider_uir_classincident_id")
);

-- Model(s): Provider_uir_contact_detail
CREATE TABLE IF NOT EXISTS "prov"."provider_uir_contact_detail" (
    "provider_uir_contact_detail_id" uuid DEFAULT gen_random_uuid(),
    "provider_uir_id" varchar(255),
    "firstname" varchar(255),
    "lastname" varchar(255),
    "phonenumber" varchar(255),
    "email" varchar(50),
    "uir_no" varchar(50),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("provider_uir_contact_detail_id")
);

-- Model(s): Provider_uir_incident_detail
CREATE TABLE IF NOT EXISTS "prov"."provider_uir_incident_detail" (
    "provider_uir_incident_detail_id" uuid DEFAULT gen_random_uuid(),
    "provider_uir_id" uuid,
    "incident_type" varchar(50),
    "incident_precipitating_event" varchar(50),
    "other_class3" varchar(50),
    "incident_level_of_supervision" integer,
    "incident_location" varchar(50),
    "incident_area" varchar(50),
    "incident_date" timestamp,
    "incident_time" varchar(50),
    "discovered_date" timestamp,
    "discovered_time" varchar(50),
    "precipitating_event" varchar(100),
    "uir_no" varchar(50),
    "inserted_by" varchar(50),
    "inserted_on" timestamp,
    "updated_by" varchar(50),
    "updated_on" timestamp,
    "activeflag" integer,
    PRIMARY KEY ("provider_uir_incident_detail_id")
);

-- Model(s): provider_uir_lawenforcement_detail
CREATE TABLE IF NOT EXISTS "prov"."provider_uir_lawenforcement_detail" (
    "provider_uir_lawenforcement_detail_id" uuid DEFAULT gen_random_uuid(),
    "provider_uir_id" uuid,
    "report_number" varchar(255),
    "date" timestamp,
    "time" varchar(255),
    "contact_first_name" varchar(255),
    "contact_last_name" varchar(255),
    "phone_no" varchar(255),
    "uir_no" varchar(50),
    "inserted_by" varchar(50),
    "inserted_on" timestamp,
    "updated_by" varchar(50),
    "updated_on" timestamp,
    "active_flag" integer,
    PRIMARY KEY ("provider_uir_lawenforcement_detail_id")
);

-- Model(s): Provider_uir_notification
CREATE TABLE IF NOT EXISTS "prov"."provider_uir_notification" (
    "provider_uir_notification_id" uuid DEFAULT gen_random_uuid(),
    "provider_uir_id" uuid,
    "notification_type" varchar(50),
    "services_name" varchar(255),
    "notifcation_name" varchar(255),
    "notifcation_datetime" timestamp,
    "notifcation_received" boolean,
    "notifcation_comments" text,
    "method_type" varchar(255),
    "inserted_by" varchar(50),
    "inserted_on" timestamp,
    "updated_by" varchar(50),
    "updated_on" timestamp,
    "active_flag" integer,
    "effective_date" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("provider_uir_notification_id")
);

-- Model(s): Provider_uir_staff_config
CREATE TABLE IF NOT EXISTS "prov"."provider_uir_staff_config" (
    "provider_uir_staff_config_id" uuid DEFAULT gen_random_uuid(),
    "provider_uir_id" uuid,
    "provider_staff_id" integer,
    "inserted_by" varchar(50),
    "inserted_on" timestamp,
    "updated_by" varchar(50),
    "updated_on" timestamp,
    "active_flag" integer,
    "effective_date" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("provider_uir_staff_config_id")
);

-- Model(s): Provider_uir_supervisory
CREATE TABLE IF NOT EXISTS "prov"."provider_uir_supervisory" (
    "provider_uir_supervisory_id" uuid DEFAULT gen_random_uuid(),
    "provider_uir_id" uuid,
    "supervisor_comments" text,
    "supervisor_name" varchar(255),
    "supervisor_signdate" timestamp,
    "is_section_filledout" boolean,
    "is_supervisor_comments" boolean,
    "is_youth_witness" boolean,
    "is_notification" boolean,
    "is_nurses_reports" boolean,
    "is_signed_dates" boolean,
    "is_check_spelling" boolean,
    "is_comments_location" boolean,
    "is_addition_support" boolean,
    "is_incident_report" boolean,
    "other_section_filledout" text,
    "other_supervisor_comments" text,
    "other_youth_witness" text,
    "other_notification" text,
    "other_nurses_reports" text,
    "other_signed_dates" text,
    "other_check_spelling" text,
    "other_comments_location" text,
    "other_addition_support" text,
    "other_incident_report" text,
    "completed_by_name" varchar(255),
    "completed_by_date" timestamp,
    "inserted_by" varchar(50),
    "inserted_on" timestamp,
    "updated_by" varchar(50),
    "updated_on" timestamp,
    "active_flag" integer,
    "effective_date" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("provider_uir_supervisory_id")
);

-- Model(s): Provider_uir_witness
CREATE TABLE IF NOT EXISTS "prov"."provider_uir_witness" (
    "provider_uir_witness_id" uuid DEFAULT gen_random_uuid(),
    "provider_uir_id" uuid,
    "first_name" varchar(255),
    "last_name" varchar(255),
    "actor_type_id" integer,
    "other_actor_type" varchar(255),
    "witness_statement" text,
    "inserted_by" varchar(50),
    "inserted_on" timestamp,
    "updated_by" varchar(50),
    "updated_on" timestamp,
    "active_flag" integer,
    "effective_date" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("provider_uir_witness_id")
);

-- Model(s): Provider_uir_youth_detail
CREATE TABLE IF NOT EXISTS "prov"."provider_uir_youth_detail" (
    "provider_uir_youth_detail_id" uuid DEFAULT gen_random_uuid(),
    "provider_uir_id" varchar(255),
    "uir_no" varchar(255),
    "provider_uir_actor_id" varchar(255),
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "activeflag" integer,
    "provider_id" varchar(255),
    PRIMARY KEY ("provider_uir_youth_detail_id")
);

-- Model(s): Providerorientationtraining
CREATE TABLE IF NOT EXISTS "prov"."providerorientationtraining" (
    "orientation_training_id" uuid DEFAULT gen_random_uuid(),
    "training_number" varchar(50),
    "training_type" varchar(50),
    "jurisdiction" varchar(50),
    "training_topic" varchar(500),
    "training_date" date,
    "start_datetime" timestamp,
    "end_datetime" timestamp,
    "duration" integer,
    "medium" varchar(50),
    "addr_line1" varchar(50),
    "addr_line2" varchar(50),
    "addr_city" varchar(50),
    "room_no" varchar(50),
    "training_status" varchar(50),
    "addr_state" varchar(50),
    "addr_zip" varchar(50),
    "training_url" varchar(250),
    "narrative" varchar(2500),
    "instructor_1" uuid,
    "instructor_2" uuid,
    "session_no" varchar(255),
    "create_ts" varchar(30),
    "session_type" varchar(50),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    PRIMARY KEY ("orientation_training_id")
);

-- Model(s): Providerorientationtrainingattendance
CREATE TABLE IF NOT EXISTS "prov"."providerorientationtrainingattendance" (
    "orientation_training_attendance_id" uuid DEFAULT gen_random_uuid(),
    "training_number" varchar(50),
    "orientation_training_id" uuid,
    "object_id" varchar(50),
    "phase" varchar(50),
    "attendee_first_nm" varchar(150),
    "attendee_last_nm" varchar(150),
    "is_intent_to_attend" boolean,
    "is_attended" boolean,
    "narrative" varchar(2500),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "update_user_id" varchar(50),
    "delete_sw" varchar(1),
    PRIMARY KEY ("orientation_training_attendance_id")
);

-- Model(s): Providerportalrequest
CREATE TABLE IF NOT EXISTS "prov"."providerportalrequest" (
    "request_id" varchar(255),
    "signimage" varchar(255),
    "request_no" varchar(255),
    "provider_id" varchar(255),
    "request_type" varchar(255),
    "request_comments" varchar(255),
    "license_no" varchar(255),
    "site_id" varchar(255),
    "min_age_from" varchar(255),
    "max_age_from" varchar(255),
    "gender_from" varchar(255),
    "children_no_from" varchar(255),
    "min_age_to" varchar(255),
    "gender_to" varchar(255),
    "children_no_to" varchar(255),
    "max_age_to" varchar(255),
    "update_user_id" varchar(50),
    "update_ts" timestamp,
    "create_user_id" varchar(50),
    "create_ts" timestamp,
    "delete_sw" char(1),
    "request_expirationdate" timestamp,
    "request_effectivedate" timestamp,
    "dob" timestamp,
    "request_date" timestamp,
    "zip_no" integer,
    "program_address" varchar(255),
    "comar_citation" varchar(255),
    "program_phone" varchar(255),
    "program_fax" varchar(255),
    "variance_type" varchar(255),
    "waiver_type" varchar(255),
    "state" varchar(255),
    "city" varchar(255),
    "completing_person_name" varchar(255),
    "person_name" varchar(255),
    "gender" varchar(255),
    "reason_for_request_variance" varchar(255),
    "reason_for_request_waiver" varchar(255),
    "alternate_measures" varchar(255)
);

-- Model(s): Providerportalrequestnarrative
CREATE TABLE IF NOT EXISTS "prov"."providerportalrequestnarrative" (
    "request_narrative_id" varchar(255),
    "request_no" varchar(255),
    "request_comments" varchar(255),
    "request_narrative_by" varchar(255),
    "update_user_id" varchar(50),
    "update_ts" timestamp,
    "create_user_id" varchar(50),
    "create_ts" timestamp,
    "delete_sw" char(1),
    PRIMARY KEY ("request_narrative_id")
);

-- Model(s): Providerstaff
CREATE TABLE IF NOT EXISTS "prov"."providerstaff" (
    "provider_staff_id" uuid DEFAULT gen_random_uuid(),
    "object_id" varchar(50),
    "first_nm" varchar(150),
    "middle_nm" varchar(50),
    "last_nm" varchar(150),
    "affiliation_type" varchar(100),
    "job_title" varchar(100),
    "employee_type" varchar(100),
    "start_date" varchar(50),
    "end_date" varchar(50),
    "reason_for_leaving" varchar(50),
    "behavioral_interventions_training" varchar(50),
    "cps_clearance_request_date" varchar(50),
    "cps_clearance_result_date" varchar(50),
    "cps_rcc_compliant" varchar(50),
    "cps_cpa_compliant" varchar(50),
    "federal_clearance_request_date" varchar(50),
    "federal_clearance_result_date" varchar(50),
    "federal_rcc_compliant" varchar(50),
    "federal_cpa_compliant" varchar(50),
    "state_clearance_request_date" varchar(50),
    "state_clearance_result_date" varchar(50),
    "state_rcc_compliant" varchar(50),
    "state_cpa_compliant" varchar(50),
    "rcc_certificate_type" varchar(50),
    "rcc_certificate_due_date" varchar(50),
    "rcc_date_application_mailed" varchar(50),
    "rcc_date_tested" varchar(50),
    "rcc_certification_effective_date" varchar(50),
    "staff_comment" varchar(500),
    "rcc_certification_number" varchar(50),
    "rcc_certification_renewal_date" varchar(50),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "delete_sw" varchar(1),
    "update_user_id" varchar(50),
    "groupinglog" integer,
    PRIMARY KEY ("provider_staff_id")
);

-- Model(s): Providerstaffconfig
CREATE TABLE IF NOT EXISTS "prov"."providerstaffconfig" (
    "provider_staff_config_id" uuid DEFAULT gen_random_uuid(),
    "object_id" varchar(50),
    "provider_staff_id" uuid,
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(50),
    "delete_sw" varchar(1),
    "update_user_id" varchar(50),
    PRIMARY KEY ("provider_staff_config_id")
);

-- Model(s): Providersubtypeconfig
CREATE TABLE IF NOT EXISTS "prov"."providersubtypeconfig" (
    "providersubtypeconfigid" uuid DEFAULT gen_random_uuid(),
    "servicesubtypekey" varchar(100),
    "rate" numeric(5,2),
    "providerid" uuid,
    "rank" integer,
    "effectivedate" timestamp,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "updatedby" varchar(50),
    "activeflag" integer,
    "old_id" varchar(50),
    PRIMARY KEY ("providersubtypeconfigid")
);

-- Model(s): Providertraininginstructor
CREATE TABLE IF NOT EXISTS "prov"."providertraininginstructor" (
    "instructor_id" uuid DEFAULT gen_random_uuid(),
    "create_ts" timestamp,
    "create_user_id" varchar(50),
    "update_ts" timestamp,
    "delete_sw" varchar(1),
    "update_user_id" varchar(50),
    "active_flag" integer,
    "instructor_first_nm" varchar(50),
    "instructor_middle_nm" varchar(50),
    "instructor_last_nm" varchar(50),
    PRIMARY KEY ("instructor_id")
);

-- Model(s): Providercontractprogram
CREATE TABLE IF NOT EXISTS "prov"."tb_contract_program" (
    "program_id" integer,
    "contract_id" integer,
    "program_nm" varchar(255),
    "start_dt" date,
    "end_dt" date,
    "capacity_percentage_no" date,
    "contract_beds_no" date,
    "vacancy_no" date,
    "preferred_cd" date,
    "program_status_cd" date,
    "admission_comments_tx" date,
    "create_ts" date,
    "create_user_id" date,
    "update_user_id" date,
    "update_ts" varchar(255),
    "delete_sw" varchar(255),
    "program_purpose_cd" varchar(255),
    "child_specific_agreement_cd" varchar(255),
    "child_specific_update_staff_id" varchar(255),
    "child_specific_change_ts" varchar(255),
    "license_no" varchar(255),
    "row_lock" varchar(50),
    PRIMARY KEY ("program_id")
);

-- Model(s): Tb_prov_program_facility
CREATE TABLE IF NOT EXISTS "prov"."tb_prov_program_facility" (
    "facility_id" integer,
    "program_id" integer,
    "provider_id" integer,
    "related_site_id" integer,
    "end_dt" date,
    "start_dt" date,
    "create_user_id" varchar(10),
    "update_user_id" varchar(10),
    "delete_sw" char(1),
    "create_ts" timestamp,
    "update_ts" timestamp,
    PRIMARY KEY ("facility_id")
);

-- Model(s): Tb_provider
CREATE TABLE IF NOT EXISTS "prov"."tb_provider" (
    "provider_id" integer,
    "mail_code_tx" varchar(20),
    "prov_tax_type_cd" varchar(5),
    "tax_id_no" numeric(5,2),
    "indicator_1099_sw" char(1),
    "medicaid_sw" char(1),
    "withhold_payment_sw" char(1),
    "admission_comments_tx" varchar(500),
    "provider_category_cd" varchar(5),
    "conversion_no_tx" integer,
    "source_tx" varchar(20),
    "provider_status_cd" varchar(5),
    "paid_sw" char(1),
    "profit_sw" char(1),
    "provider_nm" varchar(100),
    "provider_prefix_cd" varchar(5),
    "provider_first_nm" varchar(20),
    "provider_middle_nm" varchar(10),
    "provider_last_nm" varchar(20),
    "provider_suffix_cd" varchar(5),
    "business_start_tm" varchar(12),
    "business_end_tm" varchar(12),
    "medical_license_no_tx" varchar(20),
    "medical_speciality_tx" varchar(100),
    "school_district_tx" varchar(20),
    "county_cd" varchar(20),
    "collecting_entity_cd" varchar(5),
    "vacancy_no" integer,
    "pay_to_affiliate_cd" varchar(5),
    "dob_dt" date,
    "ref_contact_prefix_cd" varchar(5),
    "ref_contact_first_nm" varchar(20),
    "ref_contact_middle_nm" varchar(10),
    "ref_contact_last_nm" varchar(20),
    "ref_contact_suffix_cd" varchar(5),
    "adm_contact_prefix_cd" varchar(5),
    "adm_contact_first_nm" varchar(20),
    "adm_contact_middle_nm" varchar(10),
    "adm_contact_last_nm" varchar(20),
    "adm_contact_suffix_cd" varchar(5),
    "adr_work_phone_tx" varchar(10),
    "adr_work_xtn_tx" varchar(5),
    "adr_home_phone_tx" varchar(10),
    "adr_pager_tx" varchar(20),
    "adr_email_tx" varchar(100),
    "adr_fax_tx" varchar(10),
    "adr_cell_phone_tx" varchar(10),
    "adr_url_tx" varchar(100),
    "adr_other_contact_tx" varchar(500),
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "affiliate_provider_id" integer,
    "co_prefix_cd" varchar(5),
    "co_first_nm" varchar(20),
    "co_middle_nm" varchar(10),
    "co_last_nm" varchar(20),
    "co_suffix_cd" varchar(5),
    "co_ssn_no" numeric(5,2),
    "co_dob_dt" date,
    "provider_type_cd" varchar(5),
    "ive_reimbursable_sw" char(1),
    "accept_plcmnt_ref_sw" char(1),
    "ref_work_phone_tx" varchar(10),
    "ref_work_xtn_tx" char(1),
    "ref_home_phone_tx" varchar(10),
    "ref_pager_tx" varchar(20),
    "ref_email_tx" varchar(100),
    "ref_fax_tx" varchar(10),
    "ref_cell_phone_tx" varchar(10),
    "ref_url_tx" varchar(100),
    "ref_other_contact_tx" varchar(500),
    "adm_work_phone_tx" varchar(10),
    "adm_work_xtn_tx" char(5),
    "adm_home_phone_tx" varchar(10),
    "adm_pager_tx" varchar(20),
    "adm_email_tx" varchar(100),
    "adm_fax_tx" varchar(10),
    "adm_cell_phone_tx" varchar(10),
    "adm_url_tx" varchar(100),
    "adm_other_contact_tx" varchar(500),
    "formatted_first_nm" varchar(20),
    "formatted_last_nm" varchar(20),
    "first_nm_soundex" char(4),
    "last_nm_soundex" char(4),
    "eft_sw" char(1),
    "formatted_middle_nm" varchar(10),
    "formatted_provider_nm" varchar(100),
    "provider_nm_soundex" char(4),
    "lnm_soundex" varchar(30),
    "fnm_soundex" varchar(30),
    "pnm_soundex" varchar(30),
    "reason_changed" varchar(200),
    "old_provider_id" integer,
    "row_lock" varchar(50),
    PRIMARY KEY ("provider_id")
);

-- Model(s): Tb_provider_address
CREATE TABLE IF NOT EXISTS "prov"."tb_provider_addresses" (
    "address_id" integer,
    "parent_key_id" varchar(255),
    "adr_type_cd" varchar(255),
    "adr_format_cd" varchar(255),
    "adr_street_no" integer,
    "adr_box_no" integer,
    "adr_pre_dir_cd" varchar(255),
    "adr_street_nm" varchar(255),
    "adr_street_suffix_cd" varchar(255),
    "adr_post_dir_cd" varchar(255),
    "adr_unit_type_cd" varchar(255),
    "adr_unit_no_tx" varchar(255),
    "adr_city_nm" varchar(255),
    "adr_county_cd" varchar(255),
    "adr_state_cd" varchar(255),
    "adr_zip5_no" integer,
    "adr_zip4_no" integer,
    "adr_direction_tx" varchar(255),
    "adr_foreign_tx" varchar(255),
    "adr_foreign_state_tx" varchar(255),
    "adr_country_tx" varchar(255),
    "adr_postal_code_tx" varchar(255),
    "adr_default_sw" varchar(255),
    "adr_start_dt" date,
    "adr_end_dt" date,
    "adr_street_tx" varchar(255),
    "create_ts" timestamp,
    "create_user_id" varchar(50),
    "update_ts" timestamp,
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    PRIMARY KEY ("address_id")
);

-- Model(s): Tb_provider_complaint
CREATE TABLE IF NOT EXISTS "prov"."tb_provider_complaint" (
    "provider_complaintid" uuid DEFAULT gen_random_uuid(),
    "intakeservreqinputtypeid" uuid,
    "complaint_source" varchar(255),
    "source_information_type" varchar(255),
    "complaint_date" timestamp,
    "investigationstartdate" timestamp,
    "investigationenddate" timestamp,
    "narrative" varchar(255),
    "complainant_firstname" varchar(255),
    "complainant_lastname" varchar(255),
    "complainant_phone" varchar(255),
    "complainant_email" varchar(255),
    "complainant_address1" varchar(255),
    "complainant_address2" varchar(255),
    "complainant_city" varchar(255),
    "complainant_state" varchar(255),
    "complainant_county" varchar(255),
    "isrouted" boolean,
    "routedusersid" varchar(255),
    "complaint_number" varchar(255),
    "routedon" varchar(255),
    "teamtype_key" varchar(255),
    "provider_id" integer,
    "site_id" integer,
    "is_draft" integer,
    "activeflag" integer,
    "effective_date" timestamp,
    "inserted_by" varchar(50),
    "inserted_on" timestamp,
    "updated_by" varchar(50),
    "updated_on" timestamp,
    "old_id" varchar(50),
    "complainant_zipcode" varchar(50),
    "source_specification" varchar(50),
    "summary" varchar(50),
    "outcomes" varchar(50),
    PRIMARY KEY ("provider_complaintid")
);

-- Model(s): Tb_provider_complaint_contacts
CREATE TABLE IF NOT EXISTS "prov"."tb_provider_complaint_contacts" (
    "provider_complaint_contactsid" uuid DEFAULT gen_random_uuid(),
    "provider_complaintid" uuid,
    "complaint_contacts_name" varchar(50),
    "complaint_contacts_source" varchar(50),
    "complainant_contacts_phone" varchar(50),
    "inserted_by" varchar(50),
    "inserted_on" timestamp,
    "updated_by" varchar(50),
    "updated_on" timestamp,
    "activeflag" integer,
    "effective_date" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("provider_complaint_contactsid")
);

-- Model(s): Tb_provider_complaint_deficiency
CREATE TABLE IF NOT EXISTS "prov"."tb_provider_complaint_deficiency" (
    "tb_provider_complaint_deficiencyid" uuid DEFAULT gen_random_uuid(),
    "provider_complaintid" uuid,
    "deficiency_violationname" varchar(50),
    "citation" text,
    "comments" text,
    "frequencyofdeficiency" varchar(50),
    "impactofdeficiency" varchar(50),
    "scopeofdeficiency" varchar(50),
    "findings" text,
    "inserted_by" varchar(50),
    "inserted_on" timestamp,
    "updated_by" varchar(50),
    "updated_on" timestamp,
    "activeflag" integer,
    "effective_date" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("tb_provider_complaint_deficiencyid")
);

-- Model(s): Tb_provider_complaint_notes
CREATE TABLE IF NOT EXISTS "prov"."tb_provider_complaint_notes" (
    "provider_complaint_notesid" uuid DEFAULT gen_random_uuid(),
    "provider_complaint_contactsid" uuid,
    "complaint_notes_date" timestamp,
    "complaint_notes_method_of_contact" varchar(50),
    "complaint_notes_note" text,
    "inserted_by" varchar(50),
    "inserted_on" timestamp,
    "updated_by" varchar(50),
    "updated_on" timestamp,
    "activeflag" integer,
    "effective_date" timestamp,
    "old_id" varchar(50),
    "include_in_summary" boolean,
    PRIMARY KEY ("provider_complaint_notesid")
);

-- Model(s): Tb_provider_services
CREATE TABLE IF NOT EXISTS "prov"."tb_provider_services" (
    "provider_service_id" integer,
    "provider_id" integer,
    "program_id" integer,
    "service_id" numeric(5,2),
    "start_dt" date,
    "end_dt" date,
    "create_ts" varchar(30),
    "create_user_id" varchar(50),
    "update_ts" varchar(30),
    "update_user_id" varchar(50),
    "delete_sw" char(1),
    "primary_sw" char(1),
    "location_sw" char(1),
    "paid_cd" varchar(50),
    PRIMARY KEY ("provider_service_id")
);

-- Model(s): Tb_provider_userconfig
CREATE TABLE IF NOT EXISTS "prov"."tb_provider_userconfig" (
    "provider_userconfig_id" uuid DEFAULT gen_random_uuid(),
    "provider_id" integer,
    "applicant_id" varchar(255),
    "securityusers_id" uuid,
    "activeflag" integer,
    "inserted_on" timestamp,
    "inserted_by" varchar(50),
    "updated_on" timestamp,
    "updated_by" varchar(50),
    "effective_date" timestamp,
    "expiration_date" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("provider_userconfig_id")
);

-- Model(s): Tb_services
CREATE TABLE IF NOT EXISTS "prov"."tb_services" (
    "service_id" integer,
    "service_nm" varchar(50),
    "payment_category_cd" varchar(5),
    "placement_sw" varchar(1),
    "affiliated_sw" varchar(1),
    "support_sw" varchar(1),
    "create_ts" varchar(30),
    "create_user_id" varchar(10),
    "update_ts" varchar(30),
    "update_user_id" varchar(10),
    "delete_sw" varchar(1),
    "educational_sw" varchar(1),
    "structure_service_cd" varchar(5),
    "state_ldss_cd" varchar(5),
    "active_sw" varchar(1),
    "placement_structure_id" integer,
    "paid_non_paid_cd" varchar(5),
    "service_category_cd" varchar(5),
    "comar_sw" varchar(1),
    "child_account_sw" varchar(1),
    "iv_e_allowable_sw" varchar(1),
    PRIMARY KEY ("service_id")
);

-- ===== Supplemental tables (not declared by any api-master model; needed for db-master's day-zero
-- seed data to load). Columns inferred from db-master seed-script INSERT column lists, not from
-- an authoritative CREATE TABLE source -- double check types/constraints before relying on these. =====

CREATE TABLE IF NOT EXISTS "cjams"."tb_batch_master" (
    "batch_master_id" integer NOT NULL,
    "batch_nm" varchar(255),
    "dependent_master_id" integer,
    "batch_desc_tx" text,
    "active_sw" varchar(1),
    "frequency" varchar(10),
    "scheduled_tm" varchar(20),
    "threshold_tm" integer,
    "threshold_cutoff_tm" integer,
    "alert_cd" varchar(20),
    "email_sw" varchar(1),
    "comments_tx" text,
    "batch_detail_desc_tx" text,
    "help_failure_tx" text,
    "dependencies_desc_tx" text,
    "module_cd" varchar(50),
    PRIMARY KEY ("batch_master_id")
);

CREATE TABLE IF NOT EXISTS "cjams"."tb_batch_log" (
    "batch_log_id" integer NOT NULL,
    "batch_master_id" integer,
    "success_sw" varchar(1),
    "run_dt" date,
    "comments_tx" text,
    "start_ts" timestamptz,
    "end_ts" timestamptz,
    PRIMARY KEY ("batch_log_id")
);

CREATE TABLE IF NOT EXISTS "cjams"."tb_batch_sp_master" (
    "batch_sp_master_id" integer NOT NULL,
    "batch_master_id" integer,
    "sp_nm" varchar(255),
    "sp_desc_tx" text,
    "sp_call_level_cd" varchar(20),
    "comments_tx" text,
    PRIMARY KEY ("batch_sp_master_id")
);

CREATE TABLE IF NOT EXISTS "cjams"."tb_batch_sp_log" (
    "batch_sp_log_id" integer NOT NULL,
    "batch_log_id" integer,
    "batch_sp_master_id" integer,
    "success_sw" varchar(1),
    "sp_args" text,
    "comments_tx" text,
    "start_ts" timestamptz,
    "end_ts" timestamptz,
    PRIMARY KEY ("batch_sp_log_id")
);

CREATE TABLE IF NOT EXISTS "cjams"."routingstatustype" (
    "sequencenumber" integer NOT NULL,
    "routingstatustypekey" varchar(50),
    "activeflag" integer,
    "typedescription" varchar(255),
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "timestamp" timestamp,
    "insertedby" varchar(50),
    "updatedby" varchar(50),
    "insertedon" timestamp,
    "updatedon" timestamp,
    "old_id" varchar(50),
    PRIMARY KEY ("sequencenumber")
);

CREATE TABLE IF NOT EXISTS "cjams"."routingconfig" (
    "routingconfigid" uuid NOT NULL,
    "eventcode" varchar(50),
    "targetrolekey" varchar(50),
    "activeflag" integer,
    "insertedby" varchar(50),
    "insertedon" timestamp,
    "updatedby" varchar(50),
    "updatedon" timestamp,
    "effectivedate" timestamp,
    "expirationdate" timestamp,
    "targetteamtypekey" varchar(50),
    "sourcerolekey" varchar(50),
    "old_id" varchar(50),
    "routingstatustypekey" varchar(50),
    PRIMARY KEY ("routingconfigid")
);

