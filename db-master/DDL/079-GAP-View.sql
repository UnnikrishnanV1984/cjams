/*guardianship sequence*/

ALTER TABLE cjams.guardianship
    ADD COLUMN alternateid bigint;

DROP SEQUENCE  IF EXISTS sequence_guardianship CASCADE; 
CREATE SEQUENCE sequence_guardianship
    INCREMENT 1
    START 1000001
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER  TABLE guardianship ALTER COLUMN alternateid  SET DEFAULT nextval('sequence_guardianship'::regclass);
UPDATE guardianship SET alternateid =nextval('sequence_guardianship'::regclass) ;
-------------
ALTER TABLE cjams.gapagreementrate
    ADD COLUMN alternateid bigint;

DROP SEQUENCE  IF EXISTS sequence_gapagreementrate CASCADE; 
CREATE SEQUENCE sequence_gapagreementrate
    INCREMENT 1
    START 1000001
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER  TABLE gapagreementrate ALTER COLUMN alternateid  SET DEFAULT nextval('sequence_gapagreementrate'::regclass);
UPDATE gapagreementrate SET alternateid =nextval('sequence_gapagreementrate'::regclass) ;

/*Renaming table*/
ALTER TABLE tb_gap_rates RENAME TO tb_gap_rates_delete ;

ALTER TABLE gapagreement DROP COLUMN IF EXISTS tcaamount;
ALTER TABLE cjams.gapagreement
    ADD COLUMN tcaamount numeric(10);

/*tb_gap_rates*/

 DROP  VIEW IF EXISTS cjams.tb_gap_rates;

CREATE OR REPLACE VIEW cjams.tb_gap_rates AS
 SELECT gr.alternateid AS gap_rate_id,
    gr.gapagreementrateid,
    gr.gapagreementid,
    ( SELECT g.alternateid
           FROM guardianship g
             JOIN gapagreement gapa ON g.gapid = gapa.gapid
          WHERE gapa.gapagreementid = gr.gapagreementid) AS assistance_id,
    'N'::text AS delete_sw,
    '3047'::text AS approval_status_cd,
    gr.startdate::date AS rate_start_dt,
    gr.enddate::date AS rate_end_dt,
    gr.paymentamout AS payment_amt,
        CASE COALESCE(gr.isoverride, false)
            WHEN false THEN 'N'::text
            ELSE 'Y'::text
        END AS rate_override_sw,
        CASE COALESCE(gr.isoverride, false)
            WHEN false THEN '3045'::text
            ELSE '3046'::text
        END AS override_status_cd,
    NULL::date AS rate2_end_dt
   FROM gapagreementrate gr
     JOIN ( SELECT routing.eventcode,
            routing.objectid,
            routing.routeddescription,
            routing.insertedon
           FROM routing
          WHERE routing.routingstatustypeid = 16 AND routing.eventcode::text = 'GAAR'::text AND routing.activeflag = 1) r ON r.objectid::text = gr.gapagreementrateid::character varying::text
  WHERE gr.activeflag = 1;

/*Renaming table*/
ALTER TABLE tb_guardian_subsidy RENAME TO tb_guardian_subsidy_delete ; 

DROP VIEW IF EXISTS cjams.tb_guardian_subsidy;

CREATE OR REPLACE VIEW cjams.tb_guardian_subsidy AS
 SELECT g.gapid,
    g.alternateid AS guardian_subsidy_id,
    gar.provider_id,
    ga.gapagreementid,
    gar.gapagreementrateid,
    'N'::text AS delete_sw,
    p.cjamspid AS client_id,
    sc.servicecasenumber::bigint AS case_id,
    '3047'::text AS susbsidy_approval_status_cd,
    ga.enddate::date AS subsidy_end_dt,
    ga.startdate::date AS subsidy_start_dt,
    ga.tcaamount::numeric(10,2) AS tca_amount
   FROM guardianship g
     JOIN gapagreement ga ON ga.gapid = g.gapid AND ga.activeflag = 1
     JOIN ( SELECT routing.eventcode,
            routing.objectid,
            routing.routeddescription,
            routing.insertedon
           FROM routing
          WHERE routing.routingstatustypeid = 16 AND routing.eventcode::text = 'GAAR'::text AND routing.activeflag = 1) r ON r.objectid::text = ga.gapagreementid::character varying::text
     JOIN gapagreementrate gar ON gar.gapagreementid = ga.gapagreementid AND gar.activeflag = 1
     JOIN permanencyplan pp ON pp.permanencyplanid = g.permanencyplanid AND pp.activeflag = 1
     JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = pp.intakeservicerequestactorid AND isra.activeflag = 1
     JOIN person p ON p.personid = isra.personid AND p.activeflag = 1
     JOIN servicecase sc ON sc.servicecaseid = g.servicecaseid AND sc.activeflag = 1;

 