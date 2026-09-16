drop function if exists getprovapplicanttierdecisions(character varying,character varying);
CREATE OR REPLACE FUNCTION cjams.getprovapplicanttierdecisions(eventcd character varying, objid character varying)
 RETURNS TABLE(fromuser character varying, touser character varying, fromroleid character varying, toroleid character varying, objectid character varying, isreviewrequest boolean, remarks text, status text,
 fromsecurityusersid character varying,tosecurityusersid character varying)
 LANGUAGE plpgsql
AS $function$ 

declare 

v_eventcode character varying;
v_objectid character varying;

begin
	v_eventcode:= eventcd;
	v_objectid:= objid;
	
	RETURN QUERY 
	
	SELECT cast(upf.firstname || ' ' || upf.lastname as character varying), cast(upt.firstname || ' ' || upt.lastname as character varying), ptr.fromroleid, ptr.toroleid, ptr.objectid, ptr.isreviewrequest::bool, ptr.routeddescription::text, rst.typedescription::text as status,
	ptr.fromsecurityusersid,ptr.tosecurityusersid
	FROM routing ptr 
	join userprofile upf on upf.securityusersid = ptr.fromsecurityusersid
	join userprofile upt on upt.securityusersid = ptr.tosecurityusersid 
	join routingstatustype rst on rst.sequencenumber=ptr.routingstatustypeid
	where  ptr.objectid = v_objectid and ptr.eventcode != 'PRWS'
	order by ptr.insertedon desc;
end;

$function$;
