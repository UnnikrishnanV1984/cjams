/*
-- Issue Description: 
   User request to delete the writeoff request
   Provider ID: 5051600 (Patricia Ingham)
    Client ID: 202601771 (Unique Shrewbridge)
    Receivable Detail ID: 1759385 , 1759376, 1759375, 1759373, 1759364
   
-- Category/ Module: Account Receivables (Finance Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to do the writeoff reversal.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete Write-Off 
/*
select receivable_detail_id,receivable_balance_no, written_off_amount_no, 
	receivable_status_cd, write_off_approval_status, write_off_action_date, write_off_request_date, 
	written_off_request_amount_no, comments_tx, update_ts, update_user_id  
from tb_receivable_detail 
where receivable_detail_id in (1759385,1759376,1759375,1759373,1759364)
	and delete_sw = 'N' ;
*/

/*
UPDATE cjams.tb_receivable_detail
SET receivable_balance_no=0.00, written_off_amount_no=874.80, receivable_status_cd='21', write_off_approval_status='3047', write_off_action_date='2025-07-16', write_off_request_date='2025-07-16', written_off_request_amount_no=874.8, comments_tx='Duplicate payment due to rate change from regular foster care to intermediate foster care on 01/01/25. Ck #700655 for $874.80', update_ts='2025-07-16 18:58:55.581', update_user_id='b0fbf926-91a3-4a91-a6a4-62e458683797'
WHERE receivable_detail_id=1759364;
UPDATE cjams.tb_receivable_detail
SET receivable_balance_no=0.00, written_off_amount_no=816.48, receivable_status_cd='21', write_off_approval_status='3047', write_off_action_date='2025-07-16', write_off_request_date='2025-07-16', written_off_request_amount_no=816.48, comments_tx='Duplicate payment due to rate change from regular foster care to intermediate foster care on 01/01/25. Ck #508716302 for $816.48', update_ts='2025-07-16 18:58:49.657', update_user_id='b0fbf926-91a3-4a91-a6a4-62e458683797'
WHERE receivable_detail_id=1759373;
UPDATE cjams.tb_receivable_detail
SET receivable_balance_no=0.00, written_off_amount_no=903.96, receivable_status_cd='21', write_off_approval_status='3047', write_off_action_date='2025-07-16', write_off_request_date='2025-07-16', written_off_request_amount_no=903.96, comments_tx='Duplicate payment due to rate change from regular foster care to intermediate foster care on 01/01/25. Ck #508756431 for $903.96', update_ts='2025-07-16 18:58:41.145', update_user_id='b0fbf926-91a3-4a91-a6a4-62e458683797'
WHERE receivable_detail_id=1759375;
UPDATE cjams.tb_receivable_detail
SET receivable_balance_no=0.00, written_off_amount_no=903.96, receivable_status_cd='21', write_off_approval_status='3047', write_off_action_date='2025-07-16', write_off_request_date='2025-07-16', written_off_request_amount_no=903.96, comments_tx='Duplicate payment due to rate change from regular foster care to intermediate foster care on 01/01/25. Ck #508830414 for $903.96', update_ts='2025-07-16 18:58:37.054', update_user_id='b0fbf926-91a3-4a91-a6a4-62e458683797'
WHERE receivable_detail_id=1759376;
UPDATE cjams.tb_receivable_detail
SET receivable_balance_no=0.00, written_off_amount_no=903.96, receivable_status_cd='21', write_off_approval_status='3047', write_off_action_date='2025-07-16', write_off_request_date='2025-07-16', written_off_request_amount_no=903.96, comments_tx='Duplicate payment due to rate change from regular foster care to intermediate foster care on 01/01/25. Ck #508679217 for $903.96', update_ts='2025-07-16 18:58:31.945', update_user_id='b0fbf926-91a3-4a91-a6a4-62e458683797'
WHERE receivable_detail_id=1759385;
*/

--1759385
update tb_receivable_detail
set written_off_amount_no = null,  
	receivable_balance_no = amount_no,
	receivable_status_cd = '19',  
	write_off_approval_status = null, 
	write_off_action_date = null,  
	write_off_request_date = null,  
	written_off_request_amount_no = null,  
	comments_tx = null,
	update_ts = now(),
	update_user_id = 'CJAMS-61193'
where  receivable_detail_id in (1759385,1759376,1759375,1759373,1759364)
	and delete_sw = 'N'
	and written_off_amount_no > 0 ;

update routing
set activeflag = 0, 
	updatedby = 'CJAMS-61193', 
	updatedon  = now()
where objectid  in ('1759385','1759376','1759375','1759373','1759364')--receivable id
	and eventcode  = 'FNSWO'
	and activeflag  = 1 ;
	
-- Fix Payment Receipt Amount
-- update collected_amount_no =  $27.95

/*
 * no liquidation record only comes if there is offset
select receivable_detail_id, collected_amount_no, update_ts, update_user_id  
from tb_receivable_liquidation
where receivable_detail_id in (1759385,1759376,1759375,1759373,1759364)
	and delete_sw  = 'N' ;

update tb_receivable_liquidation
set collected_amount_no = 27.95,
	update_ts = now(),
	update_user_id = 'CJAMS-61193'
where rcvbl_liquidation_id = 3383836
	and delete_sw  = 'N' ;
*/
	
--select * from tb_receivable_header where provider_id = 5051600 and delete_sw = 'N';--243511

-- 	Update Provider AR Balances & Payment Plan		   

	
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
	update_user_id = 'CJAMS-61193'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 243511 ;
		 
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
	update_user_id = 'CJAMS-61193'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 243511 ;