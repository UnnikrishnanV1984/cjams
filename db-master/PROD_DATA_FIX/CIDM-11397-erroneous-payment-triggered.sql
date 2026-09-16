/*
-- Issue Description: 
   Incorrect A/R Balance fix

-Cecilia Sterret (PID # 3041664) as detailed below:1. We will verify if the Provider overpayment for Provider ID # 5043548 was created for partial of May 2011 and June 2011 services.2. We will proceed with the data fix to update the GAP agreement & subsidy rate start date from 06/01/2011 to 05/18/2011.2. Update the Child Removal & OOH program end date from 06/01/2011 to 05/18/20113. Update the GAP program assignment start date from 06/10/2011 to 05/18/2011 for Cecilia Sterret (PID # 3041664) 4. Once the data fix is completed and deployed to production, CJAMS will create a GAP adjustment payment for partial services from May 2011.
-- Fix Provided: Datafix has been promoted to delete the Incorrect A/R.
-- Pull request# N/A 
-- Is Code fix Required?: No
--	Code fix ticket#: N/A
--	Reason why no related code fix: 
--  Regression Impacts: N/A
*/

update tb_receivable_collection_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-11397'
where receivable_detail_id in (
1770385, 1770386, 1770387, 1770388, 1770389, 1770390, 1770391, 1770392, 1770393, 1770394,
1770395, 1770396, 1770397, 1770398, 1770399, 1770400, 1770401, 1770402, 1770403, 1770404,
1770405, 1770406, 1770407, 1770408, 1770409, 1770410, 1770411, 1770412, 1770413, 1770414,
1770415, 1770416, 1770417, 1770418, 1770419, 1770420, 1770421, 1770422, 1770423, 1770424,
1770425, 1770426, 1770427, 1770428, 1770429, 1770430, 1770431, 1770432, 1770433, 1770434,
1770435, 1770436, 1770437, 1770438, 1770439, 1770440, 1770441, 1770442, 1770443, 1770444,
1770445, 1770446, 1770447, 1770448, 1770449, 1770450, 1770451, 1770452, 1770453, 1770454,
1770455, 1770456, 1770457, 1770458, 1770459, 1770460, 1770461, 1770462, 1770463, 1770464,
1770465, 1770466, 1770467, 1770468, 1770469, 1770470, 1770471, 1770472, 1770473, 1770474,
1770475, 1770476, 1770477, 1770478, 1770479, 1770480, 1770481, 1770482, 1770483, 1770484,
1770485, 1770486, 1770487, 1770488   
)
	and delete_sw = 'N';
	
update tb_receivable_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-11397'
where receivable_detail_id in (
1770385, 1770386, 1770387, 1770388, 1770389, 1770390, 1770391, 1770392, 1770393, 1770394,
1770395, 1770396, 1770397, 1770398, 1770399, 1770400, 1770401, 1770402, 1770403, 1770404,
1770405, 1770406, 1770407, 1770408, 1770409, 1770410, 1770411, 1770412, 1770413, 1770414,
1770415, 1770416, 1770417, 1770418, 1770419, 1770420, 1770421, 1770422, 1770423, 1770424,
1770425, 1770426, 1770427, 1770428, 1770429, 1770430, 1770431, 1770432, 1770433, 1770434,
1770435, 1770436, 1770437, 1770438, 1770439, 1770440, 1770441, 1770442, 1770443, 1770444,
1770445, 1770446, 1770447, 1770448, 1770449, 1770450, 1770451, 1770452, 1770453, 1770454,
1770455, 1770456, 1770457, 1770458, 1770459, 1770460, 1770461, 1770462, 1770463, 1770464,
1770465, 1770466, 1770467, 1770468, 1770469, 1770470, 1770471, 1770472, 1770473, 1770474,
1770475, 1770476, 1770477, 1770478, 1770479, 1770480, 1770481, 1770482, 1770483, 1770484,
1770485, 1770486, 1770487, 1770488   
)
	and delete_sw = 'N';
	
-- Update Provider AR Balances & Payment Plan		   
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
	update_user_id = 'CIDM-11397'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 245035 ;
		 
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
	update_user_id = 'CIDM-11397'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 245035 ;



update gapagreementrate 
set updatedon = now(), updatedby = 'CIDM-11397'
where gapagreementid = '9c653e19-c634-4b30-b79b-811531fedf07' and activeflag = 1 ;


update gapagreementrevision 
set approvaldate=now(), updatedon = now(), updatedby = 'CIDM-11397'
where gapagreementid = '9c653e19-c634-4b30-b79b-811531fedf07' and activeflag = 1 ;
