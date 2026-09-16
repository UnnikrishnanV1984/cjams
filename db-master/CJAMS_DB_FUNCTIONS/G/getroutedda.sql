CREATE OR REPLACE FUNCTION cjams.getroutedda(userid character varying, isassigned boolean, pagenumber bigint, pagesize bigint, servicereqno character varying, sortcolumn character varying, sortorder character varying, assignedid character varying DEFAULT NULL::character varying, v_status character varying DEFAULT NULL::character varying, v_filter character varying DEFAULT NULL::character varying)
 RETURNS TABLE(totalcount bigint, offencecounty json, casecondtions json, assistid character varying, cjamspid bigint, servicereqid uuid, servicerequestnumber character varying, cpsresponse character varying, servreqtype character varying, servreqsubtype character varying, reporteddate timestamp without time zone, servreqstatus character varying, routedon timestamp without time zone, assignedto character varying, assigned boolean, assigneddate timestamp without time zone, isgroup boolean, incidentlocation character varying, acceptdate timestamp without time zone, intakenumber character varying, dadetails json, sdm json, placementfostercareapprove character varying, servicelogapprovestatus character varying, finalfindings json, legalguardian json, assignbtn boolean, appealconame character varying, raname character varying)
 LANGUAGE plpgsql
AS $function$
-----------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 10/31/2024 - Manasa Kasula - CIDM-9543- Filtering the CPS cases without action type(data issue)
-- 02/07/2025 - Manasa Kasula - CIDM-10165- Fix for CPS Case record is moving to "assigned tab" after clicking on assign later button
------------------------------------------------------------------------------------------------------------ 
/* Two parameter added sortcolumn and sortorder */

declare   

 v_pageoffset  int;
 v_pagenumber  int;
 statusval character varying;

begin

  v_pagenumber  :=  pagenumber-1;
  v_pageoffset  =  v_pagenumber  *  pagesize;
  raise notice 'v_status %',v_status;

if (isassigned  =  false)  THEN

