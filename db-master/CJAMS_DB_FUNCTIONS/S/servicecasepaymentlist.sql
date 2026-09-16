-- FUNCTION: cjams.servicecasepaymentlist(uuid)
DROP FUNCTION IF EXISTS cjams.servicecasepaymentlist(uuid);

CREATE OR REPLACE FUNCTION cjams.servicecasepaymentlist(v_objectid uuid)
 RETURNS TABLE(client_id bigint, clientname text, firstname character varying, lastname character varying, middlename character varying, suffix character varying, grouptotal numeric, grandtotal numeric, age character varying, dob timestamp without time zone, gender character varying, payments json)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 09/23/2022 Vineet Tirodkar - To change the Person Gender value logic (CDM-25373)
-- 06/24/2024 Palani/Akhil/Vineet - Performance tuning (CIDM-8410)
------------------------------------------------------------------------------------------------------------
DECLARE v_grandtotal decimal;

BEGIN
DROP TABLE IF EXISTS tmp_payment;
CREATE TEMP TABLE tmp_payment(client_id bigint, clientname text,firstname character varying,lastname character varying,middlename character varying,
suffix character varying,grouptotal decimal, grandtotal decimal, age character varying, dob timestamp without time zone,
gender character varying, payments json);

INSERT INTO tmp_payment
SELECT
client1.cjamspid,INITCAP(TRIM(client1.firstname)||' '||TRIM(client1.lastname)) AS clientname,
client1.firstname,client1.lastname,client1.middlename,client1.suffix,
sum(paydet1.final_amount_no)
, 0
--EXTRACT(YEAR FROM AGE(NOW(), client1.dob)) :: character varying AS age,
, CASE
WHEN EXTRACT(YEAR FROM age(now(), client1.dob)) <= 0 THEN
CASE WHEN EXTRACT(MONTH FROM age(now(), client1.dob)) <= 0 THEN
CONCAT (EXTRACT(DAY FROM age(now(), client1.dob))::CHARACTER VARYING, ' ', 'Day(s)')
ELSE
CONCAT (EXTRACT(MONTH FROM age(now(), client1.dob))::CHARACTER VARYING, ' ', 'Month(s)')
END
ELSE
CONCAT (EXTRACT(YEAR FROM age(now(), client1.dob))::CHARACTER VARYING, ' ', 'Yrs')
END::CHARACTER VARYING AS age ,
client1.dob,
-- gt.typedescription AS gender,
(select value_text
from referencevalues
where referencetypeid = 301
and activeflag = 1
and coalesce(teamtypekey, 'CW') = 'CW'
and ref_key = client1.gendertypekey
Limit 1
) as gender,
(
SELECT json_agg(e) FROM
(
SELECT
Paydet.client_id
,payhead.payment_id
,(COALESCE(paydet.final_amount_no,0.00) )::CHARACTER VARYING gross_amount_no
,(0.00 ):: CHARACTER VARYING AS offset_amount_no
,payhead.payment_dt
,payhead.payment_type_cd
,payhead.provider_id,
paydet.payment_detail_id,
paydet.final_service_start_dt,
paydet.final_service_end_dt
,MAX(
CASE COALESCE(prov.provider_nm,'')
WHEN '' THEN (COALESCE(prov.provider_first_nm,'') || ' ' || COALESCE(prov.provider_last_nm,''))
ELSE COALESCE(prov.provider_nm,'')
END
) AS provider_nm
,(SELECT
value_tx
FROM tb_picklist_values
WHERE TRIM(PICKLIST_VALUE_CD)=payhead.payment_type_cd AND PICKLIST_TYPE_ID='2') AS payment_type_nm
,(SELECT
DISTINCT PV.value_tx
FROM tb_payment_status PS
INNER JOIN tb_picklist_values PV ON PS.payment_status_cd=TRIM(PV.PICKLIST_VALUE_CD) AND PV.PICKLIST_TYPE_ID='133'
AND PS.payment_id=payhead.payment_id
) AS payment_status_nm
,trim(paydet.final_fiscal_category_cd) as final_fiscal_category_cd
FROM tb_payment_header payhead
INNER JOIN tb_payment_detail paydet ON paydet.payment_id=payhead.payment_id AND paydet.delete_sw='N'
LEFT JOIN tb_provider AS prov ON payhead.provider_id = prov.provider_id AND prov.delete_sw='N'
--INNER JOIN person client ON client.cjamspid=paydet.client_id AND client.activeflag=1
inner JOIN tb_payment_status paystat ON payhead.payment_id=paystat.payment_id and paystat.payment_status_cd in ('1636', '1634') -- get approved(1634) and interfaced(1636) records
--inner JOIN servicecase AS ISR ON ISR.servicecasenumber = paydet.case_id::character varying AND ISR.activeflag=1 AND ISR.servicecaseid=v_objectid
WHERE payhead.delete_sw='N' AND paydet.client_id=client1.cjamspid
GROUP BY Paydet.client_id,payhead.payment_id,paydet.final_amount_no,payhead.payment_dt,
payhead.payment_type_cd,payhead.provider_id,paydet.payment_detail_id,paydet.final_service_start_dt, paydet.final_service_end_dt,
paydet.final_fiscal_category_cd
ORDER BY payhead.payment_dt DESC
) e
) :: json AS payments
FROM tb_payment_header payhead1
INNER JOIN tb_payment_detail paydet1 ON paydet1.payment_id=payhead1.payment_id AND paydet1.delete_sw='N'
INNER JOIN person client1 ON client1.cjamspid=paydet1.client_id AND client1.activeflag=1
LEFT JOIN tb_provider AS prov1 ON payhead1.provider_id = prov1.provider_id AND prov1.delete_sw='N'
INNER JOIN gendertype gt ON gt.gendertypekey=client1.gendertypekey AND gt.activeflag=1
INNER JOIN servicecase AS ISR ON to_int_char(ISR.servicecasenumber) = (paydet1.case_id)
inner join tb_payment_status tps ON payhead1.payment_id=tps.payment_id and tps.payment_status_cd in ('1636', '1634')
AND ISR.activeflag=1
WHERE payhead1.delete_sw='N' AND ISR.servicecaseid=v_objectid
GROUP BY client1.cjamspid,clientname,age,client1.dob, client1.gendertypekey,
client1.firstname,client1.lastname,client1.middlename,client1.suffix;

SELECT SUM (tmp_payment.grouptotal) INTO v_grandtotal
FROM tmp_payment;

RETURN query
SELECT tmp_payment.client_id
,tmp_payment.clientname,
tmp_payment.firstname,
tmp_payment.lastname,
tmp_payment.middlename,
tmp_payment.suffix,tmp_payment.grouptotal,v_grandtotal
,tmp_payment.age
,tmp_payment.dob
,tmp_payment.gender
,tmp_payment.payments FROM tmp_payment;
--DROP TABLE IF EXISTS tmp_payment;
END;

$function$
;
