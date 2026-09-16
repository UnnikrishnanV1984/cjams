DROP FUNCTION IF EXISTS cjams.tb_providersearch_dashboard_wirteoff(searchobj json);
CREATE OR REPLACE FUNCTION cjams.tb_providersearch_dashboard_wirteoff(searchobj json)
 RETURNS TABLE(totalcount bigint, providername character varying, providerfirstname character varying, providerlastname character varying, provider_id integer, taxid numeric, mail_code_tx character varying, receivable_detail_id integer, dateidentified character varying, fromdate date, todate date, overpaymentamount numeric, balance numeric, client_id bigint, clientname text, county_name character varying, written_off_amount_no numeric, write_off_approval_status character varying, cjamspid bigint, provider_type character varying, balance_no numeric, receivable_original_amount_no numeric, receivable_id bigint, payment_id integer)
 LANGUAGE plpgsql
AS $function$

---------------------------------------------------------------
--Revisions
-- 6/15/2026 Vinesh - CIDM-11058 Update the proc to remove tb_conv_county_codes left join which has been renamed to  tb_conv_county_codes_06172026
----------------------------------------------------------------

DECLARE 

	v_Providerid INT;

    v_Clientid INT;

    v_ProviderName VARCHAR(50);

    v_Paymentid INT;

    v_taxid INT;

    v_Firstname varchar(50); 

    v_Lastname varchar(50);

   v_Mailcode varchar(50);

    v_Enteredby varchar(50);

   v_status text[];

    v_liPageNumber INT;                              

    v_liPageSize INT;

   	v_pagenumber int;

	v_pageoffset int;

	v_receivable_type varchar(20);
    v_roletypekey varchar(20);
   	v_sortcolumn varchar(50);
   	v_sortdir varchar(20);



	

BEGIN 

v_Providerid := searchobj ->> 'providerid';

v_Clientid := searchobj ->> 'clientid'; 

v_ProviderName := searchobj ->> 'providername';  

v_Paymentid := searchobj ->> 'paymentid';  

v_taxid := searchobj ->> 'taxid'; 

v_Firstname := searchobj ->> 'fname'; 

v_Lastname := searchobj ->> 'lname'; 

v_Mailcode := searchobj ->> 'mailcode';

v_liPageNumber := searchobj ->> 'pagenumber';

v_liPageSize := searchobj ->> 'pagesize'; 

v_Enteredby := searchobj ->> 'enteredby';

v_status := searchobj ->> 'writeoffstatus';

v_receivable_type := searchobj ->> 'receivable_type'; 

v_roletypekey := searchobj ->> 'roletypekey'; 

v_sortcolumn := searchobj ->> 'sortcolumn'; 

v_sortdir := searchobj ->> 'sortorder';

raise notice 'v_roletypekey%',v_roletypekey;

 

IF COALESCE(v_liPageSize, 0) < 1 THEN                     

	v_liPageSize := 10;

END IF;



IF COALESCE(v_liPageNumber, 0) < 1 

THEN

	v_liPageNumber := 1;	

end if;



v_pagenumber := v_liPageNumber - 1;

v_pageoffset := v_pagenumber * v_liPageSize;



return query

select count(1) over() as totalcount,(CASE WHEN (tp.provider_nm is null OR tp.provider_nm='') THEN CONCAT(tp.provider_first_nm,' ',tp.provider_last_nm) ELSE tp.provider_nm END) as providernames,tp.provider_first_nm as providerfirstname,tp.provider_last_nm as providerlastname,
tp.provider_id,tp.tax_id_no as taxid
,tp.mail_code_tx AS     mail_code_tx
,trd.receivable_detail_id,trd.receivable_ts as dateidentified, trd.start_dt as fromdate, trd.end_dt as todate,trd.amount_no as overpaymentamount,
trd.receivable_balance_no as balance,tpd.client_id, concat (p.firstname, ' ',p.lastname) as clientname, 
pv.value_tx as county_name,--tccc.county_name,
trd.written_off_amount_no,trd.write_off_approval_status,p.cjamspid  
,(select value_tx from tb_picklist_values where PICKLIST_type_id=155 AND delete_sw='N'
AND active_sw='Y' AND  TRIM(PICKLIST_VALUE_CD)=TRIM(tp.provider_category_cd)) AS  providertype,
(select sum(trdd.amount_no) from tb_receivable_detail trdd
join tb_receivable_header ttrh on ttrh.receivable_id=trdd.receivable_id
join tb_provider tp on tp.provider_id =ttrh.provider_id where tp.provider_id=  tp.provider_id
) as balance_nos,
(
select sum(trdd.receivable_balance_no) from tb_receivable_detail trdd
join tb_receivable_header ttrh on ttrh.receivable_id=trdd.receivable_id
join tb_provider tp on tp.provider_id =ttrh.provider_id where tp.provider_id=  tp.provider_id
) as receivable_original_amount_nos,trh.receivable_id,tpd.payment_id
from tb_provider tp 
  join tb_receivable_header trh on trh.provider_id = tp.provider_id
  join tb_receivable_detail trd on trd.receivable_id = trh.receivable_id 
