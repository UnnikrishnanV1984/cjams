/*
Case ID: 3265611
Client ID: 4195652 (AALIYAH BROWN)
Correct Provider ID: 5083542 (Katherine Dorsey)
Wrong Provider ID: 5055574 (Lakeesha King) - Aug 2024 to Nov 2024 payments

Datafix is needed for...
Step 1) with this CDM-43552
Create Account Receivables for the below payments using the receivable_id 1256223 (tb_receivable_header)

payment_id payment_detail_id start_dt end_dt final_amount_no
----------------------------------------------------------------------------
4624232 5867617 2024-11-01 2024-11-30 840.30
4609318 5848681 2024-10-01 2024-10-31 868.31
4592282 5827673 2024-09-01 2024-09-30 840.30
4568199 5800050 2024-08-14 2024-08-31 504.18
4568199 5800051 2024-08-01 2024-08-13 364.13
  
-- Root cause: Data issue, the payment has been created under the correct provider ID.
-- Fix Provided: Datafix has been promoted to create an AR for the incorrect provider (Lakeesha King / ID# 5055574) from August to November 2024 service period.
-- Regression Impacts: GAP setup in CJAMS. 
-- Is Code fix Required?: TDB
--	Code fix ticket#: TBD
--	Reason why no related code fix: TBD

*/

-- Create ARs - NO data in tb_receivable_header
-- debra.dandridge@maryland.gov - baltimore finance supervisor
/*
providerid, payment_detail_id, payment_id
5055574	5867617	4624232
5055574	5848681	4609318
5055574	5827673	4592282
5055574	5800050	4568199
5055574	5800051	4568199
*/

/*
select * from tb_receivable_detail where payment_detail_id in (5867617,5848681,5827673,5800050,5800051);
*/
insert into tb_receivable_detail
	(	
	receivable_detail_id,
	payment_detail_id,
	receivable_id,
	amount_no,
	receivable_balance_no,
	receivable_status_cd,
	receivable_status_dt,
	start_dt,
	end_dt,
	manual_sw,
	notes_tx,
	create_ts,
	create_user_id,
	update_ts,
	update_user_id,
	delete_sw,
	receivable_type,
	approval_status_cd,
	action_dt,
	county_cd,
	receivable_ts
	)
	select SP_nextid( 'sq_receivable_detail'::character varying),
		payment_detail_id,
		(select receivable_id from tb_receivable_header where provider_id = 5055574 and delete_sw  = 'N'),--receivable_id = '1256223'
		final_amount_no,
		final_amount_no,
		'19',-- OUTSTANDING
		current_date,
		final_service_start_dt,
		final_service_end_dt,
		'N',
		'Created thru Under Over Batch',
		now(),
		'CDM-43552',
		now(),
		'CDM-43552',
		'N',
		'926', -- GAP,
		'3047',
		current_date,
		county_cd,
		now()
	from cjams.tb_payment_detail pd 
	where payment_detail_id
	in (5867617,5848681,5827673,5800050,5800051);
		
/*select update_user_id ,* from tb_receivable_collection_status trcs where trcs.update_user_id = 'CDM-43552';
in (5867617,5848681,5827673,5800050,5800051);*/

insert into tb_receivable_collection_status
	(	collection_status_id,
		collection_status_cd,
		collection_status_dt,                      
		active_sw,
		create_ts,                                 
		create_user_id,
		update_ts,                                 
		receivable_detail_id,
		update_user_id,                            
		delete_sw
	)	
	select SP_nextid ( 'sq_receivable_collection_status'::character varying),
		'780', -- Recovery
		current_date,                            
		'Y',
		now(),
		'CDM-43552',
		now(),
		receivable_detail_id,
		'CDM-43552',  
		'N'	
	from tb_receivable_detail	
	where delete_sw = 'N'
		and payment_detail_id
		in (5867617,5848681,5827673,5800050,5800051);

/*
select * from tb_ticklers tt where county_cd = '1429' and system_tickler_id =42 order by tickler_id Desc ;
*/
--entity_type_cd = '2953';
insert into tb_ticklers
	 ( tickler_id,
	   tickler_tx,
	   tickler_type_sw,
	   due_dt,
	   reminder_start_dt,
	   entity_type_cd,
	   entity_key_id,
	   entity_nm,
	   assigned_to_staff_id,
	   client_id,
	   create_ts,
	   create_user_id,
	   update_ts,
	   update_user_id,
	   delete_sw,
	   county_cd,
	   county_unit_id,
	   system_tickler_id,
	   tickler_nature_cd,
	   assign_to_county_cd,
	   assign_to_unit_id,
	   expiry_dt,
	   entity_id1,
	   entity_id2,
	   screen_cd )
values 
	( SP_nextid('sq_ticklers'::character varying),
	   'A Subsidy/GAP payment has gone to wrong provider Lakeesha King. Send Overpayment Notice (Recovery).',
	   'S',
	   (current_date + 30),
	   (current_date + 30 ) - 30,
       '2953',
	   5055574,
	   'Lakeesha King',
	   NULL,
	   4195652,
	   current_timestamp,
	   'CDM-43552',
	   current_timestamp,
	   'CDM-43552',
	   'N',
	   '1429', -- Baltimore City
	   13070,
	   42,
	   '2532', -- Fiscal
	   '1429', -- Baltimore City
	   NULL,
	   (current_date + 30 ) + 30,
	   (select max(receivable_detail_id)
			from tb_receivable_detail	
		where delete_sw = 'N'
			and payment_detail_id
			in (5867617,5848681,5827673,5800050,5800051)
		)		,
	   5356, -- GAP ID
	   NULL 
	 );



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
	update_user_id = 'CDM-43552'
where rh.receivable_id = 1256223
	and rh.delete_sw = 'N'  ;
		 
		 
		 
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
	update_user_id = 'CDM-43552'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1256223 ;
	

