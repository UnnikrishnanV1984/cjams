
DROP FUNCTION IF EXISTS cjams.getcasebyintake(character varying, character varying, integer, integer);
DROP FUNCTION IF EXISTS cjams.getcasebyintake(character varying, character varying, character varying, integer, integer);
CREATE OR REPLACE FUNCTION cjams.getcasebyintake(v_intakenumber character varying, v_securityuserid character varying, isExpungementSuperUser integer DEFAULT 0::integer, isexpunged integer DEFAULT 0::integer)
 RETURNS TABLE(casenumber character varying, servicerequestnumber character varying, intakeserviceid uuid, activeflag integer, actiontype character varying, servicecaseid uuid, reporteddate timestamp without time zone, programkey character varying, subprogramkey character varying, restrictstatus character varying)
 LANGUAGE plpgsql
AS $function$ 
-------------------------------------------------------------------------------------------
--Revision(s)
--06-09-2023 --Smitha Somasekharan CDM-31875-to display casenumber in intake
-- 11/17/2025 Amiya Pradhan - CIDM-10890 - CJAMS Manual & Automation Expungement Enhancement - for Sexual Abuse CPS Intakes and Cases
-------------------------------------------------------------------------------------------                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
 DECLARE  
 
V_activeflag integer;
V_actiontype character varying;
v_servicerequestnumber character varying;
v_intakeserviceid uuid;
v_isexpunged integer := 0;
 BEGIN

IF isExpungementSuperUser= 1 THEN
  v_isexpunged := isexpunged;
END IF;

IF v_isexpunged = 1 THEN 
  -- fully expunged 
  select i.activeflag,i.actiontype, i.servicerequestnumber  
      into V_activeflag,V_actiontype, v_servicerequestnumber
  from expunge.intakeservicerequest_expunge i 
  where i.intakenumber = v_intakenumber and i.activeflag = 1 
    ORDER BY i.updatedon desc
  LIMIT 1;

  if v_servicerequestnumber is null then 

    select i.activeflag,i.actiontype
      into V_activeflag,V_actiontype
    from expunge.intakeservicerequest_expunge i 
    where i.intakenumber = v_intakenumber 
      ORDER BY i.updatedon DESC 
    LIMIT 1 ;

  end if;

  If (V_activeflag =0 and V_actiontype is null)
  then
    RETURN QUERY
    select
    distinct servicecasenumber,
    i.servicerequestnumber,
    i.intakeserviceid ,
    i.activeflag,
    i.actiontype,
    i.servicecaseid,
    i.reporteddate,
    p.programkey,
    p.subprogramkey,
    (SELECT * FROM getRestrictedCaseStatus(i.intakeserviceid ::text ,v_securityuserid)):: character varying as restrictStatus
    from expunge.intakeservicerequest_expunge i 
    inner join servicecase s on s.servicecaseid=i.servicecaseid and s.activeflag=1
    left join personprogramarea p on i.servicecaseid::character varying = p.objectid
    where i.actiontype is null AND i.activeflag =0 and i.intakenumber = v_intakenumber:: character varying;

  else if (V_activeflag =1 and V_actiontype is not null)
  then
    RETURN QUERY
    select
    distinct servicecasenumber,
    i.servicerequestnumber,
    i.intakeserviceid ,
    i.activeflag,
    i.actiontype,
    i.servicecaseid,
    i.reporteddate,
    p.programkey,
    p.subprogramkey,
    (SELECT * FROM getRestrictedCaseStatus( i.intakeserviceid ::text ,v_securityuserid)):: character varying as restrictStatus
    from expunge.intakeservicerequest_expunge i left join servicecase s on s.servicecaseid=i.servicecaseid and s.activeflag=1
    left join personprogramarea p on i.servicerequestnumber = p.entityid
    where  i.actiontype is not null AND i.activeflag =1 and i.intakenumber = v_intakenumber:: character varying;

  else

    RETURN QUERY
    select
    distinct servicecasenumber,
    i.servicerequestnumber,
    i.intakeserviceid ,
    i.activeflag,
    i.actiontype,
    i.servicecaseid,
    i.reporteddate,
    p.programkey,
    p.subprogramkey,
    (SELECT * FROM getRestrictedCaseStatus( i.intakeserviceid ::text ,v_securityuserid)):: character varying as restrictStatus
    from expunge.intakeservicerequest_expunge i inner join servicecase s on s.servicecaseid=i.servicecaseid and s.activeflag=1
    left join personprogramarea p on i.servicecaseid::character varying = p.objectid
    where i.actiontype is null AND i.activeflag =1 and i.intakenumber = v_intakenumber:: character varying;

  end if;
  end if;
ELSE 
  -- original query
  select i.activeflag,i.actiontype, i.servicerequestnumber  
      into V_activeflag,V_actiontype, v_servicerequestnumber
  from intakeservicerequest i 
  where intakenumber= v_intakenumber
  and i.activeflag = 1 
  ORDER BY i.updatedon desc
  LIMIT 1;

  if v_servicerequestnumber is null then 

    select i.activeflag,i.actiontype
      into V_activeflag,V_actiontype
    from intakeservicerequest i 
    where intakenumber=v_intakenumber 
        ORDER BY i.updatedon DESC 
    LIMIT 1 ;

  end if;

  If (V_activeflag =0 and V_actiontype is null)
  then
    RETURN QUERY
    select
    distinct servicecasenumber,
    i.servicerequestnumber,
    i.intakeserviceid ,
    i.activeflag,
    i.actiontype,
    i.servicecaseid,
    i.reporteddate,
    p.programkey,
    p.subprogramkey,
    (SELECT * FROM getRestrictedCaseStatus( i.intakeserviceid ::text ,v_securityuserid)):: character varying as restrictStatus
    from intakeservicerequest i inner join servicecase s on s.servicecaseid=i.servicecaseid and s.activeflag=1
    left join personprogramarea p on i.servicecaseid::character varying = p.objectid
    where i.actiontype is null AND i.activeflag =0 and i.intakenumber = v_intakenumber:: character varying;

  else if (V_activeflag =1 and V_actiontype is not null)
  then
    RETURN QUERY
    select
    distinct servicecasenumber,
    i.servicerequestnumber,
    i.intakeserviceid ,
    i.activeflag,
    i.actiontype,
    i.servicecaseid,
    i.reporteddate,
    p.programkey,
    p.subprogramkey,
    (SELECT * FROM getRestrictedCaseStatus( i.intakeserviceid ::text ,v_securityuserid)):: character varying as restrictStatus
    from intakeservicerequest i left join servicecase s on s.servicecaseid=i.servicecaseid and s.activeflag=1
    left join personprogramarea p on i.servicerequestnumber :: character varying = p.entityid
    where  i.actiontype is not null AND i.activeflag =1 and i.intakenumber = v_intakenumber:: character varying;

  else

    RETURN QUERY
    select
    distinct servicecasenumber,
    i.servicerequestnumber,
    i.intakeserviceid ,
    i.activeflag,
    i.actiontype,
    i.servicecaseid,
    i.reporteddate,
    p.programkey,
    p.subprogramkey,
    (SELECT * FROM getRestrictedCaseStatus( i.intakeserviceid ::text ,v_securityuserid)):: character varying as restrictStatus
    from intakeservicerequest i inner join servicecase s on s.servicecaseid=i.servicecaseid and s.activeflag=1
    left join personprogramarea p on i.servicecaseid::character varying = p.objectid
    where i.actiontype is null AND i.activeflag =1 and i.intakenumber = v_intakenumber:: character varying;

  end if;
  end if;
END IF;  
end;  
$function$
;
