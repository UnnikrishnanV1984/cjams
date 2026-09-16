SET  search_path TO cjams;

ALTER TABLE evaluationsourceagency
   ADD COLUMN countyid uuid NULL;

--ALTER TABLE tb_placement_auto_validation_log
   --ALTER COLUMN placement_auto_validation_log_id DROP DEFAULT;

ALTER TABLE tb_placement_auto_validation_log
   ALTER COLUMN placement_auto_validation_log_id SET
                  DEFAULT nextval (
                             'sq_placement_auto_validation_log'::regclass);

CREATE TABLE guardinmeetingboardmembers
(
   guardinmeetingboardmembersid    uuid NOT NULL DEFAULT gen_random_uuid (),
   guardinshipmeetingid            uuid NOT NULL,
   boardmembertype                 CHARACTER VARYING (50) NULL,
   firstname                       CHARACTER VARYING (50) NULL,
   lastname                        CHARACTER VARYING (50) NULL,
   email                           CHARACTER VARYING (50) NULL,
   phoneno                         CHARACTER VARYING (50) NULL,
   activeflag                      INTEGER NOT NULL DEFAULT 1,
   updatedby                       CHARACTER VARYING (50) NULL,
   updatedon                       TIMESTAMP (6) NULL DEFAULT now (),
   insertedby                      CHARACTER VARYING (50) NOT NULL,
   insertedon                      TIMESTAMP (6) NOT NULL DEFAULT now (),
   effectivedate                   TIMESTAMP (6) NOT NULL DEFAULT now (),
   old_id                          CHARACTER VARYING (50) NULL,
   CONSTRAINT pk_guardinmeetingboardmembers PRIMARY KEY
      (guardinmeetingboardmembersid)
      NOT DEFERRABLE INITIALLY IMMEDIATE
)
WITH (OIDS = FALSE);

ALTER TABLE persontransportation
   ADD COLUMN allegationid uuid NULL;

CREATE TABLE evaluationsourceagencyconfig
(
   sourceagencyconfigid         uuid NOT NULL DEFAULT gen_random_uuid (),
   evaluationsourcetypekey      CHARACTER VARYING (25) NOT NULL,
   evaluationsourceagencykey    CHARACTER VARYING (25) NOT NULL,
   countycode                   CHARACTER VARYING (50) NULL,
   sourceagencyconfigkey        CHARACTER VARYING (50) NULL,
   updatedby                    CHARACTER VARYING (50) NULL,
   updatedon                    TIMESTAMP (6) NULL DEFAULT now (),
   insertedby                   CHARACTER VARYING (50) NULL,
   insertedon                   TIMESTAMP (6) NULL DEFAULT now (),
   intakeservreqtypekey         CHARACTER VARYING (50) NULL
)
WITH (OIDS = FALSE);

ALTER TABLE intakeservreqadultscreentool
   ALTER COLUMN detailsofreferralcomments TYPE
                  TEXT
                  USING detailsofreferralcomments::TEXT;

ALTER TABLE personaddress
   ADD COLUMN personaddresssubtypekey CHARACTER VARYING NULL;

ALTER TABLE personaddress
   ADD COLUMN personadrstartdate TIMESTAMP (6) NULL;

ALTER TABLE personaddress
   ADD COLUMN personadrenddate TIMESTAMP (6) NULL;

ALTER TABLE personaddress
   ADD COLUMN addressstatus BOOLEAN NULL;

CREATE TABLE intakeservreqguradmeetingconfig
(
   intakeservreqguradmeetingconfigid    uuid
                                          NOT NULL DEFAULT gen_random_uuid (),
   guardinshipmeetingid                 uuid NULL,
   intakeserviceid                      uuid NULL,
   activeflag                           INTEGER NOT NULL DEFAULT 1,
   updatedby                            CHARACTER VARYING (50) NULL,
   updatedon                            TIMESTAMP (6) NULL DEFAULT now (),
   insertedby                           CHARACTER VARYING (50) NOT NULL,
   insertedon                           TIMESTAMP (6) NOT NULL DEFAULT now (),
   effectivedate                        TIMESTAMP (6) NOT NULL DEFAULT now (),
   old_id                               CHARACTER VARYING (50) NULL,
   CONSTRAINT pk_intakeservreqguradmeetingconfig PRIMARY KEY
      (intakeservreqguradmeetingconfigid)
      NOT DEFERRABLE INITIALLY IMMEDIATE
)
WITH (OIDS = FALSE);

ALTER TABLE tb_provider
   ALTER COLUMN delete_sw SET DEFAULT 'N'::bpchar;

