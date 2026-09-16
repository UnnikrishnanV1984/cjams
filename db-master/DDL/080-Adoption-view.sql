ALTER TABLE cjams.adoptionplanning
    ADD COLUMN alternateid bigint;

DROP SEQUENCE  IF EXISTS sequence_adoptionplanning CASCADE; 
CREATE SEQUENCE sequence_adoptionplanning
    INCREMENT 1
    START 1000001
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER  TABLE adoptionplanning ALTER COLUMN alternateid  SET DEFAULT nextval('sequence_adoptionplanning'::regclass);
UPDATE adoptionplanning SET alternateid =nextval('sequence_adoptionplanning'::regclass) ;

/*Renaming table*/
ALTER TABLE tb_adoption RENAME TO tb_adoption_delete ; 
----------------------
ALTER TABLE cjams.adoptionagreement
    ADD COLUMN alternateid bigint;

DROP SEQUENCE  IF EXISTS sequence_adoptionagreement CASCADE; 
CREATE SEQUENCE sequence_adoptionagreement
    INCREMENT 1
    START 1000001
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER  TABLE adoptionagreement ALTER COLUMN alternateid  SET DEFAULT nextval('sequence_adoptionagreement'::regclass);
UPDATE adoptionagreement SET alternateid =nextval('sequence_adoptionagreement'::regclass) ;

/*Renaming table*/
ALTER TABLE tb_adoption_subsidy_agreement RENAME TO tb_adoption_subsidy_agreement_delete ; 

ALTER TABLE cjams.adoptionagreementrate
    ADD COLUMN rateoverwrittensw character(1);

drop view if exists cjams.tb_adoption;
-- View: cjams.tb_adoption

-- DROP VIEW cjams.tb_adoption;

CREATE OR REPLACE VIEW cjams.tb_adoption AS
 SELECT ap.alternateid AS adoption_id,
    ap.adoptionplanningid,
    agr.provider_id,
    agr.adoptionagreementrateid,
    agr.adoptionagreementid,
    NULL::text AS ma_only_payment_cd,
    s.servicecasenumber::bigint AS case_id,
    ag.startdate AS subsidy_start_dt,
    ag.enddate AS subsidy_end_dt,
    p.cjamspid AS client_id,
    'N'::character varying AS delete_sw
   FROM adoptionplanning ap
     JOIN adoptionagreement ag ON ag.adoptionplanningid = ap.adoptionplanningid AND ag.activeflag = 1
     JOIN ( SELECT DISTINCT routing.objectid,
            routing.remarks,
            routing.routeddescription
           FROM routing
          WHERE routing.routingstatustypeid = 16 AND routing.eventcode::text = 'ASAR'::text AND routing.activeflag = 1) r ON r.objectid::text = ag.adoptionagreementid::character varying::text
     JOIN permanencyplan pp ON ap.permanencyplanid = pp.permanencyplanid AND pp.activeflag = 1 AND ap.activeflag = 1
     JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = pp.intakeservicerequestactorid AND isra.activeflag = 1
     JOIN person p ON p.personid = isra.personid AND p.activeflag = 1
     JOIN servicecase s ON s.servicecaseid = ap.servicecaseid AND s.activeflag = 1
     JOIN adoptionagreementrate agr ON agr.adoptionagreementid = ag.adoptionagreementid AND agr.activeflag = 1;
    
 
DROP VIEW IF EXISTS cjams.tb_adoption_subsidy_agreement;


CREATE OR REPLACE VIEW cjams.tb_adoption_subsidy_agreement AS
 SELECT ag.alternateid AS subsidy_agreement_id,
    ag.adoptionagreementid,
    ap.adoptionplanningid,
    agr.adoptionagreementrateid,
    ( SELECT adoptionplanning.alternateid
           FROM adoptionplanning
          WHERE adoptionplanning.adoptionplanningid = ag.adoptionplanningid) AS adoption_id,
    'N'::text AS delete_sw,
    '3047'::text AS approval_status_cd,
    ag.startdate::date AS agreement_start_dt,
    ag.enddate::date AS agreement_end_dt,
    agr.paymentamout AS payment_amount_no,
    agr.rateoverwrittensw AS rate_overwritten_sw
   FROM adoptionplanning ap
     JOIN adoptionagreement ag ON ag.adoptionplanningid = ap.adoptionplanningid AND ag.activeflag = 1
     JOIN ( SELECT routing.eventcode,
            routing.objectid,
            routing.routingstatustypeid,
            routing.insertedon
           FROM routing
          WHERE routing.routingstatustypeid = 16 AND routing.eventcode::text = 'ASAR'::text AND routing.activeflag = 1) r ON r.objectid::text = ag.adoptionagreementid::character varying::text
     JOIN adoptionagreementrate agr ON agr.adoptionagreementid = ag.adoptionagreementid AND agr.activeflag = 1;
   

 