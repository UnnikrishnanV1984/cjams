DROP FUNCTION IF EXISTS cjams.getprovider114report(integer, character varying, date, date) ;

CREATE OR REPLACE FUNCTION cjams.getprovider114report(v_providerid integer, date_sw character varying, date_from date, date_to date)
 RETURNS TABLE(child114report json)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 07/29/2021 Vineet Tirodkar - To fix FMIS Response check details display (CDM-15551)
-- 12/06/2022 Umasankar Raavi - Type cast changes (CDM-27170)
-- 12/16/2022 Vineet Tirodkar - To fix FMIS Response check date Type cast Aurora Issue (CDM-27445)
-- 01/20/2023 Umasankar Raavi - Tax ID information modification (CDM-22915)
-- 05/17/2023 Vineet Tirodkar - To fix the duplicate Payments display issue (CDM-31412)
-- 07/25/2023 Palani/Chandra - Performance fix (CIDM-7566)
-- 08/30/2023 Vineet Tirodkar - To fix more than one row returned by a subquery error (CDM-33940)
-- 09/06/2023 Palani/Vineet - Performance fix (CIDM-7879)
-- 11/09/2023 Sundeep Kiran - To get check no and checkdate CJAMS Report (CDM-35359)
-- 04/03/2024 Manasa/Palani - To optimize the query (CIDM-8664)
-- Parshal Chitrakar - 09/12/2024 CIDM-9412 Provider Name Suffix is not updated in CW Application
------------------------------------------------------------------------------------------------------------
BEGIN  

