-- 03/11/2023 prasanna sai kommineni - CIDM-10188 B-215263 : Psychotropic Prescription Review Report Dashboard

DROP FUNCTION IF EXISTS cjams.getpsychotropicmedicationreport(startdate date, enddate date,v_medicationname character varying, v_prescribername character varying ,v_dateprescribed date ,v_submissiondate date
,filterdatetype character varying ,v_clientname character varying,v_age int,v_psychotropicrequestid int,v_objectid character varying,v_reviewcoordinator character varying ,v_pharmacist character varying,
v_psychiatrist character varying,v_countyid character varying,v_turnaround_hours int,v_teamid character varying,page integer , pagelimit integer  , v_sortcolumn character varying , v_sortorder character varying,v_countfilter character varying,v_searchobj json);

DROP FUNCTION IF EXISTS cjams.getpsychotropicmedicationreport(startdate date, enddate date,v_medicationname character varying, v_prescribername character varying ,v_dateprescribed date ,v_submissiondate date
,filterdatetype character varying ,v_clientname character varying,v_age int,v_psychotropicrequestid int,v_objectid character varying,v_reviewcoordinator character varying ,v_pharmacist character varying,
v_psychiatrist character varying,v_countyid character varying,v_turnaround_hours int,v_teamid character varying,page integer , pagelimit integer  , v_sortcolumn character varying , v_sortorder character varying,v_countfilter character varying,v_searchobj json, v_caseworkid character varying);


CREATE OR REPLACE FUNCTION cjams.getpsychotropicmedicationreport(startdate date DEFAULT NULL, enddate date DEFAULT NULL, 
v_medicationname character varying DEFAULT NULL::character varying, v_prescribername character varying DEFAULT NULL::character varying, 
v_dateprescribed date DEFAULT NULL,v_submissiondate date DEFAULT NULL, filterdatetype character varying DEFAULT null::character varying, v_clientname character varying DEFAULT NULL::character varying, 
v_age int DEFAULT NULL, v_psychotropicrequestid int DEFAULT NULL, v_objectid character varying DEFAULT NULL, v_reviewcoordinator character varying DEFAULT NULL, 
v_pharmacist character varying DEFAULT NULL, v_psychiatrist character varying DEFAULT NULL, v_countyid character varying DEFAULT NULL, v_turnaround_hours int DEFAULT null ,v_teamid character varying DEFAULT null
, page integer DEFAULT 1::integer, pagelimit integer DEFAULT 10::integer, v_sortcolumn character varying DEFAULT NULL::character varying, v_sortorder character varying DEFAULT NULL::character varying,v_countfilter character varying DEFAULT NULL::character varying,v_searchobj json DEFAULT NULL, v_caseworkid character varying DEFAULT NULL)
RETURNS json
LANGUAGE plpgsql
AS $$
--------------------------------------------------------------------------------------------------
-- 03/11/2023 prasanna sai kommineni - CIDM-10188 B-215263 : Psychotropic Prescription Review Report Dashboard
-- 04/10/2025 prasanna sai kommineni - CIDM-10188 B-215263 : Psychotropic Prescription Review Report Dashboard updated total time
-- 09/08/2025 Veera Nadimpalli CIDM-10784 - To get returned to worker count
-- 11/20/2025 Vinesh Puthan CDM-44596 Psychotropic Med Report filter by county issue fix
-----------------------------------------------------------------------------------------------------
DECLARE
    v_result json;
   v_resultcount json;
    v_enddate DATE;
    v_startdate DATE;
    v_filterdatetype character varying;
    v_filterdatetypeforrouting INTEGER[];
   v_pageoffset  int;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
 v_pagenumber  int; 
