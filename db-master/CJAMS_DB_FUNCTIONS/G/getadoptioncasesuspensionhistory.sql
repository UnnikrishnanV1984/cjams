DROP FUNCTION IF EXISTS cjams.getadoptioncasesuspensionhistory(uuid, integer, integer);
CREATE OR REPLACE FUNCTION cjams.getadoptioncasesuspensionhistory(v_adoptionagreementid uuid, v_page integer, v_limit integer)
 RETURNS TABLE(adoptionsuspensionid uuid, reasonforsuspension character varying, suspensionreasontypekey character varying, suspensionbegindate timestamp without time zone, suspensionenddate timestamp without time zone, suspensionremarks text, requestedby text, requesteddate timestamp without time zone, approvedby text, approvaldate timestamp without time zone, approvalstatus text, adoptionactiveflag integer)
 LANGUAGE plpgsql
AS $function$

DECLARE 
v_pagenumber   int;
v_pageoffset  int;  

BEGIN

        v_pagenumber  :=  v_page-1;
        v_pageoffset  =  v_pagenumber  *  v_limit;
    

RETURN query

SELECT DISTINCT
    adspr.adoptionsuspensionid,
	(SELECT rv.description 
	FROM 
	referencevalues rv WHERE activeflag =1 AND rv.ref_key = adspr.suspensionreasontypekey LIMIT 1) as description,
	adspr.suspensionreasontypekey,
	adspr.suspensionbegindate,
--	adspr.suspensionenddate,
	case when
                ((select gsv.suspensionenddate from 
                adoptioncasesuspensionrevision gsv where gsv.adoptionsuspensionid=adspr.adoptionsuspensionid 
                 and gsv.approvalstatustypekey='3045' and gsv.activeflag=1 
               order by gsv.insertedon desc limit 1
                )is not null  and rs.typedescription='Review') then (select gsv.suspensionenddate from 
                adoptioncasesuspensionrevision gsv where gsv.adoptionsuspensionid=adspr.adoptionsuspensionid  
                and gsv.approvalstatustypekey='3045' and gsv.activeflag=1
                ) else adspr.suspensionenddate end as enddate  ,
	adspr.suspensionremarks,--1 as activeflag,
--	adspr.activeflag as activeflag,
	(SELECT up.firstname || ' '|| up.lastname 
	 FROM userprofile up 
	 WHERE up.securityusersid = adspr.insertedby AND up.activeflag =1 LIMIT 1 ) as requestedby,
	adspr.transactiondate as requesteddate,
	CASE r.routingstatustypeid WHEN  15  THEN ''
	ELSE (SELECT up1.firstname || ' '|| up1.lastname 
	 FROM userprofile up1 
	 WHERE up1.securityusersid = r.fromsecurityusersid AND up1.activeflag =1 )  END as approvedby,
	CASE r.routingstatustypeid WHEN  15  THEN NULL ELSE  r.insertedon END :: timestamp without time zone  as approveddate,
	rs.typedescription as approvalstatus ,
	 adspr.activeflag  as activeflag
	
FROM 	adoptioncasesuspension adspr
		LEFT JOIN routing r ON r.objectid = (adspr.adoptionsuspensionid) :: character varying AND r.eventcode = 'ADSR'  AND r.activeflag =1 /*Migration Fix*/
		LEFT JOIN routingstatustype rs ON r.routingstatustypeid = rs.sequencenumber and rs.activeflag =1  /*Migration Fix*/
WHERE  adspr.adoptioncaseid = v_adoptionagreementid and adspr.activeflag=1
LIMIT  v_limit  OFFSET  v_pageoffset;	

END;

$function$
;
