-- FUNCTION: cjams.getdispositionhistory(uuid, integer, integer)

DROP FUNCTION cjams.getdispositionhistory(uuid, integer, integer);

CREATE OR REPLACE FUNCTION cjams.getdispositionhistory(
	servicerequestid uuid,
	pageno integer,
	pagesize integer)
RETURNS TABLE(totalcount bigint, displaydate timestamp without time zone, dispstatus text, insertedon timestamp without time zone, disposition text,
rejectioncomments text,  userrole character varying, loadnumber character varying, username character varying, reviewcomments text, routingstatus text, intakeservicerequestdispositioncodeid uuid, approvedby CHARACTER varying, approvedon timestamp without time zone)
    LANGUAGE 'plpgsql'
    VOLATILE 
    COST 100
    ROWS 1000
AS $BODY$

DECLARE 
	categoryid uuid;
	subcategoryid uuid;
	targetid uuid;
BEGIN

      
RETURN QUERY 	
		/*
		 Select  count(1) OVER() totalcount, min(sd.insertedon) as displaydate, st.Description as dispstatus,cc.description as disposition ,
		cast(max(u.RoleTypeKey) as character varying) as userrole,
		cast(max(u.LoadNumber) as character varying) as LoadNumber, 
		cast( max(up.displayname) as character varying) as username,
		max(coalesce(sd.reviewcomments,'')) 
		 from IntakeServiceRequestDispositionCode sd  
		inner join IntakeSerReqStatusType st on st.IntakeSerReqStatusTypeid = sd.IntakeSerReqStatusTypeid  
		 left join servicerequesttypeconfigdispositioncode cc on cc.ServiceRequestTypeConfigIdDispostionId = sd.ServiceRequestTypeConfigIdDispostionId
		 inner join (
		SELECT TMA.SecurityUsersId , max(coalesce(TM.RoleTypeKey,'')) AS RoleTypeKey, max( coalesce(TM.LoadNumber,'') ) AS LoadNumber    
		FROM TeamMemberAssignment TMA    
		  JOIN TeamMember TM ON TMA.TeamMemberId = TM.TeamMemberId    
		  group by TMA.SecurityUsersId ) u on u.SecurityUsersId = sd.insertedby
		  inner join userprofile up on up.SecurityUsersId = sd.insertedby
		where IntakeServiceId= servicerequestid
		 group by sd.IntakeSerReqStatusTypeid, sd.ServiceRequestTypeConfigIdDispostionId, st.Description,cc.DispositionCode,cc.description , sd.insertedby
		 ,u.RoleTypeKey,u.LoadNumber,up.displayname
		 order by min(sd.insertedon)  desc
		 limit pagesize  offset pageno ;*/
		 
		 
		 Select  count(1) OVER() totalcount,  
		   coalesce( 
			(select r.insertedon from routing r
			WHERE r.eventcode = 'INDR' AND r.objectid=sd.intakeservicerequestdispositioncodeid :: character varying and r.routingstatustypeid = 15 order by insertedon desc limit 1), 
			sd.statusdate, 
			sd.insertedon
			) as displaydate, 
		 st.Description as dispstatus, sd.insertedon as insertedon,  cc.description as disposition ,
		(select r.remarks from routing r
			WHERE r.eventcode = 'INDR' AND 
			r.objectid=sd.intakeservicerequestdispositioncodeid :: character varying and r.routingstatustypeid = 17 
			order by r.insertedon desc limit 1)
			as rejectioncomments,
		--cast( (rt.RoleTypename) as character varying) as userrole,
		case when r.roletypekey like 'JS%' then r.description else cast( (rt.RoleTypename) as character varying) end as userrole,
		cast( (u.LoadNumber) as character varying) as LoadNumber, 
		(SELECT up.displayname from routing r
			INNER JOIN userprofile  up ON up.securityusersid = r.fromsecurityusersid
			WHERE r.eventcode = 'INDR' AND r.objectid  =  sd.intakeservicerequestdispositioncodeid :: character varying and r.routingstatustypeid = 15 ORDER BY r.insertedon DESC LIMIT 1) as username,
		 (coalesce(sd.reviewcomments,'')),
		  (SELECT rs.typedescription from routing r
			INNER JOIN routingstatustype  rs ON r.routingstatustypeid = rs.sequencenumber
			WHERE r.eventcode = 'INDR' AND r.objectid  =  sd.intakeservicerequestdispositioncodeid :: character varying and r.activeflag = 1 ORDER BY r.insertedon DESC LIMIT 1) routingstatus,
			sd.intakeservicerequestdispositioncodeid
			,
			    ( SELECT displayname  AS approvedby
                  FROM   userprofile up 
                  INNER JOIN routing r 
                  ON r.objectid  =  sd.intakeservicerequestdispositioncodeid :: character varying
                  WHERE up.securityusersid = r.fromsecurityusersid 
                  AND r.eventcode = 'INDR' 
                  and r.routingstatustypeid = 16
                  AND r.activeflag = 1 
                  ORDER BY r.insertedon 
                  LIMIT 1 )
				,( SELECT r.insertedon  AS approvedon
                  FROM  routing r 
                  WHERE --up.securityusersid = r.fromsecurityusersid and
				  r.objectid  =  sd.intakeservicerequestdispositioncodeid :: character varying
                  AND r.eventcode = 'INDR' 
                  and r.routingstatustypeid = 16
                  AND r.activeflag = 1 
                  ORDER BY r.insertedon 
                  LIMIT 1 )
		 from IntakeServiceRequestDispositionCode sd  
		inner join IntakeSerReqStatusType st on st.IntakeSerReqStatusTypeid = sd.IntakeSerReqStatusTypeid and st.activeflag = 1 and sd.activeflag = 1
		 left join servicerequesttypeconfigdispositioncode cc on cc.ServiceRequestTypeConfigIdDispostionId = sd.ServiceRequestTypeConfigIdDispostionId
		 LEFT join (
					SELECT TMA.SecurityUsersId , max(coalesce(TM.RoleTypeKey,'')) AS RoleTypeKey, max( coalesce(TM.LoadNumber,'') ) AS LoadNumber    
					FROM TeamMemberAssignment TMA    
					JOIN TeamMember TM ON TMA.TeamMemberId = TM.TeamMemberId    
					group by TMA.SecurityUsersId ) u on u.SecurityUsersId = sd.insertedby
		  LEFT join userprofile up on up.SecurityUsersId = sd.insertedby
		  LEFT join role  R on r.roletypekey = u.RoleTypeKey 
		  and r.activeflag =1
		  left join roletype rt on rt.shortname = r.name
		  and rt.activeflag =1
		where IntakeServiceId= servicerequestid 
		 order by  (sd.insertedon)  desc
		  limit pagesize  offset pageno;
END;

$BODY$;

