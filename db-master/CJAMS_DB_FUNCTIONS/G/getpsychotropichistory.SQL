-- 10/18/2023 prasanna sai kommineni -- CIDM-9541 B-206485 : CW-Psychotropic Medications - Secondary Review
-- 09/12/2025 Anil Kumar Dharni -- CIDM-10699 B-206485 Pyschotropic history duplicate submission record - filter by activeflag on phone number

DROP FUNCTION IF EXISTS cjams.getpsychotropichistory(psychotropicid character varying);
CREATE OR REPLACE FUNCTION cjams.getpsychotropichistory(psychotropicid character varying)
 returns json
 LANGUAGE plpgsql
AS $function$

DECLARE 
result json;
v_psychotropicid character varying;
v_result json;

BEGIN

v_psychotropicid:=psychotropicid;

select json_agg(a) INTO  v_result from(select r.routingid,(up.firstname || ' ' || up.lastname) as displayname ,r.insertedon,up.email,pp.phonenumber,r.fromroleid,r.routeddescription as comments,r.remarks as rejectcomments, r.reassignnotes as rejectreason,
rs.typedescription,r.tosecurityusersid from routing r 
 left join v_userprofile up on up.securityusersid::character varying =r.fromsecurityusersid
 left join userprofilephonenumber pp on pp.securityusersid=r.fromsecurityusersid and pp.activeflag=1
 left join routingstatustype rs on rs.sequencenumber=r.routingstatustypeid
  where r.objectid=v_psychotropicid and r.eventcode='PSY' order by r.insertedon desc)a;


RETURN v_result;
END;

$function$;
