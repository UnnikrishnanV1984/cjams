DROP FUNCTION IF EXISTS cjams.programmanagerapprovallist(character varying, character varying, character varying, character varying, bigint, bigint, character varying, character varying, character varying, boolean);
DROP FUNCTION IF EXISTS cjams.programmanagerapprovallist(character varying, character varying, character varying, bigint, bigint, character varying, character varying, character varying, boolean);
CREATE OR REPLACE FUNCTION cjams.programmanagerapprovallist(v_securityid character varying, v_role character varying, v_status character varying, pagenumber bigint, pagesize bigint, v_sortcolumn character varying DEFAULT NULL::character varying, v_sortorder character varying DEFAULT NULL::character varying, v_searchobj json DEFAULT NULL::json, assigned_pa boolean DEFAULT true)
 RETURNS TABLE(totalcount bigint, ispaymentapproved boolean, funding_approval_dt date, payment_approval_dt date, ads_approval_dt date, client_id bigint, client_name text, age integer, paymentaddress character varying, dob timestamp without time zone, gender character varying, service_nm character varying, provider_nm character varying, service_start_dt date, service_end_dt date, authorization_id integer, 
 justification_tx character varying, cost_no numeric, voucher character, fiscal_category_cd character, fiscal_category_desc character varying, payee character varying, ads_approval_status_cd character varying, service_log_id integer, actionstatus text, payment_end_dt date, payment_start_dt date, provider_id integer, remarks text, isapproved integer, request_date date, 
 client_account_id integer, routingstatustypeid integer, reason_tx text, objecttypekey character varying, bmanualrouting boolean, programkey character varying, description_tx character varying, case_id bigint, service_id integer)
 LANGUAGE plpgsql
AS $function$

-- 11/01/2023 - Manasa Kasula - Changes to optimize the proc from dynamically building query to static(CIDM-8072/B-181152).
-- 11/15/2023 Umasankar Raavi - B-180207-CIDM-8072: Changes are done to search result with dynamic fields and sorting is implemented


DECLARE 
v_pageoffset int;
v_pagenumber int;
v_toroleid character varying default null;
v_payee_nm character varying;
--v_addresstype character varying;
v_approvestatus  character varying;
v_countyid character varying;
v_authorization_id int;
v_service_log_id int;
v_fiscal_category_code character varying;
v_request_date date;
v_cost_no numeric;


begin
v_pagenumber := pagenumber-1;
v_pageoffset = v_pagenumber * pagesize;
--v_addresstype := '{3356,3357}';
v_payee_nm := v_searchObj ->> 'payee_nm';
v_authorization_id := v_searchObj ->> 'authorization_id';
v_service_log_id := v_searchObj ->> 'service_log_id';
v_fiscal_category_code := v_searchObj ->> 'fiscal_category_code';
v_request_date := v_searchObj ->> 'request_date';
v_cost_no := v_searchObj ->> 'cost_no';
v_approvestatus := '3047';

raise notice 'v_status%',
v_sortcolumn;

raise notice 'v_status%',
v_sortorder;
SELECT t.countyid INTO v_countyid from team t
join teammember tm on tm.teamid=t.teamid and tm.activeflag=1
join teammemberassignment tma on tma.teammemberid=tm.teammemberid and tma.activeflag=1
join muser mu on mu.securityusersid = tma.securityusersid and mu.activeflag=1
where mu.securityusersid = v_securityid;

IF (v_role = 'CWSP') THEN
	v_toroleid = 'CWSP';
END IF;

if(v_role = 'LDSSPM') then
	v_toroleid = '{LDSSPM}';	
end  if;

return query 
select count(1) over(),
(select case when count(1) > 0 then true else false end as ispaymentapproved from tb_service_purchase_authorization tss
where tss.authorization_id = tspa.authorization_id  and coalesce(tss.payment_approval_status_cd,'') = v_approvestatus),
tspa.funding_approval_dt,tspa.payment_approval_dt, tspa.ads_approval_dt,
tsl.client_id,concat(p.firstname,' ',p.middlename,' ',p.lastname) as pname,
(EXTRACT(YEAR FROM age(now(), p.dob)))::int age,
   (select provider_adr :: character varying as paymentaddress from get_provider_address(tp.provider_id,trim('{3356,3357}'))),
p.dob,gt.typedescription,ts.service_nm,
CASE WHEN (tp.provider_nm is null OR tp.provider_nm='') 
THEN CONCAT(tp.provider_first_nm,' ',tp.provider_last_nm) ELSE tp.provider_nm END AS providernm,tsl.start_dt as startdate,tsl.end_dt as enddate,
tspa.authorization_id, tspa.justification_tx::character varying,tspa.cost_no,tspa.voucher_sw,Trim(tspa.fiscal_category_cd)::bpchar as fiscal_category_cd,tfcm.fiscal_category_desc,
CASE WHEN (tp.provider_nm is null OR tp.provider_nm='') 
THEN CONCAT(tp.provider_first_nm,' ',tp.provider_last_nm)::character varying ELSE tp.provider_nm::character varying END as payee,
 tspa.ads_approval_status_cd,tspa.service_log_id,
