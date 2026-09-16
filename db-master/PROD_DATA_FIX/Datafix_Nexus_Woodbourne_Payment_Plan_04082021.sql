-- Private Organization ID: 5001284	(Nexus Woodbourne Family Healing)

select payment_plan_id, plan_dt, amount_no, percentage_no, months_no, start_dt, end_dt, update_ts, update_user_id 
	from tb_payment_plan
where receivable_id = 229566
   and delete_sw = 'N' ;

update tb_payment_plan
set plan_dt =  '2021-03-25'::date,
	start_dt = '2021-03-25'::date,
	end_dt = null,
	update_ts = now(),
	update_user_id = 'DFX04072021'
where payment_plan_id = 1055688
	and delete_sw  = 'N' ;

	
update tb_payment_plan
set start_dt = '2021-03-16'::date,
	end_dt = '2021-03-25'::date,
	update_ts = now(),
	update_user_id = 'DFX04072021'
where payment_plan_id = 1055689
	and delete_sw  = 'N' ;
	