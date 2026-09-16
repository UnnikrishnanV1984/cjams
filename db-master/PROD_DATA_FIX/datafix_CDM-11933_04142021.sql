-- CDM-11933 - Child Accounts
/*
-- Issue Description: 
   User Request to update SSA Receipts Child Account Transaction Amounts.
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: User Error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
select comm_account_id, client_id, total_balance_no, available_balance_no, obligated_for_anc, obligated_for_coc, 
	update_ts, update_user_id, comm_account_id 
from cjams.tb_client_account  
where client_account_id in (11940, 14664, 13745, 10842, 13522)
  and delete_sw  = 'N' ;

-- Client ID: 1078498 (DEASIA DENECE BARBER) - 7dff36bc-223d-46ca-a4d5-2226e1dca26f
-- Conserved  Account CLIENT_ACCOUNT_ID:  11940
 
-- $517.00 --> $103.40
select transaction_id, transaction_source_cd, transaction_type_cd, credit_debit_sw,
		transaction_amount_no, update_user_id, update_ts 
from tb_account_transaction 
where transaction_id  = 97979
	and client_account_id = 11940
	and transaction_amount_no = 517.00
	and delete_sw  = 'N' ;
	
update tb_account_transaction
	set transaction_amount_no = 103.40,
		update_ts = now(),
		update_user_id = 'CDM-11933'
where transaction_id  = 97979
	and client_account_id = 11940
	and transaction_amount_no = 517.00
	and delete_sw  = 'N' ;


-- $517.00 --> $103.40
select transaction_id, transaction_source_cd, transaction_type_cd, credit_debit_sw,
		transaction_amount_no, update_user_id, update_ts 
from tb_account_transaction 		
where transaction_id  = 99850
	and client_account_id = 11940
	and transaction_amount_no = 517.00
	and delete_sw  = 'N' ;
   
update tb_account_transaction
	set transaction_amount_no = 103.40,
		update_ts = now(),
		update_user_id = 'CDM-11933'
where transaction_id  = 99850
	and client_account_id = 11940
	and transaction_amount_no = 517.00
	and delete_sw  = 'N' ;


update tb_client_account ta
set total_balance_no = 
	(
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
			where tr.client_account_id = ta.client_account_id
			   and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
			   and tr.transaction_type_cd <> '5530'    
			   and tr.credit_debit_sw = 'C'
			   and tr.delete_sw = 'N' 
		)	   
		- 
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction  tr
			where tr.client_account_id =  ta.client_account_id
				and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
				and tr.transaction_type_cd <> '5530'    
				and tr.credit_debit_sw = 'D'
				and tr.delete_sw = 'N' 
		)
	),
	obligated_for_coc = 
	coalesce(( select
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
		   where tr.client_account_id = ca.client_account_id
			and tr.delete_sw = 'N'
			and tr.credit_debit_sw = 'C'
			and tr.transaction_source_cd in ('587','586','585')	
			and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
		 )
		+
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'C'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
					)

		),0)
		-
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'D'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
					)

		),0)
		from tb_client_account ca
	where ca.client_account_id = ta.client_account_id
		and ca.delete_sw = 'N'
	),0),
	update_ts = now(),
	update_user_id = 'CDM-11933'
where ta.client_account_id = 11940
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CDM-11933'
where ta.client_account_id = 11940
and ta.delete_sw = 'N' ;
   
-- Client ID: 1066856 (AUSTIN J	DAVIDSON) - 8157f6fa-3f39-457e-8fad-df17b58f0009
-- Conserved  Account CLIENT_ACCOUNT_ID: 14664
   
-- $351.00 --> $70.20
select transaction_id, transaction_source_cd, transaction_type_cd, credit_debit_sw,
		transaction_amount_no, update_user_id, update_ts 
from tb_account_transaction 
where transaction_id  = 97978
	and client_account_id = 14664
	and transaction_amount_no = 351.00
	and delete_sw  = 'N' ;

update tb_account_transaction
	set transaction_amount_no = 70.20,
		update_ts = now(),
		update_user_id = 'CDM-11933'
where transaction_id  = 97978
	and client_account_id = 14664
	and transaction_amount_no = 351.00
	and delete_sw  = 'N' ;
		

-- $351.00 --> $70.20
select transaction_id, transaction_source_cd, transaction_type_cd, credit_debit_sw,
		transaction_amount_no, update_user_id, update_ts 
from tb_account_transaction 
where transaction_id  = 99848
	and client_account_id = 14664
	and transaction_amount_no = 351.00
	and delete_sw  = 'N' ;

update tb_account_transaction
	set transaction_amount_no = 70.20,
		update_ts = now(),
		update_user_id = 'CDM-11933'
where transaction_id  = 99848
	and client_account_id = 14664
	and transaction_amount_no = 351.00
	and delete_sw  = 'N' ;


update tb_client_account ta
set total_balance_no = 
	(
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
			where tr.client_account_id = ta.client_account_id
			   and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
			   and tr.transaction_type_cd <> '5530'    
			   and tr.credit_debit_sw = 'C'
			   and tr.delete_sw = 'N' 
		)	   
		- 
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction  tr
			where tr.client_account_id =  ta.client_account_id
				and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
				and tr.transaction_type_cd <> '5530'    
				and tr.credit_debit_sw = 'D'
				and tr.delete_sw = 'N' 
		)
	),
	obligated_for_coc = 
	coalesce(( select
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
		   where tr.client_account_id = ca.client_account_id
			and tr.delete_sw = 'N'
			and tr.credit_debit_sw = 'C'
			and tr.transaction_source_cd in ('587','586','585')	
			and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
		 )
		+
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'C'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
					)

		),0)
		-
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'D'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
					)

		),0)
		from tb_client_account ca
	where ca.client_account_id = ta.client_account_id
		and ca.delete_sw = 'N'
	),0),
	update_ts = now(),
	update_user_id = 'CDM-11933'
where ta.client_account_id = 14664
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CDM-11933'
where ta.client_account_id = 14664
and ta.delete_sw = 'N' ;
   
-- Client ID: 1049592 (JAYDEN JONES) - f96af2c0-8288-4366-a059-a0c74380ab92
-- Conserved  Account CLIENT_ACCOUNT_ID: 13745
   
-- $122.00 --> $24.40
select transaction_id, transaction_source_cd, transaction_type_cd, credit_debit_sw,
		transaction_amount_no, update_user_id, update_ts 
from tb_account_transaction 		
where transaction_id  = 97980
	and client_account_id = 13745
	and transaction_amount_no  = 122.00
	and delete_sw  = 'N' ;

update tb_account_transaction
	set transaction_amount_no = 24.40,
		update_ts = now(),
		update_user_id = 'CDM-11933'
where transaction_id  = 97980
	and client_account_id = 13745
	and transaction_amount_no  = 122.00
	and delete_sw  = 'N' ;


-- $122.00 --> $24.40
select transaction_id, transaction_source_cd, transaction_type_cd, credit_debit_sw,
		transaction_amount_no, update_user_id, update_ts 
from tb_account_transaction 		
where transaction_id  = 99849
	and client_account_id = 13745
	and transaction_amount_no = 122.00
	and delete_sw  = 'N' ;

update tb_account_transaction
	set transaction_amount_no = 24.40,
		update_ts = now(),
		update_user_id = 'CDM-11933'
where transaction_id  = 99849
	and client_account_id = 13745
	and transaction_amount_no = 122.00
	and delete_sw  = 'N' ;


update tb_client_account ta
set total_balance_no = 
	(
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
			where tr.client_account_id = ta.client_account_id
			   and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
			   and tr.transaction_type_cd <> '5530'    
			   and tr.credit_debit_sw = 'C'
			   and tr.delete_sw = 'N' 
		)	   
		- 
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction  tr
			where tr.client_account_id =  ta.client_account_id
				and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
				and tr.transaction_type_cd <> '5530'    
				and tr.credit_debit_sw = 'D'
				and tr.delete_sw = 'N' 
		)
	),
	obligated_for_coc = 
	coalesce(( select
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
		   where tr.client_account_id = ca.client_account_id
			and tr.delete_sw = 'N'
			and tr.credit_debit_sw = 'C'
			and tr.transaction_source_cd in ('587','586','585')	
			and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
		 )
		+
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'C'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
					)

		),0)
		-
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'D'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
					)

		),0)
		from tb_client_account ca
	where ca.client_account_id = ta.client_account_id
		and ca.delete_sw = 'N'
	),0),
	update_ts = now(),
	update_user_id = 'CDM-11933'
where ta.client_account_id = 13745
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CDM-11933'
where ta.client_account_id = 13745
and ta.delete_sw = 'N' ;

-- Client ID: 2161875 (LEE C MOORE) - 44a2239e-0cea-4c47-91d2-c19cf5513e06
-- Conserved  Account CLIENT_ACCOUNT_ID: 10842

-- $66.00 --> $13.20
select transaction_id, transaction_source_cd, transaction_type_cd, credit_debit_sw,
		transaction_amount_no, update_user_id, update_ts 
from tb_account_transaction 		
where transaction_id  = 97977
	and client_account_id = 10842
	and transaction_amount_no = 66.00
	and delete_sw  = 'N' ;

update tb_account_transaction
	set transaction_amount_no = 13.20,
		update_ts = now(),
		update_user_id = 'CDM-11933'
where transaction_id  = 97977
	and client_account_id = 10842
	and transaction_amount_no = 66.00
	and delete_sw  = 'N' ;


-- $66.00 --> $13.20
select transaction_id, transaction_source_cd, transaction_type_cd, credit_debit_sw,
		transaction_amount_no, update_user_id, update_ts 
from tb_account_transaction 		
where transaction_id  = 99847
	and client_account_id = 10842
	and transaction_amount_no = 66.00
	and delete_sw  = 'N' ;

update tb_account_transaction
	set transaction_amount_no = 13.20,
		update_ts = now(),
		update_user_id = 'CDM-11933'
where transaction_id  = 99847
	and client_account_id = 10842
	and transaction_amount_no = 66.00
	and delete_sw  = 'N' ;

update tb_client_account ta
set total_balance_no = 
	(
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
			where tr.client_account_id = ta.client_account_id
			   and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
			   and tr.transaction_type_cd <> '5530'    
			   and tr.credit_debit_sw = 'C'
			   and tr.delete_sw = 'N' 
		)	   
		- 
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction  tr
			where tr.client_account_id =  ta.client_account_id
				and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
				and tr.transaction_type_cd <> '5530'    
				and tr.credit_debit_sw = 'D'
				and tr.delete_sw = 'N' 
		)
	),
	obligated_for_coc = 
	coalesce(( select
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
		   where tr.client_account_id = ca.client_account_id
			and tr.delete_sw = 'N'
			and tr.credit_debit_sw = 'C'
			and tr.transaction_source_cd in ('587','586','585')	
			and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
		 )
		+
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'C'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
					)

		),0)
		-
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'D'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
					)

		),0)
		from tb_client_account ca
	where ca.client_account_id = ta.client_account_id
		and ca.delete_sw = 'N'
	),0),
	update_ts = now(),
	update_user_id = 'CDM-11933'
where ta.client_account_id = 10842
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CDM-11933'
where ta.client_account_id = 10842
and ta.delete_sw = 'N' ;
	
-- Client ID: 4153917 (DEANDRE GOOSBY) - ccf8af8b-052b-49dd-8142-823644c4d6fb
-- Conserved  Account CLIENT_ACCOUNT_ID: 13522

-- $249.00 --> $49.80
select transaction_id, transaction_source_cd, transaction_type_cd, credit_debit_sw,
		transaction_amount_no, update_user_id, update_ts 
from tb_account_transaction 		
where transaction_id  = 97976
	and client_account_id = 13522
	and transaction_amount_no = 249.00
	and delete_sw  = 'N' ;

update tb_account_transaction
	set transaction_amount_no = 49.80,
		update_ts = now(),
		update_user_id = 'CDM-11933'
where transaction_id  = 97976
	and client_account_id = 13522
	and transaction_amount_no = 249.00
	and delete_sw  = 'N' ;


-- $249.00 --> $49.80
select transaction_id, transaction_source_cd, transaction_type_cd, credit_debit_sw,
		transaction_amount_no, update_user_id, update_ts 
from tb_account_transaction 		
where transaction_id  = 99846
	and client_account_id = 13522
	and transaction_amount_no = 249.00
	and delete_sw  = 'N' ;  

update tb_account_transaction
	set transaction_amount_no = 49.80,
		update_ts = now(),
		update_user_id = 'CDM-11933'
where transaction_id  = 99846
	and client_account_id = 13522
	and transaction_amount_no = 249.00
	and delete_sw  = 'N' ;  

update tb_client_account ta
set total_balance_no = 
	(
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
			where tr.client_account_id = ta.client_account_id
			   and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
			   and tr.transaction_type_cd <> '5530'    
			   and tr.credit_debit_sw = 'C'
			   and tr.delete_sw = 'N' 
		)	   
		- 
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction  tr
			where tr.client_account_id =  ta.client_account_id
				and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
				and tr.transaction_type_cd <> '5530'    
				and tr.credit_debit_sw = 'D'
				and tr.delete_sw = 'N' 
		)
	),
	obligated_for_coc = 
	coalesce(( select
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
		   where tr.client_account_id = ca.client_account_id
			and tr.delete_sw = 'N'
			and tr.credit_debit_sw = 'C'
			and tr.transaction_source_cd in ('587','586','585')	
			and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
		 )
		+
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'C'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
					)

		),0)
		-
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'D'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
					)

		),0)
		from tb_client_account ca
	where ca.client_account_id = ta.client_account_id
		and ca.delete_sw = 'N'
	),0),
	update_ts = now(),
	update_user_id = 'CDM-11933'
where ta.client_account_id = 13522
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CDM-11933'
where ta.client_account_id = 13522
and ta.delete_sw = 'N' ;

-- No Commingled Accounts assocaited 