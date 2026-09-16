DROP FUNCTION IF EXISTS cjams.fundingapprovalslist(character varying, character varying, character varying, bigint, bigint, character varying, character varying, character varying, boolean);
CREATE OR REPLACE FUNCTION cjams.fundingapprovalslist(v_securityid character varying, v_role character varying, v_status character varying, pagenumber bigint, pagesize bigint, v_sortcolumn character varying DEFAULT NULL::character varying, v_sortorder character varying DEFAULT NULL::character varying, v_searchobj json DEFAULT NULL::json, assigned_pa boolean DEFAULT true)
 RETURNS TABLE(totalcount bigint, funding_approval_dt date, payment_approval_dt date, ads_approval_dt date, client_name text, age integer, dob timestamp without time zone, gender character varying, service_nm character varying, provider_nm character varying, paymentaddress character varying, service_start_dt date, service_end_dt date, authorization_id integer, justification_tx character varying, cost_no numeric, voucher character, fiscal_category_cd character, fiscal_category_desc character varying, payee character varying, ads_approval_status_cd character varying, service_log_id integer, actionstatus text, payment_end_dt date, payment_start_dt date, provider_id integer, remarks text, isapproved integer, request_date date, client_account_id integer, routingstatustypeid integer, reason_tx text, objecttypekey character varying, bmanualrouting boolean, programkey character varying, description_tx character varying, case_id bigint, service_id integer, client_id bigint)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 07/19/2021 Vineet Tirodkar - Modifications to Provider Name Search for extra space(s) in the name (CDM-15114)
-- 12/16/2021 SJ - Remove Already Approved Payments (from Funding Status-Pending Approval) CDM-17992
-- 05/12/2022 Vineet Tirodkar - Modifications to consider the Inactive Services (tb_services) - CDM-22319
-- 01/27/2023 Vineet Tirodkar - For 7108 Forwarded to Funding Approval logic (CDM-28348)
-- 10/18/2023 Manasa Kasula - B-110620-CIDM-8072: Changes are done to search result with dynamic fields and sorting is implemented
-- 10/30/2023 Umasankar Raavi- B-181152-CIDM-8072: Changes are done to search result and sorting for voucher
-- 02/27/2023 Sreekanth Marrikanti - CIDM-8468: Changes to fix duplicate issue
------------------------------------------------------------------------------------------------------------
-- 11/14/2023 Charan Sai  - For AP Funding Approval Dates Missing - CMD-35280
-- 02/17/2026 Vamshikri.byreddy - query tuning - CIDM-11127
-- 04/22/2026 Varun.Venugopal, Vamshikri.byreddy - query tuning - CIDM-11341
-------------------------------------------------------------------------------------------------------------
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
v_approvestatus  character varying;
assigned_auth character varying default '';
v_countyid character varying;
v_authorization_id int;
v_service_log_id int;
v_fiscal_category_code character varying;
v_request_date date;
v_cost_no numeric;
v_funding_approval_dt date;
v_voucher_sw character varying;
   
begin
v_pagenumber := pagenumber-1;
v_pageoffset = v_pagenumber * pagesize;
v_payee_nm := v_searchObj ->> 'payee_nm';
v_authorization_id := v_searchObj ->> 'authorization_id';
v_service_log_id := v_searchObj ->> 'service_log_id';
v_fiscal_category_code := v_searchObj ->> 'fiscal_category_code';
v_request_date := v_searchObj ->> 'request_date';
v_cost_no := v_searchObj ->> 'cost_no';
v_funding_approval_dt := v_searchObj ->> 'funding_approval_dt';
v_voucher_sw:= v_searchObj ->> 'voucher';
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
v_fromroleid = '{CWSP,FNSDF,FNSFS,LDSSPM}';
v_toroleid = '{FNSFS,FNSFW}';
v_sprvsr_approval_status_cd= '3047';
v_funding_approval_status_cd='' ;
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

