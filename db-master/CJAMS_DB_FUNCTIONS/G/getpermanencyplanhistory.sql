DROP FUNCTION IF EXISTS cjams.getpermanencyhistory(v_personid character varying, _page integer, _limit integer, sortcol character varying, sortby character varying,
													v_updatedfrom character varying, v_updatedto character varying, caseworker character varying);
CREATE OR REPLACE FUNCTION cjams.getpermanencyhistory(v_personid character varying, _page integer, _limit integer, sortcol character varying, sortby character varying, v_updatedfrom character varying, v_updatedto character varying, caseworker character varying)
 RETURNS TABLE(totalcount bigint, permanencyplanhistoryid uuid, permanencyplanid uuid, intakeservicerequestactorid uuid, intakeserviceid uuid, servicecaseid uuid, placementid uuid, permanencyplanremainssame boolean, projecteddate timestamp without time zone, establisheddate timestamp without time zone, enddate timestamp without time zone, caseworkername character varying, status character varying, insertedon timestamp without time zone, insertedby character varying, updatedon timestamp without time zone, updatedby character varying, servicecasenumber character varying, primarypermanencytype character varying, concurrentpermanencytype character varying, inserteduserdetails json, updateduserdetails json)
 LANGUAGE plpgsql
AS $function$

DECLARE                    
_offset    integer;


BEGIN
_offset  :=  (_page  -  1)  *  _limit;    

 
RETURN  QUERY  

