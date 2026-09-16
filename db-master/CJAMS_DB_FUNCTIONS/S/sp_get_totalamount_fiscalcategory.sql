CREATE OR REPLACE FUNCTION cjams.sp_get_totalamount_fiscalcategory(v_securityuserid character varying, v_role character varying)
 RETURNS TABLE(fiscal_category_cd text, totalamount numeric, fiscal_category_desc text)
 LANGUAGE plpgsql
AS $function$
BEGIN

	RETURN QUERY

select trim(tspa.fiscal_category_cd) ,sum(cost_no), trim(tfcm.fiscal_category_desc)
from tb_service_purchase_authorization tspa
join routing r on r.objectid = tspa.authorization_id :: character varying
left join tb_fiscal_category_master tfcm on trim(tfcm.fiscal_category_cd) =  trim(tspa.fiscal_category_cd)
where  
case when v_role ='FNSFW' THEN
r.toroleid = v_role else r.routingstatustypeid in (44,40) end
and r.fromroleid  = ANY ('{CWSP,FNSDF}')
and r.fromsecurityusersid != v_securityuserid
and (r.tosecurityusersid= v_securityuserid or r.tosecurityusersid is null or r.tosecurityusersid = '00000000-0000-0000-0000-000000000000')
and sprvsr_approval_status_cd='3047'
and coalesce(funding_approval_status_cd,'') = ''
and coalesce(ads_approval_status_cd,'') = '3047' and coalesce(payment_approval_status_cd,'') =''
and r.routingstatustypeid !=62 and r.activeflag =1 and r.eventcode in ('PCAUTHR', 'PCAUTH')

and (select t.countyid from team t join teammember tm on tm.teamid=t.teamid and tm.activeflag=1
join teammemberassignment tma on tma.teammemberid=tm.teammemberid and tma.activeflag=1
join muser mu on mu.securityusersid = tma.securityusersid and mu.activeflag=1
where mu.securityusersid = v_securityuserid )
=(select tt.countyid from team tt where tt.teamid = r.teamid)

group by tspa.fiscal_category_cd,tfcm.fiscal_category_desc;

/*union all

select trim(tspa.fiscal_category_cd) ,sum(cost_no), trim(tfcm.fiscal_category_desc)
from tb_service_purchase_authorization tspa
join routing r on r.objectid = tspa.authorization_id :: character varying
left join tb_fiscal_category_master tfcm on trim(tfcm.fiscal_category_cd) =  trim(tspa.fiscal_category_cd)
where  r.toroleid = v_role  and r.fromroleid  = ANY ('{CWSP,FNSDF}')
and r.tosecurityusersid= v_securityuserid and
sprvsr_approval_status_cd='3047'
and coalesce(funding_approval_status_cd,'') = ''
and coalesce(ads_approval_status_cd,'') = '3047' and coalesce(payment_approval_status_cd,'') =''
and r.routingstatustypeid !=62 and r.activeflag =1 and r.eventcode='PCAUTH'

and (select t.countyid from team t join teammember tm on tm.teamid=t.teamid and tm.activeflag=1
join teammemberassignment tma on tma.teammemberid=tm.teammemberid and tma.activeflag=1
join muser mu on mu.securityusersid = tma.securityusersid and mu.activeflag=1
where mu.securityusersid = v_securityuserid )
=(select tt.countyid from team tt where tt.teamid = r.teamid)

group by tspa.fiscal_category_cd,tfcm.fiscal_category_desc;*/

 END
 $function$;
