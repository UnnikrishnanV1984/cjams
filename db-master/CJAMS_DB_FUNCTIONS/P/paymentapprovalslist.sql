DROP FUNCTION IF EXISTS cjams.paymentapprovalslist(character varying, character varying, character varying, bigint, bigint, character varying, character varying, character varying, boolean);
CREATE OR REPLACE FUNCTION cjams.paymentapprovalslist(v_securityid character varying, v_role character varying, v_status character varying, pagenumber bigint, pagesize bigint, v_sortcolumn character varying DEFAULT NULL::character varying, v_sortorder character varying DEFAULT NULL::character varying, v_searchobj json DEFAULT NULL::json, assigned_pa boolean DEFAULT true)
 RETURNS TABLE(totalcount bigint, funding_approval_dt date, payment_approval_dt date, ads_approval_dt date, client_name text, age integer, dob timestamp without time zone, gender character varying, service_nm character varying, provider_nm character varying, paymentaddress character varying, service_start_dt date, service_end_dt date, authorization_id integer, justification_tx character varying, cost_no numeric, voucher character, fiscal_category_cd character, fiscal_category_desc character varying, payee character varying, ads_approval_status_cd character varying, service_log_id integer, actionstatus text, payment_end_dt date, payment_start_dt date, provider_id integer, remarks text, isapproved integer, request_date date, client_account_id integer, routingstatustypeid integer, reason_tx text, objecttypekey character varying, bmanualrouting boolean, programkey character varying, description_tx character varying, case_id bigint, service_id integer, client_id bigint)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 05/12/2022 Vineet Tirodkar - Modifications to consider the Inactive Services (tb_services) - CDM-22319
-- 04/24/2023 Vineet Tirodkar - Modifications to fix prod SP Performance issue (CIDM-7062)
-- 10/18/2023 Manasa Kasula - B-110620-CIDM-8072: Changes are done to search result with dynamic fields and sorting is implemented
-- 05/29/2025 Parshal Chitrakar - CDM-44400 changes are done to fetch the PA if user search with the PA id for same county.
------------------------------------------------------------------------------------------------------------  
DECLARE

query_payment text;
v_pageoffset int;
v_pagenumber int;
v_sprvsr_approval_status_cd character varying default '';
v_funding_approval_status_cd character varying default '';
v_payment_approval_status_cd character varying default '';
v_ads_approval_status_cd character varying default '';
v_fromroleid character varying default null;
v_toroleid character varying default null;
v_appendstring character varying default '';
v_sortval character varying default '';
v_payee_nm character varying;
-- v_addresstype character varying;
v_approvestatus  character varying;
assigned_auth character varying default '';
v_countyid character varying;
v_authorization_id int;
v_service_log_id int;
v_fiscal_category_code character varying;
v_request_date date;
v_cost_no numeric;
v_payment_approval_dt date;

begin
v_pagenumber := pagenumber-1;
v_pageoffset = v_pagenumber * pagesize;
v_payee_nm := v_searchObj ->> 'payee_nm';
v_authorization_id := v_searchObj ->> 'authorization_id';
v_service_log_id := v_searchObj ->> 'service_log_id';
v_fiscal_category_code := v_searchObj ->> 'fiscal_category_code';
v_request_date := v_searchObj ->> 'request_date';
v_cost_no := v_searchObj ->> 'cost_no';
v_payment_approval_dt := v_searchObj ->> 'payment_approval_dt';
v_approvestatus := '3047';

raise notice 'v_status%',
v_sortcolumn;

raise notice 'v_status%',
v_sortorder;

IF (v_role = 'CWSP') THEN
RAISE NOTICE '%', 'INSIDE BLOCK';
v_fromroleid = '{CWSP}';
v_toroleid = 'CWSP';
v_sprvsr_approval_status_cd= '3047';
v_funding_approval_status_cd='' ;
v_payment_approval_status_cd= '' ;
v_ads_approval_status_cd = '3047';
END IF;

if(v_role = 'FNSFS') then
v_fromroleid = '{FNSFW,FNSFS}';
v_toroleid = 'FNSFS';
v_sprvsr_approval_status_cd= '3047';
v_funding_approval_status_cd='3047' ;
v_payment_approval_status_cd= '' ;
v_ads_approval_status_cd = '3047';
end if;

if(v_role = 'FNSDF') then
v_fromroleid = '{CWSP}';
v_toroleid = '{CWSP,FNSDF}';
v_sprvsr_approval_status_cd= '3047';
v_funding_approval_status_cd='' ;
v_payment_approval_status_cd= '' ;
v_ads_approval_status_cd = '3047';
end if;

