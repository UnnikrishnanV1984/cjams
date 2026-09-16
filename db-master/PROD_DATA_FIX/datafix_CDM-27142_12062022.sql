-- CDM-27142 - Missing SYAD Payments to D365/FM105R
/*
-- Issue Description: 
   To delete erroneous Emergency Foster Home Care payments with no payment dates

-- Delete
5091578	Courtney Sobus 			4259020	ZEPPELIN  MISKIMON		3270506	1605.92	4496586	955.20
5091578	Courtney Sobus 			4259020	ZEPPELIN  MISKIMON		3270505	1018.88	4496585	1018.88
5091578	Courtney Sobus 			4259020	ZEPPELIN  MISKIMON		3270504	1050.72	4496584	1050.72
5091578	Courtney Sobus 			4259020	ZEPPELIN  MISKIMON		3270503	191.04	4496583	191.04
5091578	Courtney Sobus 			4258974	KAIA A MISKIMON			3270502	1605.92	4496582	955.20
5091578	Courtney Sobus 			4258974	KAIA A MISKIMON			3270501	1018.88	4496581	1018.88
5091578	Courtney Sobus 			4258974	KAIA A MISKIMON			3270500	1050.72	4496580	1050.72
5091578	Courtney Sobus 			4258974	KAIA A MISKIMON			3270499	191.04	4496579	191.04
5091578	Courtney Sobus 			4259020	ZEPPELIN  MISKIMON		3269738	955.20	4495923	955.20
5091578	Courtney Sobus 			4259020	ZEPPELIN  MISKIMON		3269737	1018.88	4495922	1018.88
5091578	Courtney Sobus 			4259020	ZEPPELIN  MISKIMON		3269736	1050.72	4495921	1050.72
5091578	Courtney Sobus 			4259020	ZEPPELIN  MISKIMON		3269735	191.04	4495920	191.04
5091578	Courtney Sobus 			4258974	KAIA A MISKIMON			3269732	955.20	4495917	955.20
5091578	Courtney Sobus 			4258974	KAIA A MISKIMON			3269731	1018.88	4495916	1018.88
5091578	Courtney Sobus 			4258974	KAIA A MISKIMON			3269730	1050.72	4495915	1050.72
5091578	Courtney Sobus 			4258974	KAIA A MISKIMON			3269729	191.04	4495914	191.04
5092935	Andrea  Mewshaw 		200801813	Kamel  McCooey		3270513	63.68	4496593	63.68
5092935	Andrea  Mewshaw 		200801813	Kamel  McCooey		3270512	955.20	4496592	955.20
5092935	Andrea  Mewshaw 		200801813	Kamel  McCooey		3270511	1178.08	4496591	1178.08
5092935	Andrea  Mewshaw 		200801813	Kamel  McCooey		3270510	1146.24	4496590	1146.24
5092935	Andrea  Mewshaw 		200801813	Kamel  McCooey		3270509	955.20	4496589	955.20
5092935	Andrea  Mewshaw 		200801813	Kamel  McCooey		3270508	1018.88	4496588	1018.88
5092935	Andrea  Mewshaw 		200801813	Kamel  McCooey		3270507	1050.72	4496587	1050.72
5092935	Andrea  Mewshaw 		200801813	Kamel  McCooey		3269748	63.68	4495933	63.68
5092935	Andrea  Mewshaw 		200801813	Kamel  McCooey		3269747	955.20	4495932	955.20
5092935	Andrea  Mewshaw 		200801813	Kamel  McCooey		3269746	1178.08	4495931	1178.08
5092935	Andrea  Mewshaw 		200801813	Kamel  McCooey		3269745	1146.24	4495930	1146.24
5092935	Andrea  Mewshaw 		200801813	Kamel  McCooey		3269744	955.20	4495929	955.20
5092935	Andrea  Mewshaw 		200801813	Kamel  McCooey		3269743	1018.88	4495928	1018.88
5092935	Andrea  Mewshaw 		200801813	Kamel  McCooey		3269742	1050.72	4495927	1050.72
6002673	Eric William Allard 	3545868	JACOB ALLEN GALLAGI		3270515	389.04	4496595	63.68
6002673	Eric William Allard 	3545868	JACOB ALLEN GALLAGI		3269754	63.68	4495939	63.68
6005765	ANGELA Ayers BEASLEY 	200780827	Cheyanne  Locklear	3270514	1584.78	4496594	1178.08
6005765	ANGELA Ayers BEASLEY 	200780827	Cheyanne  Locklear	3269751	1178.08	4495936	1178.08

-- Update Gross amout (As havign other valid payment detail record)
5091578	Courtney Sobus 			4259020		ZEPPELIN  MISKIMON	3270506	1605.92	4496586	955.20
5091578	Courtney Sobus 			4258974		KAIA A MISKIMON		3270502	1605.92	4496582	955.20
6002673	Eric William Allard 	3545868		JACOB ALLEN GALLAGI	3270515	389.04	4496595	63.68
6005765	ANGELA Ayers BEASLEY 	200780827	Cheyanne  Locklear	3270514	1584.78	4496594	1178.08

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Code issue implemented with CDM-24422 fix
-- Pull request# sp_get_current_balance was modified to fix the error 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: 12/06/2022
*/

