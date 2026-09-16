DROP FUNCTION IF EXISTS cjams.checkplacementvalidation(bigint);
CREATE OR REPLACE FUNCTION cjams.checkplacementvalidation(v_alternateid bigint, v_fromscreen character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE 
v_status  character varying;
v_placementid uuid;
v_placement_entrydate timestamp without time zone;
v_placement_revision_entrydate timestamp without time zone;
v_exitdate timestamp without time zone;
v_alternateplacementid bigint;
 
v_routingstatustypeid  int;
v_eventcode character varying;

v_placementrevisioncount  int;
v_placementcount  int;
v_approvedplacementcount int;
v_activeplacementrevisioncount int; 
begin
	if (v_fromscreen = 'pv') then 
	v_status:= 'Y';  --Y means existing placement
	else
 	update Tb_placement_auto_validation_log set activeflag=0 
 	where placement_id=	v_alternateid;
 
	SELECT count(*) as placementcount,pl.alternateid, 
		   pl.startdatetime::date, pl.enddatetime::date,placementid
	INTO   v_placementcount,v_alternateplacementid,
		   v_placement_entrydate,v_exitdate ,v_placementid
	from  placement pl where pl.alternateid=v_alternateid
	group by pl.alternateid, 
		   pl.startdatetime, pl.enddatetime,placementid;
	 
	RAISE NOTICE 'v_placementcount:%', v_placementcount;
	RAISE NOTICE 'v_alternateplacementid:%', v_alternateplacementid;
	RAISE NOTICE 'v_entryddate:%', v_placementcount;
	RAISE NOTICE 'v_exitdate:%', v_alternateplacementid;
	RAISE NOTICE 'v_placementid:%', v_placementid;

	SELECT routingstatustypeid,eventcode into v_routingstatustypeid,v_eventcode
	FROM routing WHERE routingstatustypeid =16 AND eventcode ='PLTR' AND activeflag =1 --and fromroleid='CWSP' and toroleid='CWCW'
	and objectid=v_placementid 	:: character varying  
	order by insertedon desc limit 1 ;
	RAISE NOTICE 'v_routingstatustypeid:%', v_routingstatustypeid;

   	SELECT count(*)
	INTO   v_placementrevisioncount		    
	FROM placementrevision plr
	where plr.placementid=v_placementid and plr.approvalstatustypkey='3045'; -- and plr.activeflag=1;
		RAISE NOTICE 'v_placementrevisioncount:%', v_placementrevisioncount;

		SELECT count(*)
	INTO   v_activeplacementrevisioncount		    
	FROM placementrevision plr
	where plr.placementid=v_placementid and plr.approvalstatustypkey='3045' and plr.activeflag=1;
		RAISE NOTICE 'v_placementrevisioncount:%', v_placementrevisioncount;
		
	SELECT entrydate::date
	INTO   v_placement_revision_entrydate		    
	FROM placementrevision plr
	where plr.placementid=v_placementid and plr.approvalstatustypkey='3045' 
	order by updatedon desc limit 1;

	SELECT count(*)
	INTO   v_approvedplacementcount		    
	FROM placementrevision plr
	where plr.placementid=v_placementid and plr.approvalstatustypkey='3047'; -- and plr.activeflag=1;
		RAISE NOTICE 'v_approvedplacementcount:%', v_approvedplacementcount;
	  if (v_placementcount=1 
	  and v_placementrevisioncount>=1 
	  and (v_approvedplacementcount=0 or v_approvedplacementcount=1 or v_approvedplacementcount is null) 
	  and (v_activeplacementrevisioncount = 1 and v_approvedplacementcount<>1)	   
	  and v_exitdate is null  and v_placement_entrydate is not null and (v_placement_entrydate=v_placement_revision_entrydate)) 
	   then
	   v_status:= 'P'; -- P means new placement
	   
	   elseif (v_placementcount=1 
	  and v_placementrevisioncount>=1 
	  and (v_approvedplacementcount=0 or v_approvedplacementcount=1 or v_approvedplacementcount is null) 
	  and (v_activeplacementrevisioncount = 0 and v_approvedplacementcount=1)	   
	  and v_exitdate is null  and v_placement_entrydate is not null and (v_placement_entrydate=v_placement_revision_entrydate)) 
	   then
	   v_status:= 'P'; -- P means new placement
 	  elseif (v_placementcount=1 
	  and v_placementrevisioncount>=1 
	  and (v_approvedplacementcount=0 or v_approvedplacementcount=1 or v_approvedplacementcount is null) 
	  and (v_activeplacementrevisioncount = 1 and v_approvedplacementcount<>1)	   
	  and v_exitdate is null  and v_placement_entrydate is not null and (v_placement_entrydate<>v_placement_revision_entrydate)) 
	   then
	   v_status:= 'P'; -- P means new placement
     else
     v_status:= 'Y';  --Y means existing placement
    end if;	
	end if;			
RETURN v_status;
		
END;

$function$;
