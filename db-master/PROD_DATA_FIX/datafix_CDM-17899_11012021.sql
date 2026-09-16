-- CDM-17899 Overpayment not true
/*
-- Issue Description: 
   A/Rs created on 10/19/2021 are wrong, 
   Error happened due to the GAP Code Deployed Issue; which was fixed & deployed on Prod 10/22 
      
-- Case ID: 3177270
-- Client ID: 2655300 (JAYDIN LAMONT MADDREY) - 85f3fbf8-fe16-48fa-be34-2b7aecf9c619
-- GAP ID: 3068 - 2013-09-25 To 2026-06-30 - ba7b3de2-9400-4f84-897e-634e8736904a
-- Provider ID: 5056922	(Veronica E Walker) 
	  
-- Category/ Module: Accounts Receivables (Finance Management) 
-- Root cause: TDB (Need further Analysis)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Receivable ID: 1245169
/*
--	Rec 	AR 		Payment 
--	Detl ID Amount	Detail ID
-----------------------------------------------------
1720011		713.31	1876845	2014-10-01	2014-10-31
1720012		690.30	1894332	2014-11-01	2014-11-30
1720013		713.31	1912545	2014-12-01	2014-12-31
1720014		713.31	1930628	2015-01-01	2015-01-31
1720015		644.28	1947928	2015-02-01	2015-02-28
1720016		713.31	1966399	2015-03-01	2015-03-31
1720017		690.30	1984249	2015-04-01	2015-04-30
1720018		713.31	2002046	2015-05-01	2015-05-31
1720019		690.30	2022033	2015-06-01	2015-06-30
1720020		713.31	2040191	2015-07-01	2015-07-31
1720021		713.31	2059117	2015-08-01	2015-08-31
1720023		552.24	2077817	2015-09-01	2015-09-24
1720022		138.06	2077816	2015-09-25	2015-09-30
1720024		713.31	2096229	2015-10-01	2015-10-31
1720025		690.30	2114346	2015-11-01	2015-11-30
1720026		713.31	2132888	2015-12-01	2015-12-31
1720027		713.31	2150824	2016-01-01	2016-01-31
1720028		667.29	2169406	2016-02-01	2016-02-29
1720029		713.31	2188331	2016-03-01	2016-03-31
1720030		690.30	2206344	2016-04-01	2016-04-30
1720031		713.31	2225402	2016-05-01	2016-05-31
1720032		690.30	2245051	2016-06-01	2016-06-30
1720033		713.31	2263125	2016-07-01	2016-07-31
1720034		713.31	2281719	2016-08-01	2016-08-31
1720036		552.24	2299912	2016-09-01	2016-09-24
1720035		138.06	2299911	2016-09-25	2016-09-30
1720037		713.31	2318369	2016-10-01	2016-10-31
1720038		690.30	2336093	2016-11-01	2016-11-30
1720039		713.31	2353575	2016-12-01	2016-12-31
1720040		713.31	2372055	2017-01-01	2017-01-31
1720041		644.28	2389626	2017-02-01	2017-02-28
1720042		713.31	2407767	2017-03-01	2017-03-31
1720043		690.30	2426086	2017-04-01	2017-04-30
1720044		713.31	2444702	2017-05-01	2017-05-31
1720045		690.30	2463102	2017-06-01	2017-06-30
1720046		713.31	2482086	2017-07-01	2017-07-31
1720047		713.31	2501298	2017-08-01	2017-08-31
1720049		552.24	2519319	2017-09-01	2017-09-24
1720048		138.06	2519318	2017-09-25	2017-09-30
1720050		713.31	2537897	2017-10-01	2017-10-31
1720051		690.30	2556405	2017-11-01	2017-11-30
1720052		713.31	2573605	2017-12-01	2017-12-31
1720053		713.31	2592821	2018-01-01	2018-01-31
1720054		644.28	2612145	2018-02-01	2018-02-28
1720055		713.31	2629873	2018-03-01	2018-03-31
1720056		690.30	2648465	2018-04-01	2018-04-30
1720057		713.31	2666884	2018-05-01	2018-05-31
1720058		690.30	2686212	2018-06-01	2018-06-30
1720059		713.31	2705012	2018-07-01	2018-07-31
1720060		713.31	2723797	2018-08-01	2018-08-31
1720062		552.24	2741822	2018-09-01	2018-09-24
1720061		138.06	2741821	2018-09-25	2018-09-30
1720063		713.31	2760013	2018-10-01	2018-10-31
1720064		690.30	2777706	2018-11-01	2018-11-30
1720065		713.31	2803261	2018-12-01	2018-12-31
1720066		713.31	2821950	2019-01-01	2019-01-31
1720067		644.28	2839349	2019-02-01	2019-02-28
1720068		713.31	2857489	2019-03-01	2019-03-31
1720069		690.30	2876295	2019-04-01	2019-04-30
1720070		713.31	2895030	2019-05-01	2019-05-31
1720071		690.30	2915090	2019-06-01	2019-06-30
1720072		713.31	2933536	2019-07-01	2019-07-31
1720073		713.31	2951904	2019-08-01	2019-08-31
1720075		552.24	2970500	2019-09-01	2019-09-24
1720074		138.06	2970499	2019-09-25	2019-09-30
1720076		713.31	2988121	2019-10-01	2019-10-31
1720077		690.30	3004947	2019-11-01	2019-11-30
1720078		713.31	3021953	2019-12-01	2019-12-31
1720079		713.31	3038949	2020-01-01	2020-01-31
1720080		667.29	3055196	2020-02-01	2020-02-29
1720081		713.31	3071851	2020-03-01	2020-03-31
1720082		690.30	3085528	2020-04-01	2020-04-30
1720083		713.31	3096514	2020-05-01	2020-05-31
1720084		690.30	3102863	2020-06-01	2020-06-30
1720085		713.31	4017285	2020-07-01	2020-07-31
1720086		713.31	4032651	2020-08-01	2020-08-31
1720088		552.24	4049585	2020-09-01	2020-09-24
1720087		138.06	4049584	2020-09-25	2020-09-30
1720089		713.31	4071077	2020-10-01	2020-10-31
1720090		690.30	4087293	2020-11-01	2020-11-30
1720091		713.31	4103184	2020-12-01	2020-12-31
1720092		713.31	4118875	2021-01-01	2021-01-31
1720093		644.28	4134543	2021-02-01	2021-02-28
1720094		713.31	4151221	2021-03-01	2021-03-31
1720095		690.30	4167053	2021-04-01	2021-04-30
1720096		713.31	4192051	2021-05-01	2021-05-31
1720010		690.30	4208973	2021-06-01	2021-06-30
1720009		713.31	4226130	2021-07-01	2021-07-31
1720008		713.31	4243197	2021-08-01	2021-08-31
*/

