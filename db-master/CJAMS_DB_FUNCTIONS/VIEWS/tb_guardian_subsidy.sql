--DROP VIEW IF EXISTS cjams.tb_guardian_subsidy;

CREATE OR REPLACE VIEW cjams.tb_guardian_subsidy
AS SELECT DISTINCT g.gapid,
    g.alternateid AS guardian_subsidy_id,
	( select gar.provider_id from gapagreementrate gar 
		where gar.gapagreementid = ga.gapagreementid
		and gar.activeflag = 1 
		order by gar.startdate desc
		limit 1
	) as provider_id,
    --gar.provider_id,
    ga.gapagreementid,
    --gar.gapagreementrateid,
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
     JOIN permanencyplan pp ON pp.permanencyplanid = g.permanencyplanid AND pp.activeflag = 1
     JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = pp.intakeservicerequestactorid AND isra.activeflag = 1
     JOIN person p ON p.personid = isra.personid AND p.activeflag = 1
     JOIN servicecase sc ON sc.servicecaseid = g.servicecaseid AND sc.activeflag = 1;
