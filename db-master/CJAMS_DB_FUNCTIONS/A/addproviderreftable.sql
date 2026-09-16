DROP FUNCTION IF EXISTS cjams.addproviderreftable(insertedtlsobj json);
CREATE OR REPLACE FUNCTION cjams.addproviderreftable(insertedtlsobj json)
 RETURNS text
 LANGUAGE plpgsql
AS $function$ 

DECLARE
v_referraldata json;
v_ReqReferralId text;
returnStatus text;
v_securityuserid text;
v_program_type json;
i text;

BEGIN

v_ReqReferralId := insertedtlsobj->>'provider_referral_id';
v_securityuserid := insertedtlsobj->>'securityuserid';
v_program_type := insertedtlsobj->>'prov_program_type';
RAISE NOTICE '%','11111111111111111111111111111111111111111111111111111';



IF LENGTH(insertedtlsobj->>'provider_referral_id') > 1
then 

INSERT into  tb_provider_referral(provider_referral_id,provider_referral_nm,provider_referral_med,provider_referral_first_nm,
is_son,is_rfp,create_user_id,update_user_id,referral_dt,provider_referral_last_nm,parent_entity,parent_entity_taxid,adr_cell_phone_tx,
adr_home_phone_tx,narrative,referral_status,referral_decision,adr_email_tx,provider_program_name,is_taxid,corporation_entity,
corporation_entity_taxid,adr_fax_tx,provider_referral_program,provider_category,county_cd,county_cd_tx,create_ts,agency) 
values(insertedtlsobj->>'provider_referral_id', insertedtlsobj->>'provider_referral_nm' , insertedtlsobj->>'provider_referral_med',
insertedtlsobj->>'provider_referral_first_nm', insertedtlsobj->>'is_son', insertedtlsobj->>'is_rfp', v_securityuserid , v_securityuserid,
(insertedtlsobj->>'referral_dt')::date,insertedtlsobj->>'provider_referral_last_nm',insertedtlsobj->>'parent_entity',insertedtlsobj->>'parent_entity_taxid',
insertedtlsobj->>'adr_cell_phone_tx',insertedtlsobj->>'adr_home_phone_tx',insertedtlsobj->>'narrative',insertedtlsobj->>'referral_status',insertedtlsobj->>'referral_decision',
insertedtlsobj->>'adr_email_tx',insertedtlsobj->>'provider_program_name',insertedtlsobj->>'is_taxid',insertedtlsobj->>'corporation_entity',
(insertedtlsobj->>'corporation_entity_taxid')::int,insertedtlsobj->>'adr_fax_tx',insertedtlsobj->>'provider_referral_program',insertedtlsobj->>'provider_category',insertedtlsobj->>'adr_county_cd',insertedtlsobj->>'adr_county_cd_tx',now()::timestamp,insertedtlsobj->>'agency');

INSERT into  tb_provider_referral_addresses(address_id, parent_key_id,create_user_id,update_user_id,adr_city_nm,adr_country_tx,adr_county_cd,adr_street_nm,adr_postal_code_tx,
adr_zip5_no,adr_state_cd,adr_street_no, adr_county_cd_tx) 
values(insertedtlsobj->>'provider_referral_id', insertedtlsobj->>'provider_referral_id', v_securityuserid, v_securityuserid,insertedtlsobj->>'adr_city_nm',
insertedtlsobj->>'adr_country_tx',insertedtlsobj->>'adr_county_cd',insertedtlsobj->>'adr_street_nm',insertedtlsobj->>'adr_postal_code_tx',(insertedtlsobj->>'adr_zip5_no')::int,
insertedtlsobj->>'adr_state_cd',(insertedtlsobj->>'adr_street_no')::int, insertedtlsobj->>'adr_county_cd_tx');


for i IN SELECT * FROM json_array_elements_text(v_program_type)
loop
INSERT INTO tb_prov_ref_program_type
(program_type_id, referral_id, program_type, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES(gen_random_uuid(), insertedtlsobj->>'provider_referral_id', i, 1, v_securityuserid, now(), v_securityuserid, now());
END LOOP;
else
returnStatus:= 'failure';
END IF;
returnStatus:= 'Success';
RETURN returnStatus;
                                                      
END;

$function$
;