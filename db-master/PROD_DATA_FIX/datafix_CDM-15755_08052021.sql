-- CDM-15755 - A/R Referred to CCU (CDM-13148)
/*
-- Issue Description: 
   Request to revert the AR Balances for below Providers wheer status is 'Reffered to CCU' 
   Prince George's:
    Receivable_id	Provider 
	241000			5048316	Lydia Laidlow
	241521			5013773	Kimberly  Johnson 
	243502			5056236	Selena Davis
	244502			5050719	George Desilva
	244812			5088187	Victoria  Duarte 
	1244884			5017512	Stephanie Smith-adams
	1244916			5095833	Sayquan  Johnson 
	1244949			5034383	Andria Stafford
      
-- Category/ Module: Accounts Receivables (Finance Management) 
-- Root cause: Application was having a flaw, which was fixed with CDM-13148 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Deployed in production
*/
-- Before
select receivable_detail_id, payment_detail_id, amount_no, receivable_balance_no, 
	written_off_amount_no, write_off_approval_status, delete_sw, update_ts, update_user_id  
	from tb_receivable_detail
where delete_sw = 'N'
	and receivable_detail_id 
		in 
	( 	1716178, 1716168, 1716894, 1716895, 1716896, 1716897, 1716898, 1716899, 
		1716900, 1716901, 1716902, 1716903, 1716904, 716601, 716602, 1716159,
		1716176, 716507, 716502, 1716740 
	); 
	
update tb_receivable_detail rd
set receivable_balance_no = 
		( 
			amount_no
			-
			(
			coalesce(( select sum(rl.collected_amount_no)
				from tb_payment_receipt pr,
					tb_receivable_liquidation rl
				where pr.receipt_id = rl.receipt_id
					and pr.delete_sw = 'N'
					and rl.delete_sw = 'N'
					and rl.receivable_detail_id	= rd.receivable_detail_id
			),0.00) -- receipt_amount
			+
			coalesce(( select sum(rl.collected_amount_no)
				from  tb_receivable_offset ro,
					tb_receivable_liquidation rl
				where ro.offset_id = rl.offset_id 
					and ro.delete_sw = 'N'
					and rl.delete_sw = 'N'
					and rl.receivable_detail_id	= rd.receivable_detail_id
			),0.00) -- offset_amount
			+
			coalesce(rd.written_off_amount_no,0.00) -- written_off_amount
			)
		),
	update_ts = now(),
	update_user_id = 'CDM-15755'
where delete_sw = 'N'
	and receivable_detail_id 
		in 	( 	1716178, 1716168, 1716894, 1716895, 1716896, 1716897, 1716898, 1716899, 
				1716900, 1716901, 1716902, 1716903, 1716904, 716601, 716602, 1716159,
				1716176, 716507, 716502, 1716740 
			); 
		   
		   
-- After
select receivable_detail_id, payment_detail_id, amount_no, receivable_balance_no, 
	written_off_amount_no, write_off_approval_status, delete_sw, update_ts, update_user_id  
	from tb_receivable_detail
where delete_sw = 'N'
	and receivable_detail_id 
		in 
	( 	1716178, 1716168, 1716894, 1716895, 1716896, 1716897, 1716898, 1716899, 
		1716900, 1716901, 1716902, 1716903, 1716904, 716601, 716602, 1716159,
		1716176, 716507, 716502, 1716740 
	); 
	
-- 	Update Provider AR Balances & Payment Plan		   
update tb_receivable_header rh
set rh.balance_no 
		= coalesce(( select sum(rd.receivable_balance_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	rh.receivable_original_amount_no 
		= coalesce(( select sum(rd.amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),					  
	rh.written_off_amount_no
		= coalesce(( select sum(rd.written_off_amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	rh.update_ts = now(),
	rh.update_user_id = 'CDM-15755'
where rh.delete_sw = 'N'  
	and rh.receivable_id in ( 241000, 241521, 243502, 244502, 244812, 1244884, 1244916, 1244949 );
		 
-- 	Update Payment Plan
update tb_payment_plan pp
set pp.current_receivable_amount 
		= coalesce(( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ),0),
    pp.amount_no 
		= coalesce(((( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ) * pp.percentage_no ) / 100 ),0),
    pp.update_ts = now(),
	pp.update_user_id = 'CDM-15755'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id in ( 241000, 241521, 243502, 244502, 244812, 1244884, 1244916, 1244949 );

