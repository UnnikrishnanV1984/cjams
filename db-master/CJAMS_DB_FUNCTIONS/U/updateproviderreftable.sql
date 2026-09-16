CREATE OR REPLACE FUNCTION cjams.updateproviderreftable(updatedtlsobj json)
 RETURNS text
 LANGUAGE plpgsql
AS $function$                                        

DECLARE
v_referraldata json;
v_ReqReferralId text;
returnStatus text;
v_securityuserid text;
v_program_type json;
i json;

BEGIN

v_ReqReferralId := updatedtlsobj->>'provider_referral_id';
v_program_type := updatedtlsobj->'provider_program_type';
v_securityuserid := updatedtlsobj->>'securityuserid';
RAISE NOTICE '%','11111111111111111111111111111111111111111111111111111';

IF LENGTH(updatedtlsobj->>'provider_referral_id') > 1
THEN
UPDATE tb_provider_referral
  SET  provider_referral_nm= updatedtlsobj->>'provider_referral_nm',provider_referral_program=updatedtlsobj->>'provider_referral_program',
	   provider_referral_med= updatedtlsobj->>'provider_referral_med',provider_referral_first_nm=updatedtlsobj->>'provider_referral_first_nm',
	   is_son= updatedtlsobj->>'is_son',is_rfp=updatedtlsobj->>'is_rfp',is_taxid=updatedtlsobj->>'is_taxid',parent_entity= updatedtlsobj->>'parent_entity',
	   parent_entity_taxid=updatedtlsobj->>'parent_entity_taxid',adr_fax_tx= updatedtlsobj->>'adr_fax_tx',adr_email_tx=updatedtlsobj->>'adr_email_tx',
	   adr_cell_phone_tx= updatedtlsobj->>'adr_cell_phone_tx',adr_home_phone_tx=updatedtlsobj->>'adr_home_phone_tx',narrative= updatedtlsobj->>'narrative',
	   provider_referral_last_nm=updatedtlsobj->>'provider_referral_last_nm',corporation_entity= updatedtlsobj->>'corporation_entity',
	   corporation_entity_taxid=(updatedtlsobj->>'corporation_entity_taxid')::int,referral_status= updatedtlsobj->>'referral_status',
	   referral_decision=updatedtlsobj->>'referral_decision',provider_program_name=updatedtlsobj->>'provider_program_name',county_cd=updatedtlsobj->>'adr_county_cd',county_cd_tx=updatedtlsobj->>'adr_county_cd_tx'
from tb_provider_referral_addresses
WHERE tb_provider_referral.provider_referral_id = v_ReqReferralId and tb_provider_referral.provider_referral_id = tb_provider_referral_addresses.parent_key_id;

UPDATE tb_provider_referral_addresses 
  SET  adr_street_no= (updatedtlsobj->>'adr_street_no')::int,adr_city_nm=updatedtlsobj->>'adr_city_nm',adr_country_tx=updatedtlsobj->>'adr_country_tx',adr_street_nm=updatedtlsobj->>'adr_street_nm',
  adr_state_cd=updatedtlsobj->>'adr_state_cd',adr_county_cd=updatedtlsobj->>'adr_county_cd',adr_zip5_no=(updatedtlsobj->>'adr_zip5_no')::int,adr_county_cd_tx=updatedtlsobj->>'adr_county_cd_tx'
  from tb_provider_referral
WHERE tb_provider_referral_addresses.parent_key_id = v_ReqReferralId and tb_provider_referral.provider_referral_id = tb_provider_referral_addresses.parent_key_id;


-- Delete all existing license types
delete from tb_prov_ref_program_type WHERE referral_id=v_ReqReferralId;

for i IN SELECT * FROM json_array_elements(v_program_type)
loop
INSERT INTO tb_prov_ref_program_type
(program_type_id, referral_id, program_type, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES(gen_random_uuid(),v_ReqReferralId , i , 1, v_securityuserid, now(), v_securityuserid, now());
END LOOP;


else
returnStatus:= 'failure';
END IF;
returnStatus:= 'Success';
RETURN returnStatus;
                                                      
END;

$function$