return  query

	  SELECT  count(1) over(), *, (select getcasepersonname from getcasepersonname ('servicerequest',intakeserviceid:: CHARACTER VARYING)),
      null:: boolean, null :: character varying,
      (SELECT getreportername FROM getreportername('servicerequest',Assignlist.intakeserviceid::character varying, 'reporter')) as  clientname
      from ( 
      	  SELECT       
      	  null::json as  offencecounty,
      	  null::json  as  caseconditions,
          ''::character varying as assistid, null::bigint as cjamspid,
          ISR.intakeserviceid, cast(ISR.servicerequestnumber || case coalesce(isr.actiontype,'') when '' then '' else '('||  coalesce(isr.actiontype,'') || ')' end  
                as character varying) as servicerequestnumber,
                cast(case ISR.iscps when true then 'CPS' when false then 'Non  CPS' else '' end as character varying),
                (SELECT  itsrt.intakeservreqtypekey  FROM  intakeservicerequesttype  as  itsrt  WHERE  itsrt.intakeservreqtypeid=ISR.intakeservreqtypeid  AND  itsrt.activeflag  =1  limit  1),
                (SELECT  srst.classkey FROM servicerequestsubtype as srst WHERE srst.servicerequestsubtypeid=ISR.intakeservicerequestclassid AND srst.activeflag =1 limit 1),
                ISR.reporteddate as reporteddate,
                intakeserreqstatustypekey,
                ISR.routedon as routeddate,
                cast(up.lastname ||',  '||up.firstname as character varying) assingeduser,
                ISR.isrouted,
                R.Assignedon as assigneddate,
                false,
                cast(coalesce(isr.offenselocation,'') as character varying),
                null::timestamp without time zone,
                ISR.intakenumber as intakenumber,
                null  ::json,
                (SELECT  json_agg(e)    as  fatality  from
                (select  isrs.ischildfatality,isrs.ismaltreatment  from  intakeservicerequestsdm  isrs  where  isrs.intakenumber  =  ISR.IntakeNumber  and  activeflag  =1) as e)::json,
		            null::character varying as placementfostercareapprove
                ,null::character varying  as serviceapprovestatus,
                null::json  as finalfindings
        FROM  intakeservicerequest  as  ISR     
        INNER JOIN (SELECT  DISTINCT  objectid  ,cast(r.insertedon  as  timestamp)  assignedon  FROM  ROUTING  R 
        WHERE R.tosecurityusersid  =  userid AND routingstatustypeid in (2, 76) AND R.activeflag  =1) R ON r.objectid = ISR.intakenumber
        LEFT JOIN userprofile up on up.securityusersid  =  ISR.routedusersid  and  up.activeflag  =1
        INNER JOIN intakeserreqstatustype irst on irst.intakeserreqstatustypeid = ISR.intakeserreqstatustypeid and irst.activeflag  =1 and lower(irst.Intakeserreqstatustypekey) Not in ('closed','rejected','completed')
        WHERE ISR.servicerequestnumber  ILIKE  servicereqno  ||'%'
        AND coalesce(ISR.isrouted,false)  =isassigned
        AND ISR.teamtypekey = 'CW'
        AND ISR.activeflag  =1 AND ISR.intakeservicerequestclassid <> '00000000-0000-0000-0000-000000000000' and actiontype is not null

    	  UNION  ALL

          SELECT   
          null::json as  offencecounty,
          null::json as  caseconditions,
          ''::character varying as assistid, null::bigint as cjamspid,
          ISR.intakeserviceid,cast(ISR.servicerequestnumber ||
          case  coalesce(isr.actiontype,'') when '' then '' else '  ('||  coalesce(isr.actiontype,'') || ')' end as character varying) as servicerequestnumber,
          cast(case  ISR.iscps  when  true  then  'CPS'  when  false  then  'Non  CPS'  else  ''  end    as  character  varying),
          (SELECT  itsrt.intakeservreqtypekey  FROM  intakeservicerequesttype  as  itsrt  WHERE  itsrt.intakeservreqtypeid=ISR.intakeservreqtypeid AND itsrt.activeflag =1 limit 1),
          (SELECT  srst.classkey  FROM  servicerequestsubtype  as  srst  WHERE  srst.servicerequestsubtypeid=ISR.intakeservicerequestclassid  AND  srst.activeflag  =1    limit  1),
          ISR.reporteddate as reporteddate,
          intakeserreqstatustypekey,
          ISR.routedon as routeddate,
          cast(up.lastname  ||',  '||up.firstname  as  character  varying),
          ISR.isrouted,
          R.assignedon as assigneddate,
          false,
          cast(coalesce(isr.offenselocation,'')  as  character  varying),
          null::timestamp  without  time  zone,
          ISR.intakenumber as intakenumber,
          null  ::json,
          (SELECT  json_agg(e) as fatality  from	(select  isrs.ischildfatality,isrs.ismaltreatment from 
          intakeservicerequestsdm  isrs  where  isrs.intakenumber  =  ISR.IntakeNumber  and  activeflag  =1 )  as  e)  ::json,
          null::character varying as placementfostercareapprove
          , null::character varying  as serviceapprovestatus,null::json  as finalfindings 
          FROM  intakeservicerequest  as  ISR
          INNER  JOIN  (SELECT  DISTINCT  objectid,tosecurityusersid,cast(r.insertedon  as  timestamp)  assignedon FROM  ROUTING  R  
                                  WHERE  R.tosecurityusersid  =  userid  AND  routingstatustypeid  =9  AND  R.activeflag  =1  )  R 
          ON  r.objectid  =    cast(ISR.intakeserviceid    as  character  varying)
          LEFT  JOIN  userprofile  up  on  up.securityusersid  =  R.tosecurityusersid  and  up.activeflag  =1
          INNER  JOIN  intakeserreqstatustype  irst  on  irst.intakeserreqstatustypeid  =  ISR.intakeserreqstatustypeid
          AND  irst.activeflag  =1  AND  lower(irst.Intakeserreqstatustypekey)  Not  in ('closed','rejected','completed')
          WHERE  ISR.servicerequestnumber  ILIKE  servicereqno  ||'%'
          AND  coalesce(ISR.isrouted,false)  =isassigned
          AND ISR.teamtypekey = 'CW'  
          AND  ISR.activeflag  =1 AND ISR.intakeservicerequestclassid <> '00000000-0000-0000-0000-000000000000' and actiontype is not null         
        )  as  Assignlist  
        /* Sorting implemented by Gavaskar 10-01-2019 */
        ORDER  BY  ( CASE sortorder when 'asc' then CASE sortcolumn when 'servicerequestnumber' then cast( Assignlist.servicerequestnumber as character varying) 
		    when 'assigneddate' then cast( Assignlist.assigneddate  as character varying)
		    when 'reporteddate' then cast( Assignlist.reporteddate  as character varying)
		    when 'routeddate' then  cast( Assignlist.routeddate  as character varying)
		    when 'cjamspid' then  cast( Assignlist.cjamspid  as character varying)
		    when 'intakenumber' then  cast( Assignlist.intakenumber  as character varying)
		    ELSE cast( Assignlist.assigneddate  as character varying) end    end)  asc 
		    ,

		    ( CASE sortorder when 'desc' then CASE sortcolumn when 'servicerequestnumber' then cast( Assignlist.servicerequestnumber  as character varying)
		    when 'assigneddate' then cast( Assignlist.assigneddate  as character varying)
		    when 'reporteddate' then cast( Assignlist.reporteddate  as character varying)
		    when 'routeddate' then  cast( Assignlist.routeddate  as character varying)
		    when 'cjamspid' then  cast( Assignlist.cjamspid  as character varying)
		    when 'intakenumber' then  cast( Assignlist.intakenumber  as character varying)
		    ELSE cast( Assignlist.assigneddate  as character varying) end    end )  desc 

        LIMIT  pagesize  OFFSET  v_pageoffset ; 

