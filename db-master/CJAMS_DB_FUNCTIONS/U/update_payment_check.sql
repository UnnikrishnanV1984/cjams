CREATE OR REPLACE FUNCTION cjams.update_payment_check(	v_securityuserid character varying, 
														v_objectid integer, 
														v_notes character varying, 
														v_key character varying
													)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 01/29/2021 Vineet Tirodkar - Modification to update all tables/audit columns (CDM-9278)
-- 12/01/2022 Vineet Tirodkar - Modification to update Provider Withhold Flag updates (CIDM-6074/B-150256)
-- Update Withhold Flag = 'Y' for 4849 - Returned
-- Update Withhold Flag = 'N' for 580 - Remailed
------------------------------------------------------------------------ 
Declare vs_withhold_payment_sw character varying;
Declare vs_payment_type_cd character varying;
Declare vs_withholdreason character varying;
Declare vl_provider_id bigint;
                               
Begin

	select ph.provider_id,
		ph.payment_type_cd,
		coalesce(pr.withhold_payment_sw, 'N')	
	into vl_provider_id,
		vs_payment_type_cd,
		vs_withhold_payment_sw
	from tb_payment_header ph,
		prov.tb_provider pr
	where ph.provider_id = pr.provider_id
		and ph.payment_id = v_objectid ;

	update tb_payment_header 
		set check_status_cd = btrim(v_key),
			check_status_dt = now()::date,
			notes_tx = v_notes,
			update_ts = now(),
			update_user_id = v_securityuserid
	where payment_id = v_objectid;

	if vl_provider_id is not null and btrim(vs_payment_type_cd) in ('5689', '6', '7') then -- Adoption Subsidy / Maintenance / GAP
		-- Returned
		if btrim(v_key) = '4849' and vs_withhold_payment_sw = 'N' then 
			update prov.tb_provider 
			set withhold_payment_sw = 'Y',
				update_ts = now(),
				update_user_id = v_securityuserid
			where provider_id = vl_provider_id ;

			-- For Audit Purposes 	
			vs_withholdreason := 'Check status was updated as Returned for ' ||
					(case when vs_payment_type_cd = '5689' then 'Adoption Subsidy'
						when vs_payment_type_cd = '6' then 'Maintenance'
						when vs_payment_type_cd = '7' then 'Guardianship Assistance Program'
					end)::character varying || ' Payment # ' || v_objectid::character varying || '.' ;
						
			insert into withhold_eft_config
				(	withhold_payment_sw, eft_sw, 
					activeflag, insertedby, insertedon, updatedby, updatedon,
					provider_id, withhold_reason
				)
			values
				( 	'Y', NULL, 
					1, v_securityuserid, now(), v_securityuserid, now(),
					vl_provider_id, vs_withholdreason
				);
		end if;
		
		-- Remailed
		if btrim(v_key) = '580' and vs_withhold_payment_sw = 'Y' then 
			update prov.tb_provider 
			set withhold_payment_sw = 'N',
				update_ts = now(),
				update_user_id = v_securityuserid
			where provider_id = vl_provider_id ;
			-- where provider_id = (select provider_id from tb_payment_header where payment_id = v_objectid) ;
			
			
			-- For Audit Purposes 	
			vs_withholdreason := 'Check status was updated as Remailed for ' ||
					(case when vs_payment_type_cd = '5689' then 'Adoption Subsidy'
						when vs_payment_type_cd = '6' then 'Maintenance'
						when vs_payment_type_cd = '7' then 'Guardianship Assistance Program'
					end)::character varying || ' Payment # ' || v_objectid::character varying || '.' ;
						
			insert into withhold_eft_config
				(	withhold_payment_sw, eft_sw, 
					activeflag, insertedby, insertedon, updatedby, updatedon,
					provider_id, withhold_reason
				)
			values
				( 	'N', NULL, 
					1, v_securityuserid, now(), v_securityuserid, now(),
					vl_provider_id, vs_withholdreason
				);
				
			-- Release Payments on Hold
			PERFORM cjams.sp_release_payments(vl_provider_id::bigint) ;
			
		end if;
	end if;

	update tb_payment_history 
		set delete_sw = 'Y',
			update_ts = now(),
			update_user_id = v_securityuserid
	where payment_id = v_objectid 
		and delete_sw = 'N';

		
	INSERT INTO cjams.tb_payment_history
	(	payment_id, object_id, object_key, create_ts, create_user_id, update_ts, update_user_id, delete_sw	)
	VALUES
	(	v_objectid, btrim(v_key), 'check', now(), v_securityuserid, now(), v_securityuserid,  'N'	);

	RETURN  'Success';

END;
 
$function$
;