if(v_role = 'FNSFW') then
v_fromroleid = '{CWSP,FNSDF,LDSSPM}';
v_toroleid = '{FNSFW}';
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
SELECT
    count(*) OVER() AS total_count,
    tspa.funding_approval_dt,
    tspa.payment_approval_dt,
    tspa.ads_approval_dt,
    concat_ws(' ', p.firstname, p.middlename, p.lastname) AS pname,
    EXTRACT(YEAR FROM age(now(), p.dob))::int AS age,
    p.dob,
    gt.typedescription,
    ts.service_nm,
    COALESCE(NULLIF(tp.provider_nm,''),concat_ws(' ', tp.provider_first_nm, tp.provider_last_nm))::varchar AS provider_nm,
    (select provider_adr :: character varying as paymentaddress from get_provider_address(tp.provider_id,trim('{3356,3357}'))),
    tsl.start_dt AS startdate,
    tsl.end_dt   AS enddate,
    tspa.authorization_id,
    tspa.justification_tx::varchar,
    tspa.cost_no,
    tspa.voucher_sw,
    trim(tspa.fiscal_category_cd)::bpchar AS fiscal_category_cd,
    tfcm.fiscal_category_desc,
    COALESCE(NULLIF(tp.provider_nm,''), concat_ws(' ', tp.provider_first_nm, tp.provider_last_nm))::varchar AS payee,
    tspa.ads_approval_status_cd,
    tspa.service_log_id,
    CASE WHEN tspa.ads_approval_status_cd = '3047' THEN 'Approved' ELSE 'Pending' END AS actionval,
    tspa.end_dt,
    tspa.start_dt,
    tp.provider_id,
    CASE WHEN v_status = 'A' THEN 'Approved' WHEN r.remarks = 'Approved' THEN 'Approved' WHEN r.activeflag = 1 AND r.routingstatustypeid <> 62 THEN 'Pending' ELSE r.remarks END AS remarks1,
    r.activeflag,
    tspa.sprvsr_approval_dt AS request_date,
    CASE WHEN trim(tspa.fiscal_category_cd) IN ('7502','7503') THEN tspa.client_account_id END AS client_account_id1,
    r.routingstatustypeid,
    tspa.reason_tx,
    r.objecttypekey,
    (r.objecttypekey <> 'ServiceCase') AS is_servicecase,
    agency_program_area_id,
    tsl.description_tx,
    tsl.case_id,
    ts.service_id,
    tsl.client_id
FROM tb_service_purchase_authorization tspa
JOIN routing r ON r.objectid::bigint = tspa.authorization_id AND r.eventcode IN ('PCAUTH','PCAUTHR')
JOIN tb_service_log tsl ON tsl.service_log_id = tspa.service_log_id AND tsl.delete_sw = 'N'
JOIN prov.tb_provider_services tps ON tps.provider_service_id = tsl.provider_service_id AND tps.delete_sw = 'N'
JOIN prov.tb_provider tp ON tp.provider_id = tps.provider_id    
JOIN tb_fiscal_category_master tfcm ON tfcm.fiscal_category_cd = tspa.fiscal_category_cd
JOIN person p ON p.cjamspid = tsl.client_id AND p.activeflag = 1
LEFT JOIN gendertype gt  ON gt.gendertypekey = p.gendertypekey
JOIN prov.tb_services ts  ON ts.service_id = tps.service_id

WHERE
--r.toroleid = v_toroleid
--r.toroleid = any(v_toroleid:: text[])
(v_status = 'A' OR r.toroleid = ANY(v_toroleid::text[]))
AND (v_role IS NULL OR ((v_role = 'CWSP'  AND r.fromroleid = 'CWSP')
OR (v_role = 'FNSFS' AND r.fromroleid IN ('CWSP','FNSDF','FNSFS','LDSSPM','CWPS'))
OR (v_role = 'FNSDF' AND r.fromroleid = 'CWSP')
OR (v_role = 'FNSFW' AND r.fromroleid IN ('CWSP','FNSDF','FNSFS','LDSSPM','CWPS'))))
AND tspa.sprvsr_approval_status_cd = v_sprvsr_approval_status_cd
AND tspa.ads_approval_status_cd = v_ads_approval_status_cd
AND ((v_status = 'A' AND r.routingstatustypeid IN (40,44) AND r.activeflag = 0)
OR (v_status = 'P' AND r.routingstatustypeid IN (40,44) AND r.activeflag = 1 AND tspa.funding_approval_dt IS NULL)
OR (v_status = 'R' AND r.routingstatustypeid = 62)
OR v_status IS NULL)
AND tsl.client_id IS NOT NULL
AND (v_payee_nm IS NULL
    OR lower(btrim(tp.provider_nm)) LIKE lower(v_payee_nm) || '%'
    OR lower(btrim(tp.provider_first_nm)) LIKE lower(v_payee_nm) || '%'
    OR lower(btrim(tp.provider_last_nm))  LIKE lower(v_payee_nm) || '%')
