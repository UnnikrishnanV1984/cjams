drop FUNCTION if exists getemailuser(authorizationid character varying , v_eventcode character varying 
, assignedto character varying,v_roletypekey  character varying,
userid  character varying ,v_routingstatusid character varying ,v_cost numeric);
CREATE OR REPLACE FUNCTION getemailuser(authorizationid character varying , v_eventcode character varying , assignedto character varying,v_roletypekey  character varying, userid  character varying ,v_routingstatusid character varying ,v_cost numeric)
 RETURNS  TABLE  (securityusersid character varying , email character varying)      
 LANGUAGE plpgsql
AS $function$

declare
 v_assignedto  character varying;

begin
	v_assignedto := assignedto;
	
if(v_cost > 0)
then	
if(v_routingstatusid in ('43','42','39','40'))
then

if(v_routingstatusid in ('43'))
then
	select rr.tosecurityusersid into v_assignedto from routing rr where objectid = authorizationid :: character varying and rr.routingstatustypeid = '42' and eventcode in ('PCAUTH','PCAUTHR');
end if;

if(v_routingstatusid in ('39'))
then
	select rr.tosecurityusersid into v_assignedto from routing rr where objectid = authorizationid :: character varying and rr.routingstatustypeid = '39' and eventcode in ('PCAUTH','PCAUTHR');
end if;

if(v_routingstatusid in ('40'))
then
	select rr.fromsecurityusersid into v_assignedto from routing rr where objectid = authorizationid :: character varying and rr.routingstatustypeid = '39'  and eventcode in ('PCAUTH','PCAUTHR')
	ORDER BY rr.updatedon DESC LIMIT 1;
end if;

IF(v_eventcode in('PCAUTH','PCAUTHR')) then 
RETURN QUERY
select mu.securityusersid :: character varying ,mu.email
from muser mu
where mu.securityusersid:: character varying  = v_assignedto;

ELSE 
RETURN QUERY
select mu.securityusersid,mu.email
from team t 
join teammember tm on tm.teamid=t.teamid and tm.activeflag=1
join teammemberassignment tma on tma.teammemberid=tm.teammemberid and tma.activeflag=1 
join muser mu on mu.securityusersid = tma.securityusersid and mu.activeflag=1 
join rolemapping rm on rm.principalid::int=mu.id and rm.activeflag=1 
join "role" r on r.id = rm.roleid 
where   r.roletypekey = v_roletypekey;

end if ;
end if ;
else 
return query
select '','';
end if ;
end;


$function$
;