v_medicationsearch character varying;
v_clientnamesearch character varying;
v_dateprescribedsearch date;
begin
	v_medicationsearch := v_searchObj ->> 'Medication';
	v_clientnamesearch := v_searchObj ->> 'Client Name';
	v_dateprescribedsearch:= v_searchObj ->> 'Prescription Date';
    v_startdate := startdate ::DATE;
   v_pageoffset:=page;
     if(v_pageoffset is null) then
     v_pageoffset:=1;
end if; 
v_pagenumber  :=  (page-1)*10; 
   if filterdatetype is null then
		v_filterdatetype := 'all';
	else
    v_filterdatetype := filterdatetype;
   end if;
    IF enddate IS NULL THEN
        v_enddate := CURRENT_DATE ::DATE;
    ELSE
        v_enddate := enddate ::DATE;
    END IF;
		
		
    IF v_filterdatetype = 'all' THEN
        v_filterdatetypeforrouting := ARRAY[900, 901, 902, 903, 904, 905, 906, 907, 16, 908];
    END IF;

    IF v_filterdatetype = 'awaiting_assignment' THEN
        v_filterdatetypeforrouting := ARRAY[ 900];
    END IF;

    IF v_filterdatetype = 'information_incomplete' THEN
        v_filterdatetypeforrouting := ARRAY[906];
    END IF;

    IF v_filterdatetype = 'pending_peer_review' THEN
        v_filterdatetypeforrouting := ARRAY[907];
    END IF;

    IF v_filterdatetype = 'pending_pharmacist_review' THEN
        v_filterdatetypeforrouting := ARRAY[901];
    END IF;

    IF v_filterdatetype = 'pending_cap_review' THEN
        v_filterdatetypeforrouting := ARRAY[903];
    END IF;

    IF v_filterdatetype = 'return_worker' THEN
        v_filterdatetypeforrouting := ARRAY[904];
    END IF;

    IF v_filterdatetype = 'approved' THEN
        v_filterdatetypeforrouting := ARRAY[16];
    END IF;

    IF v_filterdatetype = 'rejected' THEN
        v_filterdatetypeforrouting := ARRAY[905];
    END IF;
    IF v_filterdatetype = 'initial_submission' THEN
        v_filterdatetypeforrouting := ARRAY[908];
    END IF;
     IF v_filterdatetype = 'coordinator_assignment_pending' THEN
        v_filterdatetypeforrouting := ARRAY[902];
    END IF;


   SELECT json_agg(a) INTO v_resultcount FROM (
        SELECT 
            COUNT(r.*) AS totalrequest, 
            COUNT(CASE WHEN r.routingstatustypeid IN (16) THEN 1 END) AS totalapproved,
            COUNT(CASE WHEN r.routingstatustypeid IN (905) THEN 1 END) AS totalrejected,
            COUNT(CASE WHEN r.routingstatustypeid IN (904) THEN 1 END) AS totalreturntoworker,
            COUNT(CASE WHEN r.routingstatustypeid IN (900, 906, 907) 
                       AND (r.routingstatustypeid <> 906 OR r.fromroleid = 'CWPSYCOORD') 
                       AND (r.routingstatustypeid <> 907 OR r.fromroleid = 'CWPSYCOORD') 
                  THEN 1 END) AS pendingreviewcoordinator,
            COUNT(CASE WHEN r.routingstatustypeid IN (903, 906, 907) 
                       AND (r.routingstatustypeid <> 906 OR r.fromroleid = 'CWPSYPSYCH') 
                       AND (r.routingstatustypeid <> 907 OR r.fromroleid = 'CWPSYPSYCH') 
                  THEN 1 END) AS pendingpsychiatrist,
            COUNT(CASE WHEN r.routingstatustypeid IN (908, 902) THEN 1 END) AS pendingcommonpool,
            COUNT(CASE WHEN r.routingstatustypeid IN (901, 906, 907) 
                       AND (r.routingstatustypeid <> 906 OR r.fromroleid = 'CWPSYPHARM') 
                       AND (r.routingstatustypeid <> 907 OR r.fromroleid = 'CWPSYPHARM') 
                  THEN 1 END) AS pendingpharmacist,
            COUNT(CASE WHEN r.routingstatustypeid NOT IN (16, 905, 904) THEN 1 END) AS totalpending
     
        FROM 
            routing r
            LEFT JOIN psychotropicmedications psm ON psm.psychotropicid:: VARCHAR = r.objectid
            LEFT JOIN person p ON p.personid = psm.personid::uuid
            LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = psm.insertedby and tma.activeflag = 1
			LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
        WHERE 
            r.eventcode = 'PSY' 
            AND r.activeflag = 1 
            AND (CASE WHEN v_medicationname IS NOT NULL THEN psm.medicationname ILIKE '%' || v_medicationname || '%' ELSE TRUE END)
            AND (CASE WHEN v_prescribername IS NOT NULL THEN psm.prescribername ILIKE '%' || v_prescribername || '%' ELSE TRUE END)
            AND (CASE WHEN v_countyid IS NOT NULL THEN t.countyid = v_countyid ELSE TRUE END)
             AND (CASE WHEN v_caseworkid IS NOT NULL THEN psm.insertedby = v_caseworkid ELSE TRUE END)
			AND (CASE WHEN v_dateprescribed IS NOT NULL THEN psm.dateprescribed::DATE = v_dateprescribed::date ELSE TRUE END)
               AND (CASE WHEN v_submissiondate IS NOT NULL THEN  (SELECT r3.insertedon 
         FROM routing r3 
         WHERE r3.objectid = psm.psychotropicid::VARCHAR 
           AND r3.eventcode = 'PSY' 
           AND r3.routingstatustypeid = 908 
         ORDER BY r3.insertedon DESC 
         LIMIT 1)::date = v_submissiondate::DATE  ELSE TRUE END)
            AND (CASE WHEN v_reviewcoordinator IS NOT NULL THEN (r.tosecurityusersid = v_reviewcoordinator AND toroleid = 'CWPSYCOORD') ELSE TRUE END)
            AND (CASE WHEN v_pharmacist IS NOT NULL THEN (r.tosecurityusersid = v_pharmacist AND toroleid = 'CWPSYPHARM') ELSE TRUE END)
            AND (CASE WHEN v_psychiatrist IS NOT NULL THEN (r.tosecurityusersid = v_psychiatrist AND toroleid = 'CWPSYPSYCH') ELSE TRUE END)
            AND (CASE WHEN v_objectid IS NOT NULL THEN psm.objectid = v_objectid ELSE TRUE END)
            AND (CASE WHEN v_psychotropicrequestid IS NOT NULL THEN psm.psychotropicrequestid = v_psychotropicrequestid::int ELSE TRUE END)
			AND (CASE WHEN v_age IS NOT NULL 
    THEN DATE_PART('year', AGE(CURRENT_DATE, p.dob)) <= v_age 
    ELSE TRUE  END)
            AND (CASE WHEN v_clientname IS NOT NULL THEN CONCAT(p.firstname,' ', p.lastname) ILIKE '%' || v_clientname || '%' ELSE TRUE END)
            AND (CASE WHEN v_filterdatetype = 'all' THEN (r.routingstatustypeid IN (900, 901, 902, 903, 904, 905, 906, 907, 16, 908) OR COALESCE(r.routingstatustypeid, 1) = 1)
                      WHEN v_filterdatetype = 'draft' THEN COALESCE(r.routingstatustypeid, 1) = 1
                      ELSE (CASE WHEN v_filterdatetypeforrouting IS NULL THEN (r.routingstatustypeid IN (904) OR COALESCE(r.routingstatustypeid, 1) = 1)
                                 ELSE r.routingstatustypeid = ANY(v_filterdatetypeforrouting) END)
            END)
            AND (CASE WHEN v_turnaround_hours IS NOT NULL THEN (EXTRACT(epoch FROM (r.updatedon - r.insertedon)) / 3600 > v_turnaround_hours) ELSE TRUE END)
            AND (v_startdate IS NULL OR psm.insertedon::date >= v_startdate::date)
    		AND (v_enddate IS NULL OR psm.insertedon::date <= v_enddate::date)
    		AND (CASE WHEN (v_teamid IS NOT NULL and v_teamid != '') THEN t.teamid = v_teamid::uuid ELSE true END)

    ) a;

    SELECT 
          
                json_agg(sort_details) into v_result from ( 
       SELECT 
        CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname) AS clientname,
        psm.medicationname,
        psm.dateprescribed::date::text AS dateprescribed,
        psm.psychotropicid,
        psm.psychotropicrequestid,
        (SELECT r3.insertedon 
         FROM routing r3 
         WHERE r3.objectid = psm.psychotropicid::VARCHAR 
           AND r3.eventcode = 'PSY' 
           AND r3.routingstatustypeid = 908 
         ORDER BY r3.insertedon DESC 
         LIMIT 1) AS submissiondate,
         COALESCE(rs.typedescription, 'Draft')  AS currentstatus,
        -- Add all other subqueries and calculations here
        (select (EXTRACT(day FROM (sum((CASE WHEN r1.insertedon = r1.updatedon THEN now() ELSE r1.updatedon END) -r1.insertedon))) || ' D, ' || 
  									EXTRACT(hour FROM (sum((CASE WHEN r1.insertedon = r1.updatedon THEN now() ELSE r1.updatedon END) -r1.insertedon))) || ' H, ' ||
  									EXTRACT(minute FROM (sum((CASE WHEN r1.insertedon = r1.updatedon THEN now() ELSE r1.updatedon END) -r1.insertedon))) || ' M '
  									) from routing r1 where r1.toroleid='CWCW' and r1.routingstatustypeid IN (904)
  									and r1.objectid =psm.psychotropicid :: VARCHAR  
  									group by r1.objectid) AS timetakenbycaseworker,
                    (select (EXTRACT(day FROM (sum((CASE WHEN r1.insertedon = r1.updatedon THEN now() ELSE r1.updatedon END) -r1.insertedon))) || ' D, ' || 
  									EXTRACT(hour FROM (sum((CASE WHEN r1.insertedon = r1.updatedon THEN now() ELSE r1.updatedon END) -r1.insertedon))) || ' H, ' ||
  									EXTRACT(minute FROM (sum((CASE WHEN r1.insertedon = r1.updatedon THEN now() ELSE r1.updatedon END) -r1.insertedon))) || ' M '
  									) from routing r1 where r1.toroleid='CWPSYCOORD' and r1.routingstatustypeid IN (900,902, 906, 907)
  									and r1.objectid =psm.psychotropicid :: VARCHAR   
  									group by r1.objectid) as timetakenbycoordinator,
  			(select (EXTRACT(day FROM (sum((CASE WHEN r1.insertedon = r1.updatedon THEN now() ELSE r1.updatedon END) -r1.insertedon))) || ' D, ' || 
  									EXTRACT(hour FROM (sum((CASE WHEN r1.insertedon = r1.updatedon THEN now() ELSE r1.updatedon END) -r1.insertedon))) || ' H, ' ||
  									EXTRACT(minute FROM (sum((CASE WHEN r1.insertedon = r1.updatedon THEN now() ELSE r1.updatedon END) -r1.insertedon))) || ' M '
  									) from routing r1 where r1.toroleid='CWPSYPSYCH' and r1.routingstatustypeid IN (903, 906, 907)
  									and r1.objectid =psm.psychotropicid :: VARCHAR  
  									group by r1.objectid ) as timetakenbypsychiatrist,
  			(select (EXTRACT(day FROM (sum((CASE WHEN r1.insertedon = r1.updatedon THEN now() ELSE r1.updatedon END) -r1.insertedon))) || ' D, ' || 
  									EXTRACT(hour FROM (sum((CASE WHEN r1.insertedon = r1.updatedon THEN now() ELSE r1.updatedon END) -r1.insertedon))) || ' H, ' ||
  									EXTRACT(minute FROM (sum((CASE WHEN r1.insertedon = r1.updatedon THEN now() ELSE r1.updatedon END) -r1.insertedon))) || ' M '
  									) from routing r1 where r1.toroleid='CWPSYPHARM' and r1.routingstatustypeid IN (901, 906, 907)
  									and r1.objectid =psm.psychotropicid :: VARCHAR  
  									group by r1.objectid) as timetakenbypharmacist,
  			(SELECT 
    (EXTRACT(day FROM (CASE 
                         WHEN r1.updatedon = r1.insertedon THEN CURRENT_TIMESTAMP 
                         ELSE r1.updatedon 
                       END - r1.insertedon)) || ' D, ' || 
     EXTRACT(hour FROM (CASE 
                         WHEN r1.updatedon = r1.insertedon THEN CURRENT_TIMESTAMP 
                         ELSE r1.updatedon 
                       END - r1.insertedon)) || ' H, ' || 
     EXTRACT(minute FROM (CASE 
                         WHEN r1.updatedon = r1.insertedon THEN CURRENT_TIMESTAMP 
                         ELSE r1.updatedon 
                       END - r1.insertedon)) || ' M ' ) as timeundercommonpool
FROM routing r1 
WHERE r1.fromroleid = 'CWCW' 
  AND r1.routingstatustypeid IN (908) 
  AND r1.objectid = psm.psychotropicid :: VARCHAR
LIMIT 1
 ),

  (select  (EXTRACT(day FROM ((case when r1.routingstatustypeid IN (16,905) then r1.insertedon else (CASE WHEN r1.insertedon = r1.updatedon THEN now() ELSE r1.updatedon END)end) -(select r2.insertedon  from routing r2 where r2.eventcode='PSY'  
and r2.objectid =psm.psychotropicid :: VARCHAR  order by r2.insertedon asc limit 1))) || ' D, ' || 
  									EXTRACT(hour FROM ((case when r1.routingstatustypeid IN (16,905) then r1.insertedon else (CASE WHEN r1.insertedon = r1.updatedon THEN now() ELSE r1.updatedon END)end) -(select r2.insertedon  from routing r2 where r2.eventcode='PSY'  
and r2.objectid =psm.psychotropicid :: VARCHAR  order by r2.insertedon asc limit 1))) || ' H, ' ||
  									EXTRACT(minute FROM ((case when r1.routingstatustypeid IN (16,905) then r1.insertedon else (CASE WHEN r1.insertedon = r1.updatedon THEN now() ELSE r1.updatedon END)end) -(select r2.insertedon  from routing r2 where r2.eventcode='PSY'  
and r2.objectid =psm.psychotropicid :: VARCHAR  order by r2.insertedon asc limit 1))) || ' M '
  									) from routing r1 where r1.eventcode='PSY'  and r1.activeflag=1
  									and r1.objectid =psm.psychotropicid :: VARCHAR   limit 1)  as totaltimetakenforreview
           
       

            
        FROM 
            routing r
            LEFT JOIN psychotropicmedications psm ON psm.psychotropicid:: VARCHAR = r.objectid
            LEFT JOIN person p ON p.personid = psm.personid::uuid
            LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = psm.insertedby and tma.activeflag = 1
			LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
			LEFT JOIN routingstatustype rs on rs.sequencenumber =r.routingstatustypeid
        WHERE 
            r.eventcode = 'PSY' 
            AND r.activeflag = 1 
            and psm.psychotropicid is not null
            AND (CASE WHEN v_medicationname IS NOT NULL THEN psm.medicationname ILIKE '%' || v_medicationname || '%' ELSE TRUE END)
            AND (CASE WHEN v_prescribername IS NOT NULL THEN psm.prescribername ILIKE '%' || v_prescribername || '%' ELSE TRUE END)
            AND (CASE WHEN v_countyid IS NOT NULL THEN t.countyid = v_countyid ELSE TRUE END)
            AND (CASE WHEN v_caseworkid IS NOT NULL THEN psm.insertedby = v_caseworkid ELSE TRUE END)
			AND (CASE WHEN v_dateprescribed IS NOT NULL THEN psm.dateprescribed::DATE = v_dateprescribed::date ELSE TRUE END)
            AND (CASE WHEN v_submissiondate IS NOT NULL THEN  (SELECT r3.insertedon 
         FROM routing r3 
         WHERE r3.objectid = psm.psychotropicid::VARCHAR 
           AND r3.eventcode = 'PSY' 
           AND r3.routingstatustypeid = 908 
         ORDER BY r3.insertedon DESC 
         LIMIT 1)::date = v_submissiondate::DATE  ELSE TRUE END)
            AND (CASE WHEN v_reviewcoordinator IS NOT NULL THEN (r.tosecurityusersid = v_reviewcoordinator AND toroleid = 'CWPSYCOORD') ELSE TRUE END)
            AND (CASE WHEN v_pharmacist IS NOT NULL THEN (r.tosecurityusersid = v_pharmacist AND toroleid = 'CWPSYPHARM') ELSE TRUE END)
            AND (CASE WHEN v_psychiatrist IS NOT NULL THEN (r.tosecurityusersid = v_psychiatrist AND toroleid = 'CWPSYPSYCH') ELSE TRUE END)
            AND (CASE WHEN v_objectid IS NOT NULL THEN psm.objectid = v_objectid ELSE TRUE END)
            AND (CASE WHEN v_psychotropicrequestid IS NOT NULL THEN psm.psychotropicrequestid = v_psychotropicrequestid::int ELSE TRUE END)
			AND (CASE WHEN v_age IS NOT NULL 
    THEN DATE_PART('year', AGE(CURRENT_DATE, p.dob)) <= v_age 
    ELSE TRUE  END)
            AND (CASE WHEN v_clientname IS NOT NULL THEN CONCAT(p.firstname,  ' ', p.lastname) ILIKE '%' || v_clientname || '%' ELSE TRUE END)
            AND (CASE WHEN v_filterdatetype = 'all' THEN (r.routingstatustypeid IN (900, 901, 902, 903, 904, 905, 906, 907, 16, 908) OR COALESCE(r.routingstatustypeid, 1) = 1)
                      WHEN v_filterdatetype = 'draft' THEN COALESCE(r.routingstatustypeid, 1) = 1
                      ELSE (CASE WHEN v_filterdatetypeforrouting IS NULL THEN (r.routingstatustypeid IN (904) OR COALESCE(r.routingstatustypeid, 1) = 1)
                                 ELSE r.routingstatustypeid = ANY(v_filterdatetypeforrouting) END)
            END)
             AND (CASE WHEN v_turnaround_hours IS NOT NULL THEN (EXTRACT(epoch FROM (r.updatedon - r.insertedon)) / 3600 > v_turnaround_hours) ELSE TRUE END)
            AND (v_startdate IS NULL OR psm.insertedon::date >= v_startdate::date)
    		AND (v_enddate IS NULL OR psm.insertedon::date <= v_enddate::date)
    		AND (CASE WHEN (v_teamid IS NOT NULL and v_teamid != '') THEN t.teamid = v_teamid::uuid ELSE true END)
            AND (case when v_countfilter ='pendingreviewcoordinator' then (r.routingstatustypeid IN (900, 906, 907) 
                       AND (r.routingstatustypeid <> 906 OR r.fromroleid = 'CWPSYCOORD') 
                       AND (r.routingstatustypeid <> 907 OR r.fromroleid = 'CWPSYCOORD') )  ELSE TRUE END )
            AND (case when v_countfilter ='pendingpsychiatrist' then (r.routingstatustypeid IN (903, 906, 907) 
                       AND (r.routingstatustypeid <> 906 OR r.fromroleid = 'CWPSYPSYCH') 
                       AND (r.routingstatustypeid <> 907 OR r.fromroleid = 'CWPSYPSYCH') )  ELSE TRUE END )
            AND (case when v_countfilter ='pendingpharmacist' then (r.routingstatustypeid IN (901, 906, 907) 
                       AND (r.routingstatustypeid <> 906 OR r.fromroleid = 'CWPSYPHARM') 
                       AND (r.routingstatustypeid <> 907 OR r.fromroleid = 'CWPSYPHARM') )  ELSE TRUE END )
            AND (case when v_countfilter ='totalpending' then (r.routingstatustypeid NOT IN (16, 905, 904) )  ELSE TRUE END )
            AND (case when v_countfilter ='pendingcommonpool' then (r.routingstatustypeid IN (908, 902) )  ELSE TRUE END )
            AND (case when v_countfilter ='return_worker' then (r.routingstatustypeid IN (904) )  ELSE TRUE END )
             AND (case when v_countfilter ='all' then (r.routingstatustypeid IN (900, 901, 902, 903, 904, 905, 906, 907, 16, 908) )  ELSE TRUE END )
              AND (case when v_countfilter ='approved' then (r.routingstatustypeid IN (16) )  ELSE TRUE END )
              AND (case when v_countfilter ='rejected' then (r.routingstatustypeid IN (905) )  ELSE TRUE END )
            AND Case when v_medicationsearch is not null then psm.medicationname ilike '%' || v_medicationsearch  || '%'else true end
			AND Case when v_clientnamesearch is not null then CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname) ilike '%' || v_clientnamesearch || '%' else true end
			AND Case when v_dateprescribedsearch is not null then psm.dateprescribed=v_dateprescribedsearch::date else true end
            
   order by 			( CASE v_sortorder
      WHEN 'asc'
      THEN
        CASE v_sortcolumn
        WHEN 'Medication' THEN (psm.medicationname)
		WHEN 'Client Name' THEN (CONCAT(p.firstname, ' ', p.lastname))
		WHEN 'Prescription Date' THEN ((psm.dateprescribed ::timestamp)::character varying)
		WHEN 'Current Status' THEN (rs.typedescription)
		WHEN 'Submission Date' THEN ((SELECT r3.insertedon ::timestamp
         FROM routing r3 
         WHERE r3.objectid = psm.psychotropicid::VARCHAR 
           AND r3.eventcode = 'PSY' 
           AND r3.routingstatustypeid = 908 
         ORDER BY r3.insertedon DESC 
         LIMIT 1)::character varying)
		end
end) asc nulls last,
    (  CASE v_sortorder
      WHEN 'desc'
      THEN
        CASE v_sortcolumn
        WHEN 'Medication' THEN (psm.medicationname)
		WHEN 'Client Name' THEN (CONCAT(p.firstname, ' ', p.lastname))
		WHEN 'Prescription Date' THEN ((psm.dateprescribed ::timestamp)::character varying)
		WHEN 'Current Status' THEN (rs.typedescription)
		WHEN 'Submission Date' THEN ((SELECT r3.insertedon ::timestamp
         FROM routing r3 
         WHERE r3.objectid = psm.psychotropicid::VARCHAR 
           AND r3.eventcode = 'PSY' 
           AND r3.routingstatustypeid = 908 
         ORDER BY r3.insertedon DESC 
         LIMIT 1)::character varying)
		end
end) DESC nulls last LIMIT  pagelimit OFFSET    v_pagenumber )
     as sort_details;
    
    RETURN json_build_object('details',v_result,'count',v_resultcount);
END;
$$;