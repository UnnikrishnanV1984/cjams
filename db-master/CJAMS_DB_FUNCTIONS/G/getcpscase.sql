DROP  FUNCTION IF EXISTS cjams.getcpscase(v_servicereqno character varying, v_pagenumber integer, v_pagelimit integer);
CREATE OR REPLACE FUNCTION cjams.getcpscase(v_servicereqno character varying, v_pagenumber integer, v_pagelimit integer)
RETURNS TABLE(totalcount bigint, intakeserviceid character varying, legalguardian json, servicerequestnumber character varying, casetype  character varying, datereceived date, workername character varying)
 LANGUAGE plpgsql
AS $function$     
DECLARE l_pagenumber int;
BEGIN 
     l_pagenumber:=(v_pagenumber-1)*v_pagelimit;             
	RETURN QUERY
	SELECT	  COUNT(1) over()
			, isr.intakeserviceid ::character varying 
			, (SELECT getcasepersonname FROM getcasepersonname ('servicerequest',isr.intakeserviceid::character varying))
			, isr.servicerequestnumber
			, (CASE WHEN isr.actiontype = 'IR' THEN 'CPS IR' WHEN isr.actiontype = 'AR' THEN 'CPS AR' END)::character varying  as casetype 
			, CAST(isr.ReportedDate as date) as datereceived
			, (SELECT 	string_agg(distinct up.fullname, '- ')::character varying 
			   FROM 	routing r
						INNER JOIN userprofile up ON up.securityusersid = r.tosecurityusersid 
				WHERE 	r.objectid::text=isr.intakeserviceid :: text AND r.eventcode = 'INVT' AND r.routingstatustypeid = 4 AND r.activeflag = 1 
			  ) as workername 
	FROM 	intakeservicerequest  isr 
	WHERE   isr.activeflag=1 AND isr.teamtypekey ='CW' AND isr.isdraft = 0
			AND  isr.actiontype IN ('IR','AR')
			AND  LOWER(isr.servicerequestnumber)  LIKE   '%' ||   LOWER(v_servicereqno)  ||  '%' 
	LIMIT  v_pagelimit OFFSET    l_pagenumber ;
END;
$function$;