inner join routing r on r.objectid::int = trd.receivable_detail_id and r.eventcode='FNSWO' and r.activeflag=1 and 
	(r.tosecurityusersid=v_Enteredby or  r.fromsecurityusersid=v_Enteredby )
--(case when v_roletypekey in ('FNSCOFS','FNSFS') then r.tosecurityusersid=v_Enteredby when  v_roletypekey in ('FNSCOFW','FNSFW') then  r.fromsecurityusersid=v_Enteredby end )
 left join tb_payment_detail tpd on tpd.payment_detail_id = trd.payment_detail_id 
 left join person p on p.cjamspid = tpd.client_id
 left join cjams.tb_picklist_values pv on pv.picklist_type_id = 104 
	and btrim(pv.picklist_value_cd) = btrim(tp.county_cd) 
	and pv.delete_sw  = 'N'
-- left join tb_county_unit tcu on tcu.county_cd = tp.county_cd 
--left  join tb_conv_county_codes tccc on tccc.county_code = tcu.county_cd
left join userprofile up on up.securityusersid = v_Enteredby 
where (v_Providerid is null or tp.provider_id=v_Providerid)
and (v_Clientid is null or tpd.client_id=v_Clientid)
--AND (COALESCE(lower(tp.provider_nm) ,'') LIKE COALESCE(lower(v_ProviderName) ,'')||'%')
and (case when tp.provider_nm is not null then (COALESCE(lower(tp.provider_nm) ,'') LIKE COALESCE(lower(v_ProviderName) ,'')||'%')  
          when tp.provider_nm is  null  then  ((COALESCE(lower(tp.provider_first_nm) ,'') LIKE COALESCE(lower(v_ProviderName) ,'')||'%') or  (COALESCE(lower(tp.provider_last_nm) ,'') LIKE COALESCE(lower(v_ProviderName) ,'')||'%')) or 
          (COALESCE(lower(concat (tp.provider_first_nm,' ',tp.provider_last_nm)) ,'') LIKE COALESCE(lower(v_ProviderName) ,'')||'%') end )
and (v_Paymentid is null or tpd.payment_id=v_Paymentid)
and (v_taxid is null or tp.tax_id_no=v_taxid)
AND (COALESCE(lower(tp.provider_first_nm) ,'') LIKE COALESCE(lower(v_Firstname) ,'')||'%')
AND (COALESCE(lower(tp.provider_last_nm) ,'') LIKE COALESCE(lower(v_Lastname) ,'')||'%')
and (v_Mailcode is null or tp.mail_code_tx=v_Mailcode)
and (v_status is null or trd.write_off_approval_status= ANY (v_status))
--group by providername, providerfirstname, providerlastname,
--tp.provider_id,tp.tax_id_no,providertype,tp.mail_code_tx 
group by providernames,tp.provider_first_nm ,tp.provider_last_nm ,
tp.provider_id,tp.tax_id_no  
,tp.mail_code_tx 
,trd.receivable_detail_id,trd.receivable_ts , trd.start_dt , trd.end_dt ,trd.amount_no ,
trd.receivable_balance_no ,  clientname, 
pv.value_tx, --tccc.county_name,
trd.written_off_amount_no,trd.write_off_approval_status,p.cjamspid ,
providertype,balance_nos,receivable_original_amount_nos,trh.receivable_id,tpd.payment_id
,tpd.client_id,trd.write_off_request_date
order by 
    (
    case
      v_sortdir
      when 'asc' then
      case
        v_sortcolumn
        when 'provider_id' then cast( tp.provider_id as character varying)
        when 'providername' then cast(tp.provider_first_nm  || ' ' || tp.provider_last_nm as character varying)
        when 'client_id' then cast(tpd.client_id  as character varying)
        when 'payment_id' then cast( tpd.payment_id as character varying)
        when 'receivable_id' then cast(trh.receivable_id as character varying)
        when 'written_off_amount_no' then cast(trd.written_off_amount_no  as character varying)
        else cast(trd.write_off_request_date  as character varying) 
      end
      else cast(trd.write_off_request_date  as character varying)
    end) asc nulls last,
    (
    case
      v_sortdir
      when 'desc' then
      case
        v_sortcolumn
        when 'provider_id' then cast( tp.provider_id as character varying)
        when 'providername' then cast(tp.provider_first_nm  || ' ' || tp.provider_last_nm as character varying)
        when 'client_id' then cast(tpd.client_id as character varying)
        when 'payment_id' then cast( tpd.payment_id as character varying)
        when 'receivable_id' then cast(trh.receivable_id as character varying)
        when 'written_off_amount_no' then cast(trd.written_off_amount_no  as character varying)
        else cast(trd.write_off_request_date  as character varying) 
      end
      else cast(trd.write_off_request_date  as character varying) 
    end ) desc nulls last

LIMIT v_liPageSize OFFSET v_pageoffset; 

END;
$function$
;