SELECT  
	COUNT(1)  OVER()  AS  totalcount, 
	a.permanencyplanhistoryid,
	a.permanencyplanid ,
	a.intakeservicerequestactorid,
	a.intakeserviceid,
	a.servicecaseid,
	a.placementid,
	a.permanencyplanremainssame, 
	a.projecteddate, 	 
	a.establisheddate,
	a.enddate,
	a.caseworkername,
 	a.status,
	a.insertedon,
	a.insertedby,
	a.updatedon,
	a.updatedby,
	a.servicecasenumber,
	a.primarypermanencytype,
	a.concurrentpermanencytype,
	a.inserteduserdetails,
	a.updateduserdetails
	
	from (
/*	
SELECT  
	COUNT(1)  OVER()  AS  totalcount, 
	pph.permanencyplanhistoryid as permanencyplanhistoryid,
	pph.permanencyplanid as permanencyplanid ,
	pph.intakeservicerequestactorid as intakeservicerequestactorid,
	pph.intakeserviceid as intakeserviceid,
	pph.servicecaseid as servicecaseid,
	pph.placementid as placementid,
	pph.projecteddate as projecteddate, 	 
	pph.establisheddate as establisheddate,
	pph.enddate as enddate,
	pph.caseworkername as caseworkername,
 	pph.status as status,
	pph.insertedon as insertedon,
	pph.insertedby as insertedby,
	pph.updatedon as updatedon,
	pph.updatedby as updatedby,
	 
	(select sc.servicecasenumber from servicecase sc where sc.servicecaseid=pp.servicecaseid) as servicecasenumber,
	(select ppt.description from permanencyplantype ppt where ppt.permanencyplantypekey =pp.primarypermanencytype) as primarypermanencytype,
	(select ppt.description from permanencyplantype ppt where ppt.permanencyplantypekey =pp.concurrentpermanencytype) as concurrentpermanencytype,	
	(SELECT to_json (e) FROM (	 						
		SELECT  tm.roletypekey ,r.description ,t.teamid , up.firstname ,up.lastname  ,t.teamname                                                                                                      
		FROM   teammemberassignment tma  
		INNER JOIN  teammember tm  ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1                                                                                                                                                                                     
		inner join team t on t.teamid = tm.teamid  and t.activeflag =1                                                                                                                                                                                         
		inner join userprofile up on up.securityusersid = tma.securityusersid 
		inner join role r on r.roletypekey=tm.roletypekey                                                                                                                                                                                  
		and up.activeflag =1  WHERE  tma.SecurityUsersId = pph.insertedby  AND   tma.activeflag =1  limit 1) e 
	) :: json as inserteduserdetails,	
	(SELECT to_json (e) FROM (	 						
		SELECT  tm.roletypekey ,r.description ,t.teamid , up.firstname ,up.lastname  ,t.teamname                                                                                                      
		FROM   teammemberassignment tma  
		INNER JOIN  teammember tm  ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1                                                                                                                                                                                     
		inner join team t on t.teamid = tm.teamid  and t.activeflag =1                                                                                                                                                                                         
		inner join userprofile up on up.securityusersid = tma.securityusersid 
		inner join role r on r.roletypekey=tm.roletypekey                                                                                                                                                                                  
		and up.activeflag =1  WHERE  tma.SecurityUsersId = pph.updatedby  AND   tma.activeflag =1 limit 1) e 
	) :: json as updateduserdetails	 
	from permanencyplan pp 
	inner join intakeservicerequestactor isra on pp.intakeservicerequestactorid=isra.intakeservicerequestactorid  
	inner join actor a on a.actorid = isra.actorid  
	inner join person p on p.personid = a.personid  
	and isra.intakeservicerequestactorid in (select iaa.intakeservicerequestactorid  
	from intakeservicerequestactor iaa where iaa.personid =  v_personid :: uuid)
	inner join 
	permanencyplanhistory pph on pp.permanencyplanid=pph.permanencyplanid and pp.activeflag=1 and pph.status = 'Approved'
	and pph.permanencyplanid :: character varying not in (select ro.objectid 
	 from routing ro where ro.eventcode = 'PPLR' and ro.activeflag = 1 and ro.objectid = pp.permanencyplanid :: character varying 
	 order by ro.updatedon desc limit 1)
	
	
	union all
		*/	
	SELECT  
 	COUNT(1)  OVER()  AS  totalcount, 
	null::uuid as permanencyplanhistoryid,
	pp.permanencyplanid as permanencyplanid ,
	pp.intakeservicerequestactorid as intakeservicerequestactorid,
	pp.intakeserviceid as intakeserviceid,
	pp.servicecaseid as servicecaseid,
	pp.placementid as placementid,
	pp.permanencyplanremainssame as permanencyplanremainssame,
	pp.projecteddate as projecteddate, 	 
	pp.establisheddate as establisheddate,
	pp.enddate as enddate,
	pp.caseworkername as caseworkername,
 	(select (case when ro.routingstatustypeid = 16 then 'Approved' when ro.routingstatustypeid = 15 then 'Pending' when ro.routingstatustypeid = 17 then 'Rejected' else '' end) 
	 from routing ro where ro.eventcode = 'PPLR' and ro.activeflag = 1 and ro.objectid = pp.permanencyplanid :: character varying 
	 order by ro.updatedon desc limit 1) :: character varying as status,
	pp.insertedon as insertedon,
	pp.insertedby as insertedby,
	pp.updatedon as updatedon,
	pp.updatedby as updatedby,
	(select sc.servicecasenumber from servicecase sc where sc.servicecaseid=pp.servicecaseid) as servicecasenumber,
	(select ppt.description from permanencyplantype ppt where ppt.permanencyplantypekey =pp.primarypermanencytype) as primarypermanencytype,
	(select ppt.description from permanencyplantype ppt where ppt.permanencyplantypekey =pp.concurrentpermanencytype) as concurrentpermanencytype,	
	(SELECT to_json (e) FROM (	 						
		SELECT  tm.roletypekey ,r.description ,t.teamid , up.firstname ,up.lastname  ,t.teamname                                                                                                      
		FROM   teammemberassignment tma  
		INNER JOIN  teammember tm  ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1                                                                                                                                                                                     
		inner join team t on t.teamid = tm.teamid  and t.activeflag =1                                                                                                                                                                                         
		inner join userprofile up on up.securityusersid = tma.securityusersid 
		inner join role r on r.roletypekey=tm.roletypekey                                                                                                                                                                                  
		and up.activeflag =1  WHERE  tma.SecurityUsersId = pp.insertedby  AND   tma.activeflag =1  limit 1) e 
	) :: json as inserteduserdetails,	
	(SELECT to_json (e) FROM (	 						
		SELECT  tm.roletypekey ,r.description ,t.teamid , up.firstname ,up.lastname  ,t.teamname                                                                                                      
		FROM   teammemberassignment tma  
		INNER JOIN  teammember tm  ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1                                                                                                                                                                                     
		inner join team t on t.teamid = tm.teamid  and t.activeflag =1                                                                                                                                                                                         
		inner join userprofile up on up.securityusersid = tma.securityusersid 
		inner join role r on r.roletypekey=tm.roletypekey                                                                                                                                                                                  
		and up.activeflag =1  WHERE  tma.SecurityUsersId = pp.updatedby  AND   tma.activeflag =1  limit 1) e 
	) :: json as updateduserdetails	 
	from permanencyplan pp 
	inner join intakeservicerequestactor isra on pp.intakeservicerequestactorid=isra.intakeservicerequestactorid AND pp.activeflag=1 
	inner join actor a on a.actorid = isra.actorid  
	inner join person p on p.personid = a.personid  
	and isra.intakeservicerequestactorid in (select iaa.intakeservicerequestactorid  
	from intakeservicerequestactor iaa where iaa.personid =  v_personid :: uuid) 
	inner join routing r on r.objectid = pp.permanencyplanid :: character varying where r.eventcode = 'PPLR' and r.activeflag = 1 and r.routingstatustypeid = 16
	/*and pp.permanencyplanid not in ( select ppl.permanencyplanid 
	from permanencyplan ppl 
	inner join intakeservicerequestactor isra on ppl.intakeservicerequestactorid=isra.intakeservicerequestactorid  
	inner join actor a on a.actorid = isra.actorid  
	inner join person p on p.personid = a.personid  
	and isra.intakeservicerequestactorid in (select iaa.intakeservicerequestactorid  
	from intakeservicerequestactor iaa where iaa.personid =  v_personid :: uuid)
	inner join 
	permanencyplanhistory pph on ppl.permanencyplanid=pph.permanencyplanid and pp.activeflag=1
	)	*/ 
	
	
		) a 
