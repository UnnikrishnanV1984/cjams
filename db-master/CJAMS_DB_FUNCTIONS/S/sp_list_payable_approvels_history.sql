-- FUNCTION: cjams.sp_list_payable_approvels_history(character varying)

DROP FUNCTION IF EXISTS cjams.sp_list_payable_approvels_history(character varying);

CREATE OR REPLACE FUNCTION cjams.sp_list_payable_approvels_history(
	v_authorzationid character varying)
RETURNS TABLE(createddate timestamp without time zone, fromuser character varying, touser character varying, fromrole character varying, torole character varying, status text) 
    LANGUAGE 'plpgsql'
    VOLATILE 
    COST 100
    ROWS 1000
AS $BODY$

--RAISE NOTICE 'status:%', status;
begin
RETURN query 

select r.insertedon ,up1.fullname as fromuser,
--up2.fullname as touser,
case when r.routingstatustypeid = 39
then
case when (select count(*)
	from routing rr 
	inner join userprofile up on up.securityusersid=rr.fromsecurityusersid
	inner join tb_service_purchase_authorization tspaaa on tspaaa.authorization_id :: character varying = rr.objectid 
	where rr.objectid=v_authorzationid::character varying  and rr.eventcode  in ('PCAUTH','PCAUTHR')
	and rr.routingstatustypeid in (40,42)
	limit 1) >0
then 
	(select up.fullname
	from routing rr 
	inner join userprofile up on up.securityusersid=rr.fromsecurityusersid
	inner join tb_service_purchase_authorization tspaaa on tspaaa.authorization_id :: character varying = rr.objectid 
	where rr.objectid=v_authorzationid::character varying  and rr.eventcode  in ('PCAUTH','PCAUTHR')
	and rr.routingstatustypeid in (40,42)
	limit 1)
else
up2.fullname end
else
up2.fullname end as touser,
case when r.routingstatustypeid in (40)and (select count(*)
	from routing rr 
	inner join userprofile up on up.securityusersid=rr.fromsecurityusersid
	inner join tb_service_purchase_authorization tspaaa on tspaaa.authorization_id :: character varying = rr.objectid and tspaaa.fiscal_category_cd = '7108'
	where rr.objectid= v_authorzationid::character varying  and rr.eventcode = 'PCAUTHR' 
	limit 1) >0 then 'SSA Placement Manager'
else rt1.description end,
case when r.routingstatustypeid in (42,62)
then 
   case when ((select count(1) from routing where objectid=v_authorzationid and toroleid = 'LDSSPM') >= 1) THEN 'LDSS Program Manager' 
   ELSE 
   case when r.routingstatustypeid = 42 then (select roletypename from roletype where roletypecode = 'DF') else rt.description  end
   END
else
   case when r.routingstatustypeid in (39)and (select count(*)
	from routing rr 
	inner join tb_service_purchase_authorization tspaaa on tspaaa.authorization_id :: character varying = rr.objectid and tspaaa.fiscal_category_cd = '7108'
	where rr.objectid= v_authorzationid::character varying  and rr.eventcode = 'PCAUTHR' and r.tosecurityusersid is null
	limit 1) >0 then 'SSA Placement Manager' else 
   rt.description end
 end as torole,
case when r.routingstatustypeid = 62 then 'Denied' when r.routingstatustypeid = 850 
then 'Returned' when (r.activeflag = 1 and r.routingstatustypeid != 43) then 'Pending' else 'Approved' end as status
from routing r 
join tb_service_purchase_authorization tspa on tspa.authorization_id :: character varying = r.objectid 
join userprofile up1 on up1.securityusersid=r.fromsecurityusersid
left join userprofile up2 on up2.securityusersid=r.tosecurityusersid
left join role rt1 on rt1.roletypekey=r.fromroleid
left join role rt on  rt.roletypekey=r.toroleid 
where r.objectid=v_authorzationid and  r.eventcode in ('PCAUTH','PCAUTHR') order by r.insertedon asc;
--(r.activeflag=0 or r.routingstatustypeid in (43,62)) and

END;

$BODY$;


