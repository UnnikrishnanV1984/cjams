CREATE OR REPLACE FUNCTION cjams.sp_tb_purchase_authorization(v_authorization_id bigint, v_status bigint, v_securityid character varying, v_costno numeric, v_provider_id integer, v_startdate date, v_enddate date, v_payment_method character varying, v_store_receipt_id character varying, v_type_1099_cd character varying, v_report_1099_sw character, v_client_account_id integer)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 04/29/2021 Vineet Tirodkar - Modifications to LDSS Code & Address logic for snapshot data (CDM-1217)
-- 11/09/2021 Vineet Tirodkar - Modifications for CJAMS - Performance Issue (CIDM-4060)
-- 01/05/2022 Chandra Ramasamy - Added logics for showing Payment approval records which are funding approved by Caseworker, Case supervisor, IV-E team (CDM-19322)
-- 08/22/2022 Vineet Tirodkar - Modifications to remove all pending routing records after payment generation (CDM-24464)
-- 09-21-2022 - Aurora Issue Fixes  - Veera
-- 06/27/2023 Vineet Tirodkar - Payment Approval fix when Supervisory apporval routing record is missing exception scenario(CDM-32517)
-- 10/17/2023 - Vineet Tirodkar - Modifications for Authorizations from Adoption cases. (CDM-34858)
-- 11/06/2023 - Amiya Pradhan - Modifications for Service Log Vendor info missing. (CIDM-7987) 
-- 08/26/2025 - Parshal Chitrakar(CDM-44494)-- Modification for the supervisor name and cjampid logic
------------------------------------------------------------------------------------------------------------	
/* One Parameter added decision - intakeserreqstatustypeid  */
DECLARE 
	 
	v_paymentid integer;
	v_fromroleid character varying;
	v_fromloadnumber character varying;
	v_toroleid character varying;
	v_securityuserid character varying;
	vl_pay_header_id BIGINT DEFAULT 0;
	vl_pay_status_id BIGINT DEFAULT 0;
	vl_pay_detail_id BIGINT DEFAULT 0;
	vl_slpa_snapsho_id integer default 0;
	vl_tb_client_account BIGINT DEFAULT 0;
	v_fiscal_category_cd character varying;
	v_fiscalcount bigint;
	v_costcount bigint;
	v_notifystatus character varying;
	v_msg character varying;
	v_msgfiscal	character varying;
	v_msgcost character varying;
	v_tosecurityusersid character varying;
	v_fiscalcd character varying;
	v_fiscalcdoriginal character varying;
	v_orginalcost numeric;
	v_totalmgs character varying;
    v_conservedchange integer;
    v_alreadydebited integer;
    v_modifiedfiscal character varying;
   	v_fiscal_cd character varying;
   	v_mod_fiscal_cd character varying;
   	v_account_type character varying;
	--v_client_account_id integer;

	vl_affiliate_provider bigint;
	vl_payment_provider_id  bigint;
	v_pay_cd character varying;
	v_adr_typ character varying;
	v_addr_format character varying;
	v_addr_st_no character varying;
	vl_addr_box bigint;
	v_addr_pre character varying;
	v_addr_st character varying;
	v_addr_suff character varying;
	v_addr_post character varying;
	v_unit_type character varying;
	v_add_unit character varying;
	v_city character varying;
	v_county character varying;
	v_state character varying; 
	vd_zip5 bigint;
	vd_zip4 bigint;
	v_direc character varying;
	v_foreign character varying;
	v_foreign_st character varying;
	v_foreign_postal character varying;
	v_add_country character varying;
	v_default_sw character varying;
	vdt_end_dt date;
	vdt_start_dt date;	
	v_caseworker_statecountycd character varying;
	v_securityuserid_statecountycd character varying;
	--	select concat(coalesce(tpas.adr_street_no :: text,(tpas.adr_street_no||', '),''),
	--	coalesce(tpas.adr_street_nm :: text,(tpas.adr_street_nm||', '),''),
	--	coalesce(tpas.adr_city_nm :: text,(tpas.adr_city_nm||', '),''),
	--	coalesce(tpas.adr_state_cd :: text,(tpas.adr_state_cd||', '),''),
	--	coalesce(tpas.adr_zip5_no :: text,(tpas.adr_zip5_no||', '),''),
	--	
	--	select  concat_ws(', ',tpas.adr_street_no,tpas.adr_street_nm,tpas.adr_city_nm,tpas.adr_state_cd,tpas.adr_zip5_no) from tb_provider_addresses tpas
	--	where address_id = 8442;
	--	
	--	select * from tb_provider_services;
begin
	v_securityuserid:= v_securityid;
	--For getting case worker county id 
	select trim(c.statecountycode)::character varying 
		into v_caseworker_statecountycd 
	from routing r 
		join team t on r.teamid=t.teamid  and t.activeflag = 1
		join county c on c.countyid = t.countyid::uuid 
	where r.objectid=v_authorization_id::character varying 
		and r.routingstatustypeid=39
	limit 1;
	
	If v_caseworker_statecountycd is null then
		select trim(c.statecountycode)::character varying 
			into v_caseworker_statecountycd 
		from routing r 
			join team t on r.teamid=t.teamid and t.activeflag = 1
			join county c on c.countyid = t.countyid::uuid 
		where r.objectid = v_authorization_id::character varying 
		order by r.insertedon
		limit 1;
	end if;
	
	--For getting current user county 
	select trim(c.statecountycode) :: character varying 
		into v_securityuserid_statecountycd
	from team t 
		join teammember tm on tm.teamid=t.teamid and tm.activeflag=1 
		join teammemberassignment tma on tma.teammemberid=tm.teammemberid and tma.activeflag=1 
		join muser mu on mu.securityusersid = tma.securityusersid and mu.activeflag=1 
		join rolemapping rm on rm.principalid::int=mu.id and rm.activeflag=1 
		join county c on c.countyid = t.countyid::uuid   
		join role r on r.id = rm.roleid::int 
	where mu.securityusersid = v_securityuserid limit 1;
	
	select fiscal_category_cd into v_fiscal_category_cd 
		from tb_service_purchase_authorization 
	where authorization_id = v_authorization_id;
	--select client_account_id into v_client_account_id from tb_client_account where account_type_cd='591' and client_id=v_client_id;
	
		
	if(v_status = 39)
		
	then
		delete from routing 
		where objectid = v_authorization_id::character varying
			and eventcode in ('PCAUTH','PCAUTHR') 
			and  activeflag = 0;
			
		delete from routing 
		where objectid = v_authorization_id::character varying
			and eventcode in ('PCAUTH','PCAUTHR') 
			and  routingstatustypeid = 62;
			
		update routing 
			set activeflag = 0 
		where objectid = v_authorization_id::character varying
			and  eventcode in ('PCAUTH','PCAUTHR') 
			and routingstatustypeid = 62;
	end if;
	
	if(v_status = 40 
			and ((SELECT count(*) 
					FROM routing r 
				  where activeflag = 1 
					AND r.objectid = v_authorization_id::character varying	
					AND r.eventcode in ('PCAUTH','PCAUTHR')
					and r.routingstatustypeid=40) =1) 
	  )
	then
	
	
		--if (v_fiscal_category_cd = '7502')
		--then
		raise notice 'v_client_account_id%',v_client_account_id;
		raise notice 'v_costno%',v_costno;

	
		--end if;

		update TB_SERVICE_PURCHASE_AUTHORIZATION 
			set sprvsr_approval_status_cd = 3047, 
				sprvsr_approval_dt = now(),
				ads_approval_status_cd = 3047, 
				ads_approval_dt = now() 
		where authorization_id = v_authorization_id;
		--	update routing set tosecurityusersid = v_securityuserid where eventcode = 'PCAUTHR' and objectid = v_authorization_id :: character varying and routingstatustypeid =40;
		
		if (v_fiscal_category_cd = '7503' or v_fiscal_category_cd = '7502')
		then
			
			update tb_client_account 
				set obligated_for_anc = coalesce(obligated_for_anc,0) + v_costno	
			where client_account_id = v_client_account_id;
			--add amount to transation Source as ‘Obligated’ and Transaction type as ‘Ancillary Goods/Services Obligation’ 
			--SELECT al_next_value from  sp_nextid ( 'sq_tb_client_account') into vl_tb_client_account;
			
			INSERT INTO tb_account_transaction
			(	client_account_id ,transaction_type_cd, transaction_source_cd, benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw,
				notes_tx, create_ts,  create_user_id, update_ts, update_user_id, delete_sw,payment_detail_id, authorization_id)
			select v_client_account_id,'5530', '5474', v_startdate, v_enddate , v_costno, now(), 'D','',now(),
				v_securityuserid,now(),v_securityuserid,'N',null,v_authorization_id ;
		
			--	update tb_client_account set 
			--	available_balance_no=coalesce (available_balance_no ,0)  - v_costno, 
			--	total_balance_no=coalesce (total_balance_no ,0)  - v_costno 
			--	where client_account_id = v_client_account_id;
			
			--update tb_service_purchase_authorization set client_account_id=v_client_account_id  where  authorization_id= v_authorization_id;
			raise notice 'v_fiscal_category_cd%',v_fiscal_category_cd;
		
		end if;
	
	else if(v_status = 41 
		and ((SELECT count(*) 
				FROM routing r 
			  where activeflag = 1 
				AND r.objectid = v_authorization_id::character varying	
				AND r.eventcode in ('PCAUTH','PCAUTHR')
			   and r.routingstatustypeid=41) =1)
			 )
	then
		update TB_SERVICE_PURCHASE_AUTHORIZATION 
		set funding_approval_status_cd = 3047, 
				funding_approval_dt = now() 
		where authorization_id = v_authorization_id;
		--update routing set tosecurityusersid = v_securityuserid where eventcode = 'PCAUTHR' and objectid = v_authorization_id :: character varying and routingstatustypeid in (40,44);
		--Temporarily added. right now securityusersid is coming wrongly
		update routing 
		set tosecurityusersid = 
				(select fromsecurityusersid 
					from routing 
				 where objectid = v_authorization_id::character varying
					and routingstatustypeid = 41 
				order by insertedon desc 
				limit 1
				) 
		where eventcode = 'PCAUTHR' 
			and objectid = v_authorization_id::character varying
			and routingstatustypeid in ( 40, 44 );

	else if(v_status = 42 
		and ((SELECT count(*) 
				FROM routing r 
			  where activeflag = 1 
				AND r.objectid = v_authorization_id::character varying	
				AND r.eventcode in ('PCAUTH','PCAUTHR')
				and r.routingstatustypeid=42) =1)
			)
	then
	
		--	if (v_fiscal_category_cd = '7502')
		--	then
		
		--	end if;
	
	
		update TB_SERVICE_PURCHASE_AUTHORIZATION 
		set sprvsr_approval_status_cd = 3047, 
			sprvsr_approval_dt = now() 
		where authorization_id = v_authorization_id; 
		
		update routing 
		set tosecurityusersid = v_securityuserid 
		where eventcode = 'PCAUTHR' 
			and objectid = v_authorization_id::character varying
			and routingstatustypeid =41;
	
		if (v_fiscal_category_cd = '7503' or v_fiscal_category_cd = '7502')
		then
			--add amount to transation Source as ‘Obligated’ and Transaction type as ‘Ancillary Goods/Services Obligation’ 
			--SELECT al_next_value from  sp_nextid ( 'sq_tb_client_account') into vl_tb_client_account;
			update tb_client_account 
			set obligated_for_anc = coalesce(obligated_for_anc,0) + v_costno	
			where client_account_id = v_client_account_id;
			
			INSERT INTO tb_account_transaction
			(	client_account_id ,transaction_type_cd, transaction_source_cd, benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw,
				notes_tx, create_ts,  create_user_id, update_ts, update_user_id, delete_sw,payment_detail_id, authorization_id)
			select v_client_account_id,'5530', '5474', v_startdate, v_enddate , v_costno, now(), 'D','',now(),
				v_securityuserid,now(),v_securityuserid,'N',null,v_authorization_id ;
			
			--	update tb_client_account set 
			--	available_balance_no=coalesce (available_balance_no ,0)  - v_costno 
			--	,total_balance_no=coalesce (total_balance_no ,0)  - v_costno
			--	where client_account_id = v_client_account_id;
	
			--update tb_service_purchase_authorization set client_account_id=v_client_account_id  where  authorization_id= v_authorization_id;
	
		end if;
	
	else if(v_status = 44 
		and ((SELECT count(*) 
				FROM routing r 
			 where activeflag = 1 
				AND r.objectid = v_authorization_id::character varying	
				AND r.eventcode in ('PCAUTH','PCAUTHR')
				and r.routingstatustypeid=44) =1)
			)
	then
		update TB_SERVICE_PURCHASE_AUTHORIZATION 
		set ads_approval_status_cd = 3047, 
			ads_approval_dt = now() 
		where authorization_id= v_authorization_id; 
		--update routing set tosecurityusersid = v_securityuserid where eventcode = 'PCAUTHR' and objectid = v_authorization_id :: character varying and routingstatustypeid =42;
		--Temp fix for avoiding the invalid v_securityuserid issues
		update routing 
		set tosecurityusersid = 
			(select fromsecurityusersid 
				from routing 
			where objectid = v_authorization_id::character varying
				and routingstatustypeid = 44 
			order by insertedon desc 
			limit 1) 
		where eventcode = 'PCAUTHR' 
			and objectid = v_authorization_id::character varying
			and routingstatustypeid =42;
	
	else if(v_status = 43 and (v_caseworker_statecountycd = v_securityuserid_statecountycd))
	then
		update TB_SERVICE_PURCHASE_AUTHORIZATION 
		set payment_approval_status_cd = 3047, 
			payment_approval_dt = now() 
		where authorization_id= v_authorization_id; 
		
	end if;
	end if;
	end if;
	end if;
	end if;
	
	if( v_status = 00)
	then
	
		select ph.payment_id 
			into v_paymentid 
		from tb_payment_header ph 
		where ph.authorization_id=v_authorization_id;
	
		update tb_payment_header 
		set gross_amount_no = v_costno,
			payment_end_dt = v_enddate,
			payment_start_dt = v_startdate,
			payment_method_cd = v_payment_method
		where payment_id=v_paymentid;
	end if;

	--Obligating and liquidation for 7502/7503
	if (v_status in (41,43,42) and (v_caseworker_statecountycd = v_securityuserid_statecountycd) ) then 
		--and ((SELECT count(*) FROM routing r where activeflag =1 AND r.objectid  =v_authorization_id	AND r.eventcode in ('PCAUTH','PCAUTHR')
		--	 and r.routingstatustypeid=v_status) =1)
		v_conservedchange := 0;
		v_alreadydebited := 0;

		select count(1)  
			into v_conservedchange 
		from tb_service_purchase_authorization tsa  
		where tsa.authorization_id=v_authorization_id 
			and trim(tsa.fiscal_category_cd)  in ('7502','7503') 
			and trim(tsa.modified_fiscal_category_cd) not in ('7502','7503') 
			and delete_sw='N'
			and tsa.fiscal_category_cd != tsa.modified_fiscal_category_cd;
			
		select count(1) 
			into v_alreadydebited 
		from tb_account_transaction 
		where credit_debit_sw = 'D' 
			and authorization_id = v_authorization_id 
			and transaction_amount_no = v_costno;
 
		if (v_conservedchange > 0 and v_alreadydebited = 0) then 
 
			 INSERT INTO tb_account_transaction
				(	client_account_id ,transaction_type_cd, transaction_source_cd, benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw,
					notes_tx, create_ts,  create_user_id, update_ts, update_user_id, delete_sw,payment_detail_id, authorization_id)
			select v_client_account_id,'5530', '5474', v_startdate, v_enddate , v_costno, now(), 'D','',now(),
				'admi',now(),v_securityuserid,'N',null,v_authorization_id ;
			 
			--	update tb_client_account set 
			--	available_balance_no=coalesce (available_balance_no ,0)  - v_costno 
			--	,total_balance_no=coalesce (total_balance_no ,0)  - v_costno
			--	where client_account_id = v_client_account_id;
		end if;
		
		v_conservedchange := 0;
		select count(1),
			trim(tsa.modified_fiscal_category_cd)  
		into v_conservedchange,
			v_modifiedfiscal 
		from tb_service_purchase_authorization tsa  
		where tsa.authorization_id = v_authorization_id 
			and trim(tsa.fiscal_category_cd) not in ('7502','7503') 
			and trim(tsa.modified_fiscal_category_cd) in ('7502','7503')  
			and delete_sw = 'N' 
			and tsa.fiscal_category_cd != tsa.modified_fiscal_category_cd 
		group by tsa.modified_fiscal_category_cd;

		if (v_conservedchange > 0) then 
			if (v_modifiedfiscal in ('7502','7503')) then 
				update tb_client_account 
					set obligated_for_anc = coalesce (obligated_for_anc ,0) 
							- coalesce((select cost_no from tb_service_purchase_authorization 
											where authorization_id=v_authorization_id),0)
				where client_account_id = v_client_account_id;
			end if;
			
			raise notice 'v_costno % ',v_costno;
			INSERT INTO tb_account_transaction
			(	client_account_id ,transaction_type_cd, transaction_source_cd, benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw,
				notes_tx, create_ts,  create_user_id, update_ts, update_user_id, delete_sw,payment_detail_id, authorization_id)
			select v_client_account_id,'5530', '5475', v_startdate, v_enddate , v_costno, now(), 'C','',now(),
				v_securityuserid,now(),v_securityuserid,'N',null,v_authorization_id ;
			
			--	update tb_client_account set 
			--	available_balance_no=coalesce (available_balance_no ,0)  + 
			--	(select transaction_amount_no from tb_account_transaction where authorization_id=v_authorization_id order by create_ts limit 1) 
			--	,total_balance_no=coalesce (total_balance_no ,0)  + 
			--	(select transaction_amount_no from tb_account_transaction where authorization_id=v_authorization_id order by create_ts limit 1) 
			--
			--	where client_account_id = v_client_account_id;
		end if;

		--for conserved to dedicated or dedicated to conservered .

		select count(1)  
			into v_conservedchange  
		from tb_service_purchase_authorization tsa  
		where tsa.authorization_id = v_authorization_id 
			and trim(tsa.fiscal_category_cd) in ('7502','7503') 
			and trim(tsa.modified_fiscal_category_cd) in ('7502','7503')  
			and delete_sw = 'N' 
			and tsa.fiscal_category_cd != tsa.modified_fiscal_category_cd;

		select count(1) 
			into v_alreadydebited 
		from tb_account_transaction 
		where credit_debit_sw = 'D' 
			and authorization_id = v_authorization_id 
			and transaction_amount_no = v_costno;
			
		if (v_conservedchange > 0) then 
 
			-- if(v_mod_fiscal_cd = '7502')
			select trim(tsa.fiscal_category_cd),
				trim(tsa.modified_fiscal_category_cd) 
			into v_fiscal_cd,
				v_mod_fiscal_cd 
			from tb_service_purchase_authorization tsa  
			where tsa.authorization_id = v_authorization_id 
				and trim(tsa.fiscal_category_cd) in ('7502','7503') 
				and trim(tsa.modified_fiscal_category_cd) in ('7502','7503')  
				and delete_sw = 'N' 
				and tsa.fiscal_category_cd != tsa.modified_fiscal_category_cd
			group by tsa.fiscal_category_cd,
				tsa.modified_fiscal_category_cd;
 
			if(v_mod_fiscal_cd = '7502')
			then
				v_account_type := '590';
			else 
				v_account_type := '591';
			end if;
 
			INSERT INTO tb_account_transaction
			(	client_account_id ,transaction_type_cd, transaction_source_cd, benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw,
				notes_tx, create_ts,  create_user_id, update_ts, update_user_id, delete_sw,payment_detail_id, authorization_id)
			select v_client_account_id,'5530', '5474', v_startdate, v_enddate , v_costno, now(), 'D','',now(),'admi',
				now(),v_securityuserid,'N',null,v_authorization_id ;
 
			--	update tb_client_account set 
			--	available_balance_no=coalesce (available_balance_no ,0)  - v_costno 
			--	,total_balance_no=coalesce (total_balance_no ,0)  - v_costno
			--	where client_account_id = v_client_account_id;
			-- end if;
			-- v_conservedchange := 0;
			select count(1),
				trim(tsa.modified_fiscal_category_cd)  
			into v_conservedchange,
				v_modifiedfiscal 
			from tb_service_purchase_authorization tsa  
			where tsa.authorization_id = v_authorization_id 
				and trim(tsa.fiscal_category_cd) in ('7502','7503') 
				and trim(tsa.modified_fiscal_category_cd) in ('7502','7503')  
				and delete_sw = 'N' 
				and tsa.fiscal_category_cd != tsa.modified_fiscal_category_cd 
			group by tsa.modified_fiscal_category_cd;

			INSERT INTO tb_account_transaction
			(	client_account_id ,transaction_type_cd, transaction_source_cd, benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw,
				notes_tx, create_ts,  create_user_id, update_ts, update_user_id, delete_sw,payment_detail_id, authorization_id)
			select (select tcaaa.client_account_id 
						from tb_client_account tcaaa 
					where tcaaa.client_id=(select client_id 
											from tb_client_account tc where tc.client_account_id = v_client_account_id)  
						and tcaaa.account_type_cd = v_account_type 
						and tcaaa.status_cd = '592' 
					limit 1),'5530', '5475', v_startdate, v_enddate , v_costno, now(), 'C','',now(),v_securityuserid,
				now(),v_securityuserid,'N',null,v_authorization_id ;
 	
			--	update tb_client_account set 
			--	available_balance_no=coalesce (available_balance_no ,0)  + 
			--	(select transaction_amount_no from tb_account_transaction where authorization_id=v_authorization_id order by create_ts limit 1) 
			--	,total_balance_no=coalesce (total_balance_no ,0)  + 
			--	(select transaction_amount_no from tb_account_transaction where authorization_id=v_authorization_id order by create_ts limit 1) 
			--
			--	where client_account_id = (select tcaaa.client_account_id from tb_client_account tcaaa where 
			--	tcaaa.client_id=(select client_id from tb_client_account tc where tc.client_account_id = v_client_account_id)  
			-- and tcaaa.account_type_cd= v_account_type and tcaaa.status_cd = '592' limit 1);

			--if (v_conservedchange > 0) then 
			if (v_modifiedfiscal in ('7502','7503')) then 
				update tb_client_account 
				set obligated_for_anc = coalesce (obligated_for_anc ,0) - 
								coalesce((select cost_no from tb_service_purchase_authorization 
										where authorization_id=v_authorization_id),0)
				where client_account_id = (select tcaaa.client_account_id 
												from tb_client_account tcaaa 
											where tcaaa.client_id =
												(select client_id from tb_client_account tc 
													where tc.client_account_id = v_client_account_id)  
											and tcaaa.account_type_cd = v_account_type 
											and tcaaa.status_cd = '592' 
											limit 1);
			end if;
			
			if (v_fiscal_cd in ('7502','7503')) then 
				update tb_client_account 
				set obligated_for_anc = coalesce (obligated_for_anc ,0) + 
							coalesce((select cost_no from tb_service_purchase_authorization 
										where authorization_id=v_authorization_id),0)
				where client_account_id = v_client_account_id;
			end if;
			raise notice 'v_costno % ',v_costno;
 	
		end if;
	end if;

	if(v_status = 43 and (v_caseworker_statecountycd = v_securityuserid_statecountycd))
	then

		-- Step 1
		-- Get Provider payment setting & affiliated provider Organization ID		
		SELECT affiliate_provider_id,pay_to_affiliate_cd 
			INTO vl_affiliate_provider,
				 v_pay_cd
		FROM TB_PROVIDER
		WHERE PROVIDER_ID = v_provider_id;
			
		-- Step 2
		-- Verify Payment setting
		IF v_pay_cd = '3368' THEN -- The Payment Address of the Affiliate Organization
			-- Send Payment to affiliated provider Organization ID		
			vl_payment_provider_id = vl_affiliate_provider;

			-- Get affiliated provider Organization payment setting	
			SELECT pay_to_affiliate_cd 
				INTO v_pay_cd
			FROM TB_PROVIDER
			WHERE PROVIDER_ID = vl_payment_provider_id;
		ELSE
			-- Send Payment to the provider selected on Service Log screen		
			vl_payment_provider_id = v_provider_id;
		END IF;

		-- Step 3
		-- Get Provider's Payment Address Type, based on the vs_pay_cd (payment setting) of the Payment Provider
		IF v_pay_cd = '3366' THEN -- The Same Address (means Provider's payment address is same as Location Address)
			v_adr_typ = '3357'; -- Provider Location Address
		ELSE 
			v_adr_typ = '3356'; -- Provider Payment Address
		END IF;

		-- Step 4
		-- Get Provider's Payment Address to populate in TB_PAYMENT_HEADER table	
			
		SELECT ADR_FORMAT_CD, ADR_STREET_TX,   
			ADR_BOX_NO, ADR_PRE_DIR_CD,   
			ADR_STREET_NM, ADR_STREET_SUFFIX_CD,   
			ADR_POST_DIR_CD, ADR_UNIT_TYPE_CD,   
			ADR_UNIT_NO_TX, ADR_CITY_NM,   
			ADR_COUNTY_CD, ADR_STATE_CD,   
			ADR_ZIP5_NO, ADR_ZIP4_NO,   
			ADR_DIRECTION_TX, ADR_FOREIGN_TX,   
			ADR_FOREIGN_STATE_TX, ADR_POSTAL_CODE_TX,   
			ADR_COUNTRY_TX, ADR_DEFAULT_SW,   
			ADR_END_DT, ADR_START_DT  
		INTO	v_addr_format, v_addr_st_no,
				vl_addr_box, v_addr_pre,
				v_addr_st, v_addr_suff,
				v_addr_post, v_unit_type,
				v_add_unit, v_city,
				v_county, v_state,
				vd_zip5, vd_zip4,
				v_direc, v_foreign,
				v_foreign_st, v_foreign_postal,
				v_add_country, v_default_sw,
				vdt_end_dt, vdt_start_dt			
		FROM TB_PROVIDER_ADDRESSES  
		WHERE ADR_TYPE_CD = v_adr_typ
			AND PARENT_KEY_ID::bigint = vl_payment_provider_id::bigint
			AND DELETE_SW = 'N' 
			AND ADR_DEFAULT_SW = 'Y' 
		LIMIT 1;

		--select * from tb_payment_header;
		SELECT al_next_value from  sp_nextid ( 'sq_payment_header') into vl_pay_header_id;
		SELECT al_next_value from  sp_nextid ( 'sq_payment_detail') into vl_pay_detail_id;
		SELECT al_next_value from  sp_nextid ( 'sq_payment_status') into vl_pay_status_id;
		SELECT al_next_value from  sp_nextid ( 'seq_tb_slpa_snapshot') into vl_slpa_snapsho_id;
	
		
		/*INSERT INTO tb_payment_header
		(payment_id, provider_id, authorization_id,client_account_id, payment_dt, payment_type_cd, check_status_cd, payment_method_cd, gross_amount_no, offset_amount_no, manual_sw, approval_status_cd, 
		 create_ts,  create_user_id, update_ts, update_user_id, delete_sw,store_receipt_id)
		VALUES(vl_pay_header_id, v_provider_id, v_authorization_id ,coalesce(v_client_account_id,null), now() , '4', '', v_payment_method, v_costno, 0, '', '3047',now(),v_securityuserid,now(),v_securityuserid,'N',v_store_receipt_id )
		RETURNING payment_id into v_paymentid; */

		INSERT INTO tb_payment_header
		( 	payment_id, 
			provider_id, 
			authorization_id,
			client_account_id, 
			payment_dt, 
			payment_type_cd, 
			check_status_cd,  
			payment_method_cd, 
			gross_amount_no, 
			offset_amount_no, 
			manual_sw, 
			approval_status_cd, 
			create_ts,  
			create_user_id, 
			update_ts, 
			update_user_id, 
			delete_sw,
			store_receipt_id,
			adr_box_no,
			adr_city_nm,
			adr_country_tx,						
			adr_county_cd,		
			adr_default_sw,		
			adr_direction_tx,					
			adr_end_dt,					
			adr_start_dt,		
			adr_foreign_state_tx,		
			adr_foreign_tx,		
			adr_format_cd,		
			adr_post_dir_cd,		
			adr_postal_code_tx,		
			adr_pre_dir_cd,		
			adr_state_cd,		
			adr_street_nm,		
			adr_street_tx,		
			adr_street_suffix_cd,		
			adr_unit_no_tx,		
			adr_unit_type_cd,		
			adr_zip4_no,		
			adr_zip5_no
		)
		VALUES
		(	vl_pay_header_id, 
			vl_payment_provider_id, 
			v_authorization_id,
			coalesce(v_client_account_id,null), 
			now(), 
			'4', 
			'', 
			v_payment_method, 
			v_costno, 
			0, 
			'', 
			'3047',
			now(),
			v_securityuserid,
			now(),
			v_securityuserid,
			'N',
			v_store_receipt_id,
			vl_addr_box,
			v_city,
			v_add_country,						
			v_county,
			v_default_sw,		
			v_direc,			
			vdt_end_dt,					
			vdt_start_dt,		
			v_foreign_st,		
			v_foreign,		
			v_addr_format,		
			v_addr_post,		
			v_foreign_postal,		
			v_addr_pre,		
			v_state,		
			v_addr_st,		
			v_addr_st_no,		
			v_addr_suff,		
			v_add_unit,		
			v_unit_type,		
			vd_zip4,		
			vd_zip5	
		)
		RETURNING payment_id into v_paymentid;
	
		INSERT INTO tb_payment_detail
		(	payment_detail_id, payment_id, county_cd, payment_amount_no, client_id, final_service_id, 
			final_service_start_dt, final_service_end_dt, final_amount_no, create_ts, create_user_id, update_ts, 
			update_user_id,case_id,type_1099_cd,report_1099_sw,final_fiscal_category_cd)
		select vl_pay_detail_id,v_paymentid, v_caseworker_statecountycd,v_costno,  tsl.client_id , tps.service_id, 
			v_startdate, v_enddate, v_costno,now(),v_securityuserid,now(),v_securityuserid,tsl.case_id,
			v_type_1099_cd,v_report_1099_sw,tspa.fiscal_category_cd
			from tb_service_log tsl 
				join tb_provider_services tps on tps.provider_service_id=tsl.provider_service_id
				join tb_provider tp on tps.provider_id=tp.provider_id
				join tb_service_purchase_authorization tspa on tspa.service_log_id = tsl.service_log_id 
					and tspa.delete_sw = 'N'
		where tspa.authorization_id = v_authorization_id 
		limit 1 
		;
	
		INSERT INTO tb_payment_status
		(	payment_status_id, payment_status_cd, payment_status_dt, payment_id, 
			create_ts, create_user_id, update_ts, update_user_id)
		VALUES(vl_pay_status_id,'1634', now(), v_paymentid,now(),v_securityuserid,now(),v_securityuserid);


		update tb_service_purchase_authorization 
		set final_amount_no = v_costno 
		where authorization_id = v_authorization_id;
	
		update routing 
		set remarks = 'Approved',
			routingstatustypeid = 43,
			tosecurityusersid = v_securityuserid 
		where objectid = v_authorization_id::character varying
			and eventcode in ('PCAUTH','PCAUTHR') 
			and fromroleid in ('FNSFS','FNSFW','CWSP','CWCW','IVESV','IVESP')
			and toroleid = 'FNSFS' 
			and activeflag = 1 ;
	

		--	update routing set tosecurityusersid = v_securityuserid where eventcode = 'PCAUTHR' and objectid = v_authorization_id :: character varying and routingstatustypeid =44;
		if (v_fiscal_category_cd = '7503' or v_fiscal_category_cd = '7502')
		then
			--credit amount --Source as ‘Obligation Liquidation’ and Transaction type as ‘Ancillary Goods/Services Obligation’ 
			
			--SELECT al_next_value from  sp_nextid ( 'sq_tb_client_account') into vl_tb_client_account;

			INSERT INTO tb_account_transaction
			(	client_account_id, transaction_type_cd, transaction_source_cd, benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw,
				notes_tx, create_ts,  create_user_id, update_ts, update_user_id, delete_sw,payment_detail_id, authorization_id)
			select v_client_account_id,'5530', '5475', v_startdate, v_enddate , 
					(select transaction_amount_no 
						from tb_account_transaction 
					where authorization_id=v_authorization_id 
					order by create_ts limit 1), now(), 'C','',now(),v_securityuserid,now(),v_securityuserid,'N',
				vl_pay_detail_id,v_authorization_id ;
				
			--	update tb_client_account set 
			--	available_balance_no=coalesce (available_balance_no ,0)  + 
			--	(select transaction_amount_no from tb_account_transaction where authorization_id=v_authorization_id order by create_ts limit 1) 
			--	,total_balance_no=coalesce (total_balance_no ,0)  + 
			--	(select transaction_amount_no from tb_account_transaction where authorization_id=v_authorization_id order by create_ts limit 1)
			--where client_account_id = v_client_account_id;
				

			
			--debit amount --Source as ‘Ancillary Payments’ and Transaction type as ‘Ancillary Goods/Services Disbursements’  
			--SELECT al_next_value from  sp_nextid ( 'sq_tb_client_account') into vl_tb_client_account;
			v_alreadydebited :=0;
			select count(1) 
				into v_alreadydebited 
			from tb_account_transaction 
			where credit_debit_sw = 'D' 
				and authorization_id = v_authorization_id 
				and transaction_amount_no = v_costno;
				
		   --if (v_alreadydebited = 0) then
			INSERT INTO tb_account_transaction
			(	client_account_id, transaction_type_cd, transaction_source_cd, benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw,
				notes_tx, create_ts,  create_user_id, update_ts, update_user_id, delete_sw,payment_detail_id, authorization_id)
			select v_client_account_id,'5531', '5476', v_startdate, v_enddate , v_costno, now(), 'D','',now(),
				v_securityuserid,now(),v_securityuserid,'N',vl_pay_detail_id,v_authorization_id ;
			
			--end if;
			update tb_client_account 
			set total_balance_no = coalesce (total_balance_no ,0)  - v_costno, 
				available_balance_no = coalesce (available_balance_no ,0)  - v_costno 
			where client_account_id = v_client_account_id;

			if (v_fiscal_category_cd in ('7502','7503'))
			then
				update tb_client_account 
				set obligated_for_anc = coalesce (obligated_for_anc ,0) - 
						coalesce((select cost_no from tb_service_purchase_authorization 
							where authorization_id=v_authorization_id),0)
				where client_account_id = v_client_account_id;
			
				update tb_commingled_account 
					set total_balance_no = coalesce(total_balance_no,0) - v_costno 
					where comm_account_id = (select comm_account_id from tb_client_account 
												where client_account_id = v_client_account_id);
	
			end if;
		end if;
		
		--select * from tb_slpa_snapshot;
		--insert for snap table
		INSERT INTO tb_slpa_snapshot
			( 	slpa_snapshot_id,	authorization_id, service_log_id, case_id, case_nm, referred_dt,
				client_id, client_name, cis_client_id, provider_id, tax_id_no, prov_tax_type_cd, provider_name,
				provider_address, provider_phone,
				ldss_cd, ldss_desc, ldss_address,
				requestor_staff_id, requestor_name, requestor_phone,
				worker_staff_id, worker_name, worker_phone,
				provider_service_id, provider_service_desc, justification_tx, fiscal_category_cd,
				fiscal_category_desc, start_dt, end_dt, cost_no, voucher_sw, final_amount_no, request_dt,
				sprvsr_approval_dt, sprvsr_approval_status_cd, supervisor_approval_status,
				supervisor_staff_id, supervisor_name, supervisor_title,
				ads_approval_dt, ads_approval_status_cd, 
				director_approval_status, director_staff_id, director_name, director_title,
				funding_approval_dt, funding_approval_status_cd,
				funding_approval_status, funding_staff_id, funding_name, funding_title, 
				payment_approval_dt, payment_approval_status_cd,
				payment_approval_status, payment_staff_id, payment_name, payment_title,
				director_sw, form_version, delete_sw, create_ts, create_user_id, update_ts, update_user_id
			)
		select vl_slpa_snapsho_id,
			v_authorization_id,
			tsl.service_log_id,
			tsl.case_id,
			(SELECT INITCAP(TRIM(P.firstname)||' '||TRIM(P.lastname) ||
				CASE WHEN P.middlename IS NOT NULL AND TRIM(P.middlename) != '' THEN 
					', ' || TRIM(P.middlename) ELSE '' END)
				FROM person as P 
			WHERE personid in (
				SELECT PersonId 
					FROM IntakeServiceRequestActor  
				where isheadofhousehold = true 
					and activeflag = 1	
					and servicecaseid = (select servicecaseid from servicecase 
											where servicecasenumber = tsl.case_id::varchar )
				union all							
				SELECT PersonId 
					FROM adoptioncaseactor  
				where  actortypekey in ('CHILD', 'PVTADPCHILD')
					and activeflag = 1	
					and adoptioncaseid = (select adoptioncaseid from adoptioncase
											where adoptioncasenumber = tsl.case_id::varchar)
				LIMIT 1)
			)::character varying as case_nm,
			now(),
			tsl.client_id,
			concat(p.firstname,' ',p.middlename,' ',p.lastname)::character varying, 
			null, 
			tp.provider_id,
			tp.tax_id_no, 
			tp.prov_tax_type_cd, 
			CASE WHEN (tp.provider_nm is null OR btrim(tp.provider_nm)='') THEN 
				CONCAT(tp.provider_first_nm,' ',tp.provider_last_nm) :: character varying 
			ELSE 
				tp.provider_nm 
			END AS provider_nm,
			(select provider_adr as paymentaddress 
				from get_provider_address(tp.provider_id,trim('{3357,3356}') )) :: character varying,
			coalesce(tp.adr_cell_phone_tx,tp.adr_home_phone_tx,tp.adr_work_phone_tx) :: character varying,
			(select (
				select ct.statecountycode from team t
					join teammember tm on tm.teamid=t.teamid and tm.activeflag=1
					join teammemberassignment tma on tma.teammemberid=tm.teammemberid and tma.activeflag=1
					join muser mu on mu.securityusersid = tma.securityusersid and mu.activeflag=1 
					join rolemapping rm on rm.principalid::int=mu.id and rm.activeflag=1 
					join role r on r.id = rm.roleid :: int 
					join county ct on ct.countyid:: character varying = t.countyid
				where  mu.securityusersid=rr.fromsecurityusersid limit 1
				) from routing rr 
					inner join userprofile up on up.securityusersid=rr.fromsecurityusersid
					inner join userprofile ups on ups.securityusersid = rr.insertedby
					left join userprofilephonenumber upps on ups.securityusersid = upps.securityusersid
					left join userprofilephonenumber upp on up.securityusersid = upp.securityusersid
					left join userprofileaddress upa on up.securityusersid = upa.securityusersid
				where rr.objectid = v_authorization_id::character varying
					and rr.fromroleid = 'CWCW'
				limit 1	
			),
			'',
			(select distinct (concat_ws(' ',upa.address,upa.city) :: character varying
				|| ',' ||
				concat_ws(' ',upa.state,upa.zipcode) :: character varying) 
					from routing rr 
						inner join userprofile up on up.securityusersid=rr.fromsecurityusersid
						inner join userprofile ups on ups.securityusersid = rr.insertedby
						left join userprofilephonenumber upps on ups.securityusersid = upps.securityusersid
						left join userprofilephonenumber upp on up.securityusersid = upp.securityusersid
						left join userprofileaddress upa on up.securityusersid = upa.securityusersid
				where rr.objectid=v_authorization_id::character varying
					and rr.fromroleid = 'CWCW'
				limit 1	
			 ),
			(select up.cjamspid from routing r 
				join userprofile up on up.securityusersid =r.fromsecurityusersid
			where r.objectid = v_authorization_id::character varying
				and r.eventcode  in ('PCAUTH','PCAUTHR') 
				and r.routingstatustypeid = 39 
				limit 1),
			(select up.fullname from routing r 
				join userprofile up on up.securityusersid = r.fromsecurityusersid 
			where r.objectid = v_authorization_id::character varying
				and r.eventcode  in ('PCAUTH','PCAUTHR') 
				and r.routingstatustypeid = 39 
				limit 1),
			(select upp.phonenumber from routing r 
				join userprofile up on up.securityusersid = r.fromsecurityusersid
				join userprofilephonenumber upp on upp.securityusersid= r.fromsecurityusersid 
			where r.objectid = v_authorization_id::character varying
				and r.eventcode  in ('PCAUTH','PCAUTHR') 
				and r.routingstatustypeid = 39 
				limit 1),
			(select up.cjamspid from routing r 
				join userprofile up on up.securityusersid =r.fromsecurityusersid
			where r.objectid = v_authorization_id::character varying
				and r.eventcode  in ('PCAUTH','PCAUTHR') 
				and r.routingstatustypeid = 39 
				limit 1),
			(select up.fullname from routing r 
				join userprofile up on up.securityusersid = r.fromsecurityusersid 
			where r.objectid = v_authorization_id::character varying
				and r.eventcode  in ('PCAUTH','PCAUTHR') 
				and r.routingstatustypeid = 39 
				limit 1),
			(select upp.phonenumber from routing r 
				join userprofile up on up.securityusersid = r.fromsecurityusersid
				join userprofilephonenumber upp on upp.securityusersid= r.fromsecurityusersid 
			where r.objectid = v_authorization_id::character varying
				and r.eventcode  in ('PCAUTH','PCAUTHR') 
				and r.routingstatustypeid = 39 
				limit 1),
			tsl.provider_service_id, 
			ts.service_nm, 
			tspa.justification_tx, 
			tspa.fiscal_category_cd,
			tfm.fiscal_category_desc, 
			tspa.start_dt, 
			tspa.end_dt, 
			tspa.cost_no, 
			tspa.voucher_sw, 
			tspa.final_amount_no, 
			tspa.sprvsr_approval_dt,
			tspa.sprvsr_approval_dt, 
			tspa.sprvsr_approval_status_cd,
			'Approved',
			(SELECT (
			    CASE 
			        WHEN r.routingstatustypeid = 39 then --logic if another supervisor approves
			            CASE 
			                WHEN (
			                    SELECT COUNT(*)
			                    FROM routing rr 
			                    INNER JOIN userprofile up ON up.securityusersid = rr.fromsecurityusersid
			                    INNER JOIN tb_service_purchase_authorization tspaaa 
			                        ON tspaaa.authorization_id::character varying = rr.objectid 
			                    WHERE rr.objectid = v_authorization_id::character varying  -- Cast once to string for clarity
			                      AND rr.eventcode IN ('PCAUTH', 'PCAUTHR')
			                      AND rr.routingstatustypeid IN (40, 42)
			                    LIMIT 1
			                ) > 0 THEN
			                    (
			                        SELECT up.cjamspid
			                        FROM routing rr 
			                        INNER JOIN userprofile up ON up.securityusersid = rr.fromsecurityusersid
			                        INNER JOIN tb_service_purchase_authorization tspaaa 
			                            ON tspaaa.authorization_id::character varying = rr.objectid 
			                        WHERE rr.objectid = v_authorization_id::character varying
			                          AND rr.eventcode IN ('PCAUTH', 'PCAUTHR')
			                          AND rr.routingstatustypeid IN (40, 42)
			                        LIMIT 1
			                    )
			                ELSE
			                    up.cjamspid
			            END
			    end )
 				from routing r 
				join userprofile up on up.securityusersid =r.tosecurityusersid
			where r.objectid = v_authorization_id::character varying
				and r.eventcode  in ('PCAUTH','PCAUTHR') 
				--and r.routingstatustypeid = 39 
				limit 1),
			(select (
			    CASE 
			        WHEN r.routingstatustypeid = 39 then --logic if another supervisor approves
			            CASE 
			                WHEN (
			                    SELECT COUNT(*)
			                    FROM routing rr 
			                    INNER JOIN userprofile up ON up.securityusersid = rr.fromsecurityusersid
			                    INNER JOIN tb_service_purchase_authorization tspaaa 
			                        ON tspaaa.authorization_id::character varying = rr.objectid 
			                    WHERE rr.objectid = v_authorization_id::character varying  -- Cast once to string for clarity
			                      AND rr.eventcode IN ('PCAUTH', 'PCAUTHR')
			                      AND rr.routingstatustypeid IN (40, 42)
			                    LIMIT 1
			                ) > 0 THEN
			                    (
			                        SELECT up.fullname 
			                        FROM routing rr 
			                        INNER JOIN userprofile up ON up.securityusersid = rr.fromsecurityusersid
			                        INNER JOIN tb_service_purchase_authorization tspaaa 
			                            ON tspaaa.authorization_id::character varying = rr.objectid 
			                        WHERE rr.objectid = v_authorization_id::character varying
			                          AND rr.eventcode IN ('PCAUTH', 'PCAUTHR')
			                          AND rr.routingstatustypeid IN (40, 42)
			                        LIMIT 1
			                    )
			                ELSE
			                    up.fullname
			            END
			    end )
			    from routing r 
				join userprofile up on up.securityusersid = r.tosecurityusersid 
			where r.objectid = v_authorization_id::character varying
				and r.eventcode  in ('PCAUTH','PCAUTHR') 
				--and r.routingstatustypeid = 39 
				limit 1),
			'',
			tspa.ads_approval_dt, 
			tspa.ads_approval_status_cd,
			'Approved',
			(select up.cjamspid from routing r 
				join userprofile up on up.securityusersid =r.tosecurityusersid 
			where r.objectid = v_authorization_id::character varying
				and r.eventcode  in ('PCAUTH','PCAUTHR') 
				and r.routingstatustypeid = 42 
				limit 1),
			(select up.fullname from routing r 
				join userprofile up on up.securityusersid = r.tosecurityusersid 
			where r.objectid = v_authorization_id::character varying
				and r.eventcode  in ('PCAUTH','PCAUTHR') 
				and r.routingstatustypeid = 42 
				limit 1),
			'',
			funding_approval_dt, 
			funding_approval_status_cd,
			'Approved',
			(select up.cjamspid from routing r 
				join userprofile up on up.securityusersid =r.fromsecurityusersid
			where r.objectid = v_authorization_id::character varying
				and r.eventcode  in ('PCAUTH','PCAUTHR') 
				and r.routingstatustypeid = 43 
				limit 1),
			(select up.fullname from routing r 
				join userprofile up on up.securityusersid = r.fromsecurityusersid 
			where r.objectid = v_authorization_id::character varying
				and r.eventcode  in ('PCAUTH','PCAUTHR') 
				and r.routingstatustypeid = 43 
				limit 1),
			'',
			tspa.payment_approval_dt,
			tspa.payment_approval_status_cd,
			'Approved',
			(select up.cjamspid from routing r 
				join userprofile up on up.securityusersid =r.tosecurityusersid 
			where r.objectid = v_authorization_id::character varying
				and r.eventcode  in ('PCAUTH','PCAUTHR') 
				and r.routingstatustypeid = 43 
				limit 1),
			(select up.fullname from routing r 
				join userprofile up on up.securityusersid = r.tosecurityusersid 
			where r.objectid = v_authorization_id::character varying
				and r.eventcode  in ('PCAUTH','PCAUTHR') 
				and r.routingstatustypeid = 43 
				limit 1),
			'',
			'',
			'', 
			'N',
			now(),
			v_securityuserid,
			now(),
			v_securityuserid
		from tb_service_log tsl 
			join tb_provider_services tps on tps.provider_service_id=tsl.provider_service_id
			join tb_provider tp on tps.provider_id=tp.provider_id
			join tb_service_purchase_authorization tspa on tspa.service_log_id=tsl.service_log_id and tspa.delete_sw='N'
			join person p on p.cjamspid = tsl.client_id 
			left join tb_provider_addresses tpas on tp.provider_id::bigint = tpas.parent_key_id::bigint and tpas.delete_sw='N'
			left join tb_services ts on ts.service_id = tps.service_id 
			left join tb_fiscal_category_master tfm on tfm.fiscal_category_cd = tspa.fiscal_category_cd
			/*
			left join (
				select ins.intakeserviceid :: uuid as servicecaseid,ins.servicerequestnumber as servicecasenumber,
					ins.intakeservreqtypeid from intakeservicerequest ins where ins.activeflag =1
				union 
				select sce.servicecaseid ::uuid  as servicecaseid,sce.servicecasenumber as servicecasenumber,
					sce.intakeservreqtypeid from servicecase sce  where  sce.activeflag =1
				) isr on isr.servicecasenumber = tsl.case_id::character varying
			left join servicecaserequest scr on scr.servicecaseid = isr.servicecaseid
			left join intakeservicerequesttype isrt on isrt.intakeservreqtypeid = isr.intakeservreqtypeid
			*/
		where tspa.authorization_id = v_authorization_id 
		limit 1 ;

		
	 -- Delete all pending routing records (CDM-24464)
		update routing 
		set activeflag = 0,
			-- updatedby = v_securityuserid, 
			updatedon = now()
		where objectid = v_authorization_id :: character varying  
			and eventcode in ('PCAUTH','PCAUTHR') 
			and activeflag = 1
			and routingstatustypeid <> 43 ;
	end if;

	if(v_status not in (39))
	then
		select count(1) 
			into v_fiscalcount 
		from tb_service_purchase_authorization ttz 
		where ttz.authorization_id = v_authorization_id 
			and trim(ttz.fiscal_category_cd) = (select  trim(tx.modified_fiscal_category_cd) 
						from  tb_service_purchase_authorization tx where tx.authorization_id =v_authorization_id  );
		
		select count(1) 
			into v_costcount 
		from tb_service_purchase_authorization trz 
		where trz.authorization_id =v_authorization_id 
		and trz.cost_no = v_costno;
	
		select tfm.fiscal_category_desc||' (' || ttz.fiscal_category_cd ||')' :: character varying  
			into v_fiscalcdoriginal
		from tb_service_purchase_authorization ttz 
			join tb_fiscal_category_master tfm on trim(tfm.fiscal_category_cd) = trim(ttz.fiscal_category_cd)
		where ttz.authorization_id = v_authorization_id ;
		
		select tfm.fiscal_category_desc||' (' ||tfm.fiscal_category_cd ||')' :: character varying  
			into v_fiscalcd 
		from tb_fiscal_category_master tfm 
		where trim(tfm.fiscal_category_cd) = 
			(select  trim(tx.modified_fiscal_category_cd) from  tb_service_purchase_authorization tx 
				where tx.authorization_id =v_authorization_id ) ;
		
		select trz.cost_no 
			into v_orginalcost 
		from tb_service_purchase_authorization trz 
		where trz.authorization_id =v_authorization_id ;

		raise notice 'v_fiscalcount % ',v_fiscalcount;
		raise notice 'v_costcount % ',v_costcount;
		v_msg := 'Requested Purchase Authorization ('||coalesce(v_authorization_id:: character varying,'')||') has been modified as follows, ';
		
		if(v_fiscalcount = 0)
		then 
			raise notice 'if % ',v_fiscalcdoriginal;
			raise notice 'if % ',v_fiscalcd;
			v_msgfiscal := 'selected fiscal category : '|| coalesce(v_fiscalcdoriginal,'') ||' is changed to '|| coalesce(v_fiscalcd,'') ||'. ';
		end if;
	
		if(v_costcount = 0)
		then 
			v_msgcost := 'Requested cost : $'|| coalesce(v_orginalcost:: character varying,'') ||' is adjusted to $'|| coalesce(v_costno :: character varying,'') ||'.';
		end if;
	
		if(v_costcount = 0 or v_fiscalcount = 0)
		then
	
			select rr.fromsecurityusersid 
				into v_tosecurityusersid 
			from routing rr 
			where rr.objectid = v_authorization_id::character varying
				and rr.eventcode in ('PCAUTH','PCAUTHR') 
				and rr.fromroleid = 'CWCW' 
			limit 1;
			
			v_totalmgs := coalesce(v_msg,'')||' '||coalesce(v_msgfiscal,'')||' '||coalesce(v_msgcost,'');
			raise notice 'notify  % ',v_msgfiscal;
			raise notice 'notify  % ',v_msgcost;
			
			SELECT send_notIFication 
				INTO v_notIFystatus 
			FROM send_notIFication(	v_tosecurityusersid,v_securityuserid, v_tosecurityusersid,
					'System', 'High',v_totalmgs :: character varying,
					v_totalmgs :: character varying, 
						(
						select sc.servicecaseid:: character varying 
						from tb_service_purchase_authorization tps 
							join tb_service_log tsl on tsl.service_log_id = tps.service_log_id 
							join servicecase sc on sc.servicecasenumber = tsl.case_id::character varying
						where tps.authorization_id = v_authorization_id
						union all
						select adc.adoptioncaseid::character varying 
						from tb_service_purchase_authorization tps 
							join tb_service_log tsl on tsl.service_log_id = tps.service_log_id 
							join adoptioncase adc on adc.adoptioncasenumber = tsl.case_id::character varying
						where tps.authorization_id = v_authorization_id
						)::character varying 
						);
			
			update tb_service_purchase_authorization 
			set modified_fiscal_category_cd = v_fiscal_category_cd 
			where authorization_id = v_authorization_id ;
	
		end if;
	end if;
	
	RETURN 'success';
END;
	
$function$
;
