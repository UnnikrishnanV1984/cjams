Drop function if exists listiveplacement(character varying, text[], character varying,character varying,  bigint, bigint);

CREATE OR REPLACE FUNCTION public.listiveplacement(userid character varying, v_status text[], v_roleid character varying, v_placementtype character varying, pagenumber bigint, pagesize bigint)
 RETURNS TABLE(status integer, gapagreementid uuid, adoptionbreakthelinkid uuid, placementid uuid, fromsecurityusersid character varying, clientid bigint, lastname character varying, firstname character varying, removaldate timestamp without time zone, removalid bigint, childname character varying, casenumber bigint, childagency character varying, childjurisdiction character varying, placementdate date, dateofbirth date, removalage integer, caseid uuid)
 LANGUAGE plpgsql
AS $function$
 
DECLARE
	v_pageoffset int;
	v_pagenumber int;
DECLARE 
	totalcount integer;
BEGIN
    v_pagenumber := pagenumber-1;
    v_pageoffset = v_pagenumber * pagesize;
 
 if(v_placementtype = 'Fostercare')
 then
 if(v_roleid = 'IVESV' and v_status:: character varying = '{70}' :: character varying) --return resp for non-assigned user 
 then
 raise notice 'test %',v_status;
RETURN QUERY 
SELECT r.routingstatustypeid,null :: uuid,null :: uuid,pl.placementid,r.fromsecurityusersid,
p.cjamspid,p.lastname,p.firstname,isrcr.removaldate, isrcr.removalid ,
	CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname)::VARCHAR as childname,
	--p.cjamspid as client_id, 
	sc.servicecasenumber::BIGINT as casenumber,
	'DHS'::character varying  as childagency,
	'MD'::character varying as childjurisdiction,
	pl.startdatetime::date as placementdate,
	p.dob::date as dateofbirth,
	extract('years' FROM isrcr.removaldate)::int -  extract('years' FROM p.dob)::int as removalage,
	sc.servicecaseid as caseid
FROM placement pl
INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid=pl.intakeservicerequestactorid AND isra.activeflag=1
INNER JOIN person p ON p.personid=isra.personid AND p.activeflag=1
--join placement pla on pla.intakeservicerequestactorid = isra.intakeservicerequestactorid and pla.activeflag=1
INNER JOIN routing r ON r.objectid=pl.placementid :: character varying AND r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = any (v_status)
INNER JOIN intakeservreqchildremoval isrcr ON isrcr.intakeservreqchildremovalid=pl.intakeservreqchildremovalid AND isrcr.activeflag=1
INNER JOIN servicecase sc ON sc.servicecaseid = pl.servicecaseid AND sc.activeflag = 1
WHERE r.fromsecurityusersid=userid AND 
pl.activeflag=1
order by pl.updatedon desc;
--LIMIT pagesize OFFSET v_pageoffset;

else

RETURN QUERY 
SELECT r.routingstatustypeid,null :: uuid,null :: uuid,pl.placementid,r.fromsecurityusersid,
p.cjamspid,p.lastname,p.firstname,isrcr.removaldate,isrcr.removalid,
	CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname)::VARCHAR as childname,
	--p.cjamspid as client_id, 
	sc.servicecasenumber::BIGINT as casenumber,
	'DHS'::character varying  as childagency,
	'MD'::character varying as childjurisdiction,
	pl.startdatetime::date as placementdate,
	p.dob::date as dateofbirth,
	extract('years' FROM isrcr.removaldate)::int -  extract('years' FROM p.dob)::int as removalage,
	sc.servicecaseid as caseid
FROM placement pl
INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid=pl.intakeservicerequestactorid AND isra.activeflag=1
INNER JOIN person p ON p.personid=isra.personid AND p.activeflag=1
--join placement pla on pla.intakeservicerequestactorid = isra.intakeservicerequestactorid and pla.activeflag=1
INNER JOIN routing r ON r.objectid=pl.placementid :: character varying AND r.activeflag=1 AND r.eventcode='PLTR' AND r.routingstatustypeid::text = any (v_status)
INNER JOIN intakeservreqchildremoval isrcr ON isrcr.intakeservreqchildremovalid=pl.intakeservreqchildremovalid AND isrcr.activeflag=1
INNER JOIN servicecase sc ON sc.servicecaseid = pl.servicecaseid AND sc.activeflag = 1
WHERE r.tosecurityusersid=userid AND 
pl.activeflag=1
order by pl.updatedon desc;
--LIMIT pagesize OFFSET v_pageoffset;
end if;

