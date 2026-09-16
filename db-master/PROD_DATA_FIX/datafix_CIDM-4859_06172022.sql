-- CIDM-4859 
-- Provider Betty Mason (5017681) Baltimore City Finance did a write off for the Overpayment to Betty Mason.
/*
-- Issue Description: 
   User Reuest to reverse the Write-Off approvals
   
-- Provider ID: 5017681 (Betty A Mason) - Local Department Home	Open - Baltimore City
-- Receivable ID: 241555

    
-- Category/ Module: Account Receivables (Finance Management) 
-- Root cause: Data Issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
Receivable Details
1721713	2019-12-01	2019-12-10	641.52	0.00	641.52
1721712	2019-12-01	2019-12-10	641.52	0.00	641.52
1721698	2020-01-01	2020-01-31	903.96	0.00	903.96
1721695	2021-02-01	2021-02-28	816.48	0.00	816.48
1721692	2022-01-01	2022-01-31	903.96	0.00	903.96
1721691	2021-05-01	2021-05-31	903.96	0.00	903.96
1721687	2021-08-01	2021-08-31	903.96	0.00	903.96
1721685	2021-10-01	2021-10-31	903.96	0.00	903.96
1721684	2020-12-01	2020-12-31	903.96	0.00	903.96
1721681	2021-11-01	2021-11-30	874.80	0.00	874.80
1721678	2021-10-01	2021-10-31	903.96	0.00	903.96
1721677	2021-07-01	2021-07-31	903.96	0.00	903.96
1721675	2020-07-01	2020-07-31	903.96	0.00	903.96
1721674	2021-04-01	2021-04-30	874.80	0.00	874.80
1721672	2021-06-01	2021-06-30	874.80	0.00	874.80
1721670	2022-02-01	2022-02-28	816.48	0.00	816.48
1721668	2021-05-01	2021-05-31	903.96	0.00	903.96
1721666	2021-01-01	2021-01-31	903.96	0.00	903.96
1721665	2020-04-01	2020-04-30	874.80	0.00	874.80
1721662	2021-04-01	2021-04-30	874.80	0.00	874.80
1721661	2020-11-01	2020-11-30	874.80	0.00	874.80
1721658	2020-03-01	2020-03-31	903.96	0.00	903.96
1721657	2020-07-01	2020-07-31	903.96	0.00	903.96
1721656	2020-10-01	2020-10-31	903.96	0.00	903.96
1721655	2020-02-01	2020-02-29	845.64	0.00	845.64
1721652	2021-12-01	2021-12-31	903.96	0.00	903.96
1721651	2021-07-01	2021-07-31	903.96	0.00	903.96
1721649	2020-05-01	2020-05-31	903.96	0.00	903.96
1721646	2021-03-01	2021-03-31	903.96	0.00	903.96
1721644	2020-02-01	2020-02-29	845.64	0.00	845.64
1721643	2020-03-01	2020-03-31	903.96	0.00	903.96
1721642	2020-11-01	2020-11-30	874.80	0.00	874.80
1721641	2020-10-01	2020-10-31	903.96	0.00	903.96
1721637	2020-05-01	2020-05-31	903.96	0.00	903.96
1721636	2020-01-01	2020-01-31	903.96	0.00	903.96
1721634	2021-09-01	2021-09-30	874.80	0.00	874.80
1721633	2020-12-01	2020-12-31	903.96	0.00	903.96
1721632	2020-08-01	2020-08-31	903.96	0.00	903.96
1721631	2021-03-01	2021-03-31	903.96	0.00	903.96
1721629	2022-01-01	2022-01-31	903.96	0.00	903.96
1721628	2021-02-01	2021-02-28	816.48	0.00	816.48
1721627	2021-09-01	2021-09-30	874.80	0.00	874.80
1721626	2021-12-01	2021-12-31	903.96	0.00	903.96
1721625	2021-08-01	2021-08-31	903.96	0.00	903.96
1721623	2020-04-01	2020-04-30	874.80	0.00	874.80
1721622	2020-09-01	2020-09-30	874.80	0.00	874.80
1721620	2021-01-01	2021-01-31	903.96	0.00	903.96
1721619	2020-06-01	2020-06-30	874.80	0.00	874.80
1721617	2020-09-01	2020-09-30	874.80	0.00	874.80
1721614	2021-06-01	2021-06-30	874.80	0.00	874.80
1721613	2021-11-01	2021-11-30	874.80	0.00	874.80
1721612	2020-08-01	2020-08-31	903.96	0.00	903.96
1721611	2020-06-01	2020-06-30	874.80	0.00	874.80
1721610	2022-02-01	2022-02-28	816.48	0.00	816.48 
*/



-- 22   Write-Off Request
select receivable_detail_id, amount_no, receivable_balance_no, written_off_amount_no, 
	receivable_status_cd, write_off_approval_status, write_off_request_date, 
	written_off_request_amount_no, comments_tx, update_ts, update_user_id  
from tb_receivable_detail 
where receivable_id = 241555
	and receivable_detail_id 
	in (
		1721713, 1721712, 1721698, 1721695, 1721692, 1721691, 1721687, 1721685, 1721684, 1721681,
		1721678, 1721677, 1721675, 1721674, 1721672, 1721670, 1721668, 1721666, 1721665, 1721662,
		1721661, 1721658, 1721657, 1721656, 1721655, 1721652, 1721651, 1721649, 1721646, 1721644,
		1721643, 1721642, 1721641, 1721637, 1721636, 1721634, 1721633, 1721632, 1721631, 1721629,
		1721628, 1721627, 1721626, 1721625, 1721623, 1721622, 1721620, 1721619, 1721617, 1721614,
		1721613, 1721612, 1721611, 1721610
		)
	and delete_sw = 'N'
	and written_off_amount_no > 0 ;

	
