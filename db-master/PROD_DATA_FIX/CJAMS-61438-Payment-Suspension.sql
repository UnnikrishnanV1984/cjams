/*
Issue Description:CJAMS-61438 Not due Provider Subsidy Payment/ Overpayment
Category/Module: Subsidy Payment/ Overpayment
Root cause: Payment went on hold as the provider had passed away.
            While analyzing we found that the Provider payment from April to August 2022 are Hold as the Withhold Payment (Returned Check) is checked on 04/14/2022. And there is an Account Receivable ($137.25) created on 08/18/2025 for April 2022 services as suspension is added into the adoption case.
             data fix to remove the suspension and provider overpayment that entered/identified on 08/18/2025
Fix provided: Data fix has been done to remove the supension and provider overpayment entered.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A 
Reason why no related code fix:   This issue is due to payment going on hold and data fix is needed to resolve it.
*/



update adoptioncasesuspension
set activeflag = 0,
    updatedby = 'CJAMS-61438',
    updatedon = now()
where adoptionsuspensionid = '714dc138-d5b3-4eca-9360-615209d2f966'
and activeflag = 1;

update adoptioncasesuspensionrevision
set activeflag = 0,
    updatedby = 'CJAMS-61438',
    updatedon = now()
where adoptionsuspensionid = '714dc138-d5b3-4eca-9360-615209d2f966'
and activeflag = 1;


update routing
set activeflag = 0,
    updatedby = 'CJAMS-61438',
    updatedon = now()
where objectid = '714dc138-d5b3-4eca-9360-615209d2f966'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-61438'
where adoptionagreementrateid in ('4a9bc0db-0d62-4299-b719-c2729efc1d82')
and activeflag = 1;


--Deleting the AR payment

update tb_receivable_detail
set delete_sw = 'Y',
    update_ts = now(),
	update_user_id = 'CJAMS-61438'
where receivable_id  = 1260091;    

-- Update Provider AR Balances & Payment Plan after AR deletion		   
update tb_receivable_header rh
set balance_no 
		= coalesce(( select sum(rd.receivable_balance_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	receivable_original_amount_no 
		= coalesce(( select sum(rd.amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),					  
	written_off_amount_no
		= coalesce(( select sum(rd.written_off_amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	update_ts = now(),
	update_user_id = 'CJAMS-61438'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 1260091 ;
		 
-- 	Update Payment Plan
update tb_payment_plan pp
set current_receivable_amount 
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
    amount_no 
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
    update_ts = now(),
	update_user_id = 'CJAMS-61438'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1260091 ;