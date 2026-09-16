CREATE OR REPLACE FUNCTION cjams.placementexitvoidtickler(v_objectid character varying, v_securityusersid character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------
-- Revisions:
-- Vineet Tirodkar - 05/16/2023 - Modifications to the Placement voided tickler logic (CDM-31225)
-- Vineet Tirodkar - 11/06/2024 - To add new Non-paid Kinship Placement structure in exclusion  (B-207876 / CIDM-9688)
-- Vineet Tirodkar - 11/18/2024 - Modifications to Fix System generated Payment plans with Percentage 0.00% Issue (CDM-41336)
------------------------------------------------------------------------------------------------
DECLARE 

v_providerid bigint;
v_pay_providerid bigint;
v_providernm character varying;
v_enddatetime timestamp;
v_isvoided int;
v_count int;
v_receivablecount int;
v_receivableid bigint;
vl_tickler_id BIGINT DEFAULT 0;--
vs_tickler_col VARCHAR(50) DEFAULT 'sq_ticklers';
v_categorycd character varying;
v_percentage_no numeric;
v_countycd character varying;
v_placementid bigint;
v_clientid bigint;
v_caseid bigint;
v_receivables RECORD; 
v_placement_structure_id bigint;
vl_sql_code INT DEFAULT 0;

BEGIN 
	vl_tickler_id := 0; -- INITIAL VALUE
	vs_tickler_col:='sq_ticklers';

	select statecountycode into v_countycd from v_userprofile where securityusersid = v_securityusersid LIMIT 1;

	select placement_id, client_id, case_id, placement_structure_id 
		into v_placementid, v_clientid, v_caseid, v_placement_structure_id
	from tb_placement 
	where placementid = v_objectid::uuid;
	
	SELECT sp_nextid(vs_tickler_col::character varying) into vl_tickler_id;

	select pl.enddatetime,pl.isvoided, tb.provider_id, 
		(case when pl.providerorganizationid is not null and tb.pay_to_affiliate_cd = '3368' then tb.affiliate_provider_id else tb.provider_id end), 
		-- tb.provider_category_cd,
		f_prvpcklst_cat(tb.provider_id::bigint,'PLACEMENT'),
		-- (case when tb.provider_nm is null or tb.provider_nm = '' then concat_ws(' ',tb.provider_first_nm,tb.provider_last_nm) else tb.provider_nm end) 
		f_ename('2953', tb.provider_id::bigint)
		into  v_enddatetime,v_isvoided,v_providerid,v_pay_providerid,v_categorycd,v_providernm
	from placement pl 
		inner join tb_provider tb on tb.provider_id = pl.altproviderid
	where pl.placementid=v_objectid::uuid;

	
	if((v_isvoided = 1)) and v_placement_structure_id not in (8, 76, 531) then 
		INSERT INTO tb_ticklers
			(TICKLER_ID, tickler_tx, tickler_type_sw, due_dt, reminder_start_dt, entity_type_cd, 
			entity_key_id, entity_nm, assigned_to_staff_id, client_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, county_cd, county_unit_id, system_tickler_id, 
			tickler_nature_cd, assign_to_county_cd, assign_to_unit_id, expiry_dt, entity_id1, entity_id2, screen_cd, data_valid_sw, client_merge_id, action_tx, action_sw, action_dt, supervisor_review_sw, transfered_tickler_id, action_by_staff_id)
		VALUES
			( vl_tickler_id,'Placement has been voided, which will generate overpayment.', 'S', NULL, NULL, '2953', 
			v_providerid, v_providernm, NULL, v_clientid, now(), 'online',now(), 'online', 'N', v_countycd, NULL, 439,
			NULL, NULL, NULL, NULL, v_caseid, v_placementid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
			);
	end if;

	-- CDM-41336
	select receivable_id 
		into v_receivableid 
	from tb_receivable_header 
	where provider_id = v_pay_providerid 
		and delete_sw = 'N' ;
	
	if v_receivableid > 0 then 
		select sp_payment_plan_insert(v_receivableid::bigint) into vl_sql_code;
	end if;	

	/*
	if(btrim(v_categorycd) = '1783') then  
		v_percentage_no = 25::numeric;
	else
		v_percentage_no = 100::numeric;
	end if;


	select count(1) into v_count from tb_placement tp 
	where tp.provider_id=v_providerid and tp.delete_sw='N' and tp.approval_status_cd = '3047' and exit_dt is null and void_sw is null;

	v_receivablecount:= 0;

	select count(1) over(),receivable_id into v_receivablecount,v_receivableid from tb_receivable_header where provider_id=v_pay_providerid and delete_sw='N' limit 1;

	IF(v_receivablecount > 0) THEN 
		IF (v_count = 0 or v_isvoided=1 ) THEN

			update tb_payment_plan set delete_sw='Y' where receivable_id=v_receivableid;

			INSERT INTO cjams.tb_payment_plan
			( plan_dt, receivable_id, amount_no, percentage_no, months_no, start_dt, end_dt, offset_sw, payment_option_sw, 
			offset_option_sw, manual_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw, current_receivable_amount)
			SELECT  plan_dt, receivable_id, amount_no, v_percentage_no, months_no, start_dt, end_dt, null, payment_option_sw, 
			null, manual_sw, now(), 'online', now(), 'online', 'N', current_receivable_amount
			FROM cjams.tb_payment_plan
			WHERE receivable_id=v_receivableid and delete_sw='Y' order by create_ts limit 1;

		END IF;
		IF (v_count = 1 and v_isvoided != 1) THEN

			update tb_payment_plan set delete_sw='Y' where receivable_id=v_receivableid;

			INSERT INTO cjams.tb_payment_plan
			( plan_dt, receivable_id, amount_no, percentage_no, months_no, start_dt, end_dt, offset_sw, payment_option_sw, 
			offset_option_sw, manual_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw, current_receivable_amount)
			SELECT  plan_dt, receivable_id, amount_no, v_percentage_no, months_no, start_dt, end_dt, 'Y', payment_option_sw, 
			'A', manual_sw, now(), 'online', now(), 'online', 'N', current_receivable_amount
			FROM cjams.tb_payment_plan
			WHERE receivable_id=v_receivableid and delete_sw='Y' order by create_ts limit 1;

		END IF;

		FOR v_receivables IN 
			SELECT tbrcs.receivable_detail_id, tbrcs.collection_status_id, tbrcs.collection_status_cd				
				FROM tb_receivable_collection_status tbrcs
					JOIN tb_receivable_detail tjrt on tjrt.receivable_detail_id = tbrcs.receivable_detail_id
						and tjrt.delete_sw  = 'N' and tjrt.receivable_balance_no > 0
					JOIN tb_receivable_header trh on trh.receivable_id = tjrt.receivable_id	and trh.delete_sw  = 'N'			
				WHERE 	trh.provider_id = v_pay_providerid and tbrcs.delete_sw  = 'N' and tbrcs.active_sw = 'Y' 
		LOOP
			IF (v_count = 0 or v_isvoided=1) THEN
				IF v_receivables.collection_status_cd = '779' THEN 

					INSERT INTO tb_receivable_collection_status
								(collection_status_cd, collection_status_dt, active_sw, create_ts, create_user_id, update_ts, 
													receivable_detail_id, update_user_id, delete_sw, etl_userid, etl_load_date)
					SELECT '780', collection_status_dt, 'Y', now(), 'online', now(), receivable_detail_id, 'online', delete_sw, etl_userid, etl_load_date
					FROM tb_receivable_collection_status
					where receivable_detail_id = v_receivables.receivable_detail_id and collection_status_id = v_receivables.collection_status_id and delete_sw = 'N' and active_sw = 'Y';   

					update tb_receivable_collection_status set active_sw = 'N', delete_sw='Y', update_ts = now(), update_user_id = 'online'
					where receivable_detail_id = v_receivables.receivable_detail_id and v_receivables.collection_status_id = collection_status_id;

				END IF;
			ELSEIF (v_count = 1 and v_isvoided != 1) THEN
				IF v_receivables.collection_status_cd = '780' THEN  

					 INSERT INTO tb_receivable_collection_status
								(collection_status_cd, collection_status_dt, active_sw, create_ts, create_user_id, update_ts, 
													receivable_detail_id, update_user_id, delete_sw, etl_userid, etl_load_date)
					SELECT '779', collection_status_dt, 'Y', now(), 'online', now(), receivable_detail_id, 'online', delete_sw, etl_userid, etl_load_date
					FROM tb_receivable_collection_status
					where receivable_detail_id = v_receivables.receivable_detail_id and collection_status_id = v_receivables.collection_status_id and delete_sw = 'N' and active_sw = 'Y';   

					update tb_receivable_collection_status set active_sw = 'N', delete_sw='Y', update_ts = now(), update_user_id = 'online'
					where receivable_detail_id = v_receivables.receivable_detail_id and v_receivables.collection_status_id = collection_status_id;

				END IF; 
			END IF;

		END LOOP;

	end if;
	*/

	return 'success';

END;

$function$
;
