DROP FUNCTION IF EXISTS cjams.getcaseclosurelist(uuid);
CREATE OR REPLACE FUNCTION cjams.getcaseclosurelist(v_intakeserviceid uuid)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------
-- Revision(s)
-- 09/16/2022 Pratap - changing order by clause from insert to update as per PR review - CDM-22447
-- 02/11/2026 - Veera - CIDM-11127 - long running Query tunning
------------------------------------------------------------------------


declare l_closuredetails json;

begin
			SELECT    json_agg(closuredetails) INTO  l_closuredetails FROM (
			select json_agg((individualparticipant::text)::json) individualparticipant, 
 json_agg((childparticipant::text)::json) childparticipant,  ccs.referralreason, 
					ccs.caseclosuresummaryid,
        ccs.reason, 
        ccs.riskissues, 
		ccs.recommendation, 
	    ccs.interventionissues, 
	    ccs.notes,
		ccs.closuredate, 
	    st.typedescription , 
	    s.typedescription, 
	    st.closuretypekey, 
	    (select routingstatustypeid from routing rr where  rr.objectid = (select intakeservicerequestdispositioncodeid  from intakeservicerequestdispositioncode isd
 			where intakeserviceid = v_intakeserviceid and isd.activeflag=1 order by updatedon desc limit 1):: character varying 
 			and rr.eventcode = 'INDR' and rr.activeflag = 1 order by rr.insertedon desc limit 1),
        ccs.closuresubtypekey,
        ccs.clientrefrdservices from (
SELECT cp1.caseclosuresummaryid,
		CASE  cp1.ischild WHEN 1 THEN null else  json_build_object('displayname',p.firstname || ' '|| p.lastname ,'intakeservicerequestactorid',isr1.intakeservicerequestactorid,'personid',p.personid,
																	'roles',
											(SELECT json_agg(ind)FROM(
															SELECT  
															       aty.typedescription 
															FROM caseclosureparticipant cp 
															INNER JOIN intakeservicerequestactor isr ON cp.intakeservicerequestactorid = isr.intakeservicerequestactorid  AND isr.activeflag =1 
															INNER JOIN actortype aty ON    isr.intakeservicerequestpersontypekey = aty.actortype								
															WHERE cp.caseclosuresummaryid = cp1.caseclosuresummaryid AND 
															cp.ischild = 0	 
														 )ind)    ) 	end individualparticipant,
		CASE  cp1.ischild WHEN 0 THEN null else   json_build_object('displayname',p.firstname || ' '|| p. lastname ,'intakeservicerequestactorid',isr1.intakeservicerequestactorid,'personid',p.personid,
																	'roles',
																(SELECT json_agg(chd)FROM(
																				SELECT  
																				aty.typedescription 
																				
																				FROM caseclosureparticipant cp 
																				INNER JOIN intakeservicerequestactor isr ON cp.intakeservicerequestactorid = isr.intakeservicerequestactorid  AND isr.activeflag =1 
																				INNER JOIN actortype aty ON    isr.intakeservicerequestpersontypekey = aty.actortype														
																				WHERE cp.caseclosuresummaryid = cp1.caseclosuresummaryid AND 
																				cp.ischild = 1 			 
																			 )chd)    ) 	end childparticipant 
			
		FROM caseclosureparticipant cp1
		INNER JOIN intakeservicerequestactor isr1 ON cp1.intakeservicerequestactorid = isr1.intakeservicerequestactorid 
		AND isr1.activeflag =1  
		INNER JOIN person p ON p.personid =  isr1.personid AND p.activeflag =1
		INNER JOIN   caseclosuresummary ccs ON ccs.caseclosuresummaryid = cp1.caseclosuresummaryid and ccs.activeflag = 1
          WHERE   ccs.intakeserviceid = v_intakeserviceid
        AND   cp1.activeflag =1 
       
		GROUP BY cp1.CASEclosuresummaryid, 	 p.firstname || ' '|| p.lastname ,cp1.ischild,isr1.intakeservicerequestactorid,p.personid
      ) as a INNER JOIN   caseclosuresummary ccs ON ccs.caseclosuresummaryid = a.caseclosuresummaryid and ccs.activeflag = 1
        LEFT JOIN closuretype st on ccs.closuretypekey = st.closuretypekey
        LEFT JOIN closuresubtype s on ccs.closuresubtypekey = s.closuresubtypekey 
        
        WHERE   ccs.intakeserviceid = v_intakeserviceid  and ccs.activeflag =1
		GROUP BY   ccs.referralreason, 
					ccs.caseclosuresummaryid,
        ccs.reason, 
        ccs.riskissues, 
		ccs.recommendation, 
	    ccs.interventionissues, 
	    ccs.notes, 
	    st.typedescription , 
	    s.typedescription, 
	    st.closuretypekey, 
        s.closuresubtypekey  
		 

																			
			)closuredetails;
return l_closuredetails;        
end;

$function$
;
