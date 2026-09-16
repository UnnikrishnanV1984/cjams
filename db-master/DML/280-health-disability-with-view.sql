-- View: cjams.sdr_persondisability_vw

DROP VIEW cjams.sdr_persondisability_vw;

ALTER TABLE cjams.persondisability ALTER COLUMN hygienekey TYPE character varying;
ALTER TABLE cjams.persondisability ALTER COLUMN specialkey TYPE character varying;
ALTER TABLE cjams.persondisability ALTER COLUMN comments TYPE character varying;
ALTER TABLE cjams.persondisability ALTER COLUMN diagnoiseddisabilitynotes TYPE character varying;
ALTER TABLE cjams.persondisability ALTER COLUMN evaluatorname TYPE character varying;
ALTER TABLE cjams.persondisability ALTER COLUMN disabilityconditiontypekey TYPE character varying;
ALTER TABLE cjams.persondisability ALTER COLUMN disabilitytype TYPE character varying;
ALTER TABLE cjams.persondisability ALTER COLUMN disabilitytypekey TYPE character varying;


CREATE OR REPLACE VIEW cjams.sdr_persondisability_vw AS
 SELECT persondisability.persondisabilityid::character varying(100) AS persondisabilityid,
    persondisability.personid::character varying(100) AS personid,
    persondisability.disabilityconditiontypekey,
    persondisability.disabilityflag,
    persondisability.diagnoiseddisabilitynotes,
    persondisability.startdate,
    persondisability.enddate,
    persondisability.evaluationdate,
    persondisability.evaluatorname,
    persondisability.comments,
    persondisability.insertedon,
    persondisability.insertedby,
    persondisability.updatedon,
    persondisability.updatedby,
    persondisability.activeflag,
    persondisability.expungementflag,
    persondisability.old_id,
    persondisability.disabilitytypekey,
    persondisability.disabilitytype,
    persondisability.uploadpath AS json,
    persondisability.hygienekey,
    persondisability.specialkey,
    persondisability.startdateunknown
   FROM persondisability;
