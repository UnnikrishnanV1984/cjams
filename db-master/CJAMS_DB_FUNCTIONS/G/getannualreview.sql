DROP FUNCTION if exists cjams.getannualreview(v_gapid uuid, objectid uuid, objecttype character varying);
CREATE OR REPLACE FUNCTION cjams.getannualreview(v_gapid uuid, objectid uuid, objecttype character varying)
 RETURNS TABLE(gapannualreviewid uuid, gapagreementid uuid, reviewdate timestamp without time zone, isguardianresponsible boolean, isguardiansupportfinance boolean, ischildwithguardian boolean, ischildattendingschool boolean, isdocumentprovided boolean, ischildreacheighteen boolean, ischilddisability boolean, istrainingenrolled boolean, isunemployment boolean, isformcomplete boolean, cgprimarydate timestamp without time zone, cgsecondarydate timestamp without time zone, directorsigndate timestamp without time zone, ismanualentry integer, status text)
 LANGUAGE plpgsql
AS $function$

BEGIN

IF objecttype = 'annualreview' THEN

SELECT garw.gapid INTO v_gapid FROM gapannualreview garw WHERE garw.gapannualreviewid = objectid;

END IF;


RETURN  query

SELECT distinct gar.gapannualreviewid,gar.gapagreementid,gar.reviewdate,gar.isguardianresponsible,gar.isguardiansupportfinance,gar.ischildwithguardian,
gar.ischildattendingschool,gar.isdocumentprovided,gar.ischildreacheighteen,gar.ischilddisability,gar.istrainingenrolled,gar.isunemployment,
gar.isformcomplete,gar.cgprimarydate,gar.cgsecondarydate,gar.directorsigndate,gar.ismanualentry,
(select typedescription from routingstatustype where sequencenumber =  r.routingstatustypeid) as status  
FROM gapannualreview gar
inner join routing r on r.objectid = gar.gapannualreviewid :: character varying and r.activeflag = 1 
INNER JOIN guardianship gap ON gap.gapid = gar.gapid AND gap.activeflag =1 
WHERE gar.gapid = v_gapid AND gar.activeflag =1
order by gar.reviewdate asc;

 
END;

$function$;
