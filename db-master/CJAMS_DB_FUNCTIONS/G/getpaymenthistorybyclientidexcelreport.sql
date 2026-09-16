DROP FUNCTION IF EXISTS cjams.getpaymenthistorybyclientidexcelreport(v_clientid integer, sortorder character varying, sortcolumn character varying, paymenttype character varying);

CREATE OR REPLACE FUNCTION cjams.getpaymenthistorybyclientidexcelreport(v_clientid integer, sortorder character varying, sortcolumn character varying, paymenttype character varying)
 RETURNS TABLE(totalcount bigint, payee character varying, payment_id integer, payment_detail_id bigint, payment_dt date,
 payment_type_nm character varying, payment_status_nm character varying, gross_amount_no numeric, receivable_balance_no numeric,
 final_fiscal_category_cd varchar(5) , final_service_start_dt date, 
 final_service_end_dt date, service_nm character varying, caseworker jsonb)
 LANGUAGE plpgsql
AS $function$

BEGIN 

return query
select  count(1) over() as totalcount, x.providername, x.payment_id, x.payment_detail_id,x.payment_dt, x.payment_type_nm, x.payment_status_nm,
x.gross_amount_no,x.receivable_balance_no, x.final_fiscal_category_cd,x.final_service_start_dt,x.final_service_end_dt,x.service_nm
,x.caseworker
from 

(select 
(case
		when (prov.provider_nm is null
		or prov.provider_nm = '') then concat(prov.provider_first_nm, ' ', prov.provider_last_nm)
		else prov.provider_nm
	end) :: character varying as providername,
payhead.payment_id,paydet.payment_detail_id,payhead.payment_dt,
ts.service_nm,
paydet.final_service_start_dt,case when payhead.payment_type_cd='3294' then (select pd.final_service_start_dt from tb_payment_detail pd where pd.payment_detail_id =
(select phd.reference_payment_detail_id from tb_payment_detail phd where phd.payment_detail_id=paydet.payment_detail_id limit 1) limit 1) else 
paydet.final_service_end_dt end AS final_service_end_dt,
(select value_tx from tb_picklist_values where TRIM(PICKLIST_VALUE_CD)=payhead.payment_type_cd
AND PICKLIST_TYPE_ID='2') AS payment_type_nm,payhead.payment_type_cd,(select value_tx from tb_picklist_values where TRIM
(PICKLIST_VALUE_CD)=tps.payment_status_cd
AND PICKLIST_TYPE_ID='133') as payment_status_nm,paydet.final_amount_no as gross_amount_no,
(select trd.receivable_balance_no from tb_receivable_detail trd where trd.payment_detail_id = paydet.payment_detail_id limit 1) as receivable_balance_no,
paydet.final_fiscal_category_cd::varchar(5) as final_fiscal_category_cd,
 (select jsonb_agg(a) from (select  count(1) over(), * from (
 select 
	max(d.case_id) as case_id 
	,ISRT.description as case_nm
	,up.cjamspid as case_worker_id
	,up.displayname as case_worker_name
	,uppn.phonenumber as case_worker_phone_no
	,upa.county as local_dept
	from 
	 servicecase sc	
left  JOIN tb_payment_detail d on d.case_id ::character varying = sc.servicecasenumber 
left JOIN intakeservicerequest as ISR ON ISR.servicecaseid = sc.servicecaseid and ISR.activeflag =1
left JOIN IntakeServiceRequestType ISRT ON ISRT.intakeservreqtypeid=ISR.intakeservreqtypeid and ISRT.activeflag =1
left JOIN userprofile up on up.securityusersid=sc.insertedby and up.activeflag =1
LEFT join userprofilephonenumber uppn on up.securityusersid=uppn.securityusersid and uppn.userprofiletypekey='office'   and uppn.activeflag =1
LEFT join userprofileaddress upa on up.securityusersid=upa.securityusersid  and upa.activeflag =1 
where   sc.activeflag=1  and d.client_id = v_clientid 
group by ISRT.description,up.cjamspid,up.displayname,uppn.phonenumber,upa.county,sc.insertedon order by sc.insertedon desc
limit  1) as b) as a) as caseworker

from tb_payment_header payhead
left  JOIN tb_payment_detail as paydet ON payhead.payment_id = paydet.payment_id
left join tb_services ts on ts.service_id = paydet.final_service_id
left  join tb_provider prov on prov.provider_id = payhead.provider_id
left  join tb_payment_status tps on tps.payment_id = payhead.payment_id  
where paydet.client_id = v_clientid and (paymenttype is null or payhead.payment_type_cd=paymenttype) 
group by  payhead.payment_id,payment_type_nm, payhead.payment_dt, payhead.payment_type_cd, payment_status_nm, tps.payment_status_cd, payhead.gross_amount_no,receivable_balance_no,
payhead.offset_amount_no, paydet.final_fiscal_category_cd,paydet.final_service_start_dt,paydet.final_service_end_dt,
prov.provider_nm ,prov.provider_first_nm,prov.provider_last_nm,ts.service_nm, paydet.final_amount_no,paydet.case_id,caseworker,paydet.payment_detail_id) as x

group by
 x.providername, x.payment_id, x.payment_dt, x.payment_type_nm, x.payment_status_nm, x.gross_amount_no, x.receivable_balance_no,
x.caseworker,x.payment_detail_id,x.final_fiscal_category_cd,x.final_service_start_dt,x.final_service_end_dt
,x.service_nm
order by (
				CASE sortorder
					WHEN 'asc'
					THEN
                         CASE sortcolumn
                            WHEN 'paymentDate' THEN  cast(x.payment_dt  as character varying)
                         	WHEN 'paymenttype' THEN cast(x.payment_type_nm  as character varying)
                         	WHEN 'paymentstatus' THEN cast(x.payment_status_nm  as character varying)
                         	WHEN 'payee' THEN cast(x.providername  as character varying)
                         	when 'fiscal_category_cd' THEN cast(x.final_fiscal_category_cd as character varying)
             		ELSE
                  		 cast(x.payment_id  as character varying)
             		END
             	END) ASC NULLS LAST,
                (CASE sortorder
                  	WHEN 'desc'
					THEN
						CASE sortcolumn
                            WHEN 'paymentDate' THEN  cast(x.payment_dt as character varying)
                         	WHEN 'paymenttype' THEN cast(x.payment_type_nm as character varying)
                         	WHEN 'paymentstatus' THEN cast(x.payment_status_nm as character varying)
                         	WHEN 'payee' THEN cast(x.providername as character varying)
                         	when 'fiscal_category_cd' THEN cast(x.final_fiscal_category_cd as character varying)
             		ELSE
                  		 cast(x.payment_id as character varying)
             		END
                   END) DESC NULLS last;
END;


$function$
;
