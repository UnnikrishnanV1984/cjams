-- View: cjams.tb_placement

 DROP VIEW if exists cjams.tb_placement;

CREATE OR REPLACE VIEW cjams.tb_placement AS
 SELECT DISTINCT pl.alternateid AS placement_id,
    pl.altproviderid AS provider_id,
    NULL::integer AS provider_organization_id,
    tbpc.contract_id AS contract_program_id,
    pl.startdatetime AS entry_dt,
    pl.service_id AS placement_structure_id,
        CASE
            WHEN (( SELECT count(*) AS count
               FROM routing
              WHERE routing.routingstatustypeid = 16 AND routing.eventcode::text = 'PLTR'::text AND routing.activeflag = 1 AND routing.objectid::text = pl.placementid::character varying::text)) > 0 THEN '3047'::character varying
            ELSE NULL::character varying
        END AS approval_status_cd,
        CASE COALESCE(pl.isvoided, 0)
            WHEN 1 THEN 'Y'::text
            ELSE NULL::text
        END::character varying AS void_sw,
    pl.enddatetime AS exit_dt,
    'N'::character varying AS delete_sw,
    NULL::character varying AS conversion_sw,
    NULL::integer AS payment_header_id,
    pr.cjamspid AS client_id,
    pl.service_id AS rate_structure_id,
    NULL::timestamp without time zone AS placement_change_dt,
    sc.servicecasenumber::bigint AS case_id,
    pl.intakeservicerequestactorid,
    pl.servicecaseid,
    irl.removalid AS removal_id,
    pl.tfcifcconversionflag AS tfc_ifc_conversion_sw,
    pl.overunderflag AS over_under_sw,
    pl.voidapprovaldate AS void_approval_dt,
    pl.starttime AS entry_tm,
    pl.endtime AS exit_tm,
    pl.intakeserviceid,
    pl.voidreasontypekey AS void_reason_cd,
        CASE
            WHEN pl.courtorderedflag = 1 THEN 'Y'::character(1)
            WHEN pl.courtorderedflag = 0 THEN 'N'::character(1)
            ELSE NULL::character(1)
        END AS court_ordered_sw,
    pl.origplacementid AS orig_placement_id,
    pl.voidapprovalstatustypekey AS void_approval_status_cd,
    pl.exitreasontypekey AS exit_reason_cd,
    pl.insertedby AS create_user_id,
    pl.insertedon AS create_ts,
    pl.updatedby AS update_user_id,
    pl.updatedon AS update_ts,
    pl.caseid,
    pl.clientmergeid AS client_merge_id,
        CASE
            WHEN pl.datavalidflag = 1 THEN 'Y'::character(1)
            WHEN pl.datavalidflag = 0 THEN 'N'::character(1)
            ELSE NULL::character(1)
        END AS data_valid_sw,
    pl.exitreasontypekey AS exit_explanation_tx,
    pl.exittypekey AS exit_type_cd,
    pl.facilityid AS facility_id,
    pl.fiscalcategorytypekey AS fiscal_category_cd,
        CASE
            WHEN pl.icpcapprovedflag = 1 THEN 'Y'::character(1)
            WHEN pl.icpcapprovedflag = 0 THEN 'N'::character(1)
            ELSE NULL::character(1)
        END AS icpc_approved_sw,
        CASE
            WHEN pl.medicaidpaidflag = 1 THEN 'Y'::character(1)
            WHEN pl.medicaidpaidflag = 0 THEN 'N'::character(1)
            ELSE NULL::character(1)
        END AS medicaid_paid_sw,
    pl.otherservices AS other_services_tx,
    pl.personid,
    pl.placementid,
    pl.providerid,
    pl.shortlistid AS short_list_id
   FROM placement pl
     JOIN servicecase sc ON sc.servicecaseid = pl.servicecaseid AND sc.activeflag = 1
     JOIN intakeservicerequestactor isra ON pl.intakeservicerequestactorid = isra.intakeservicerequestactorid AND isra.activeflag = 1
     JOIN person pr ON pr.personid = isra.personid AND pr.activeflag = 1
     JOIN intakeservreqchildremoval irl ON irl.intakeservreqchildremovalid = pl.intakeservreqchildremovalid AND irl.activeflag = 1
     LEFT JOIN tb_provider_contracts tbpc ON tbpc.provider_id = pl.altproviderid AND tbpc.delete_sw = 'N'::bpchar
  WHERE pl.activeflag = 1;


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
    ga.tcaamount::numeric(10,2) AS tca_amount
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
    NULL::date AS rate2_end_dt
   FROM gapagreementrate gr
  WHERE gr.activeflag = 1;

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
    'N'::character varying AS delete_sw
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
    agr.rateoverwrittensw AS rate_overwritten_sw
   FROM adoptionplanning ap
     JOIN adoptionagreement ag ON ag.adoptionplanningid = ap.adoptionplanningid AND ag.activeflag = 1
     JOIN adoptionagreementrate agr ON agr.adoptionagreementid = ag.adoptionagreementid AND agr.activeflag = 1;





