-- CDM-14410 - CJAMS A/R Balance Discrepancy
/*
-- Issue Description: 
   Provider ID: 5042070 (Debra Brooks) - A/R Balance Discrepancy Issue
   Receivable Detail ID: 1718527 - $874.80
   
-- Category/ Module: Accounts Receivables (Finance Management) 
-- Root cause: Finance Draft payment batch run on May 1st had errors and duplicate payments got generated.
-- Datafix was deployed in production to remove those duplicate payment details and this fix is to remove the corresponding ARs.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
--	Rec ID	Provide	Rec 	AR 		Payment 
--			ID		Detl ID Amount	Detail ID
-----------------------------------------------------
--	1245048	5000115	1718499	461.52	4168929
--	1245058	5001083	1718510	823.50	4168976
--	1245058	5001083	1718509	823.50	4168978
--	1245052	5011935	1718503	626.40	4169919
--	1245049	5012980	1718500	576.90	4169989
--	1245065	5013189	1718520	823.50	4174325
--	1245051	5014016	1718502	576.90	4170144
--	1245055	5014870	1718506	823.50	4170378
--	243780	5015236	1718526	856.20	4174389
--	1245054	5017827	1718505	838.50	4170587
--	1245056	5018825	1718507	823.50	4170660
--	1245053	5020061	1718504	724.80	4170740
--	1245057	5021833	1718508	823.50	4170908
--	1245050	5021871	1718501	576.90	4170910
--	1245062	5027171	1718516	576.90	4174534
--	242900	5032908	1718518	823.50	4174670
--	1245060	5037521	1718512	823.50	4171822
--	1245059	5037640	1718511	936.90	4171826
--	1245063	5040381	1718517	823.50	4174810
--	1244970	5042070	1718527	874.80	4174860 - Debra Brooks
--	1245064	5046175	1718519	823.50	4174980
--	243320	5066423	1718513	823.50	4172982
--	1245066	5068925	1718521	951.90	4175817
--	1245009	5068932	1718522	411.75	4175819
--	1245067	5077341	1718523	823.50	4176133
--	1244910	5082592	1718514	874.80	4173698
--	244815	5082976	1718524	157.36	4176428
--	1245068	5083142	1718525	493.20	4176436
--	1245061	5094116	1718515	233.28	4174126


-- Data fix to delete ARs where corresponding Payment has been deleted on May 13th fix
select collection_status_id, collection_status_cd, collection_status_dt, delete_sw, update_ts, update_user_id 
	from tb_receivable_collection_status 
where delete_sw = 'N'
	and receivable_detail_id 
		in ( 1718499, 1718510, 1718509, 1718503, 1718500, 1718520, 1718502, 1718506, 1718526, 1718505,
			 1718507, 1718504, 1718508, 1718501, 1718516, 1718518, 1718512, 1718511, 1718517, 1718527,
			 1718519, 1718513, 1718521, 1718522, 1718523, 1718514, 1718524, 1718525, 1718515 
		   );

update tb_receivable_collection_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-14410'
where delete_sw = 'N'
	and receivable_detail_id 
		in ( 1718499, 1718510, 1718509, 1718503, 1718500, 1718520, 1718502, 1718506, 1718526, 1718505,
			 1718507, 1718504, 1718508, 1718501, 1718516, 1718518, 1718512, 1718511, 1718517, 1718527,
			 1718519, 1718513, 1718521, 1718522, 1718523, 1718514, 1718524, 1718525, 1718515 
		   );
		

select receivable_detail_id, payment_detail_id, delete_sw, update_ts, update_user_id 
	from tb_receivable_detail 
where delete_sw = 'N'
	and receivable_detail_id 
		in ( 1718499, 1718510, 1718509, 1718503, 1718500, 1718520, 1718502, 1718506, 1718526, 1718505,
			 1718507, 1718504, 1718508, 1718501, 1718516, 1718518, 1718512, 1718511, 1718517, 1718527,
			 1718519, 1718513, 1718521, 1718522, 1718523, 1718514, 1718524, 1718525, 1718515 
		   ) ;

update tb_receivable_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-14410'
where delete_sw = 'N'
	and receivable_detail_id 
		in ( 1718499, 1718510, 1718509, 1718503, 1718500, 1718520, 1718502, 1718506, 1718526, 1718505,
			 1718507, 1718504, 1718508, 1718501, 1718516, 1718518, 1718512, 1718511, 1718517, 1718527,
			 1718519, 1718513, 1718521, 1718522, 1718523, 1718514, 1718524, 1718525, 1718515 
		   );

		   
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
	rh.update_user_id = 'CDM-14410'
where rh.delete_sw = 'N'  
	and rh.receivable_id 
		in (	1245048, 1245058, 1245052, 1245049, 1245065, 1245051, 1245055, 243780, 1245054, 1245056, 
				1245053, 1245057, 1245050, 1245062, 242900, 1245060 ,1245059 ,1245063, 1244970, 1245064,
				243320, 1245066, 1245009 ,1245067, 1244910, 244815, 1245068 ,1245061
		   );

		 
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
	pp.update_user_id = 'CDM-14410'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id 
		in (	1245048, 1245058, 1245052, 1245049, 1245065, 1245051, 1245055, 243780, 1245054, 1245056, 
				1245053, 1245057, 1245050, 1245062, 242900, 1245060 ,1245059 ,1245063, 1244970, 1245064,
				243320, 1245066, 1245009 ,1245067, 1244910, 244815, 1245068 ,1245061
		   );