AND ((r.eventcode = 'PCAUTH'
     AND ((true = true  AND r.tosecurityusersid = v_securityid)
         OR (true = false AND r.tosecurityusersid <> v_securityid)))
OR (r.eventcode = 'PCAUTHR'
     AND r.teamid IN (SELECT teamid FROM cjams.team tt WHERE tt.countyid = v_countyid ) ))
AND (v_authorization_id IS NULL OR tspa.authorization_id = v_authorization_id::bigint)
AND (v_service_log_id  IS NULL OR tspa.service_log_id   = v_service_log_id::bigint)
AND Case when v_fiscal_category_code is not null then concat(tfcm.fiscal_category_desc, tspa.fiscal_category_cd) ilike '%' || v_fiscal_category_code || '%' else true end
AND (v_request_date IS NULL OR tspa.sprvsr_approval_dt = v_request_date::date)
AND (v_cost_no IS NULL OR tspa.cost_no = v_cost_no::numeric)
AND (v_funding_approval_dt IS NULL OR tspa.funding_approval_dt = v_funding_approval_dt::date)
AND (v_voucher_sw IS NULL OR tspa.voucher_sw = v_voucher_sw)
GROUP BY tsl.client_id, pname,p.dob, gt.typedescription, ts.service_nm,tsl.start_dt, tsl.end_dt,tspa.authorization_id,tspa.justification_tx, tspa.cost_no, tspa.voucher_sw,
tfcm.fiscal_category_desc, tspa.ads_approval_status_cd, tspa.service_log_id,actionval,tspa.end_dt,tspa.start_dt, tp.provider_id,remarks1,payee, tspa.fiscal_category_cd,
r.activeflag,tspa.sprvsr_approval_dt,client_account_id1,r.routingstatustypeid,tspa.reason_tx, r.objecttypekey,is_servicecase,agency_program_area_id,tsl.description_tx,
tspa.funding_approval_dt, tspa.payment_approval_dt, tspa.ads_approval_dt,tsl.case_id, ts.service_id
order by 
  CASE WHEN v_sortorder = 'asc'
      THEN
        CASE v_sortcolumn
          WHEN 'authorization_id' THEN tspa.authorization_id
          WHEN 'service_log_id' THEN  tspa.service_log_id      
          WHEN 'cost_no' THEN  tspa.cost_no
        END
    END ASC NULLS last,
  CASE WHEN v_sortorder = 'asc'
      THEN
        CASE v_sortcolumn
          WHEN 'funding_approval_dt' THEN tspa.funding_approval_dt::varchar
          WHEN 'voucher' THEN tspa.voucher_sw
          WHEN 'fiscal_category_code' THEN  tfcm.fiscal_category_desc
          WHEN 'request_date' THEN tspa.sprvsr_approval_dt::varchar
         ELSE  (CASE WHEN (tp.provider_nm is null OR btrim(tp.provider_nm)='') THEN CONCAT(tp.provider_first_nm,' ',tp.provider_last_nm)::character varying ELSE tp.provider_nm::character varying end)
         END
    END ASC NULLS last,
  CASE WHEN v_sortorder = 'desc'
    THEN
      CASE v_sortcolumn
          WHEN 'authorization_id' THEN tspa.authorization_id
          WHEN 'service_log_id' THEN  tspa.service_log_id
          WHEN 'cost_no' THEN  tspa.cost_no
      END
  END DESC NULLS last,
  CASE WHEN v_sortorder = 'desc'
    THEN
      CASE v_sortcolumn          
          WHEN 'fiscal_category_code' THEN  tfcm.fiscal_category_desc
          WHEN 'request_date' THEN tspa.sprvsr_approval_dt::varchar          
          WHEN 'funding_approval_dt' THEN tspa.funding_approval_dt::varchar
          WHEN 'voucher' THEN tspa.voucher_sw
         ELSE  (CASE WHEN (tp.provider_nm is null OR btrim(tp.provider_nm)='') THEN CONCAT(tp.provider_first_nm,' ',tp.provider_last_nm)::character varying ELSE tp.provider_nm::character varying end)
      END
  END DESC NULLS last 
limit pagesize offset v_pageoffset;
END;

$function$
;