--	order by status asc
--	order by sortcol|| ' '|| sortby
where
		CASE    WHEN (v_updatedfrom IS NOT NULL and  v_updatedto is not null)  and ( v_updatedfrom !='' and v_updatedto !='' )
				THEN to_date(cast(a.updatedon::date as text), 'YYYY-MM-DD') 
				BETWEEN to_date(cast(v_updatedfrom::date as TEXT), 'YYYY-MM-DD') and to_date(cast(v_updatedto::date as text), 'YYYY-MM-DD')
   	   
				WHEN (v_updatedto IS NOT NULL and  v_updatedto !='') and  (v_updatedfrom is null  or  v_updatedfrom ='' )
		   	 	THEN to_date(cast(a.updatedon::date as text), 'YYYY-MM-DD')<= to_date(cast(v_updatedto::date as TEXT), 'YYYY-MM-DD') 
        
   	 			WHEN (v_updatedfrom IS NOT null and v_updatedfrom !='' ) and (v_updatedto ='' or v_updatedto is null)   
		      	THEN to_date(cast(a.updatedon::date as text), 'YYYY-MM-DD')>= to_date(cast(v_updatedfrom::date as TEXT), 'YYYY-MM-DD') 
	    ELSE true end
	  
   and case when caseworker is not null and caseworker!='' then a.updatedby = caseworker  else true end 
	
	order by (
				case sortby when 'asc' then 
											case sortcol-- when 'totalcount' THEN a.totalcount :: bigint 
														 when 'permanencyplanhistoryid' then a.permanencyplanhistoryid :: character varying 
														when 'permanencyplanid' then  a.permanencyplanid :: character varying 
 														when 'intakeservicerequestactorid' then a.intakeservicerequestactorid ::  character varying 
														when 'intakeserviceid' then a.intakeserviceid ::  character varying 
														when 'servicecaseid' then a.servicecaseid :: character varying 
														when 'placementid' then a.placementid :: character varying 
														when 'permanencyplanremainssame' then 	a.permanencyplanremainssame :: character varying
														when 'projecteddate' then 	a.projecteddate	:: character varying
														when 'establisheddate' then 	a.establisheddate :: character varying
														when 'enddate' then 	a.enddate :: character varying
														when 'caseworkername' then 	a.caseworkername :: character varying 
														when 'status' then  	a.status :: character varying 
														when 'insertedon' then 	a.insertedon :: character varying
														when 'insertedby' then 	a.insertedby :: character varying 
														when 'updatedon' then 	a.updatedon :: character varying
														when 'updatedby' then    a.updatedby ::character varying
														when 'servicecasenumber' then 	a.servicecasenumber :: character varying 
														when 'primarypermanencytype' then 	a.primarypermanencytype :: character varying 
														when 'concurrentpermanencytype' then 	a.concurrentpermanencytype :: character varying 
														when 'inserteduserdetails' then 	a.inserteduserdetails ::  character varying 
														when 'updateduserdetails' then 	a.updateduserdetails ::  character varying
									        END
             	END) asc NULLS last,
			(	case sortby when 'desc' then 
											case sortcol-- when 'totalcount' THEN a.totalcount :: bigint 
														 when 'permanencyplanhistoryid' then a.permanencyplanhistoryid :: character varying 
														when 'permanencyplanid' then  a.permanencyplanid :: character varying 
 														when 'intakeservicerequestactorid' then a.intakeservicerequestactorid ::  character varying 
														when 'intakeserviceid' then a.intakeserviceid ::  character varying 
														when 'servicecaseid' then a.servicecaseid :: character varying 
														when 'placementid' then a.placementid :: character varying 
														when 'permanencyplanremainssame' then 	a.permanencyplanremainssame :: character varying
														when 'projecteddate' then 	a.projecteddate	:: character varying
														when 'establisheddate' then 	a.establisheddate :: character varying
														when 'enddate' then 	a.enddate :: character varying
														when 'caseworkername' then 	a.caseworkername :: character varying 
														when 'status' then  	a.status :: character varying 
														when 'insertedon' then 	a.insertedon :: character varying
														when 'insertedby' then 	a.insertedby :: character varying 
														when 'updatedon' then 	a.updatedon :: character varying
														when 'updatedby' then    a.updatedby ::character varying
														when 'servicecasenumber' then 	a.servicecasenumber :: character varying 
														when 'primarypermanencytype' then 	a.primarypermanencytype :: character varying 
														when 'concurrentpermanencytype' then 	a.concurrentpermanencytype :: character varying 
														when 'inserteduserdetails' then 	a.inserteduserdetails ::  character varying 
														when 'updateduserdetails' then 	a.updateduserdetails ::  character varying
									        END
             	END) desc NULLS last
		
	LIMIT _limit OFFSET _offset;
 
END;

$function$
;