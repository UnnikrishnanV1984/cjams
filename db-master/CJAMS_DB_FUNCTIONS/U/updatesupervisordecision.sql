-- FUNCTION: cjams.updatesupervisordecision(json)

DROP FUNCTION cjams.updatesupervisordecision(json);

CREATE OR REPLACE FUNCTION cjams.updatesupervisordecision(
	searchobj json)
    RETURNS character varying
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$

DECLARE 

  v_timestamp timestamp;
  v_returnstatus character varying;
  v_vendorid character varying;
  v_securityuserid character varying;
 v_vendorapplicantid uuid;
 v_providerid int;
 v_decisionkey character varying;
 v_paymentaffiliate character varying;
 v_paymentaddress boolean;
 v_approvalcomments character varying;
 v_updateservicessearch character varying;
v_narrative character varying;
   

BEGIN 
v_vendorapplicantid := searchobj ->> 'vendorapplicantid';
v_vendorid := searchobj ->> 'vendorid';
v_decisionkey := searchobj ->> 'ref_key';
v_securityuserid := searchobj ->> 'securityuserid';
v_approvalcomments := searchobj ->> 'approvalcomments';
v_narrative := searchobj ->> 'narrative';
v_providerid := (searchobj ->> 'provider_id')::int;
v_timestamp := now()::timestamp with time zone;


IF (v_providerid is not null) then 
if(v_decisionkey = 'APR')then 
update tb_vendor_applicant set status='Active',approvaldate=v_timestamp,approvalcomments=v_approvalcomments,providerid=v_providerid,narrative=coalesce(v_narrative,narrative) where vendorapplicantid=v_vendorapplicantid and delete_sw='N';

INSERT INTO cjams.tb_provider_services
( provider_id, service_id, start_dt, end_dt, paid_cd
, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
(select v_providerid,ts.service_id,tvs.startdate,tvs.enddate,ts.paid_non_paid_cd,
v_timestamp,v_securityuserid,v_timestamp,v_securityuserid,'N' from tb_vendor_applicant tva 
inner join tb_vendor_applicant_services tvs on tvs.vendorapplicantid = tva.vendorapplicantid and tvs.delete_sw='N'
inner join tb_services ts on ts.service_id=tvs.service_id and ts.delete_sw='N'
where tva.vendorapplicantid=(v_vendorapplicantid)::uuid and tva.delete_sw='N');

--select updateservicessearch into v_updateservicessearch from updateservicessearch();

INSERT INTO cjams.tb_provider_addresses
( parent_key_id, adr_type_cd, adr_format_cd,
adr_street_nm, adr_city_nm, adr_county_cd, adr_state_cd, adr_zip5_no,
adr_default_sw, adr_start_dt, adr_end_dt, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
(select v_providerid, '3357', 'S', 
adr_1,adr_city_nm,adr_county_cd,adr_state_cd,adr_zip_no,'Y',adr_start_dt,adr_end_dt,
v_timestamp,v_securityuserid,v_timestamp,v_securityuserid,'N'
from tb_vendor_addresses 
where isaddress=true and vendorapplicantid=(v_vendorapplicantid)::uuid and delete_sw='N');

select ispaymentaddress into v_paymentaddress from tb_vendor_addresses where vendorapplicantid=(v_vendorapplicantid)::uuid and delete_sw='N' and isaddress=true;

v_paymentaffiliate := '3367';
if(v_paymentaddress) then 
v_paymentaffiliate := '3366';
end if;

INSERT INTO tb_provider
	(provider_id, provider_category_cd, provider_status_cd, pay_to_affiliate_cd, create_ts, create_user_id, update_ts,
	update_user_id, provider_first_nm , provider_last_nm , provider_middle_nm, prov_tax_type_cd,tax_id_no , 
	 co_first_nm ,
	co_last_nm , provider_nm,county_cd_tx)
(select v_providerid,'3304','1791',v_paymentaffiliate,v_timestamp,v_securityuserid,v_timestamp,v_securityuserid, 
primary_first_nm,primary_last_nm,primary_middle_nm,taxidtype,taxid,
admin_first_nm,admin_last_nm,org_nm,jurisdiction from tb_vendor_applicant  where vendorapplicantid=(v_vendorapplicantid)::uuid);


elsif (v_decisionkey = 'REJ') then 
update tb_vendor_applicant set status='Rejected',approvalcomments=v_approvalcomments,narrative=coalesce(v_narrative,narrative) where vendorapplicantid=(v_vendorapplicantid)::uuid and delete_sw='N';
end if;

v_returnstatus:=v_providerid;

else


v_returnstatus:='Failure';
end if;
	

return v_returnstatus;

END;

$BODY$;


