DROP FUNCTION IF EXISTS cjams.sp_subsidy_payment_restamping(date);
CREATE OR REPLACE FUNCTION cjams.sp_subsidy_payment_restamping(
	ad_run_dt date,
	OUT vs_success_sw character varying,
	OUT vl_output_sqlcode character varying,
	OUT vs_message character varying
	)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
/**
cjams.sp_subsidy_payment_restamping
- For each eligible client/period (see base population query), for each month in the last 24 months (from ad_run_dt),
  if the month falls within start_dt and end_dt, and no record exists in TB_FUND_ALLOCATION_MASTER for that client/case/period/month,
  insert a new allocation record:
    - If resulting_status_cd = '2913', split payment 50/50 state/IVE
    - Else, 100% state
- OUT parameters:
    - vs_success_sw: 'Y' (success) or 'N' (error)
    - vl_output_sqlcode: '0' (success) or error message
    - vs_message: outcome description
- All errors logged and reported via OUT params
*/

DECLARE
    rec RECORD;
    v_month_start DATE;
    v_month_end DATE;
	vd_24months_date DATE;
	vd_last_month DATE;
	vd_calc_period_start_date DATE;
	vd_calc_period_end_date DATE;
	vd_iter_month_start_dt DATE;
	vd_iter_month_end_dt DATE;
	vd_current_calc_period_start_date Date;
	
	al_sqlcode integer DEFAULT 0;
	vl_ret_status integer DEFAULT 0;
    v_iter Integer;
    v_found Integer;
	vl_subsidy_agreement_id Integer;
	vl_service_id Integer;
	vn_calc_period_iter Integer;
	vn_loop_ITER Integer;
	
    v_fund_alloc_id BIGINT;
	vl_payment_detail_id Bigint; 
	vl_fund_alloc_id  Bigint;
	v_payment_detail_id BIGINT;
	
	v_payment_amount DECIMAL(10,2) := 0.00;
    vdc_state_amt DECIMAL(10,2);
    vdc_ive_amt DECIMAL(10,2);
    vdc_final_amount_no DECIMAL(10,2);
	
    as_error VARCHAR(3000) DEFAULT '';
    SQLSTATE CHAR(5) DEFAULT '00000';
    vs_message_text VARCHAR(3000) DEFAULT '';
    vs_Procedure_nm VARCHAR(100) DEFAULT 'SP_SUBSIDY_PAYMENT_RESTAMPING';
    vs_resulting_status_cd character varying;
	vs_fiscalcat character varying;
	vs_elig_type_cd character varying; 
	vs_fam_fiscal_category_cd character varying;
	vs_fam_eligibility_status_cd character varying;
	
	cur_payments record;
	cur_payments_REFCURSOR REFCURSOR;