update tb_receivable_detail
set written_off_amount_no = null,
	receivable_status_cd = '19', -- Outstanding
	write_off_approval_status = null,
	write_off_request_date = null,
	written_off_request_amount_no = null,
	receivable_balance_no = amount_no,
	update_ts = now(),
	update_user_id = 'CIDM-4859'
where receivable_id = 241555
	and receivable_detail_id 
	in (
		1721713, 1721712, 1721698, 1721695, 1721692, 1721691, 1721687, 1721685, 1721684, 1721681,
		1721678, 1721677, 1721675, 1721674, 1721672, 1721670, 1721668, 1721666, 1721665, 1721662,
		1721661, 1721658, 1721657, 1721656, 1721655, 1721652, 1721651, 1721649, 1721646, 1721644,
		1721643, 1721642, 1721641, 1721637, 1721636, 1721634, 1721633, 1721632, 1721631, 1721629,
		1721628, 1721627, 1721626, 1721625, 1721623, 1721622, 1721620, 1721619, 1721617, 1721614,
		1721613, 1721612, 1721611, 1721610
		)
	and delete_sw = 'N'
	and written_off_amount_no > 0 ;
		

select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon 
	from routing 
where eventcode = 'FNSWO'
	and activeflag = 1
	and objectid 
	in (
			1721713, 1721712, 1721698, 1721695, 1721692, 1721691, 1721687, 1721685, 1721684, 1721681,
			1721678, 1721677, 1721675, 1721674, 1721672, 1721670, 1721668, 1721666, 1721665, 1721662,
			1721661, 1721658, 1721657, 1721656, 1721655, 1721652, 1721651, 1721649, 1721646, 1721644,
			1721643, 1721642, 1721641, 1721637, 1721636, 1721634, 1721633, 1721632, 1721631, 1721629,
			1721628, 1721627, 1721626, 1721625, 1721623, 1721622, 1721620, 1721619, 1721617, 1721614,
			1721613, 1721612, 1721611, 1721610
		) ;

update routing
set activeflag = 0,
	updatedby = 'CIDM-4859',
	updatedon = now()
where eventcode = 'FNSWO'
	and activeflag = 1
	and objectid 
	in (
			1721713, 1721712, 1721698, 1721695, 1721692, 1721691, 1721687, 1721685, 1721684, 1721681,
			1721678, 1721677, 1721675, 1721674, 1721672, 1721670, 1721668, 1721666, 1721665, 1721662,
			1721661, 1721658, 1721657, 1721656, 1721655, 1721652, 1721651, 1721649, 1721646, 1721644,
			1721643, 1721642, 1721641, 1721637, 1721636, 1721634, 1721633, 1721632, 1721631, 1721629,
			1721628, 1721627, 1721626, 1721625, 1721623, 1721622, 1721620, 1721619, 1721617, 1721614,
			1721613, 1721612, 1721611, 1721610
		) ;

-- Collection Status
select collection_status_id , collection_status_cd, delete_sw, update_ts , update_user_id 
	from tb_receivable_collection_status
where receivable_detail_id 
	in (
		1721713, 1721712, 1721698, 1721695, 1721692, 1721691, 1721687, 1721685, 1721684, 1721681,
		1721678, 1721677, 1721675, 1721674, 1721672, 1721670, 1721668, 1721666, 1721665, 1721662,
		1721661, 1721658, 1721657, 1721656, 1721655, 1721652, 1721651, 1721649, 1721646, 1721644,
		1721643, 1721642, 1721641, 1721637, 1721636, 1721634, 1721633, 1721632, 1721631, 1721629,
		1721628, 1721627, 1721626, 1721625, 1721623, 1721622, 1721620, 1721619, 1721617, 1721614,
		1721613, 1721612, 1721611, 1721610
		)
	and active_sw = 'Y'
	and delete_sw = 'Y' ;
	
update tb_receivable_collection_status
set delete_sw = 'N',
	update_ts = now(),
	update_user_id = 'CIDM-4859'
where receivable_detail_id 
	in (
		1721713, 1721712, 1721698, 1721695, 1721692, 1721691, 1721687, 1721685, 1721684, 1721681,
		1721678, 1721677, 1721675, 1721674, 1721672, 1721670, 1721668, 1721666, 1721665, 1721662,
		1721661, 1721658, 1721657, 1721656, 1721655, 1721652, 1721651, 1721649, 1721646, 1721644,
		1721643, 1721642, 1721641, 1721637, 1721636, 1721634, 1721633, 1721632, 1721631, 1721629,
		1721628, 1721627, 1721626, 1721625, 1721623, 1721622, 1721620, 1721619, 1721617, 1721614,
		1721613, 1721612, 1721611, 1721610
		)
	and active_sw = 'Y'
	and delete_sw = 'Y' ;

	
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
	rh.update_user_id = 'CIDM-4859'
where rh.receivable_id = 241555
	and rh.delete_sw = 'N'  ;
		 
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
	pp.update_user_id = 'CIDM-4859'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 241555 ;
	
select receivable_id, current_receivable_amount, update_ts, update_user_id 
	from tb_payment_plan 
where delete_sw = 'N'
	and payment_plan_id = 49709 ;
	
update tb_payment_plan
set current_receivable_amount = 0,	
	update_ts = now(),
	update_user_id = 'CIDM-4859'
where delete_sw = 'N'
	and payment_plan_id = 49709 ;
