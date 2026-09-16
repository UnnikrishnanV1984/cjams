alter table evaluationsourceagency add column if not exists countyid uuid;

DROP TABLE IF EXISTS evaluationsourceagencyconfig;
CREATE TABLE evaluationsourceagencyconfig
(
  sourceagencyconfigid uuid NOT NULL DEFAULT gen_random_uuid(),
  evaluationsourcetypekey character varying(25) NOT NULL,
  evaluationsourceagencykey character varying(25) NOT NULL,
  countycode character varying(50),
  sourceagencyconfigkey character varying(50),
  updatedby character varying(50),
  updatedon timestamp without time zone DEFAULT now(),
  insertedby character varying(50),
  insertedon timestamp without time zone DEFAULT now(),
  intakeservreqtypekey character varying(50),
  CONSTRAINT fk_sourceagencyconfig_typekey FOREIGN KEY (evaluationsourcetypekey)
      REFERENCES cjams.evaluationsourcetype (evaluationsourcetypekey) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);
ALTER TABLE evaluationsource ADD COLUMN IF NOT EXISTS sourceagencyconfigkey character varying(100);
ALTER TABLE relationshiptype ADD COLUMN IF NOT EXISTS actortypekey character varying(50);
alter table evaluationsourceagencyconfig add CONSTRAINT fk_sourceagencyconfig_typekey FOREIGN KEY (evaluationsourcetypekey) REFERENCES cjams.evaluationsourcetype(evaluationsourcetypekey);
---------------
ALTER TABLE persontransportation ADD COLUMN IF NOT EXISTS allegationid uuid;
--------------
ALTER TABLE personaddress  ADD COLUMN IF NOT EXISTS personaddresssubtypekey character varying;
---------------
ALTER TABLE personaddress ADD COLUMN IF NOT EXISTS personadrstartdate timestamp(6) without time zone;
ALTER TABLE personaddress ADD COLUMN IF NOT EXISTS personadrenddate timestamp(6) without time zone;
ALTER TABLE personaddress ADD COLUMN IF NOT EXISTS addressstatus boolean;
