CREATE OR REPLACE FUNCTION cjams.get_child117report(v_commaccountid integer, date_sw character varying DEFAULT NULL::character varying, date_from date DEFAULT NULL::date, date_to date DEFAULT NULL::date)
 RETURNS TABLE(bank_nm character varying, open_dt text, close_dt text, account_no_tx character varying, account_type_cd character varying, account_type_nm character varying, intereststartdate text, interestenddate text, status_cd character varying, status_nm character varying, total_balance_no numeric, fullname character varying, transactiondetails json, rundate text, interest_amount_no numeric)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 05/26/2021 Vineet Tirodkar - Modifications to display the associated Accounts with Interest transactions only (CDM-13470)
------------------------------------------------------------------------------------------------------------	
BEGIN  
	RETURN QUERY 
	select tca.bank_nm,
		to_char(tca.open_dt,'MM/DD/YYYY')::text as open_dt,
		to_char(tca.close_dt,'MM/DD/YYYY')::text as close_dt,
		tca.account_no,
		'Commingled Account'::character varying as account_type_cd,
		null::character varying account_type_nm,
		(
			case when date_sw = 'M' then  
				to_char((date_trunc('month',CURRENT_DATE)),'MM/DD/YYYY')::text  
			when date_sw = 'D' then 
				to_char(date_from,'MM/DD/YYYY')::text 
			when date_sw='Y' then   
				to_char((date_trunc('year',CURRENT_DATE)),'MM/DD/YYYY')::text 
			else 
				null 
			end 
		) as intereststartdate,
		(
			case when date_sw = 'M' then   
				to_char((date_trunc('month',CURRENT_DATE) + interval '1 month' - interval '1 day'),'MM/DD/YYYY')::text    
			when date_sw = 'D' then
				to_char(date_to,'MM/DD/YYYY')::text  
			when date_sw = 'Y' then   
				to_char((date_trunc('year',CURRENT_DATE) + interval '1 year' - interval '1 day'),'MM/DD/YYYY')::text 
			else 
				null 
			end 
		) as interestenddate,
		tca.approval_status_cd as status_cd,
		(select value_tx 
			from tb_picklist_values 
		where TRIM(picklist_value_cd) = tca.approval_status_cd 
		and picklist_type_id = '365'
		) status_nm,
		tca.total_balance_no,
		up.fullname,
		(select json_agg(x) from 
			( select distinct ttt.client_id,
				concat(p.firstname,' ',p.lastname) as clientfullname,
				ttt.account_no_tx as account_no,
				up.fullname,
				(select value_tx 
					from tb_picklist_values 
				where trim(picklist_value_cd) = trim(ttt.account_type_cd) 
					and picklist_type_id = 40 
				limit 1)  as account_type_nm,
				ttt.total_balance_no,
				( select jsonb_agg(x) from 
					( select to_char(tatt.benefit_start_dt,'MM/DD/YYYY') as interest_start_dt,
						to_char(tatt.benefit_end_dt,'MM/DD/YYYY') as interest_end_dt,
						coalesce((tatt.transaction_amount_no),'0.00') as interest_amount_no,
						ttt.total_balance_no,
						up.fullname 
					from tb_account_transaction tatt 
						left join userprofile up on tatt.create_user_id = up.securityusersid
					where tatt.client_account_id = ttt.client_account_id 
						and tatt.transaction_source_cd = '584' 
						and tatt.transaction_type_cd = '589' 
						and (   date_sw is null 
							or 
							(
								case when date_sw = 'M' then 
									-- tatt.benefit_start_dt >= date_trunc('month',CURRENT_DATE) 
									tatt.benefit_start_dt between date_trunc('month',CURRENT_DATE)::date 
										and (date_trunc('month',CURRENT_DATE) + interval '1 month' - interval '1 day')::date
								when date_sw = 'Y' then 
									-- tatt.benefit_start_dt >= date_trunc('year',CURRENT_DATE) 
									tatt.benefit_start_dt between date_trunc('year',CURRENT_DATE)::date
										and (date_trunc('year',CURRENT_DATE) + interval '1 year' - interval '1 day')::date
								when date_sw = 'D'  then 
									(to_date(cast(tatt.benefit_start_dt as TEXT), 'YYYY-MM-DD') 
										BETWEEN to_date(cast(date_from as TEXT), 'YYYY-MM-DD') 
											AND to_date(cast(date_to as TEXT), 'YYYY-MM-DD')  )
								end
							)
						)	
					group by tatt.benefit_start_dt, tatt.benefit_end_dt, tatt.transaction_amount_no,
							up.fullname, tatt.transaction_source_cd, tatt.transaction_type_cd, 
							tatt.client_account_id -- , tatt.comm_acct_trans_id 
					) as x
				) as interestdetails
			from tb_client_account ttt 
				left join person p on p.cjamspid = ttt.client_id
			where ttt.comm_account_id = v_commaccountid
				and (select count(*)
						from tb_account_transaction tatt 
					where tatt.client_account_id = ttt.client_account_id 
						and tatt.transaction_source_cd = '584' 
						and tatt.transaction_type_cd = '589' 
						and (   date_sw is null 
								or 
								(
									case when date_sw = 'M' then 
										tatt.benefit_start_dt between date_trunc('month',CURRENT_DATE)::date 
											and (date_trunc('month',CURRENT_DATE) + interval '1 month' - interval '1 day')::date
									when date_sw = 'Y' then 
										tatt.benefit_start_dt between date_trunc('year',CURRENT_DATE)::date
											and (date_trunc('year',CURRENT_DATE) + interval '1 year' - interval '1 day')::date
									when date_sw = 'D'  then 
										(to_date(cast(tatt.benefit_start_dt as TEXT), 'YYYY-MM-DD') 
											BETWEEN to_date(cast(date_from as TEXT), 'YYYY-MM-DD') 
												AND to_date(cast(date_to as TEXT), 'YYYY-MM-DD')  )
									end
								)
							)
					) > 0		
			group by ttt.client_account_id, ttt.client_id, ttt.account_no_tx, p.firstname, p.lastname, 
					ttt.total_balance_no, ttt.account_type_cd
			) as x
		) as transactiondetails,
		to_char(now(),'MM/DD/YYYY') as rundate,
		(select coalesce(sum(tc.interest_amount_no),'0.00') 
			from tb_comm_acct_transactions tc 
		where tc.comm_account_id = tca.comm_account_id 
			and tc.delete_sw='N'
			and (   date_sw is null 
					or 
					(
						case when date_sw = 'M' then 
							tc.interest_start_dt between date_trunc('month',CURRENT_DATE)::date 
								and (date_trunc('month',CURRENT_DATE) + interval '1 month' - interval '1 day')::date
						when date_sw = 'Y' then 
							tc.interest_start_dt between date_trunc('year',CURRENT_DATE)::date
								and (date_trunc('year',CURRENT_DATE) + interval '1 year' - interval '1 day')::date
						when date_sw = 'D'  then 
							(to_date(cast(tc.interest_start_dt as TEXT), 'YYYY-MM-DD') 
								BETWEEN to_date(cast(date_from as TEXT), 'YYYY-MM-DD') 
									AND to_date(cast(date_to as TEXT), 'YYYY-MM-DD')  )
						end
					)
				)
		)
	from tb_commingled_account tca
		left join userprofile up on tca.create_user_id = up.securityusersid
	where tca.comm_account_id = v_commaccountid 
	limit 1
	;
	
END;
$function$
;
