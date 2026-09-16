-- View: cjams.tb_adoption

 DROP VIEW if exists cjams.tb_adoption;

CREATE OR REPLACE VIEW cjams.tb_adoption AS
 SELECT ap.alternateid AS adoption_id,
    ap.adoptionplanningid,
    agr.provider_id,
    agr.adoptionagreementrateid,
    agr.adoptionagreementid,
        CASE
            WHEN (( SELECT count(*) AS count
               FROM routing
              WHERE routing.routingstatustypeid = 16 AND routing.eventcode::text = 'ASAR'::text AND routing.activeflag = 1 AND routing.objectid::text = ag.adoptionagreementid::character varying::text)) > 0 THEN '3047'::character varying
            ELSE NULL::character varying
        END AS approval_status_cd,
    NULL::text AS ma_only_payment_cd,
    s.servicecasenumber::bigint AS case_id,
    ag.startdate AS subsidy_start_dt,
    ag.enddate AS subsidy_end_dt,
    p.cjamspid AS client_id,
    'N'::character varying AS delete_sw,
    ap.insertedby AS create_user_id,
    ap.insertedon AS create_ts,
    ap.updatedby AS update_user_id,
    ap.updatedon AS update_ts
   FROM adoptionplanning ap
     JOIN adoptionagreement ag ON ag.adoptionplanningid = ap.adoptionplanningid AND ag.activeflag = 1
     JOIN permanencyplan pp ON ap.permanencyplanid = pp.permanencyplanid AND pp.activeflag = 1 AND ap.activeflag = 1
     JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = pp.intakeservicerequestactorid AND isra.activeflag = 1
     JOIN person p ON p.personid = isra.personid AND p.activeflag = 1
     JOIN servicecase s ON s.servicecaseid = ap.servicecaseid AND s.activeflag = 1
     JOIN adoptionagreementrate agr ON agr.adoptionagreementid = ag.adoptionagreementid AND agr.activeflag = 1;


-- View: cjams.tb_adoption_subsidy_agreement

 DROP VIEW if exists cjams.tb_adoption_subsidy_agreement;

CREATE OR REPLACE VIEW cjams.tb_adoption_subsidy_agreement AS
 SELECT ag.alternateid AS subsidy_agreement_id,
    ag.adoptionagreementid,
    ap.adoptionplanningid,
    agr.adoptionagreementrateid,
    ( SELECT adoptionplanning.alternateid
           FROM adoptionplanning
          WHERE adoptionplanning.adoptionplanningid = ag.adoptionplanningid) AS adoption_id,
    'N'::text AS delete_sw,
        CASE
            WHEN (( SELECT count(*) AS count
               FROM routing
              WHERE routing.routingstatustypeid = 16 AND routing.eventcode::text = 'ASAR'::text AND routing.activeflag = 1 AND routing.objectid::text = ag.adoptionagreementid::character varying::text)) > 0 THEN '3047'::character varying
            ELSE NULL::character varying
        END AS approval_status_cd,
    ag.startdate::date AS agreement_start_dt,
    ag.enddate::date AS agreement_end_dt,
    agr.paymentamout AS payment_amount_no,
    agr.rateoverwrittensw AS rate_overwritten_sw,
    ag.insertedby AS create_user_id,
    ag.insertedon AS create_ts,
    ag.updatedby AS update_user_id,
    ag.updatedon AS update_ts
   FROM adoptionplanning ap
     JOIN adoptionagreement ag ON ag.adoptionplanningid = ap.adoptionplanningid AND ag.activeflag = 1
     JOIN adoptionagreementrate agr ON agr.adoptionagreementid = ag.adoptionagreementid AND agr.activeflag = 1;
	 
-- View: cjams.tb_guardian_subsidy

 DROP VIEW if exists cjams.tb_guardian_subsidy;

CREATE OR REPLACE VIEW cjams.tb_guardian_subsidy AS
 SELECT DISTINCT g.gapid,
    g.alternateid AS guardian_subsidy_id,
    gar.provider_id,
    ga.gapagreementid,
    gar.gapagreementrateid,
    'N'::text AS delete_sw,
    p.cjamspid AS client_id,
    sc.servicecasenumber::bigint AS case_id,
        CASE
            WHEN (( SELECT count(*) AS count
               FROM routing
              WHERE routing.routingstatustypeid = 16 AND routing.eventcode::text = 'GAAR'::text AND routing.activeflag = 1 AND routing.objectid::text = ga.gapagreementid::character varying::text)) > 0 THEN '3047'::character varying
            ELSE NULL::character varying
        END AS susbsidy_approval_status_cd,
    ga.enddate::date AS subsidy_end_dt,
    ga.startdate::date AS subsidy_start_dt,
    ga.tcaamount::numeric(10,2) AS tca_amount,
    g.insertedby AS create_user_id,
    g.insertedon AS create_ts,
    g.updatedby AS update_user_id,
    g.updatedon AS update_ts
   FROM guardianship g
     JOIN gapagreement ga ON ga.gapid = g.gapid AND ga.activeflag = 1
     JOIN gapagreementrate gar ON gar.gapagreementid = ga.gapagreementid AND gar.activeflag = 1
     JOIN permanencyplan pp ON pp.permanencyplanid = g.permanencyplanid AND pp.activeflag = 1
     JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = pp.intakeservicerequestactorid AND isra.activeflag = 1
     JOIN person p ON p.personid = isra.personid AND p.activeflag = 1
     JOIN servicecase sc ON sc.servicecaseid = g.servicecaseid AND sc.activeflag = 1;

	 -- View: cjams.tb_gap_rates

 DROP VIEW if exists cjams.tb_gap_rates;

CREATE OR REPLACE VIEW cjams.tb_gap_rates AS
 SELECT gr.alternateid AS gap_rate_id,
    gr.gapagreementrateid,
    gr.gapagreementid,
    ( SELECT g.alternateid
           FROM guardianship g
             JOIN gapagreement gapa ON g.gapid = gapa.gapid
          WHERE gapa.gapagreementid = gr.gapagreementid) AS assistance_id,
    'N'::text AS delete_sw,
        CASE
            WHEN (( SELECT count(*) AS count
               FROM routing
              WHERE routing.routingstatustypeid = 16 AND routing.eventcode::text = 'GARR'::text AND routing.activeflag = 1 AND routing.objectid::text = gr.gapagreementrateid::character varying::text)) > 0 THEN '3047'::character varying
            ELSE NULL::character varying
        END AS approval_status_cd,
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
    NULL::date AS rate2_end_dt,
    gr.insertedby AS create_user_id,
    gr.insertedon AS create_ts,
    gr.updatedby AS update_user_id,
    gr.updatedon AS update_ts
   FROM gapagreementrate gr
  WHERE gr.activeflag = 1;