-- Total AR: $58698.51 
-- Delete $58146.27
-- No Fix for Rec Detl ID: 1720007 - $552.24 - 4259741	2021-09-01	2021-09-24

-- Data fix to delete ARs 
select collection_status_id, collection_status_cd, collection_status_dt, delete_sw, update_ts, update_user_id 
	from tb_receivable_collection_status 
where delete_sw = 'N'
	and receivable_detail_id in ( 
		1720011, 1720012, 1720013, 1720014, 1720015, 1720016, 1720017, 1720018, 1720019, 1720020, 
		1720021, 1720023, 1720022, 1720024, 1720025, 1720026, 1720027, 1720028, 1720029, 1720030, 
		1720031, 1720032, 1720033, 1720034, 1720036, 1720035, 1720037, 1720038, 1720039, 1720040, 
		1720041, 1720042, 1720043, 1720044, 1720045, 1720046, 1720047, 1720049, 1720048, 1720050, 
		1720051, 1720052, 1720053, 1720054, 1720055, 1720056, 1720057, 1720058, 1720059, 1720060, 
		1720062, 1720061, 1720063, 1720064, 1720065, 1720066, 1720067, 1720068, 1720069, 1720070, 
		1720071, 1720072, 1720073, 1720075, 1720074, 1720076, 1720077, 1720078, 1720079, 1720080, 
		1720081, 1720082, 1720083, 1720084, 1720085, 1720086, 1720088, 1720087, 1720089, 1720090, 
		1720091, 1720092, 1720093, 1720094, 1720095, 1720096, 1720010, 1720009, 1720008
		);

update tb_receivable_collection_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-17899'
where delete_sw = 'N'
	and receivable_detail_id in ( 
		1720011, 1720012, 1720013, 1720014, 1720015, 1720016, 1720017, 1720018, 1720019, 1720020, 
		1720021, 1720023, 1720022, 1720024, 1720025, 1720026, 1720027, 1720028, 1720029, 1720030, 
		1720031, 1720032, 1720033, 1720034, 1720036, 1720035, 1720037, 1720038, 1720039, 1720040, 
		1720041, 1720042, 1720043, 1720044, 1720045, 1720046, 1720047, 1720049, 1720048, 1720050, 
		1720051, 1720052, 1720053, 1720054, 1720055, 1720056, 1720057, 1720058, 1720059, 1720060, 
		1720062, 1720061, 1720063, 1720064, 1720065, 1720066, 1720067, 1720068, 1720069, 1720070, 
		1720071, 1720072, 1720073, 1720075, 1720074, 1720076, 1720077, 1720078, 1720079, 1720080, 
		1720081, 1720082, 1720083, 1720084, 1720085, 1720086, 1720088, 1720087, 1720089, 1720090, 
		1720091, 1720092, 1720093, 1720094, 1720095, 1720096, 1720010, 1720009, 1720008
		);
		

