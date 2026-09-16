CREATE OR REPLACE FUNCTION cjams.sp_ive_insert_rs_status()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
----------------------------------------------------------------------------------------------
-- Author          : Samir Patil
-- Date            : 02/20/2012
-- Description     : This procedure inserts/updates records into TB_RS_IVE_STATUS for each month
--					 based on Elgibility Events period begin date & period end date.
--  				 These records will be utilized by the payment stamping process to restamp the
--					 IV-E eligibility of all related fund allocations for a given client.
-- The 8 Component Types from TB_IVE_COMPONENT_STATUS for each event are as below :-
--	3242	Assets
--	3236	Demographics
--	3241	Income Summary
--	3237	Removal Type
--	3239	Removal Home
--	3240	Deprivation
--	3238	Court Order
--	3339	Placement
-- If period begin date is more than 24 months in the past then period begin date will be set as 24 months in past.
-- If period end date is more than 24 months in the past then skip that event.
-- If period end date is null then set it as current date.
-- Revision(s):
-- 09-07-2012 Vineet Tirodkar - PRJ-02667 - MD CHESSIE Batch Process Redesign - To add Return 0 on success & -1 on error
-- 05/14/2019 Vineet Tirodkar - To exclude IV-E Foster Care episodes of CJAMS Counties from the processing (B-39524)
-- 10/05/2020 Vineet Tirodkar - Changes to use the new CJAMS Foster Care Eligibility tables (B-85031)
-- 01/14/2022 Vineet Tirodkar - To capture the IV-E data max upto the Current month (CIDM-4168)
-- 09/22/2022 Vineet Tirodkar - (SELECT ...) [AS] foo fix for Aurora DB migration 
-- 11/31/2022 - Vineet Tirodkar - To fix clock_timestamp error - Aurora DB migration 
-- 02/27/2024 - Vineet Tirodkar - To Capture IV-E determination in pending review status for payment stamping finance batch (CIDM-8279 / B-186249)
-- 09/04/2024 - Vineet Tirodkar - Modifications to the logic capturing the monthly eligibility status for Payment re-stamping.(B-199152 - CIDM-9041)
----------------------------------------------------------------------------------------------
DECLARE 
	SQLCODE 				INT 			DEFAULT 0;
	SQLSTATE 				CHAR(5) 		DEFAULT '00000';
	vs_message_text 		VARCHAR(3000) 	DEFAULT '';
	vl_ret_status 			INTEGER 		DEFAULT 0;
	vs_Procedure_nm 		VARCHAR(100) 	DEFAULT 'SP_IVE_INSERT_RS_STATUS';
	vl_sqlcode 				INT 			DEFAULT 0;
	vs_error 				VARCHAR(3000);
	vl_runtime_id 			INTEGER 		DEFAULT 0;
	vs_user_id				VARCHAR(10)		DEFAULT 'IVE_CJAMS';

	vl_return INTEGER DEFAULT 0;

	vs_cursor_sql VARCHAR(12000) ;
	vn_event_id INTEGER DEFAULT 0;
	vn_eligibility_period_id INTEGER DEFAULT 0;
	vn_elig_period_count INTEGER DEFAULT 0;
	vn_ENR_resulting_status INTEGER DEFAULT 0;
	vn_ER_resulting_status  INTEGER DEFAULT 0;
	vd_period_start_date DATE;
	vd_period_end_date DATE;
	vd_calc_period_end_date DATE;
	vd_calc_period_start_date DATE;
	vn_client_id INTEGER DEFAULT 0;
	vn_rs_ive_status_id INTEGER DEFAULT 0;
	vn_calc_period_iter INTEGER;
	vs_resulting_status_cd VARCHAR(5) DEFAULT '';
	vs_reason_cd VARCHAR(25) DEFAULT '';
	vs_resulting_status_cd2 VARCHAR(5) DEFAULT '';
	vs_criteria_passed_cd VARCHAR(5) DEFAULT '3698'; -- CRITERIA_PASSED 
	vn_component_status_loop INTEGER DEFAULT 0;
	vn_loop_iter INTEGER DEFAULT 0;
	vs_component_type_cd VARCHAR(5) DEFAULT NULL;
	vs_component_3242_asset_sw VARCHAR(1) DEFAULT NULL;
	vs_component_3236_demographics_sw VARCHAR(1) DEFAULT NULL;
	vs_component_3241_income_sw VARCHAR(1) DEFAULT NULL;
	vs_component_3237_removal_sw VARCHAR(1) DEFAULT NULL;
	vs_component_3239_removal_home_sw VARCHAR(1) DEFAULT NULL;
	vs_component_3240_deprivation_sw VARCHAR(1) DEFAULT NULL;
	vs_component_3238_court_order_sw VARCHAR(1) DEFAULT NULL;
	vs_component_3339_placement_sw VARCHAR(1) DEFAULT NULL;
	vd_iter_curr_2months_dt DATE;
	vd_iter_month_start_dt DATE;
	vd_iter_month_end_dt DATE;
	vd_current_calc_period_start_date DATE;
	vd_24months_date DATE;
	vd_approval_dt DATE;
	
	vs_identity_column VARCHAR(100);

	-- Cursor to get the 8 Component Type Codes.
	-- DECLARE IVE_COMP_STATUS cursor WITH HOLD FOR s1;
	IVE_COMP_STATUS_refcur REFCURSOR;
	IVE_RS_STATUS_CUR_refcur REFCURSOR;