SELECT t.countyid INTO v_countyid from team t
join teammember tm on tm.teamid=t.teamid and tm.activeflag=1
join teammemberassignment tma on tma.teammemberid=tm.teammemberid and tma.activeflag=1
join muser mu on mu.securityusersid = tma.securityusersid and mu.activeflag=1
where mu.securityusersid = v_securityid;


RETURN QUERY
select  count(1) over(),
tspa.funding_approval_dt,
tspa.payment_approval_dt,
tspa.ads_approval_dt,
concat(p.firstname,' ',p.middlename,' ',p.lastname) as pname,
(EXTRACT(YEAR FROM age(now(), p.dob)))::int age,
p.dob,
gt.typedescription,
ts.service_nm,
CASE WHEN (tp.provider_nm is null OR tp.provider_nm='') THEN CONCAT(tp.provider_first_nm,' ',tp.provider_last_nm) ELSE tp.provider_nm END AS provider_nm,
(select provider_adr :: character varying as paymentaddress from get_provider_address(tp.provider_id,trim('{3356,3357}'))),
tsl.start_dt as startdate,
tsl.end_dt as enddate,
tspa.authorization_id,
tspa.justification_tx::character varying,
tspa.cost_no,
tspa.voucher_sw,
Trim(tspa.fiscal_category_cd)  ::bpchar as fiscal_category_cd,
tfcm.fiscal_category_desc,
CASE WHEN (tp.provider_nm is null OR tp.provider_nm='') THEN CONCAT(tp.provider_first_nm,' ',tp.provider_last_nm)::character varying ELSE tp.provider_nm::character varying END as payee,
tspa.ads_approval_status_cd,
tspa.service_log_id,
case when tspa.ads_approval_status_cd='3047' then 'Approved' else 'Pending' end as actionval,
tspa.end_dt,
tspa.start_dt,
tp.provider_id,
case when v_status = 'A' then 'Approved'
when r.remarks= 'Approved' then 'Approved'  
when r.activeflag=1 and r.routingstatustypeid !=62  then 'Pending'  
else r.remarks end as remarks1,
r.activeflag,
tspa.sprvsr_approval_dt as request_date,
(case when (trim(tspa.fiscal_category_cd) in ('7502','7503')) then tspa.client_account_id else null end) as client_account_id1,
r.routingstatustypeid,
tspa.reason_tx,
r.objecttypekey,
case when r.objecttypekey ='ServiceCase' then false else true end as is_servicecase,
tsl.agency_program_area_id,
tsl.description_tx,
tsl.case_id,
ts.service_id,
tsl.client_id
from tb_service_purchase_authorization tspa
join routing r on r.objectid::bigint = tspa.authorization_id and r.eventcode in ('PCAUTH','PCAUTHR')  
join tb_service_log tsl on tsl.service_log_id=tspa.service_log_id and tsl.delete_sw='N'
join tb_provider_services tps on tps.provider_service_id = tsl.provider_service_id and tps.delete_sw = 'N'
join tb_provider tp on tp.provider_id=tps.provider_id
join tb_fiscal_category_master tfcm on tfcm.fiscal_category_cd=tspa.fiscal_category_cd
join person p on p.cjamspid = tsl.client_id
left join gendertype gt on gt.gendertypekey = p.gendertypekey
join tb_services ts on ts.service_id=tps.service_id -- and ts.delete_sw='N'
LEFT JOIN routing r2 on r2.objectid = tspa.authorization_id::varchar   AND r2.routingstatustypeid in (40,44) and r2.eventcode in ('PCAUTH','PCAUTHR')
where
(CASE WHEN v_role = 'CWSP' THEN r.fromroleid ='CWSP'
WHEN v_role = 'FNSFS' THEN r.fromroleid IN ('FNSFW','FNSFS','CWSP','CWCW','IVESV','IVESP')
WHEN v_role = 'FNSDF' THEN r.fromroleid = 'CWSP'
ELSE TRUE END)
AND r.activeflag = 1
AND sprvsr_approval_status_cd= v_sprvsr_approval_status_cd
AND funding_approval_status_cd = v_funding_approval_status_cd
AND tspa.ads_approval_status_cd = v_ads_approval_status_cd
/* -- REMOVED COALESCE FOR PERFORMANCE IMPROVEMENT - EZHILAN 05/28/2020
--AND coalesce(funding_approval_status_cd,'') = v_funding_approval_status_cd
--AND coalesce(tspa.ads_approval_status_cd,'') = v_ads_approval_status_cd */
AND r.toroleid= v_toroleid
AND (CASE WHEN v_status = 'A' THEN r.routingstatustypeid = 43--r.remarks = 'Approved'
WHEN v_status = 'R' THEN r.routingstatustypeid = 62
WHEN v_status = 'P' THEN r.routingstatustypeid = 41 and r.activeflag=1
ELSE TRUE END)
AND tsl.client_id IS NOT NULL
AND (CASE WHEN v_payee_nm IS NOT NULL THEN (tp.provider_nm ilike v_payee_nm || '%' OR tp.provider_first_nm ilike v_payee_nm || '%' OR tp.provider_last_nm ilike v_payee_nm || '%') ELSE TRUE END)
AND
( CASE WHEN v_status IN ( 'A', 'R' ) then 
       (case when v_authorization_id is not null then 
               r.teamid in 
               (select teamid from cjams.team tt where tt.countyid =v_countyid)
       else
          (case when v_securityid is not null then
              r.tosecurityusersid = v_securityid 
          else
              r.teamid in 
                  (select teamid from cjams.team tt where tt.countyid =v_countyid)
          end)
        end)
  else
      (
          (    v_securityid != r.fromsecurityusersid 
              and r.eventcode = 'PCAUTH'
              AND CASE WHEN assigned_pa = true THEN 
                  r.tosecurityusersid = v_securityid 
              else
                  r.tosecurityusersid != v_securityid 
              end)
      OR 
          (r.teamid in 
              (select teamid from cjams.team tt where tt.countyid =v_countyid)
              and v_securityid != r2.tosecurityusersid  
              and r.eventcode= 'PCAUTHR'
          )
      )
  end 
)
AND Case when v_authorization_id is not null then tspa.authorization_id=v_authorization_id:: bigint else true end
AND Case when v_service_log_id is not null then tspa.service_log_id = v_service_log_id:: bigint else true end
AND Case when v_fiscal_category_code is not null then concat(tfcm.fiscal_category_desc, tspa.fiscal_category_cd) ilike '%' || v_fiscal_category_code || '%' else true end
AND Case when v_request_date is not null then tspa.sprvsr_approval_dt = v_request_date::date else true end
AND Case when v_cost_no is not null then tspa.cost_no = v_cost_no::numeric  else true end
AND Case when v_payment_approval_dt is not null then tspa.payment_approval_dt = v_payment_approval_dt::date else true end
GROUP BY tsl.client_id, pname,p.dob, gt.typedescription, ts.service_nm,
tsl.start_dt, tsl.end_dt,tspa.authorization_id,tspa.justification_tx, tspa.cost_no, tspa.voucher_sw,
tfcm.fiscal_category_desc, tspa.ads_approval_status_cd, tspa.service_log_id,
actionval,tspa.end_dt,tspa.start_dt, tp.provider_id,remarks1,payee, tspa.fiscal_category_cd,
r.activeflag,tspa.sprvsr_approval_dt,client_account_id1,r.routingstatustypeid,tspa.reason_tx, r.objecttypekey,
is_servicecase, tsl.agency_program_area_id,tsl.description_tx,tspa.funding_approval_dt, tspa.payment_approval_dt, 
tspa.ads_approval_dt,tsl.case_id, ts.service_id
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
          WHEN 'payment_approval_dt' THEN tspa.payment_approval_dt::varchar
          WHEN 'voucher' THEN tspa.voucher_sw
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
          WHEN 'payment_approval_dt' THEN tspa.payment_approval_dt::varchar
         ELSE  (CASE WHEN (tp.provider_nm is null OR btrim(tp.provider_nm)='') THEN CONCAT(tp.provider_first_nm,' ',tp.provider_last_nm)::character varying ELSE tp.provider_nm::character varying end)
      END
  END) DESC NULLS last
-- order by (case v_sortorder when 'asc' then (CASE WHEN (tp.provider_nm is null OR tp.provider_nm='') THEN CONCAT(tp.provider_first_nm,' ',tp.provider_last_nm)::character varying ELSE tp.provider_nm::character varying end) end) asc, (case v_sortorder when 'desc' then (CASE WHEN (tp.provider_nm = null OR tp.provider_nm='') THEN CONCAT(tp.provider_first_nm,' ',tp.provider_last_nm)::character varying ELSE tp.provider_nm::character varying end) end) desc, tspa.authorization_id desc
limit pagesize offset v_pageoffset;
END;

$function$
;