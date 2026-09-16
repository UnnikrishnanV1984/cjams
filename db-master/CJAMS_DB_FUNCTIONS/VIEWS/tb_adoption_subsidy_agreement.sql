DROP VIEW IF EXISTS cjams.tb_adoption_subsidy_agreement;

CREATE OR REPLACE VIEW cjams.tb_adoption_subsidy_agreement
AS SELECT ag.alternateid AS subsidy_agreement_id,
    ag.adoptionagreementid,
    agr.adoptionagreementrateid,
    a.alternateid AS adoption_id,
    'N'::text AS delete_sw,
	(
	CASE WHEN btrim(lower(agr.status::text)) = 'approved'::text THEN 
		'3047'::character varying
	ELSE 
		NULL::character varying
	END 
	) AS approval_status_cd,
    agr.startdate::date AS agreement_start_dt,
    agr.enddate::date AS agreement_end_dt,
    agr.paymentamout AS payment_amount_no,
    agr.rateoverwrittensw AS rate_overwritten_sw,
    agr.provider_id,
    ag.insertedby AS create_user_id,
    ag.insertedon AS create_ts,
    ag.updatedby AS update_user_id,
    ag.updatedon AS update_ts,
	agr.insertedon AS rate_create_ts
   FROM adoptioncase a
     JOIN adoptioncaseagreement ag ON ag.adoptioncaseid = a.adoptioncaseid AND ag.activeflag = 1
     JOIN adoptioncaseagreementrate agr ON agr.adoptionagreementid = ag.adoptionagreementid AND agr.activeflag = 1
  WHERE a.activeflag = 1;