ALTER TABLE relationshiptype
   ADD COLUMN actortypekey CHARACTER VARYING (50) NULL;

CREATE TABLE vl_locn_add_id
(
   max    INTEGER NULL
)
WITH (OIDS = FALSE);

CREATE TABLE guardinshipmeeting
(
   guardinshipmeetingid    uuid NOT NULL DEFAULT gen_random_uuid (),
   countyid                uuid NULL,
   dateofmeeting           TIMESTAMP (6) NULL,
   starttime               TIMESTAMP (6) NULL,
   endtime                 TIMESTAMP (6) NULL,
   meetingstatus           CHARACTER VARYING (50) NULL,
   meetingtype             CHARACTER VARYING (50) NULL,
   activeflag              INTEGER NOT NULL DEFAULT 1,
   updatedby               CHARACTER VARYING (50) NULL,
   updatedon               TIMESTAMP (6) NULL DEFAULT now (),
   insertedby              CHARACTER VARYING (50) NOT NULL,
   insertedon              TIMESTAMP (6) NOT NULL DEFAULT now (),
   effectivedate           TIMESTAMP (6) NOT NULL DEFAULT now (),
   old_id                  CHARACTER VARYING (50) NULL,
   CONSTRAINT pk_guardinshipmeeting PRIMARY KEY (guardinshipmeetingid)
      NOT DEFERRABLE INITIALLY IMMEDIATE
)
WITH (OIDS = FALSE);

ALTER TABLE personsexualinfo
   ALTER COLUMN infoprovidedby TYPE
                  CHARACTER VARYING (300)
                  USING infoprovidedby::CHARACTER VARYING (300);

ALTER TABLE personsexualinfo
   ALTER COLUMN birthcontrol TYPE
                  CHARACTER VARYING (500)
                  USING birthcontrol::CHARACTER VARYING (500);

ALTER TABLE personsexualinfo
   ALTER COLUMN sextransdis TYPE
                  CHARACTER VARYING (500)
                  USING sextransdis::CHARACTER VARYING (500);

ALTER TABLE investigationallegationmaltreators
   ADD COLUMN coalocationofhearing CHARACTER VARYING (100) NULL;

ALTER TABLE investigationallegationmaltreators
   ADD COLUMN csahearingheldreason CHARACTER VARYING (50) NULL;

ALTER TABLE investigationallegationmaltreators
   ADD COLUMN csalocationofhearing CHARACTER VARYING (100) NULL;

CREATE TABLE investigationform
(
   investigationformid    uuid NOT NULL DEFAULT gen_random_uuid (),
   intakeserviceid        uuid NULL,
   intakenumber           CHARACTER VARYING (50) NOT NULL,
   investigationname      CHARACTER VARYING (200) NULL,
   investigationdate      TIMESTAMP (6) NOT NULL DEFAULT now (),
   notes                  TEXT NULL,
   recommendation         TEXT NULL,
   statustypekey          CHARACTER VARYING (15) NULL,
   activeflag             INTEGER NULL DEFAULT 1,
   effectivedate          TIMESTAMP (6) NOT NULL DEFAULT now (),
   insertedby             CHARACTER VARYING (50) NULL,
   insertedon             TIMESTAMP (6) NOT NULL DEFAULT now (),
   updatedby              CHARACTER VARYING (50) NOT NULL,
   updatedon              TIMESTAMP (6) NOT NULL DEFAULT now (),
   old_id                 CHARACTER VARYING (50) NULL,
   CONSTRAINT investigationform_pkey PRIMARY KEY (investigationformid)
      NOT DEFERRABLE INITIALLY IMMEDIATE
)
WITH (OIDS = FALSE);

ALTER TABLE evaluationsource
   ADD COLUMN sourceagencyconfigkey CHARACTER VARYING (100) NULL;

ALTER TABLE guardinmeetingboardmembers
   ADD CONSTRAINT fk_guardinmeetingboardmembers_guardinshipmeetingid FOREIGN KEY
          (guardinshipmeetingid)
          REFERENCES guardinshipmeeting (guardinshipmeetingid)
             MATCH SIMPLE
             ON DELETE NO ACTION
             ON UPDATE NO ACTION
          NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE evaluationsourceagencyconfig
   ADD CONSTRAINT fk_sourceagencyconfig_typekey FOREIGN KEY
          (evaluationsourcetypekey)
          REFERENCES evaluationsourcetype (evaluationsourcetypekey)
             MATCH SIMPLE
             ON DELETE NO ACTION
             ON UPDATE NO ACTION
          NOT DEFERRABLE INITIALLY IMMEDIATE;