-- Delete tb_payment_detail
select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_detail_id 
	in (	4496586, 4496585, 4496584, 4496583, 4496582, 4496581, 4496580, 4496579, 4495923, 4495922,
			4495921, 4495920, 4495917, 4495916, 4495915, 4495914, 4496593, 4496592, 4496591, 4496590,
			4496589, 4496588, 4496587, 4495933, 4495932, 4495931, 4495930, 4495929, 4495928, 4495927,
			4496595, 4495939, 4496594, 4495936
		)
	and delete_sw = 'N' 
	and final_amount_no > 0
	and final_service_start_dt is null;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-27142'
where payment_detail_id 
	in (	4496586, 4496585, 4496584, 4496583, 4496582, 4496581, 4496580, 4496579, 4495923, 4495922,
			4495921, 4495920, 4495917, 4495916, 4495915, 4495914, 4496593, 4496592, 4496591, 4496590,
			4496589, 4496588, 4496587, 4495933, 4495932, 4495931, 4495930, 4495929, 4495928, 4495927,
			4496595, 4495939, 4496594, 4495936
		)
	and delete_sw = 'N' 
	and final_amount_no > 0
	and final_service_start_dt is null;
	
-- Delete tb_payment_status 	
select ps.payment_id, ps.payment_status_id, ps.payment_status_cd, ps.delete_sw, 
		ps.update_ts, ps.update_user_id
	from tb_payment_status ps 
where ps.payment_id
	in (
		select payment_id
			from tb_payment_detail 
		where payment_detail_id 
			in (	4496586, 4496585, 4496584, 4496583, 4496582, 4496581, 4496580, 4496579, 4495923, 4495922,
					4495921, 4495920, 4495917, 4495916, 4495915, 4495914, 4496593, 4496592, 4496591, 4496590,
					4496589, 4496588, 4496587, 4495933, 4495932, 4495931, 4495930, 4495929, 4495928, 4495927,
					4496595, 4495939, 4496594, 4495936
				)
			-- and delete_sw = 'N' 
			and final_amount_no > 0
			and final_service_start_dt is null
	)
	and ps.delete_sw = 'N' ;

update tb_payment_status ps
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-27142'
where ps.payment_id
	in (
		select payment_id
			from tb_payment_detail 
		where payment_detail_id 
			in (	4496586, 4496585, 4496584, 4496583, 4496582, 4496581, 4496580, 4496579, 4495923, 4495922,
					4495921, 4495920, 4495917, 4495916, 4495915, 4495914, 4496593, 4496592, 4496591, 4496590,
					4496589, 4496588, 4496587, 4495933, 4495932, 4495931, 4495930, 4495929, 4495928, 4495927,
					4496595, 4495939, 4496594, 4495936
				)
			-- and delete_sw = 'N' 
			and final_amount_no > 0
			and final_service_start_dt is null
	)
	and ps.delete_sw = 'N' 
	and (	select count(*)
				from tb_payment_detail pd
			where pd.payment_id = ps.payment_id
				and pd.delete_sw = 'N'
		) = 0;