select receivable_detail_id, payment_detail_id, delete_sw, update_ts, update_user_id 
	from tb_receivable_detail 
where delete_sw = 'N'
	and receivable_detail_id in ( 
		1720011, 1720012, 1720013, 1720014, 1720015, 1720016, 1720017, 1720018, 1720019, 1720020, 
		1720021, 1720023, 1720022, 1720024, 1720025, 1720026, 1720027, 1720028, 1720029, 1720030, 
		1720031, 1720032, 1720033, 1720034, 1720036, 1720035, 1720037, 1720038, 1720039, 1720040, 
		1720041, 1720042, 1720043, 1720044, 1720045, 1720046, 1720047, 1720049, 1720048, 1720050, 
		1720051, 1720052, 1720053, 1720054, 1720055, 1720056, 1720057, 1720058, 1720059, 1720060, 
		1720062, 1720061, 1720063, 1720064, 1720065, 1720066, 1720067, 1720068, 1720069, 1720070, 
		1720071, 1720072, 1720073, 1720075, 1720074, 1720076, 1720077, 1720078, 1720079, 1720080, 
		1720081, 1720082, 1720083, 1720084, 1720085, 1720086, 1720088, 1720087, 1720089, 1720090, 
		1720091, 1720092, 1720093, 1720094, 1720095, 1720096, 1720010, 1720009, 1720008
		);

update tb_receivable_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-17899'
where delete_sw = 'N'
	and receivable_detail_id in ( 
		1720011, 1720012, 1720013, 1720014, 1720015, 1720016, 1720017, 1720018, 1720019, 1720020, 
		1720021, 1720023, 1720022, 1720024, 1720025, 1720026, 1720027, 1720028, 1720029, 1720030, 
		1720031, 1720032, 1720033, 1720034, 1720036, 1720035, 1720037, 1720038, 1720039, 1720040, 
		1720041, 1720042, 1720043, 1720044, 1720045, 1720046, 1720047, 1720049, 1720048, 1720050, 
		1720051, 1720052, 1720053, 1720054, 1720055, 1720056, 1720057, 1720058, 1720059, 1720060, 
		1720062, 1720061, 1720063, 1720064, 1720065, 1720066, 1720067, 1720068, 1720069, 1720070, 
		1720071, 1720072, 1720073, 1720075, 1720074, 1720076, 1720077, 1720078, 1720079, 1720080, 
		1720081, 1720082, 1720083, 1720084, 1720085, 1720086, 1720088, 1720087, 1720089, 1720090, 
		1720091, 1720092, 1720093, 1720094, 1720095, 1720096, 1720010, 1720009, 1720008
		);
		   
-- 	Update Provider AR Balances & Payment Plan		   
select rh.balance_no 
	  ,coalesce(( select sum(rd.receivable_balance_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0) as calculated_balance_no 
	 ,rh.receivable_original_amount_no 
	 ,coalesce(( select sum(rd.amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0) as calculated_original_amount_no
	,rh.written_off_amount_no
	,coalesce(( select sum(rd.written_off_amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0) as written_off_amount_no
	,rh.update_ts 
	,rh.update_user_id 
from  tb_receivable_header rh
where rh.delete_sw = 'N'  
	and rh.receivable_id = 1245169 ;
	
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
	rh.update_user_id = 'CDM-17899'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 1245169 ;
		 
-- 	Update Payment Plan
select pp.payment_plan_id
	,pp.current_receivable_amount 
	,coalesce(( select sum(rd.receivable_balance_no)       
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
			    ),0) as calculated_current_receivable_amount
    ,pp.amount_no 
	,coalesce(((( select sum(rd.receivable_balance_no)       
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
			    ) * pp.percentage_no ) / 100 ),0) as calculated_amount_no
    ,pp.update_ts
	,pp.update_user_id
from tb_payment_plan pp	
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1245169 ;
	
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
	pp.update_user_id = 'CDM-17899'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1245169 ;
