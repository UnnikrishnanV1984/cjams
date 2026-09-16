CREATE OR REPLACE VIEW cjams.tb_gap_rates
AS SELECT gr.alternateid AS gap_rate_id,
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
          WHERE routing.routingstatustypeid = 16 AND routing.eventcode::text = 'GARR'::text AND routing.activeflag = 1) r ON r.objectid::text = gr.gapagreementrateid::character varying::text
  WHERE gr.activeflag = 1;

-- Permissions

ALTER TABLE cjams.tb_gap_rates OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.tb_gap_rates TO welfareadmin;