ELSif(v_status in ('Completed' ))
then
  return query
  SELECT count(1) over(),  *, (SELECT * from getcasepersonname ('servicerequest',intakeserviceid:: CHARACTER VARYING)),
   (select case when count(1) >0 then true else false end as assignbtn from routing rr where rr.objectid = intakeserviceid:: CHARACTER varying and rr.eventcode = 'APPL' and rr.routingstatustypeid = 15 limit 1) as assignbtn,
   (select up.fullname as appealconame from routing rr join userprofile up on up.securityusersid = rr.tosecurityusersid 
   where rr.objectid = intakeserviceid:: CHARACTER varying and rr.eventcode = 'APPL' and rr.routingstatustypeid = 15 limit 1) as appealconame,
   (SELECT getreportername FROM getreportername('servicerequest',Assignlist.intakeserviceid::character varying, 'reporter')) as  clientname
   FROM (
  	    SELECT  
  	    null::json as  offencecounty,
  			null::json as  caseconditions,
        ''::character varying as assistid, null::bigint as cjamspid, ISR.intakeserviceid,cast(ISR.servicerequestnumber  ||
        case  coalesce(isr.actiontype,'')  when  ''  then  ''  else  '  ('||  coalesce(isr.actiontype,'')  ||  ')'  end 
		  	as  character  varying) as servicerequestnumber ,
        cast(case  ISR.iscps  when  true  then  'CPS'  when  false  then  'Non  CPS'  else  ''  end    as  character  varying),
        (SELECT  itsrt.intakeservreqtypekey  FROM  intakeservicerequesttype  as  itsrt  WHERE  itsrt.intakeservreqtypeid=ISR.intakeservreqtypeid  AND  itsrt.activeflag  =1 limit  1),
        (SELECT  srst.classkey  FROM  servicerequestsubtype  as  srst  WHERE  srst.servicerequestsubtypeid=ISR.intakeservicerequestclassid  AND  srst.activeflag  =1 limit  1),
        ISR.reporteddate as reporteddate,
        'Completed' :: character varying,
        ISR.insertedon  as  routeddate,
        cast(up.lastname  ||',  '||up.firstname  as  character  varying)  assigneduser,
        ISR.isrouted,
        R.Assignedon as assigneddate,
			  false,cast(''  as  character  varying), 
        ISR.accepteddate::timestamp  without  time  zone,  
        ISR.intakenumber as intakenumber,
        null  ::json,
        (SELECT  json_agg(e)    as  fatality  from 
        (select  isrs.ischildfatality,isrs.ismaltreatment  from  intakeservicerequestsdm  isrs  where  isrs.intakenumber  =  ISR.IntakeNumber  and  activeflag  =1  )  as  e)  ::json,
	      (select (CASE WHEN r.routingstatustypeid =16 THEN 'Approved'::character varying WHEN 
        r.routingstatustypeid =17 THEN 'Rejected'::character varying ELSE 'Pending'::character varying END) 
        from placement as TBPM
        join routing r on r.objectid = TBPM.placementid :: character varying
        where TBPM.intakeserviceid = ISR.intakeserviceid and TBPM.activeflag = 1 and 
              (TBPM.exittime is null ) and r.activeflag=1 and(r.routingstatustypeid != 16 or r.routingstatustypeid is null) limit 1),
        null::character varying  as serviceapprovestatus ,
        (select json_agg(x) as finalfindings from (SELECT  isa.intakeserviceid, ifg.investigationallegationid, ifg.investigationfindingtypekey
        FROM 	investigationallegationmaltreators im 
            INNER JOIN investigationallegation ia ON ia.investigationallegationid = im.investigationallegationid AND ia.activeflag =1
            INNER JOIN investigationmaltreatmentactor ima ON ima.maltreatmentid = ia.maltreatmentid AND ima.activeflag =1
            INNER JOIN investigationfinding ifg ON ifg.investigationallegationid = im.investigationallegationid AND ifg.activeflag =1 
            INNER JOIN intakeservicerequestactor isa ON isa.intakeservicerequestactorid = ima.intakeservicerequestactorid AND isa.activeflag =1
        WHERE  isa.intakeserviceid = isr.intakeserviceid::UUID AND im.activeflag = 1
        GROUP BY isa.intakeserviceid, ifg.investigationallegationid, ifg.investigationfindingtypekey)x)::json              
        FROM  intakeservicerequest  as  ISR 
        INNER  JOIN  (SELECT  DISTINCT irs.intakeserviceid objectid,cast(r.insertedon  as  timestamp)  assignedon, r.tosecurityusersid, r.activeflag 
                        FROM  ROUTING  R
                        join intakeservicerequestdispositioncode as irs on intakeservicerequestdispositioncodeid::character varying = R.objectid and irs.intakeserreqstatustypeid='7995cecb-062d-406c-8ea9-b1da4b1877d8'
                        WHERE R.activeflag  =1 and  R.eventcode = 'INDR' and R.fromsecurityusersid  =  userid and R.routingstatustypeid = 16
                                )  R  ON  r.objectid  =   ISR.intakeserviceid and r.activeflag=1 
        LEFT  JOIN  userprofile  up  on  up.securityusersid  =  r.tosecurityusersid  and  up.activeflag  =1 
        LEFT  JOIN  intakeserreqstatustype  irst  on  irst.intakeserreqstatustypeid  =  ISR.intakeserreqstatustypeid  and irst.activeflag  =1 
        WHERE  ISR.servicerequestnumber  ILIKE  servicereqno  ||'%' AND ISR.teamtypekey = 'CW'		
		    AND CASE WHEN assignedid is NOT NULL THEN (r.tosecurityusersid=assignedid ) ELSE true end		 
        AND  coalesce(ISR.isrouted,false)  =true AND  ISR.activeflag  =1
        and lower(irst.Intakeserreqstatustypekey)  in  ('completed')
      )  as  assignlist 
      where case v_filter	when 'all' then true
        else
        	case (select case when count(1) >0 then true else false end from routing rr where rr.objectid = intakeserviceid:: CHARACTER varying and rr.eventcode = 'APPL' and rr.routingstatustypeid = 15 limit 1)
        when true and v_filter='assigned' then true when true and v_filter='unassigned' then false
        when false and v_filter='assigned' then false when false and v_filter='unassigned' then true end end
        
    /* Sorting implemented by Gavaskar 10-01-2019 */
	ORDER  BY  ( CASE sortorder when 'asc' then CASE lower(sortcolumn) when 'servicerequestnumber' then cast( assignlist.servicerequestnumber  as character varying) 
		    when 'assigneddate' then cast( assignlist.assigneddate  as character varying)
		    when 'reporteddate' then cast( assignlist.reporteddate  as character varying)
		    when 'routeddate' then  cast( assignlist.routeddate  as character varying)  
		    when 'cjamspid' then  cast( assignlist.cjamspid  as character varying)
		    when 'intakenumber' then  cast( assignlist.intakenumber  as character varying)
   		  when 'personname' then cast( (SELECT * from getcasepersonname ('servicerequest',intakeserviceid:: CHARACTER VARYING))->0->>'personname'  as character varying)		    

		    ELSE cast( assignlist.assigneddate  as character varying) end   end)  asc ,

		    ( CASE sortorder when 'desc' then CASE lower(sortcolumn) when 'servicerequestnumber' then cast( assignlist.servicerequestnumber  as character varying)
		    when 'assigneddate' then cast( assignlist.assigneddate  as character varying)
		    when 'reporteddate' then cast( assignlist.reporteddate  as character varying)
		    when 'routeddate' then  cast( assignlist.routeddate  as character varying)
		    when 'cjamspid' then  cast( assignlist.cjamspid  as character varying)
		    when 'intakenumber' then  cast( assignlist.intakenumber  as character varying)
   		  when 'personname' then cast( (SELECT * from getcasepersonname ('servicerequest',intakeserviceid:: CHARACTER VARYING))->0->>'personname'  as character varying)		    

		    ELSE cast( assignlist.assigneddate  as character varying) end   end )  desc  

        LIMIT  pagesize  OFFSET  v_pageoffset  ;

  ELSif(isassigned  =  true or v_status in ('Closed'))

	then
    return  query
      SELECT  count(1) over(), *,  (SELECT * from getcasepersonname ('servicerequest',intakeserviceid:: CHARACTER VARYING)),
      (select case when count(1) >0 then true else false end as assignbtn from routing rr where rr.objectid = intakeserviceid::CHARACTER varying and rr.eventcode = 'APPL' and rr.routingstatustypeid = 15 limit 1) as assignbtn,
      (select up.fullname as appealconame from routing rr join userprofile up on up.securityusersid = rr.tosecurityusersid 
      where rr.objectid = intakeserviceid:: CHARACTER varying and rr.eventcode = 'APPL' and rr.routingstatustypeid = 15 limit 1) as appealconame,
      (SELECT getreportername FROM getreportername('servicerequest',Assignlist.intakeserviceid::character varying, 'reporter')) as  clientname
      FROM (
      SELECT  
          null::json as offencecounty,
          null::json  as  caseconditions,
          ''::character varying as assistid, null::bigint as cjamspid,  ISR.intakeserviceid,cast(ISR.servicerequestnumber  ||
          case  coalesce(isr.actiontype,'')  when  ''  then  ''  else  '  ('||  coalesce(isr.actiontype,'')  ||  ')'  end  as  character  varying)   as servicerequestnumber   ,
          cast(case  ISR.iscps  when  true  then  'CPS'  when  false  then  'Non  CPS'  else  ''  end    as  character  varying),
          (SELECT  itsrt.intakeservreqtypekey  FROM  intakeservicerequesttype  as  itsrt  WHERE  itsrt.intakeservreqtypeid=ISR.intakeservreqtypeid  AND  itsrt.activeflag  =1  limit  1),
          (SELECT  srst.classkey  FROM  servicerequestsubtype  as  srst  WHERE  srst.servicerequestsubtypeid=ISR.intakeservicerequestclassid  AND  srst.activeflag  =1    limit  1),
          ISR.reporteddate as reporteddate,
          case v_status when 'Closed' then 'Closed' :: character varying else 
                case  isr.isaccepted  when  true  then  'Accepted'  when  false  then  'Rejected'  else  'Pending'  end  ::character  varying  
					end ,
          ISR.insertedon  as  routeddate,
          cast(up.lastname  ||',  '||up.firstname  as  character  varying)  assigneduser,
          ISR.isrouted,
          R.Assignedon as assigneddate,
          false,cast(''  as  character  varying),
          ISR.accepteddate::timestamp  without  time  zone,  
          ISR.intakenumber as intakenumber,
          null  ::json,
          (SELECT  json_agg(e) as fatality  from
		      (select  isrs.ischildfatality,isrs.ismaltreatment  from  intakeservicerequestsdm  isrs  where  isrs.intakenumber  =  ISR.IntakeNumber  and  activeflag  =1  )  as  e)  ::json,
          (select (CASE WHEN r.routingstatustypeid =16 THEN 'Approved'::character varying WHEN r.routingstatustypeid =17 THEN 'Rejected'::character varying  
          ELSE 'Pending'::character varying END) from placement as TBPM
          join routing r on r.objectid = TBPM.placementid :: character varying
          where TBPM.intakeserviceid = ISR.intakeserviceid and TBPM.activeflag = 1 and 
          (TBPM.exittime is null ) and r.activeflag=1 and(r.routingstatustypeid != 16 or  r.routingstatustypeid is null) limit 1),
          null::character varying  as serviceapprovestatus,
          null::json  as finalfindings 
        FROM  intakeservicerequest  as  ISR  
        INNER  JOIN  (SELECT  DISTINCT  objectid,cast(r.insertedon  as  timestamp)  assignedon ,tosecurityusersid,activeflag
                      FROM  ROUTING  R WHERE  R.fromsecurityusersid  =  userid  AND  routingstatustypeid  =4 AND  R.activeflag  =1 
                      and  R.eventcode != 'APPL')  R  ON  r.objectid  = cast(ISR.intakeserviceid    as  character  varying)  and r.activeflag=1 
        LEFT  JOIN  userprofile  up  on  up.securityusersid  =  r.tosecurityusersid  and  up.activeflag  =1  
        LEFT  JOIN  intakeserreqstatustype  irst  on  irst.intakeserreqstatustypeid  =  ISR.intakeserreqstatustypeid  and irst.activeflag  =1 
        WHERE  ISR.servicerequestnumber  ILIKE  servicereqno  ||'%'
		 AND CASE WHEN assignedid is NOT NULL THEN (r.tosecurityusersid=assignedid ) ELSE true end		 
        AND  coalesce(ISR.isrouted,false)  =true  AND ISR.teamtypekey = 'CW' 
        AND  ISR.activeflag  =1 AND ISR.intakeservicerequestclassid <> '00000000-0000-0000-0000-000000000000'
        and case when v_status is null then lower(irst.Intakeserreqstatustypekey) Not  in ('closed','rejected')
        when v_status= 'Closed' then  lower(irst.Intakeserreqstatustypekey)  in  ('closed') else true end
          

  	UNION ALL

        SELECT      
        null::json as offencecounty,
        null::json as  caseconditions,
        ''::character varying as assistid, null::bigint as cjamspid,  ISR.intakeserviceid, cast(ISR.servicerequestnumber  ||
        case  coalesce(isr.actiontype,'')  when  ''  then  ''  else  '  ('||  coalesce(isr.actiontype,'')  ||  ')'  end as  character  varying)   as servicerequestnumber   ,
        cast(case  ISR.iscps  when  true  then  'CPS'  when  false  then  'Non  CPS'  else  ''  end    as  character  varying),
        (SELECT  itsrt.intakeservreqtypekey  FROM  intakeservicerequesttype  as  itsrt  WHERE  itsrt.intakeservreqtypeid=ISR.intakeservreqtypeid  AND  itsrt.activeflag  =1  limit  1),
        (SELECT  srst.classkey  FROM  servicerequestsubtype  as  srst  WHERE  srst.servicerequestsubtypeid=ISR.intakeservicerequestclassid  AND  srst.activeflag  =1    limit  1),
        ISR.reporteddate as reporteddate,  
		    case v_status when 'Closed' then 'Closed' :: character varying else 
            case  isr.isaccepted  when  true  then  'Accepted'  when  false  then  'Rejected' else  'Pending'  end :: character varying  
				end ,
        ISR.insertedon,
        cast(up.lastname  ||',  '||up.firstname  as  character  varying),
        ISR.isrouted,
        R.Assignedon  as assigneddate,
        false,cast(''  as  character  varying),
        ISR.accepteddate::timestamp  without  time  zone,  
        ISR.intakenumber as intakenumber,
		    null ,
        (SELECT  json_agg(e) as  fatality  from
        (select  isrs.ischildfatality,isrs.ismaltreatment  from  intakeservicerequestsdm  isrs  where  isrs.intakenumber  =  ISR.IntakeNumber  and  activeflag  =1  )  as  e)  ::json,
        (select (CASE WHEN r.routingstatustypeid =16 THEN 'Approved'::character varying WHEN 
        r.routingstatustypeid =17 THEN 'Rejected'::character varying  ELSE 'Pending'::character varying END) 
        from placement as TBPM
        join routing r on r.objectid = TBPM.placementid :: character varying
        where TBPM.intakeserviceid = ISR.intakeserviceid and TBPM.activeflag = 1 and 
              (TBPM.exittime is null ) and r.activeflag=1 and(r.routingstatustypeid != 16 or  r.routingstatustypeid is null) limit 1),
	      null,
        null::json  as finalfindings  
        FROM  intakeservicerequest  as  ISR  
        INNER  JOIN  (SELECT  DISTINCT  objectid,tosecurityusersid,cast(r.insertedon  as  timestamp)  assignedon  FROM  ROUTING  R  
                      WHERE  R.fromsecurityusersid  =  userid  AND  routingstatustypeid  =9   and  R.eventcode != 'APPL' 
                       )  R  ON  r.objectid  =    cast(ISR.intakeserviceid    as  character  varying)  
        LEFT  JOIN  userprofile  up  on  up.securityusersid  =  r.tosecurityusersid    and  up.activeflag  =1 
        LEFT  JOIN  intakeserreqstatustype  irst  on  irst.intakeserreqstatustypeid  =  ISR.intakeserreqstatustypeid  AND    irst.activeflag  =1 
        WHERE    ISR.servicerequestnumber  ILIKE  servicereqno  ||'%' AND ISR.teamtypekey = 'CW' AND CASE WHEN assignedid is NOT NULL 
        THEN (ISR.routedusersid=assignedid ) ELSE true end
      	AND  ISR.activeflag  =1 AND ISR.intakeservicerequestclassid <> '00000000-0000-0000-0000-000000000000'
        AND case 
          when v_status is null then lower(irst.Intakeserreqstatustypekey)  Not  in  ('closed','rejected') AND coalesce(ISR.isrouted,false) = true 
          when  v_status= 'Closed'then  lower(irst.Intakeserreqstatustypekey)  in  ('closed')
          else true end
    )  as  assignlist 
    where
        case v_filter	when 'all' then true
        else
        	case (select case when count(1) >0 then true else false end from routing rr where rr.objectid = intakeserviceid:: CHARACTER varying and rr.eventcode = 'APPL' and rr.routingstatustypeid = 15 limit 1)
        when true and v_filter='assigned' then true
        when true and v_filter='unassigned' then false
        when false and v_filter='assigned' then false
        when false and v_filter='unassigned' then true
        end
        end
        
    /* Sorting implemented by Gavaskar 10-01-2019 */
	ORDER  BY  ( CASE sortorder when 'asc' then CASE lower(sortcolumn) when 'servicerequestnumber' then cast( assignlist.servicerequestnumber  as character varying) 
		    when 'assigneddate' then cast( assignlist.assigneddate  as character varying)
		    when 'reporteddate' then cast( assignlist.reporteddate  as character varying)
		    when 'routeddate' then  cast( assignlist.routeddate  as character varying)  
		    when 'cjamspid' then  cast( assignlist.cjamspid  as character varying)
		    when 'intakenumber' then  cast( assignlist.intakenumber  as character varying)
		    when 'personname' then cast( (SELECT * from getcasepersonname ('servicerequest',intakeserviceid:: CHARACTER VARYING))->0->>'personname'  as character varying)		    
		    ELSE cast( assignlist.assigneddate  as character varying) end   end)  asc ,

		    ( CASE sortorder when 'desc' then CASE lower(sortcolumn) when 'servicerequestnumber' then cast( assignlist.servicerequestnumber  as character varying)
		    when 'assigneddate' then cast( assignlist.assigneddate  as character varying)
		    when 'reporteddate' then cast( assignlist.reporteddate  as character varying)
		    when 'routeddate' then  cast( assignlist.routeddate  as character varying)
		    when 'cjamspid' then  cast( assignlist.cjamspid  as character varying)
		    when 'intakenumber' then  cast( assignlist.intakenumber  as character varying)
  		    when 'personname' then cast( (SELECT * from getcasepersonname ('servicerequest',intakeserviceid:: CHARACTER VARYING))->0->>'personname'  as character varying)
		    ELSE cast( assignlist.assigneddate  as character varying) end   end )  desc 

        LIMIT  pagesize  OFFSET  v_pageoffset  ;

END  IF;              

end;

$function$
;