RETURN QUERY
(select json_agg(x) from (
select current_date::date as run_date,
payhead.PAYMENT_ID,
payhead.PAYMENT_Dt,
PROV.PROVIDER_ID,
/*CASE WHEN (prov.provider_nm = null OR prov.provider_nm='') THEN
CONCAT(prov.provider_first_nm,' ',prov.provider_last_nm)
ELSE
prov.provider_nm
END AS provider_nm  */
cjams.f_ename('2953', prov.provider_id::bigint) as provider_nm
,(CASE WHEN Prov.PROV_TAX_TYPE_CD = '2518' THEN
(CONCAT('***-**-',RIGHT(Prov.TAX_ID_NO::varchar,4)))
ELSE
LEFT((Prov.TAX_ID_NO::varchar),2) || '-' || SUBSTR((Prov.TAX_ID_NO::varchar),3, LENGTH((Prov.TAX_ID_NO::varchar)))
END
)AS TAXID,
prov.mail_code_tx,
(select value_tx
from tb_picklist_values
where btrim(picklist_value_cd) = btrim(prov.prov_tax_type_cd)
and picklist_type_id =216
)as tax_id_type,
-- (CASE WHEN (RH.BALANCE_NO > 0) THEN 'YES' ELSE 'NO' END ) AS ACCONTS_RECEIVABLE_SW,
paydet.CASE_ID,

(case when ( select count(1) from servicecase where servicecasenumber = paydet.case_id::varchar) > 0 then 
	( select concat_ws( ' ', coalesce(p.firstname, null), coalesce(p.middlename, null), coalesce(p.lastname, null), coalesce(p.suffix, null) ) :: character varying as personname
	  from intakeservicerequestactor ISRA
		join person p on p.personid = ISRA.personid
			and p.activeflag = 1
		join actor A on A.actorid = ISRA.actorid
			and A.activeflag = 1
		join servicecase ins on ( ( ISRA.intakeserviceid = ins.servicecaseid :: uuid )
								or ( ISRA.servicecaseid = ins.servicecaseid :: uuid ) )
	  where ins.servicecasenumber = paydet.case_id::varchar
			and ISRA.activeflag = 1
			and ISRA.isheadofhousehold = true
	  order by COALESCE(ISRA.updatedon, ISRA.insertedon) desc
	  limit 1 
	)
else 
	( select concat_ws( ' ', coalesce(p.firstname, null), coalesce(p.middlename, null), coalesce(p.lastname, null), coalesce(p.suffix, null) ) :: character varying as personname
	  from adoptioncaseactor aca
		inner join person p on p.personid = aca.personid
			and p.activeflag = 1
		join adoptioncase ad on ad.adoptioncaseid = aca.adoptioncaseid
	where ad.adoptioncasenumber = paydet.case_id::varchar
		and aca.activeflag = 1 
		and aca.actortypekey in('PVTADPCHILD', 'CHILD')
	 order by COALESCE(aca.updatedon, aca.insertedon) desc
	 limit 1 
	)
end) as case_nm,

/* (SELECT INITCAP(TRIM(P.firstname)||' '||TRIM(P.lastname) ||
CASE WHEN P.middlename IS NOT NULL AND TRIM(P.middlename) != '' THEN ', ' || TRIM(P.middlename) ELSE '' END)
FROM person as P WHERE personid in (
SELECT PersonId FROM actor WHERE ActorId IN (
SELECT Actorid  FROM IntakeServiceRequestActor where servicecaseid = (select servicecaseid from servicecase where
servicecasenumber = paydet.case_id::varchar )
LIMIT 1))) as case_nm ,
*/
paydet.CLIENT_ID,
concat(p.firstname, ' ', p.middlename, ' ' ,p.lastname) :: character varying as personname,
p.cjamspid,
(SELECT (FISCAL_CATEGORY_DESC ||' (' || FISCAL_CATEGORY_CD ||')')
FROM TB_FISCAL_CATEGORY_MASTER  
WHERE FISCAL_CATEGORY_CD = paydet.FINAL_FISCAL_CATEGORY_CD
AND DELETE_SW = 'N'
) as fiscal_category,
-- (select final_fiscal_category_cd from tb_payment_detail pdsub where pdsub.payment_id = payhead.payment_id order by pdsub.payment_detail_id limit 1)::varchar(5) as fiscal_category_cd,
(select value_tx
from tb_picklist_values
where btrim(PICKLIST_VALUE_CD)= btrim(payhead.payment_type_cd)
AND PICKLIST_TYPE_ID='2'
) AS payment_type_nm,
paydet.final_service_start_dt,
paydet.final_service_end_dt,
concat('',COALESCE(paydet.FINAL_AMOUNT_NO,0.00)) AS CLIENT_GROSS_AMOUNT,
concat('',COALESCE((SELECT SUM(RD.RECEIVABLE_BALANCE_NO)
FROM TB_RECEIVABLE_DETAIL RD  
WHERE RD.PAYMENT_DETAIL_ID = paydet.PAYMENT_DETAIL_ID AND RD.DELETE_SW = 'N'
),0.00)) AS RECEIVABLE_AMOUNT,
concat('',COALESCE(paydet.FINAL_AMOUNT_NO,0.00)
- COALESCE((SELECT SUM(RD.RECEIVABLE_BALANCE_NO)
FROM TB_RECEIVABLE_DETAIL RD
WHERE RD.PAYMENT_DETAIL_ID = paydet.PAYMENT_DETAIL_ID
AND RD.DELETE_SW = 'N'),
0.00)) as CLIENT_NET_AMOUNT,
(SELECT value_tx
FROM TB_PICKLIST_VALUES
WHERE PICKLIST_TYPE_ID = 104
and btrim(PICKLIST_VALUE_CD) = btrim(paydet.COUNTY_CD)
and DELETE_SW <> 'Y'
AND ACTIVE_SW = 'Y'
) as LOCAL_DEPARTMENT,
(SELECT value_tx
FROM TB_PICKLIST_VALUES
WHERE PICKLIST_TYPE_ID = 2
AND btrim(PICKLIST_VALUE_CD) = btrim(payhead.PAYMENT_TYPE_CD)
AND DELETE_SW <> 'Y'
AND ACTIVE_SW = 'Y'
) as PAYMENT_TYPE,

(SELECT value_tx
FROM TB_PICKLIST_VALUES
WHERE PICKLIST_TYPE_ID = 37
AND btrim(PICKLIST_VALUE_CD) = btrim(payhead.CHECK_STATUS_CD)
AND DELETE_SW <> 'Y'
AND ACTIVE_SW = 'Y'
) as CHECK_STATUS,

case when (payhead.payment_type_cd = '3294' or payhead.payment_type_cd = '4') THEN
(select tar.check_no as check_no
from tb_afs_response tar
where tar.payment_id = payhead.payment_id
AND tar.DELETE_SW = 'N'
ORDER BY AFS_RESPONSE_ID DESC  
limit 1
)

else
( SELECT WARRANT_NO as check_no
FROM TB_FMIS_RESPONSE FMIS
WHERE --FMIS.INVOICE_NO::bigint = payhead.PAYMENT_ID
 FMIS.INVOICE_NO =  lpad(to_char_int(payhead.PAYMENT_ID), 14, '0')
AND FMIS.DELETE_SW = 'N'
ORDER BY FMIS_RESPONSE_ID DESC
limit 1
)
end,
/*
(case when (payhead.payment_type_cd = '3294' or payhead.payment_type_cd = '4') THEN
tar.check_no

else
FMIS.WARRANT_NO
end) as  check_no,
*/

--FMIS.WARRANT_NO as check_no,
(select  PV.value_tx  as payment_status
from tb_payment_status PS
INNER JOIN tb_picklist_values PV on btrim(PS.payment_status_cd) = btrim(PV.PICKLIST_VALUE_CD)
AND PV.PICKLIST_TYPE_ID='133'
AND payhead.payment_id = PS.payment_id
limit 1),
/*case when (payhead.payment_type_cd = '3294' or payhead.payment_type_cd = '4') THEN
(select tar.payment_status  as payment_status from tb_afs_response tar where  tar.payment_id = payhead.payment_id AND tar.DELETE_SW = 'N'
ORDER BY AFS_RESPONSE_ID DESC  limit 1)
else
( SELECT CASE WHEN FMIS.TRANSACTION_CODE = '242' THEN 'Check Sent' WHEN FMIS.TRANSACTION_CODE = '710' THEN 'Check Cancelled' ELSE '' end  as payment_status
FROM TB_FMIS_RESPONSE FMIS where FMIS.INVOICE_NO = payhead.PAYMENT_ID ::character varying AND FMIS.DELETE_SW = 'N' ORDER BY FMIS_RESPONSE_ID DESC limit 1)
END */

-- case when (payhead.payment_type_cd = '3294' or payhead.payment_type_cd = '4') THEN
-- (select tar.check_dt as check_dt
-- from tb_afs_response tar
-- where  tar.payment_id = payhead.payment_id
-- AND tar.DELETE_SW = 'N'
-- ORDER BY AFS_RESPONSE_ID DESC  
-- limit 1
-- )
-- else
-- ( SELECT TO_DATE(Warrant_WRITTEN_dt,'YYYY-MM-DD') as check_dt
-- FROM TB_FMIS_RESPONSE FMIS
-- WHERE FMIS.INVOICE_NO::bigint = payhead.PAYMENT_ID
-- AND FMIS.DELETE_SW = 'N'
-- ORDER BY FMIS_RESPONSE_ID DESC
-- limit 1
-- )
-- end,

(case when (payhead.payment_type_cd = '3294' or payhead.payment_type_cd = '4') THEN
(select tar.check_dt
from tb_afs_response tar
where tar.payment_id = payhead.payment_id
order by create_ts desc
limit 1
)
else
( SELECT TO_DATE((FMIS.Warrant_WRITTEN_dt::DATE)::character varying ,'YYYY-MM-DD')
FROM TB_FMIS_RESPONSE FMIS
WHERE --FMIS.INVOICE_NO::bigint = payhead.PAYMENT_ID
 FMIS.INVOICE_NO =  lpad(to_char_int(payhead.PAYMENT_ID), 14, '0')
AND FMIS.DELETE_SW = 'N'
and FMIS.warrant_written_dt is not null
and btrim(FMIS.warrant_written_dt) <> ''
ORDER BY FMIS_RESPONSE_ID DESC
limit 1
)
end) as check_dt,

/*
(case when (payhead.payment_type_cd = '3294' or payhead.payment_type_cd = '4') THEN
tar.check_dt

else
TO_DATE((FMIS.Warrant_WRITTEN_dt::DATE)::character varying ,'YYYY-MM-DD')
end) as  check_dt,
*/
--TO_DATE(FMIS.Warrant_WRITTEN_dt,'YYYY-MM-DD') as check_dt,
concat('',COALESCE(payhead.GROSS_AMOUNT_NO,0.00)) AS GROSS_AMOUNT,
concat('',COALESCE(payhead.OFFSET_AMOUNT_NO,0.00)) AS OFFSET_AMOUNT,
concat('',COALESCE(((CASE WHEN payhead.GROSS_AMOUNT_NO IS NULL THEN 0 ELSE payhead.GROSS_AMOUNT_NO END)
-(CASE WHEN payhead.OFFSET_AMOUNT_NO IS NULL THEN 0 ELSE payhead.OFFSET_AMOUNT_NO END)),0.00)) AS NET_AMOUNT

FROM TB_PAYMENT_HEADER as  payhead
join TB_PAYMENT_DETAIL as paydet on payhead.PAYMENT_ID = paydet.PAYMENT_ID
join prov.TB_PROVIDER as prov on payhead.PROVIDER_ID = prov.PROVIDER_ID
join person p on p.cjamspid = paydet.client_id
-- left join TB_FMIS_RESPONSE FMIS on FMIS.INVOICE_NO::bigint = payhead.PAYMENT_ID and FMIS.warrant_written_dt is not null and btrim(FMIS.warrant_written_dt) <> ''
-- left join tb_afs_response tar on tar.payment_id = payhead.payment_id and tar.DELETE_SW = 'N'
WHERE
--payhead.PAYMENT_ID = paydet.PAYMENT_ID
--AND payhead.PROVIDER_ID = prov.PROVIDER_ID
payhead.DELETE_SW = 'N'
AND paydet.DELETE_SW = 'N'  
AND prov.DELETE_SW = 'N'
AND paydet.FINAL_SERVICE_START_DT iS NOT null
-- and p.cjamspid = paydet.client_id
and payhead.provider_id  = v_providerid
AND payhead.payment_type_cd not in ('21','22')
and
(date_sw is null
  or case
   when date_sw = 'A' then
  to_date(cast(payhead.payment_dt as TEXT), 'YYYY-MM-DD')   >= '1900-01-01'
 when date_sw = 'M' then
  (date_trunc('month',payhead.payment_dt) = date_trunc('month', CURRENT_DATE - interval '1' month))
 when date_sw = 'Y' then
   date_part('year', now() :: date):: integer = date_part('year', payhead.payment_dt):: integer
 when date_sw = 'D' then
/* to_date(cast(payhead.payment_dt as TEXT), 'YYYY-MM-DD')  
 BETWEEN to_date(cast(date_from as TEXT), 'YYYY-MM-DD')
  AND to_date( cast(date_to as TEXT), 'YYYY-MM-DD' ) */
 payhead.payment_dt  BETWEEN to_date(cast(date_from as TEXT), 'YYYY-MM-DD')
  AND to_date( cast(date_to as TEXT), 'YYYY-MM-DD' )
 
  end)

 
group by payhead.PAYMENT_ID,payhead.PAYMENT_Dt, PROV.PROVIDER_ID,provider_nm,paydet.CASE_ID,prov.prov_tax_type_cd,
paydet.CLIENT_ID,case_nm,personname,p.cjamspid, paydet.final_fiscal_category_cd,payhead.payment_type_cd,
paydet.final_service_start_dt,paydet.final_service_end_dt,paydet.final_amount_no,paydet.payment_detail_id,
paydet.county_cd, payhead.check_status_cd,payhead.gross_amount_no,payhead.offset_amount_no ,payment_status
-- , FMIS.WARRANT_NO,FMIS.Warrant_WRITTEN_dt,tar.check_no,tar.check_dt
order by payhead.PAYMENT_ID desc
  )as x ) ;
 END;

$function$
;