case when tspa.ads_approval_status_cd='3047' then 'Approved' else 'Pending' end as actionval
,tspa.end_dt,tspa.start_dt,tp.provider_id
,case when coalesce(v_status,'') = 'A'then 'Approved' when r.activeflag=1 and r.routingstatustypeid!=62  then 'Pending' 
else (select r.remarks from routing r where r.activeflag=1 and r.objectid=tspa.authorization_id :: character varying and r.eventcode in ('PCAUTH','PCAUTHR') limit 1)  end as remarkss,
r.activeflag,tspa.sprvsr_approval_dt as request_date,(case when (trim(tspa.fiscal_category_cd) in ('7502','7503')) then tspa.client_account_id else null end) as clientaccountid,r.routingstatustypeid
,tspa.reason_tx,r.objecttypekey
,case when r.objecttypekey ='ServiceCase' then false else true end as is_servicecase,tsl.agency_program_area_id
,tsl.description_tx,tsl.case_id,ts.service_id
from tb_service_purchase_authorization tspa 
join routing r on r.objectid = tspa.authorization_id :: character varying 
join tb_service_log tsl on tsl.service_log_id=tspa.service_log_id and tsl.delete_sw='N'
join prov.tb_provider_services tps on tps.provider_service_id = tsl.provider_service_id and tps.delete_sw = 'N'
join prov.tb_provider tp on tp.provider_id=tps.provider_id
join tb_fiscal_category_master tfcm on tfcm.fiscal_category_cd=tspa.fiscal_category_cd
join person p on p.cjamspid = tsl.client_id 
left join gendertype gt on gt.gendertypekey = p.gendertypekey
join tb_services ts on ts.service_id=tps.service_id and ts.delete_sw='N'
where r.toroleid= any(v_toroleid:: text[]) and r.fromroleid='CWSP' AND tsl.client_id is not null  
AND (CASE WHEN v_payee_nm IS NOT NULL THEN 
( btrim(tp.provider_nm) ilike v_payee_nm || '%' OR btrim(tp.provider_first_nm) ilike v_payee_nm || '%'
OR btrim(tp.provider_last_nm) ilike v_payee_nm || '%' ) ELSE TRUE END)
AND (CASE WHEN v_status = 'A' THEN r.routingstatustypeid in  (42) and r.activeflag=0
WHEN v_status = 'P' THEN r.routingstatustypeid in  (42) and r.activeflag=1 
WHEN v_status = 'R' THEN r.routingstatustypeid = 62 ELSE TRUE END)
AND sprvsr_approval_status_cd= '3047' AND
((r.eventcode= 'PCAUTH' AND CASE WHEN assigned_pa = true THEN r.tosecurityusersid = v_securityid ELSE r.tosecurityusersid != v_securityid end)
OR (r.eventcode= 'PCAUTHR' AND r.teamid in (select teamid from cjams.team tt where tt.countyid =v_countyid) ))

AND Case when v_authorization_id is not null then tspa.authorization_id=  v_authorization_id:: bigint else true end
AND Case when v_service_log_id is not null then tspa.service_log_id= v_service_log_id:: bigint  else true end
AND Case when v_fiscal_category_code is not null then concat(tfcm.fiscal_category_desc, tspa.fiscal_category_cd) ilike '%' || v_fiscal_category_code || '%' else true end
AND Case when v_request_date is not null then tspa.sprvsr_approval_dt = v_request_date::date else true end
AND Case when v_cost_no is not null then tspa.cost_no = v_cost_no::numeric  else true end
GROUP BY 

tsl.client_id,pname,ispaymentapproved,p.dob,gt.typedescription,ts.service_nm, providernm,tsl.start_dt,
tsl.end_dt, tspa.authorization_id, tspa.justification_tx,tspa.cost_no,tspa.voucher_sw, tfcm.fiscal_category_desc,payee,tspa.ads_approval_status_cd,
tspa.service_log_id,actionval,tspa.end_dt,tspa.start_dt ,tp.provider_id,remarkss,tspa.fiscal_category_cd,r.activeflag,request_date,
clientaccountid,r.routingstatustypeid,tspa.reason_tx,r.objecttypekey,paymentaddress,is_servicecase,
tsl.agency_program_area_id,age,tsl.description_tx,tspa.funding_approval_dt,tspa.payment_approval_dt,tspa.ads_approval_dt,tsl.case_id,ts.service_id

order by 
  ( CASE v_sortorder
      WHEN 'asc'
      THEN
        CASE v_sortcolumn
          WHEN 'authorization_id' THEN tspa.authorization_id
          WHEN 'service_log_id' THEN  tspa.service_log_id      
          WHEN 'cost_no' THEN  tspa.cost_no
        END
    END) ASC NULLS last,
  ( CASE v_sortorder
      WHEN 'asc'
      THEN
        CASE v_sortcolumn
          WHEN 'fiscal_category_code' THEN  tfcm.fiscal_category_desc
          WHEN 'request_date' THEN tspa.sprvsr_approval_dt::varchar
         ELSE  (CASE WHEN (tp.provider_nm is null OR btrim(tp.provider_nm)='') THEN CONCAT(tp.provider_first_nm,' ',tp.provider_last_nm)::character varying ELSE tp.provider_nm::character varying end)
         END
    END) ASC NULLS last,
  (CASE v_sortorder
    WHEN 'desc'
    THEN
      CASE v_sortcolumn
          WHEN 'authorization_id' THEN tspa.authorization_id
          WHEN 'service_log_id' THEN  tspa.service_log_id
          WHEN 'cost_no' THEN  tspa.cost_no
      END
  END) DESC NULLS last,
  (CASE v_sortorder
    WHEN 'desc'
    THEN
      CASE v_sortcolumn          
          WHEN 'fiscal_category_code' THEN  tfcm.fiscal_category_desc
          WHEN 'request_date' THEN tspa.sprvsr_approval_dt::varchar 
         ELSE  (CASE WHEN (tp.provider_nm is null OR btrim(tp.provider_nm)='') THEN CONCAT(tp.provider_first_nm,' ',tp.provider_last_nm)::character varying ELSE tp.provider_nm::character varying end)    
      END
  END) DESC NULLS last
limit pagesize offset  v_pageoffset;
	
END;

$function$;