BEGIN
    BEGIN
		-- Capture max restamping date (24 months)
		select -- (current_date - interval '24 months'),
			f_daymonth((current_date - interval '24 months')::date,'F','C'),
			-- (current_date - interval '1 month'),
			f_daymonth((current_date - interval '1 month')::date,'L','C')
		into vd_24months_date,
			vd_last_month
		;
	
		raise notice 'vd_24months_date %',vd_24months_date ;
		raise notice 'vd_last_month %',vd_last_month ;
	
        -- Loop through base population
        FOR rec IN
            SELECT ce.eligibility_type_cd,
				   ce.client_id,
				   ce.case_id,
				   btrim(ep.status_cd) as resulting_status_cd,
				   (CASE WHEN ep.sqnm_sw = 'I' THEN 
						ce.start_dt 
					ELSE
						(pr.dob + interval '18 years') 
					END)::date as start_dt,
				   (CASE WHEN ep.sqnm_sw = 'I' THEN 
						(pr.dob + interval '18 years' - interval '1 day')::date 
					ELSE 
						(CASE WHEN btrim(ce.eligibility_type_cd) = '2934' THEN 
							(SELECT adr.enddate 
								FROM adoptioncase ad, 
									adoptioncaseagreement adr 
							WHERE ad.adoptioncaseid = adr.adoptioncaseid
								AND ad.activeflag = 1 
								AND adr.activeflag = 1 
								AND ad.alternateid = ce.adoption_id
							) 
						ELSE 
							(SELECT gr.enddate 
								FROM guardianship gs, 
									gapagreement gr 
							WHERE gs.gapid = gr.gapid 
								AND gs.activeflag = 1 
								AND gr.activeflag = 1 
								AND gs.alternateid = ce.guardian_subsidy_id
							) 
						END) 
					END)::date as end_dt,
				   ce.eligibility_id,
				   ep.eligibility_period_id,
				   ep.sqnm_sw,
				   ce.adoption_id,
				   ce.guardian_subsidy_id,
				   ep.approvedon::date,
				   rank() over(partition by ce.eligibility_id, ep.sqnm_sw order by ep.eligibility_period_id desc) as rnk
			FROM tb_client_eligibility ce,
				 tb_eligibility_period ep,
				 person pr
			WHERE ce.eligibility_id = ep.eligibility_id
				AND ce.client_id = pr.cjamspid
				AND ep.delete_sw = 'N'
				AND ce.delete_sw = 'N'
				AND pr.activeflag = 1
				AND ep.approvalstatus IN ('PENDING', 'APPROVED')
				AND ep.update_ts::date >= 
                    COALESCE(
                    (select run_dt 
                    from tb_batch_log  
                    where batch_master_id = 110 
					and coalesce(success_sw, 'N') = 'Y'
                    order by batch_log_id desc
                    limit 1),
                    f_daymonth((current_date - INTERVAL '24 months')::date, 'F', 'C')
                    )
				AND btrim(ce.eligibility_type_cd) IN ('2934', '2935')
			ORDER BY ce.eligibility_id, ep.sqnm_sw
        LOOP
			vd_calc_period_start_date := null;
			vd_calc_period_end_date := null;
			vn_calc_period_iter := 0;
			vn_loop_ITER := 0;
			vl_subsidy_agreement_id := null;
			vl_service_id := null;
			vs_fiscalCat := null;


			if rec.rnk <> 1 then
				raise notice 'Do nothing rec.rnk';
			else
			
				if rec.end_dt is Null or rec.start_dt is null then
					-- Do nothing
					raise notice 'Do nothing rec.end_dt or rec.start_dt is null %',rec.eligibility_id;
				Elseif rec.end_dt < vd_24months_date then 	
					raise notice 'Do nothing rec.end_dt < 24 months %',rec.end_dt;
				else
					raise notice 'Process  % %', rec.start_dt, rec.end_dt;
					
					if rec.adoption_id > 0 then -- Adoption/GAP
						vl_subsidy_agreement_id	:= rec.adoption_id ;
						vl_service_id := 501; 	
					else -- GAP
						vl_subsidy_agreement_id := rec.guardian_subsidy_id;				
						vl_service_id := 503; 	
					end if;
					
					vs_resulting_status_cd := btrim(rec.resulting_status_cd);
					if vs_resulting_status_cd = '2913' then  -- Eligible Reimbursable                                                                                                                                                                                                                       
						vs_elig_type_cd := '3951';
					else
						vs_elig_type_cd := '3952';
					end if;
			
					select fcm.fiscal_category_cd                                                                                                                                                                                                                        
						into vs_fiscalcat                                                                                                                                                                                                                              
					from tb_placement_stru_category_link psl, 
						tb_fiscal_category_master fcm                                                                                                                                                                              
					where psl.service_id = vl_service_id                                                                                                                                                                    
						and psl.fiscal_category_id = fcm.fiscal_category_id          
						and fcm.eligibility_cd = vs_elig_type_cd                                                                                                                                                                                
						and psl.delete_sw = 'N'                                                                                                                                                                                           
						and fcm.delete_sw = 'N';
								
					if rec.start_dt < vd_24months_date then 
						vd_calc_period_start_date := vd_24months_date;
					else 
						vd_calc_period_start_date := rec.start_dt;
					end if;
					
					if rec.end_dt > vd_last_month then 
						vd_calc_period_end_date := vd_last_month;
					else 
						vd_calc_period_end_date := rec.end_dt;
					end if;
				
					raise notice 'vd_calc_period_start_date>> %',vd_calc_period_start_date;
					raise notice 'vd_calc_period_end_date>> %',vd_calc_period_end_date;
				
					select cjams.f_months_between( vd_calc_period_start_date::date, 
						(vd_calc_period_end_date::date + interval '1 Month')::date
						)
					into vn_calc_period_iter;   
					
					raise notice 'vn_calc_period_iter>> %',vn_calc_period_iter;
						
					if vn_calc_period_iter > 0 then
						vn_loop_ITER := 1;    	
						vd_current_calc_period_start_date := vd_calc_period_start_date;
						
						LOOP 
							raise notice 'vn_loop_ITER>> %',vn_loop_ITER;
							
							EXIT WHEN vn_loop_ITER > vn_calc_period_iter ;
							
							-- calculate the start month date & end month date 
							select f_daymonth(vd_current_calc_period_start_date,'F','C'),
								f_daymonth(vd_current_calc_period_start_date,'L','C')
							into vd_iter_month_start_dt,
								vd_iter_month_end_dt;
							
							raise notice 'vd_iter_month_start_dt>> %',vd_iter_month_start_dt;
							raise notice 'vd_iter_month_end_dt>> %',vd_iter_month_end_dt;
							
							OPEN cur_payments_REFCURSOR FOR
								-- Check for the payment & prior payment stamping
								select pd.payment_detail_id,
									pd.final_amount_no
									-- , fam.fund_alloc_id
									-- , btrim(fam.fiscal_category_cd) as fiscal_category_cd
								from tb_payment_status ps, 
									tb_payment_header ph,
									tb_payment_detail pd
									-- left outer join tb_fund_allocation_master fam
									-- 	on fam.payment_detail_id = pd.payment_detail_id
									--		and fam.delete_sw = 'N'
								where ps.payment_id = ph.payment_id
									and ps.payment_id = pd.payment_id
									and ps.delete_sw = 'N'
									and pd.delete_sw = 'N' 
									and ph.delete_sw = 'N'
									and ps.payment_status_cd = '1636'
									and pd.subsidy_agreement_id = vl_subsidy_agreement_id
									and pd.final_service_id = vl_service_id
									and pd.final_amount_no > 0
									and date_part('year',ph.payment_start_dt::date) = date_part('year',vd_iter_month_start_dt::date)
									and date_part('month',ph.payment_start_dt::date) = date_part('month',vd_iter_month_start_dt::date)
									and ph.payment_type_cd  in ( '7', '5689', '3294' );
							LOOP
								fetch cur_payments_REFCURSOR into cur_payments;
								exit when not found;
							
								-- Reset
								vl_payment_detail_id := null;
								vl_fund_alloc_id := null;
								vs_fam_fiscal_category_cd := null;
								vdc_final_amount_no := null;
								vs_fam_eligibility_status_cd := null;
								
								vl_payment_detail_id := cur_payments.payment_detail_id;
								vdc_final_amount_no := cur_payments.final_amount_no;
								-- vl_fund_alloc_id := cur_payments.fund_alloc_id;
								-- vs_fam_fiscal_category_cd := cur_payments.fiscal_category_cd;
								
								select fam.fund_alloc_id,
									btrim(fam.fiscal_category_cd),
									btrim(eligibility_status_cd)
								into vl_fund_alloc_id,
									vs_fam_fiscal_category_cd,
									vs_fam_eligibility_status_cd
								from tb_fund_allocation_master fam
								where fam.payment_detail_id = vl_payment_detail_id
									and fam.delete_sw = 'N' ;
								
								IF vs_resulting_status_cd = '2913' THEN -- Eligible Reimbursable
									vdc_ive_amt := vdc_final_amount_no / 2;
									vdc_state_amt := vdc_final_amount_no / 2;
								ELSE
									vdc_ive_amt := 0;
									vdc_state_amt := vdc_final_amount_no ;
								END IF;	
								
								If vl_fund_alloc_id is null then 
									vl_fund_alloc_id := 0;
								end if;	
								
								if vl_fund_alloc_id > 0 
									and (case when vs_resulting_status_cd = '2913' then	
											vs_fam_eligibility_status_cd <> '2913' 
										 when vs_resulting_status_cd <> '2913' then 
											vs_fam_eligibility_status_cd = '2913' 
										 end)	
									-- vs_fam_eligibility_status_cd <> vs_resulting_status_cd 
									then -- Re-stamping  
									
									-- Move to fund alocation detail table
									insert into tb_fund_allocation_detail 
										(	fund_alloc_history_id
											,fund_alloc_id
											,fund_allocation_date
											,payment_detail_id
											,payment_amount
											,fiscal_category_cd
											,ssi_funding_amt
											,ssa_funding_amt
											,coc_funding_amt
											,state_funding_amt
											,ive_funding_amt
											,ivd_funding_amt
											,local_funding_amt
											,initial_stamping_sw
											,delete_sw
											,create_ts
											,create_user_id
											,update_ts
											,update_user_id
											,eligibility_status_cd
										)
									(	select nextval('sq_fund_allocation_detail')
											,fund_alloc_id
											,fund_allocation_date
											,payment_detail_id
											,payment_amount
											,fiscal_category_cd
											,ssi_funding_amt
											,ssa_funding_amt
											,coc_funding_amt
											,state_funding_amt
											,ive_funding_amt
											,ivd_funding_amt
											,local_funding_amt
											,initial_stamping_sw
											,delete_sw
											,current_timestamp -- create_ts
											,'finance' -- create_user_id
											,current_timestamp -- update_ts
											,'finance' -- update_user_id
											,eligibility_status_cd
										from tb_fund_allocation_master
										where fund_alloc_id = vl_fund_alloc_id 
											and delete_sw = 'N'
									);
									
									
									update tb_fund_allocation_master
										set fiscal_category_cd = vs_fiscalcat,
											fund_allocation_date = ad_run_dt,
											state_funding_amt = vdc_state_amt ,
											ive_funding_amt = vdc_ive_amt,
											initial_stamping_sw = 'N',
											update_user_id = 'finance',
											update_ts = current_timestamp,
											eligibility_status_cd = vs_resulting_status_cd
									where fund_alloc_id = vl_fund_alloc_id 
										and delete_sw = 'N';

								elseif vl_fund_alloc_id = 0 then -- Initial Stamping
										
									insert into tb_fund_allocation_master
										(	fund_alloc_id,			
											funding_amount_no,
											payment_detail_id,		    
											fund_allocation_date,
											payment_amount,			
											fiscal_category_cd,
											ssi_funding_amt,			
											ssa_funding_amt,
											coc_funding_amt,			
											state_funding_amt,
											ive_funding_amt,			
											ivd_funding_amt,
											local_funding_amt,		    
											initial_stamping_sw,
											delete_sw,
											create_ts,    		        
											create_user_id,
											update_ts,			        
											update_user_id,
											eligibility_status_cd 
											)
									values ( 
										nextval('sq_fund_allocation_master'),		
										0,
										vl_payment_detail_id,
										ad_run_dt,
										vdc_final_amount_no,
										vs_fiscalcat,
										0,		
										0,
										0,		
										vdc_state_amt,
										vdc_ive_amt,		
										0,
										0,							
										'Y',
										'N',
										CURRENT_TIMESTAMP,			
										'finance',
										CURRENT_TIMESTAMP,			
										'finance',
										vs_resulting_status_cd 
										)  ;
								else
									raise notice 'No change to stamping ...';
								end if;
								
							END LOOP;	
							close cur_payments_REFCURSOR;	
										
							vd_current_calc_period_start_date := vd_current_calc_period_start_date + interval '1 month';
							vn_loop_ITER := vn_loop_ITER + 1;                                   			
							
						END LOOP; 
					end if;
				end if;	
			end if;
        END LOOP;
		
        vs_success_sw := 'Y';
        vl_output_sqlcode := '0';
        vs_message := 'Subsidy payment restamping completed successfully.';
    EXCEPTION WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS vs_message_text = MESSAGE_TEXT;
        vs_success_sw := 'N';
        vl_output_sqlcode := vs_message_text;
        vs_message := 'Error in sp_subsidy_payment_restamping: ' || vs_message_text;
        SELECT SP_BATCH_ERROR_LOG (
            vs_Procedure_nm,
            NULL::bigint,
            NULL::bigint,
            NULL::character varying,
            NULL::INTEGER,
            NULL::character varying,
            SQLSTATE::character varying,
            vs_message::character varying,
            'finance'::character varying) INTO vl_ret_status;
    END;
END;
$function$
;