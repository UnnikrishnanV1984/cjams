-- CDM-15510 - Multiple eligibility status active for a client
/*
-- Issue Description: 
   Data issue: Duplicate IV-E Episodes for the same Removal Datafix
       
-- Category/ Module: Foster Care IV-E (Eligibility Management) 
-- Root cause: Few are due to the Data migration Issue 
		& there was a Application bug which is fixed now in production
--			   	
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
Case ID			Client ID	Eligibility ID
-------------------------------------------
3109598			1649923		51264
3234052			3249671		10000542
20200210026111	1987363		10000799
20200210026111	1987357		10000798
20200210026111	200139056	10000800
20200246032829	3957268		10000894
3228307			200146463	10001115
3080083			1526397		58210
3080083			1526397		58211
20200225028695	4323995		10000885
20200247032900	4445588		10000899
3008127			1050493		6900
20200230029466	3799197		10000777
20200188023469	1710630		10000516
3064985			1403212		51739
3080359			1134484		33090
20200142019017	200011231	10000378
2020027403307	200140567	10001123
20200148019465	3947290		10000395
20200147019288	200011592	10000409
3056101			1288345		157390
*/

select component_type_cd, update_ts, update_user_id, delete_sw 
	from tb_ive_component_status 
where event_id in
		( select event_id
			from tb_eligibility_events 
		where eligibility_period_id  
			in ( select eligibility_period_id
					from tb_eligibility_period 
				where eligibility_id 
					in ( 51264, 10000542, 10000799, 10000798, 10000800, 10000894, 10001115, 58210, 58211, 10000885,
						 10000899, 6900, 10000777, 10000516, 51739, 33090, 10000378, 10001123, 10000395, 10000409, 157390
						)	
					and delete_sw  = 'N'
				)
		)
	and delete_sw = 'N' ;


update tb_ive_component_status
set delete_sw = 'Y',
	update_user_id = 'CDM-15510',
	update_ts = now()
where event_id in
		( select event_id
			from tb_eligibility_events 
		where eligibility_period_id  
			in ( select eligibility_period_id
					from tb_eligibility_period 
				where eligibility_id 
					in ( 51264, 10000542, 10000799, 10000798, 10000800, 10000894, 10001115, 58210, 58211, 10000885,
						 10000899, 6900, 10000777, 10000516, 51739, 33090, 10000378, 10001123, 10000395, 10000409, 157390
						)	
					and delete_sw  = 'N'
				)
		)
	and delete_sw = 'N' ;	


select event_dt, update_ts, update_user_id, delete_sw 
	from tb_eligibility_events 
where eligibility_period_id  
	in ( select eligibility_period_id
			from tb_eligibility_period 
		where eligibility_id 
			in ( 51264, 10000542, 10000799, 10000798, 10000800, 10000894, 10001115, 58210, 58211, 10000885,
				 10000899, 6900, 10000777, 10000516, 51739, 33090, 10000378, 10001123, 10000395, 10000409, 157390
				)	
			and delete_sw  = 'N'
		) 
	and delete_sw = 'N' ;
	
update tb_eligibility_events
set delete_sw = 'Y',
	update_user_id = 'CDM-15510',
	update_ts = now()
where eligibility_period_id  
	in ( select eligibility_period_id
			from tb_eligibility_period 
		where eligibility_id 
			in ( 51264, 10000542, 10000799, 10000798, 10000800, 10000894, 10001115, 58210, 58211, 10000885,
				 10000899, 6900, 10000777, 10000516, 51739, 33090, 10000378, 10001123, 10000395, 10000409, 157390
				)	
			and delete_sw  = 'N'
		) 
	and delete_sw = 'N' ;	
	
select eligibility_period_id, start_dt, end_dt, update_ts, update_user_id, delete_sw 
	from tb_eligibility_period 
where eligibility_id 
		in ( 51264, 10000542, 10000799, 10000798, 10000800, 10000894, 10001115, 58210, 58211, 10000885,
			 10000899, 6900, 10000777, 10000516, 51739, 33090, 10000378, 10001123, 10000395, 10000409, 157390
			)
	and delete_sw = 'N' ;
	
update tb_eligibility_period
set delete_sw = 'Y',
	update_user_id = 'CDM-15510',
	update_ts = now()
where eligibility_id 
		in ( 51264, 10000542, 10000799, 10000798, 10000800, 10000894, 10001115, 58210, 58211, 10000885,
			 10000899, 6900, 10000777, 10000516, 51739, 33090, 10000378, 10001123, 10000395, 10000409, 157390
			)
	and delete_sw = 'N' ;	


select eligibility_id, client_id, start_dt, end_dt, eligibility_status_cd, update_ts, update_user_id, delete_sw  
	from tb_client_eligibility 
where eligibility_id 
		in ( 51264, 10000542, 10000799, 10000798, 10000800, 10000894, 10001115, 58210, 58211, 10000885,
			 10000899, 6900, 10000777, 10000516, 51739, 33090, 10000378, 10001123, 10000395, 10000409, 157390
			)
	and delete_sw = 'N' ;

	
update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-15510',
	update_ts = now()
where eligibility_id 
		in ( 51264, 10000542, 10000799, 10000798, 10000800, 10000894, 10001115, 58210, 58211, 10000885,
			 10000899, 6900, 10000777, 10000516, 51739, 33090, 10000378, 10001123, 10000395, 10000409, 157390
			)
	and delete_sw = 'N' ;