BEGIN
	-- Exception Handler
	BEGIN
		EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS vs_message_text :=  MESSAGE_TEXT;

		vl_return := -1;
		vl_sqlcode := -1 ;
		vs_error := COALESCE(vs_error ,'') || (CURRENT_TIMESTAMP::text) ||'::' || vs_Procedure_nm || '.' ;
		vs_error := COALESCE(vs_error ,'') || '::' || COALESCE(vs_identity_column ,'IVE Event id') || ' :: ' || COALESCE(vs_identity_val ,'');
		vs_error := vs_error || COALESCE(vs_message_text ,'');

		select cjams.sp_batch_error_log 
			( 	'SP_IVE_INSERT_RS_STATUS' ,
				NULL::bigint,
				NULL::bigint,
				NULL::character varying,
				NULL::INTEGER,
				NULL::character varying,
				SQLSTATE::character varying,
				vs_error::character varying,
				'finance'::character varying
			) into vl_ret_status;
				
		vs_error := '';
		RETURN vl_return;
	END; 

	-- Insert the starting log entry.
	SELECT nextval('sq_batch_runtime_log') INTO vl_runtime_id;
	
	-- RAISE NOTICE 'Insert - vl_runtime_id >> %', vl_runtime_id;
	
	insert into cjams.tb_batch_runtime_log 
		(	runtime_log_id, 
			program_nm, 
			runtime_start_ts, 
			create_ts, 
			create_user_id, 
			update_ts, 
			update_user_id
		)
	values 
		(	vl_runtime_id, 
			vs_Procedure_nm, 
			current_timestamp, 
			current_timestamp, 
			vs_user_id, 
			current_timestamp, 
			vs_user_id
		);
	
	-- Get the 24 month date in the past
	select (current_date - interval '24 months') into vd_24months_date;
	-- raise notice 'vd_24months_date>> %',vd_24months_date;

	-- Cursor to get Events for each client for current date.
	-- 2931 (IV-E Foster Care)
	-- 2923 (Initial Determination)
	-- 2924 (Redetermination)

	-- DECLARE IVE_RS_STATUS_CUR cursor WITH HOLD FOR
	OPEN IVE_RS_STATUS_CUR_refcur FOR
		-- LOOP
		select client_id, 
			min(event_start_dt) as min_event_dt, 
			max(event_end_dt) as max_event_dt,  
			max(event_id) as max_event_id,
			max(eligibility_period_id) as max_elig_period_id,
			count(eligibility_period_id) as elig_period_count
		from (	
			select *
			from (
					select coalesce(ev.event_id, 0) as event_id, 
						coalesce(ev.event_start_dt::date, ep.start_dt::date) as event_start_dt,
						coalesce(ev.event_end_dt::date, ep.end_dt::date) as event_end_dt,
						ce.client_id,
						coalesce(btrim(ev.resulting_status_cd), btrim(ep.status_cd)) as resulting_status_cd,
						(case when coalesce(btrim(ev.resulting_status_cd), btrim(ep.status_cd)) = '2913' then 
							'Eligible Reimbursable'
						else
							'Other'
						end) as reason_cd,
						ep.approvedon::date,
						ep.eligibility_period_id
					from tb_client_eligibility ce,
						tb_eligibility_period ep
						left join tb_eligibility_events ev on ev.eligibility_period_id = ep.eligibility_period_id
							and ev.delete_sw = 'N'	
							and btrim(ev.type_cd) in ('2923','2924')
					where ce.eligibility_id = ep.eligibility_id 
						and ep.delete_sw = 'N'
						and ce.delete_sw = 'N'
						and ep.approvalstatus = 'PENDING' 
						and	date(ep.update_ts)
							>= (select coalesce((MAX(runtime_start_ts)::date), current_date - interval '1 day')
									from tb_batch_runtime_log
								where program_nm = 'SP_IVE_INSERT_RS_STATUS' 
									and success_sw = 'Y'
								)
						and btrim(ep.status_cd) <> '2911'
						and btrim(ce.eligibility_type_cd) = '2931'
								
					union all

					select coalesce(ev.event_id, 0) as event_id, 
						coalesce(ev.event_start_dt::date, ep.start_dt::date) as event_start_dt,
						coalesce(ev.event_end_dt::date, ep.end_dt::date) as event_end_dt,
						ce.client_id,
						coalesce(btrim(ev.resulting_status_cd), btrim(ep.status_cd)) as resulting_status_cd,
						(case when coalesce(btrim(ev.resulting_status_cd), btrim(ep.status_cd)) = '2913' then 
							'Eligible Reimbursable'
						else
							'Other'
						end) as reason_cd,
						ep.approvedon::date,
						ep.eligibility_period_id
					from tb_client_eligibility ce,
						tb_eligibility_period ep
						left join tb_eligibility_events ev on ev.eligibility_period_id = ep.eligibility_period_id
							and ev.delete_sw = 'N'	
							and btrim(ev.type_cd) in ('2923','2924')
					where ep.eligibility_id = ce.eligibility_id
						and ep.delete_sw = 'N'
						and ce.delete_sw = 'N'
						and ep.approvalstatus = 'APPROVED' 
						and	date(ep.approvedon)
							>= (select coalesce((MAX(runtime_start_ts)::date), current_date - interval '1 day')
									from tb_batch_runtime_log
								where program_nm = 'SP_IVE_INSERT_RS_STATUS' 
									and success_sw = 'Y'
								)
						and btrim(ep.status_cd) <> '2911'
						and btrim(ce.eligibility_type_cd) = '2931'
			) a
			-- Unit Testing
			-- where client_id = 2621802
			order by client_id, approvedon::date, event_start_dt
			) tab
			group by client_id;		
	LOOP
		FETCH IVE_RS_STATUS_CUR_refcur
			INTO vn_client_id, 
				vd_period_start_date, -- min_event_dt 
				vd_period_end_date, -- max_event_dt  
				vn_event_id,
				vn_eligibility_period_id, -- max_elig_period_id
				vn_elig_period_count ;
				
		exit when not found;

		raise notice 'client_id>> %',vn_client_id;
		-- raise notice 'min_event_dt>> %',vd_period_start_date;
		-- raise notice 'max_event_dt>> %',vd_period_end_date;
		-- raise notice 'event_id>> %',vn_event_id;
		-- raise notice 'max_eligibility_period_id>> %',vn_eligibility_period_id;
		-- raise notice 'elig_period_count>> %',vn_elig_period_count;
		
		
		-- vd_period_start_date := vd_period_start_date::date;
		-- vd_period_end_date := vd_period_end_date::date;
		
		--WHILE_LOOP:
		--WHILE (SQLCODE = 0)
		--DO
		-- If period end date is more than 24 months in the past then skip the event.
		-- If period start date is null then skip the event.
		raise notice 'vd_period_start_date>> %',vd_period_start_date;
		raise notice 'vd_period_end_date>> %',vd_period_end_date;
		-- raise notice 'vs_resulting_status_cd>> %',vs_resulting_status_cd;
		-- raise notice 'vs_reason_cd>> %',vs_reason_cd;
				
		IF (vd_period_end_date < vd_24months_date) OR (vd_period_start_date Is Null) THEN
			-- Do nothing
			raise notice 'Do nothing';
		ELSE
			-- If End Date is null then set as Current Date.
			If vd_period_end_date Is Null OR vd_period_end_date > CURRENT_DATE THEN
				vd_calc_period_end_date := CURRENT_DATE ;
			ELSE      	
				vd_calc_period_end_date := vd_period_end_date ;
			END IF;
					
			--IF start_dt more than 24 months in past THEN  24 months in the past, else the same start date.
			IF  (vd_period_start_date < vd_24months_date) THEN
				vd_calc_period_start_date :=  vd_24months_date;
			ELSE
				vd_calc_period_start_date := vd_period_start_date;
			END IF;	

			raise notice 'Final period_start_date>> %',vd_calc_period_start_date;
			raise notice 'Final period_end_date>> %',vd_calc_period_end_date;
		
			-- calculate months between . get the number for loop counter.	
			select cjams.f_months_between( vd_calc_period_start_date::date, 
											(vd_calc_period_end_date::date + interval '1 Month')::date
										 )
			into vn_calc_period_iter;   

			-- raise notice 'vn_calc_period_iter>> %',vn_calc_period_iter;
			
			vn_loop_ITER := vn_calc_period_iter ;
			
			-- for Eligibility Periods with NO Events 
			if vn_event_id = 0 then 
				vs_resulting_status_cd := Null;
				
				-- No IV-E Events are availble 
				select btrim(ep.status_cd)
					into vs_resulting_status_cd	
				from tb_client_eligibility ce,
					tb_eligibility_period ep
				where ce.eligibility_id = ep.eligibility_id 
					and ep.delete_sw = 'N'
					and ce.delete_sw = 'N'
					and ep.approvalstatus in ('PENDING', 'APPROVED')
					and	( 	date(ep.approvedon) -- Approved 
								>= (select coalesce((MAX(runtime_start_ts)::date), current_date - interval '1 day')
										from tb_batch_runtime_log
									where program_nm = 'SP_IVE_INSERT_RS_STATUS' 
										and success_sw = 'Y'
									)
							or 
							date(ep.update_ts) -- Submitted (PENDING) 
								>= (select coalesce((MAX(runtime_start_ts)::date), current_date - interval '1 day')
										from tb_batch_runtime_log
									where program_nm = 'SP_IVE_INSERT_RS_STATUS' 
										and success_sw = 'Y'
									)
						)
					and btrim(ep.status_cd) <> '2911'
					and btrim(ce.eligibility_type_cd) = '2931'
					and ce.client_id = vn_client_id ;
			end if;	
			
			-- If the even has any period to enter then, else skip.
			IF vn_calc_period_iter > 0 THEN
				vn_loop_ITER := 1;    	
				vd_current_calc_period_start_date := vd_calc_period_start_date;
				-- WHILE_LOOP2:			
				-- WHILE vn_loop_ITER <= vn_calc_period_iter DO
				LOOP 
					-- raise notice 'vn_loop_ITER>> %',vn_loop_ITER;
					-- raise notice 'vn_calc_period_iter>> %',vn_calc_period_iter;
					-- raise notice 'vd_current_calc_period_start_date>> %',vd_current_calc_period_start_date;

					EXIT WHEN vn_loop_ITER > vn_calc_period_iter ;
					-- calculate the start month date & end month date for inserting RS_IVE_STATUS.
					select f_daymonth(vd_current_calc_period_start_date,'F','C'),
						f_daymonth(vd_current_calc_period_start_date,'L','C')
					into vd_iter_month_start_dt,
						vd_iter_month_end_dt;

					vd_current_calc_period_start_date := vd_current_calc_period_start_date + interval '1 month';
					vn_loop_ITER := vn_loop_ITER + 1;                                   			
					
					raise notice 'vd_iter_month_start_dt>> %',vd_iter_month_start_dt;
					raise notice 'vd_iter_month_end_dt>> %',vd_iter_month_end_dt;
					
					if vn_event_id > 0 then 
						vn_ENR_resulting_status := 0;
						vn_ER_resulting_status := 0;
						
						-- Check for event with <> ER on the last day of the month 
						select sum((case when btrim(ev.resulting_status_cd) <> '2913'  then 1 else 0 end )) as ENR,
								sum((case when btrim(ev.resulting_status_cd) = '2913'  then 1 else 0 end )) as ER
							into vn_ENR_resulting_status,
								vn_ER_resulting_status
						from tb_client_eligibility ce,
							tb_eligibility_period ep,
							tb_eligibility_events ev 
						where ce.eligibility_id = ep.eligibility_id 
							and ev.eligibility_period_id = ep.eligibility_period_id
							and btrim(ev.type_cd) in ('2923','2924')
							and ev.delete_sw = 'N'	
							and ep.delete_sw = 'N'
							and ce.delete_sw = 'N'
							and ep.approvalstatus in ('PENDING', 'APPROVED')
							and	( 	date(ep.approvedon) -- Approved 
										>= (select coalesce((MAX(runtime_start_ts)::date), current_date - interval '1 day')
												from tb_batch_runtime_log
											where program_nm = 'SP_IVE_INSERT_RS_STATUS' 
												and success_sw = 'Y'
											)
									or 
									date(ep.update_ts) -- Submitted (PENDING) 
										>= (select coalesce((MAX(runtime_start_ts)::date), current_date - interval '1 day')
												from tb_batch_runtime_log
											where program_nm = 'SP_IVE_INSERT_RS_STATUS' 
												and success_sw = 'Y'
											)
								)
							and btrim(ep.status_cd) <> '2911'
							and btrim(ce.eligibility_type_cd) = '2931'
							and ev.event_start_dt is not null -- Exclude Start Date null records 
							and ev.resulting_status_cd is not null -- Exclude NO status records
							and ce.client_id = vn_client_id
							-- and btrim(ev.resulting_status_cd) <> '2913' -- Eligible Reimbursable
							and vd_iter_month_end_dt::date 
								between ev.event_start_dt::date and coalesce(ev.event_end_dt::date, current_date)
							;
							
						-- IF Event found with <> ER
						IF vn_ENR_resulting_status > 0 then 
							vs_resulting_status_cd := '2912' ; -- Eligible Non-Reimbursable
						elseif vn_ER_resulting_status > 0 then 
							vs_resulting_status_cd := '2913'; -- Eligible Reimbursable
						else -- Month end date is beyond the iv-e period end date 		
							select sum((case when btrim(ev.resulting_status_cd) <> '2913'  then 1 else 0 end )) as ENR,
									sum((case when btrim(ev.resulting_status_cd) = '2913'  then 1 else 0 end )) as ER
								into vn_ENR_resulting_status,
									vn_ER_resulting_status
							from tb_client_eligibility ce,
								tb_eligibility_period ep,
								tb_eligibility_events ev 
							where ce.eligibility_id = ep.eligibility_id 
								and ev.eligibility_period_id = ep.eligibility_period_id
								and btrim(ev.type_cd) in ('2923','2924')
								and ev.delete_sw = 'N'	
								and ep.delete_sw = 'N'
								and ce.delete_sw = 'N'
								and ep.approvalstatus in ('PENDING', 'APPROVED')
								and	( 	date(ep.approvedon) -- Approved 
											>= (select coalesce((MAX(runtime_start_ts)::date), current_date - interval '1 day')
													from tb_batch_runtime_log
												where program_nm = 'SP_IVE_INSERT_RS_STATUS' 
													and success_sw = 'Y'
												)
										or 
										date(ep.update_ts) -- Submitted (PENDING) 
											>= (select coalesce((MAX(runtime_start_ts)::date), current_date - interval '1 day')
													from tb_batch_runtime_log
												where program_nm = 'SP_IVE_INSERT_RS_STATUS' 
													and success_sw = 'Y'
												)
									)
								and btrim(ep.status_cd) <> '2911'
								and btrim(ce.eligibility_type_cd) = '2931'
								and ev.event_start_dt is not null -- Exclude Start Date null records 
								and ev.resulting_status_cd is not null -- Exclude NO status records
								and ce.client_id = vn_client_id
								-- and btrim(ev.resulting_status_cd) <> '2913' -- Eligible Reimbursable
								and vd_iter_month_end_dt::date 
									between ev.event_start_dt::date and 
										f_daymonth((coalesce(ev.event_end_dt::date, current_date))::date,'L','C')::date
								;
								
							IF vn_ENR_resulting_status > 0 then 
								vs_resulting_status_cd := '2912' ; -- Eligible Non-Reimbursable
							elseif vn_ER_resulting_status > 0 then 
								vs_resulting_status_cd := '2913'; -- Eligible Reimbursable
							else
								-- No event found covering the benefit month 
								select btrim(ep.status_cd)
									into vs_resulting_status_cd	
								from tb_client_eligibility ce,
									tb_eligibility_period ep
								where ce.eligibility_id = ep.eligibility_id 
									and ep.delete_sw = 'N'
									and ce.delete_sw = 'N'
									and ep.approvalstatus in ('PENDING', 'APPROVED')
									and	( 	date(ep.approvedon) -- Approved 
												>= (select coalesce((MAX(runtime_start_ts)::date), current_date - interval '1 day')
														from tb_batch_runtime_log
													where program_nm = 'SP_IVE_INSERT_RS_STATUS' 
														and success_sw = 'Y'
													)
											or 
											date(ep.update_ts) -- Submitted (PENDING) 
												>= (select coalesce((MAX(runtime_start_ts)::date), current_date - interval '1 day')
														from tb_batch_runtime_log
													where program_nm = 'SP_IVE_INSERT_RS_STATUS' 
														and success_sw = 'Y'
													)
										)
									and btrim(ep.status_cd) <> '2911'
									and btrim(ce.eligibility_type_cd) = '2931'
									and ce.client_id = vn_client_id 
									and vd_iter_month_end_dt::date 
										between ep.start_dt::date and 
											f_daymonth((coalesce(ep.end_dt::date, current_date))::date,'L','C')::date
								;
								
								vn_event_id := 0 ;
								
								if vs_resulting_status_cd = '2913' then -- Eligible Reimbursable
									-- Do nothing 
								elseif vs_resulting_status_cd <> '2913' then -- Other
									-- Do nothing 
								else	
									vs_resulting_status_cd := '??';
								end if;	
							end if;
							
						end if;
					end if;	
					
					raise notice 'vs_resulting_status_cd>> %',vs_resulting_status_cd;
					
					if vs_resulting_status_cd = '2913' then -- Eligible Reimbursable
						vs_component_3242_asset_sw := 'N';
						vs_component_3236_demographics_sw := 'N';
						vs_component_3241_income_sw := 'N';
						vs_component_3237_removal_sw := 'N';
						vs_component_3239_removal_home_sw := 'N';
						vs_component_3240_deprivation_sw := 'N';
						vs_component_3238_court_order_sw := 'N';
						vs_component_3339_placement_sw := 'N';
					else
						vs_component_3242_asset_sw := 'Y';
						vs_component_3236_demographics_sw := 'Y';
						vs_component_3241_income_sw := 'Y';
						vs_component_3237_removal_sw := 'Y';
						vs_component_3239_removal_home_sw := 'Y';
						vs_component_3240_deprivation_sw := 'Y';
						vs_component_3238_court_order_sw := 'Y';
						vs_component_3339_placement_sw := 'Y';	
					end if;	
					
					-- Get the key for RS_IVE_STATUS to check for insert/update.
					-- if record already exists for given client & month then update.
					vn_rs_ive_status_id := 0;     
					
					Select rs_ive_status_id
						into vn_rs_ive_status_id
					from tb_rs_ive_status
					where client_id =  vn_client_id
						and benefit_start_dt = vd_iter_month_start_dt
						and delete_sw = 'N'
					limit 1;        

					vl_sqlcode := SQLCODE;

					IF (vl_sqlcode <> 0) AND (vl_sqlcode <> 100) THEN
						vs_error := 'Error in selecting IVE STATUS key--> BATCH_RS_IVE_STATUS PROGRAM ENDED'  ;
						-- SIGNAL p_sp_error  ;
					END IF ;    			
					
					-- raise notice 'vn_rs_ive_status_id>> %',vn_rs_ive_status_id;
					
					IF (vl_sqlcode = 100) OR (vn_rs_ive_status_id is Null OR vn_rs_ive_status_id = 0 ) THEN
						-- Event not found for that period so insert.
						insert into tb_rs_ive_status 
							( 	rs_ive_status_id, 
								event_id, 
								event_date, 
								client_id, 
								benefit_start_dt, 
								benefit_end_dt, 
								demographics_sw, 
								removal_type_sw, 
								removal_home_sw, 
								income_sw, 
								assets_sw, 
								court_sw, 
								deprivation_sw, 
								placement_sw, 
								resulting_status_cd, 
								reason_cd, 
								create_user_id, 
								create_ts, 
								update_user_id, 
								update_ts, 
								delete_sw, 
								eligibility_period_id
							)
						select nextval('SQ_RS_IVE_STATUS'), 
							vn_event_id, 
							current_date, 
							vn_client_id, 
							vd_iter_month_start_dt, 
							vd_iter_month_end_dt, 
							vs_component_3236_demographics_sw, 
							vs_component_3237_removal_sw, 
							vs_component_3239_removal_home_sw, 
							vs_component_3241_income_sw, 
							vs_component_3242_asset_sw, 
							vs_component_3238_court_order_sw, 
							vs_component_3240_deprivation_sw, 
							vs_component_3339_placement_sw, 
							vs_resulting_status_cd, 
							vs_reason_cd, 
							vs_user_id, 
							current_timestamp, 
							vs_user_id, 
							current_timestamp, 
							'N', 
							vn_eligibility_period_id;
									
						-- Logic to Insert Record in tb_rs_ive_status - END
						vl_sqlcode := SQLCODE;
						IF vl_sqlcode <> 0 THEN
							vs_error := 'Error in inserting IVE STATUS --> BATCH_RS_IVE_STATUS PROGRAM ENDED'  ;
							-- SIGNAL p_sp_error  ;
						END IF ;
					ELSE
						-- Event found so update the component type all times.
						Update tb_rs_ive_status
						   set demographics_sw = vs_component_3236_demographics_sw, 
								removal_type_sw = vs_component_3237_removal_sw, 
								removal_home_sw = vs_component_3239_removal_home_sw, 
								income_sw = vs_component_3241_income_sw, 
								assets_sw = vs_component_3242_asset_sw, 
								court_sw = vs_component_3238_court_order_sw, 
								deprivation_sw = vs_component_3240_deprivation_sw, 
								placement_sw = vs_component_3339_placement_sw, 
								resulting_status_cd = vs_resulting_status_cd, 
								reason_cd = vs_reason_cd, 
								update_user_id = vs_user_id, 
								update_ts = current_timestamp, 
								event_id = vn_event_id, 
								eligibility_period_id = vn_eligibility_period_id
						 where rs_ive_status_id = vn_rs_ive_status_id;
						
						vl_sqlcode := SQLCODE;
						IF vl_sqlcode <> 0 THEN
							vs_error := 'Error Updating IVE STATUS --> BATCH_IVE_STATUS PROGRAM ENDED'  ;
							-- SIGNAL p_sp_error  ;
						END IF ;					
					END IF;		
					
					-- END WHILE ;-- LOOP 2 End.
				END LOOP; -- LOOP 2 End.
			END IF;
		END IF;  -- If Period start date is null or Period end date is more than 24 months in past then skip the event.
			
		vn_event_id := 0;
		vn_client_id := 0;   
		vn_eligibility_period_id := 0;

		-- END WHILE ;							  
	END LOOP;

	close IVE_RS_STATUS_CUR_refcur;
	
	-- log entry program end.
	-- RAISE NOTICE 'Update - vl_runtime_id >> %', vl_runtime_id;
	update tb_batch_runtime_log
	   set runtime_end_ts = clock_timestamp()
	     , update_ts = clock_timestamp()
		 , update_user_id = vs_user_id
		 , success_sw = 'Y'
	 where runtime_log_id = vl_runtime_id;

	vl_sqlcode := SQLCODE;
	IF vl_sqlcode <> 0 THEN
		vs_error := 'Error Updating BATCH RUNTIMES LOG --> BATCH_RS_IVE_STATUS PROGRAM ENDED'  ;
		-- SIGNAL p_sp_error  ;
	END IF ;
	
	-- COMMIT;
	RETURN vl_return;
END;

$function$
;
