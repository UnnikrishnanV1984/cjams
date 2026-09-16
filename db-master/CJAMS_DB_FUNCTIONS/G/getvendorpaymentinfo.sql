drop function if exists getvendorpaymentinfo(uuid);
CREATE OR REPLACE FUNCTION cjams.getvendorpaymentinfo(v_vendorapplicantid uuid)
 RETURNS TABLE(vendorapplicantid uuid, taxid numeric, taxidtype character varying, ismedicalaidprov boolean, medlicense character varying, speciality character varying, is1099indicator boolean,issame boolean,narrative text,jurisdiction character varying,jurisdiction_desc character varying,org_nm character varying, address json)
 LANGUAGE plpgsql
AS $function$
	
DECLARE
    	
BEGIN
       

return query	

select  tv.vendorapplicantid,tv.taxid,tv.taxidtype,tv.ismedicalaidprov,tv.medlicense,tv.speciality,tv.is1099indicator,tv.issamepaymentaddress,tv.narrative,tv.jurisdiction,ct.countyname,tv.org_nm,
(select json_agg(x) from (select tva.adr_1,tva.adr_2,tva.adr_city_nm,tva.adr_state_cd,tva.adr_zip_no,adr_start_dt,adr_end_dt
from tb_vendor_addresses tva where tva.vendorapplicantid=v_vendorapplicantid and tva.adr_end_dt is null and tva.ispaymentaddress=true and tva.delete_sw='N' limit 1) as x
) as address
from tb_vendor_applicant tv
left join county ct on ct.countyid=(tv.jurisdiction)::uuid and ct.activeflag=1
where   tv.vendorapplicantid=v_vendorapplicantid and tv.delete_sw='N';



END;

$function$


