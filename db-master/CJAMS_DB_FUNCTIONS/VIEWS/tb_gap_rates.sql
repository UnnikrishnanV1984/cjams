-- cjams.tb_gap_rates source

CREATE OR REPLACE VIEW cjams.tb_gap_rates
AS SELECT gr.alternateid AS gap_rate_id,
    gr.gapagreementrateid,
    gr.gapagreementid,
    ( SELECT g.alternateid
           FROM guardianship g
             JOIN gapagreement gapa ON g.gapid = gapa.gapid
          WHERE gapa.gapagreementid = gr.gapagreementid) AS assistance_id,
    'N'::text AS delete_sw,
        CASE
            WHEN btrim(lower(gr.status::text)) = 'approved'::text THEN '3047'::character varying
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
            WHEN false THEN '3046'::text
            ELSE '3047'::text
        END AS override_status_cd,
    gr.enddate::date AS rate2_end_dt,
    gr.insertedby AS create_user_id,
    gr.insertedon AS create_ts,
    gr.updatedby AS update_user_id,
    gr.updatedon AS update_ts
   FROM gapagreementrate gr
  WHERE gr.activeflag = 1;