else  if(v_placementtype = 'Adoption')
 then
 
RETURN QUERY 

select r.routingstatustypeid,null :: uuid,adbl.adoptionbreakthelinkid, pl.placementid,r.fromsecurityusersid,
p.cjamspid,p.lastname,p.firstname,isrcr.removaldate,isrcr.removalid,
	CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname)::VARCHAR as childname,
	--p.cjamspid as client_id, 
	sc.servicecasenumber::BIGINT as casenumber,
	'DHS'::character varying  as childagency,
	'MD'::character varying as childjurisdiction,
	pl.startdatetime::date as placementdate,
	p.dob::date as dateofbirth,
	extract('years' FROM isrcr.removaldate)::int -  extract('years' FROM p.dob)::int as removalage,
	sc.servicecaseid as caseid
FROM adoptionbreakthelink adbl 
join adoptionplanning apl on apl.adoptionplanningid = adbl.adoptionplanningid 
join permanencyplan pp on pp.permanencyplanid = apl.permanencyplanid
join placement pl on pp.placementid = pl.placementid 
INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid=pl.intakeservicerequestactorid AND isra.activeflag=1
INNER JOIN person p ON p.personid=isra.personid AND p.activeflag=1
--join placement pla on pla.intakeservicerequestactorid = isra.intakeservicerequestactorid and pla.activeflag=1
INNER JOIN routing r ON r.objectid=adbl.adoptionbreakthelinkid :: character varying AND r.activeflag=1 AND r.eventcode='ABLR' AND r.routingstatustypeid::text = any (v_status)
INNER JOIN intakeservreqchildremoval isrcr ON isrcr.intakeservreqchildremovalid=pl.intakeservreqchildremovalid AND isrcr.activeflag=1
INNER JOIN servicecase sc ON sc.servicecaseid = pl.servicecaseid AND sc.activeflag = 1
WHERE r.tosecurityusersid=userid AND pl.activeflag=1 and pp.activeflag=1
order by pp.updatedon desc;
--LIMIT pagesize OFFSET v_pageoffset;


else  if(v_placementtype = 'Gap')
 then
 
RETURN QUERY 

select r.routingstatustypeid,ga.gapagreementid,pp.permanencyplanid, pl.placementid,r.fromsecurityusersid,
p.cjamspid,p.lastname,p.firstname,isrcr.removaldate,isrcr.removalid ,
	CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname)::VARCHAR as childname,
	--p.cjamspid as client_id, 
	sc.servicecasenumber::BIGINT as casenumber,
	'DHS'::character varying  as childagency,
	'MD'::character varying as childjurisdiction,
	pl.startdatetime::date as placementdate,
	p.dob::date as dateofbirth,
	extract('years' FROM isrcr.removaldate)::int -  extract('years' FROM p.dob)::int as removalage,
	sc.servicecaseid as caseid
from gapagreement ga 
join guardianship gd on gd.gapid =ga.gapid and gd.activeflag=1
join permanencyplan pp on pp.permanencyplanid = gd.permanencyplanid  
join placement pl on pp.placementid = pl.placementid 
INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid=pl.intakeservicerequestactorid AND isra.activeflag=1
INNER JOIN person p ON p.personid=isra.personid AND p.activeflag=1
--join placement pla on pla.intakeservicerequestactorid = isra.intakeservicerequestactorid and pla.activeflag=1
INNER JOIN routing r ON r.objectid=ga.gapagreementid :: character varying AND r.activeflag=1 AND r.eventcode='GAAR' AND r.routingstatustypeid::text = any (v_status)
INNER JOIN intakeservreqchildremoval isrcr ON isrcr.intakeservreqchildremovalid=pl.intakeservreqchildremovalid AND isrcr.activeflag=1
INNER JOIN servicecase sc ON sc.servicecaseid = pl.servicecaseid AND sc.activeflag = 1
WHERE r.tosecurityusersid=userid AND pl.activeflag=1 and pp.activeflag=1 and ga.activeflag=1
order by ga.updatedon desc;
--LIMIT pagesize OFFSET v_pageoffset;

end if;
end if;
end if;

END;

$function$