-- Delete tb_payment_header	
select ph.payment_id, ph.provider_id, ph.payment_type_cd, ph.delete_sw, ph.update_ts, ph.update_user_id
	from tb_payment_header ph
where ph.payment_id 
		in (
				select payment_id
					from tb_payment_detail 
				where payment_detail_id 
					in (	4496586, 4496585, 4496584, 4496583, 4496582, 4496581, 4496580, 4496579, 4495923, 4495922,
							4495921, 4495920, 4495917, 4495916, 4495915, 4495914, 4496593, 4496592, 4496591, 4496590,
							4496589, 4496588, 4496587, 4495933, 4495932, 4495931, 4495930, 4495929, 4495928, 4495927,
							4496595, 4495939, 4496594, 4495936
						)
					-- and delete_sw = 'N' 
					and final_amount_no > 0
					and final_service_start_dt is null
			)
	and ph.delete_sw = 'N' ;

update tb_payment_header ph
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-27142'
where ph.payment_id 
		in (
				select payment_id
					from tb_payment_detail 
				where payment_detail_id 
					in (	4496586, 4496585, 4496584, 4496583, 4496582, 4496581, 4496580, 4496579, 4495923, 4495922,
							4495921, 4495920, 4495917, 4495916, 4495915, 4495914, 4496593, 4496592, 4496591, 4496590,
							4496589, 4496588, 4496587, 4495933, 4495932, 4495931, 4495930, 4495929, 4495928, 4495927,
							4496595, 4495939, 4496594, 4495936
						)
					-- and delete_sw = 'N' 
					and final_amount_no > 0
					and final_service_start_dt is null
			)
	and ph.delete_sw = 'N' 
	and (	select count(*)
				from tb_payment_detail pd
			where pd.payment_id = ph.payment_id
				and pd.delete_sw = 'N'
		) = 0;
		
-- Update Gross Amount
select ph.payment_id, ph.provider_id, ph.payment_type_cd, ph.gross_amount_no,
		(select sum(pd1.final_amount_no)
			from tb_payment_detail pd1
		 where pd1.payment_id = ph.payment_id
			and pd1.delete_sw  = 'N'
		) as pay_detail_total,
		ph.delete_sw, ph.update_ts, ph.update_user_id
	from tb_payment_header ph
where ph.payment_id 
		in (
				select payment_id
					from tb_payment_detail 
				where payment_detail_id 
					in (	4496586, 4496585, 4496584, 4496583, 4496582, 4496581, 4496580, 4496579, 4495923, 4495922,
							4495921, 4495920, 4495917, 4495916, 4495915, 4495914, 4496593, 4496592, 4496591, 4496590,
							4496589, 4496588, 4496587, 4495933, 4495932, 4495931, 4495930, 4495929, 4495928, 4495927,
							4496595, 4495939, 4496594, 4495936
						)
					-- and delete_sw = 'N' 
					and final_amount_no > 0
					and final_service_start_dt is null
			)
	and ph.delete_sw = 'N' ;
	

update tb_payment_header ph
set gross_amount_no 
		= (select sum(pd1.final_amount_no)
				from tb_payment_detail pd1
			 where pd1.payment_id = ph.payment_id
				and pd1.delete_sw  = 'N'
		  ),
	update_ts = now(),
	update_user_id = 'CDM-27142'
where ph.payment_id 
		in (
				select payment_id
					from tb_payment_detail 
				where payment_detail_id 
					in (	4496586, 4496585, 4496584, 4496583, 4496582, 4496581, 4496580, 4496579, 4495923, 4495922,
							4495921, 4495920, 4495917, 4495916, 4495915, 4495914, 4496593, 4496592, 4496591, 4496590,
							4496589, 4496588, 4496587, 4495933, 4495932, 4495931, 4495930, 4495929, 4495928, 4495927,
							4496595, 4495939, 4496594, 4495936
						)
					-- and delete_sw = 'N' 
					and final_amount_no > 0
					and final_service_start_dt is null
			)
	and ph.delete_sw = 'N' ;
