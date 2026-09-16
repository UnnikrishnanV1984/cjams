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
    agr.provider_id,
    ag.insertedby AS create_user_id,
    ag.insertedon AS create_ts,
    ag.updatedby AS update_user_id,
    ag.updatedon AS update_ts
   FROM adoptionplanning ap
     JOIN adoptionagreement ag ON ag.adoptionplanningid = ap.adoptionplanningid AND ag.activeflag = 1
     JOIN adoptionagreementrate agr ON agr.adoptionagreementid = ag.adoptionagreementid AND agr.activeflag = 1;

