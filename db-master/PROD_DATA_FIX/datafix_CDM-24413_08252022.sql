-- CDM-24413 - Payment Adjustment (Manual Adjustment Check to Wrong Local Dept)
/*
-- Issue Description: 
   CJAMS is fowrding the Manual Adjustment Check to Wrong Local Dept
      
-- Baltimore County user's (Joseph LeCompte) request is going to Baltimore City.

-- Case ID: 3236290
-- Client ID: 4401249 (KINSLEY S REEVES) - cd408513-ab28-4a99-a6af-f625f6d2459c
-- Authorization ID: 1844959 - 1430 - Baltimore County
-- Provider ID: 6002710 (Karl Stewart) - Local Department Home
  
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Original payment selection SP was returing the worng County code.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Next prod deployment
*/

-- Generic datafix for pending Manual Adjustments to Wrong Local Dept  
-- Before 
select ph.payment_id,
	ph.authorization_id,
	pd.county_cd,
	(select pd1.county_cd 
		from tb_payment_header ph1,
			tb_payment_detail pd1
		where ph1.payment_id = pd1.payment_id
			and ph1.delete_sw = 'N'
			and pd1.delete_sw = 'N'
			and ph1.authorization_id = ph.authorization_id
			and coalesce(ph1.manual_sw, '') <> 'Y'
	) as correct_county_cd
from tb_payment_header ph,
	tb_payment_status ps,
	tb_payment_detail pd
where ph.payment_id = ps.payment_id
	and ph.payment_id = pd.payment_id
	and ph.manual_sw = 'Y'
	and ph.payment_type_cd = '3294'
	and ph.authorization_id > 0
	and ph.delete_sw = 'N'
	and ps.payment_status_cd = '1637'
	and pd.county_cd 
	<> (select pd1.county_cd 
		from tb_payment_header ph1,
			tb_payment_detail pd1
		where ph1.payment_id = pd1.payment_id
			and ph1.delete_sw = 'N'
			and pd1.delete_sw = 'N'
			and ph1.authorization_id = ph.authorization_id
			and coalesce(ph1.manual_sw, '') <> 'Y'
	) 
order by ph.payment_id desc ;


select pd2.payment_detail_id , pd2.payment_id, pd2.county_cd, pd2.update_ts, pd2.update_user_id
	,(select pd1.county_cd 
				from tb_payment_header ph1,
					tb_payment_detail pd1
				where ph1.payment_id = pd1.payment_id
					and ph1.delete_sw = 'N'
					and pd1.delete_sw = 'N'
					and ph1.authorization_id 
						= (  select ph2.authorization_id
								from tb_payment_header ph2
							 where ph2.delete_sw  = 'N'
								and ph2.payment_id = pd2.payment_id 
							 )
					and coalesce(ph1.manual_sw, '') <> 'Y'
			) 
	from tb_payment_detail pd2
where pd2.delete_sw  = 'N'
	and pd2.payment_id 
		in (
				select ph.payment_id
				from tb_payment_header ph,
					tb_payment_status ps,
					tb_payment_detail pd
				where ph.payment_id = ps.payment_id
					and ph.payment_id = pd.payment_id
					and ph.manual_sw = 'Y'
					and ph.payment_type_cd = '3294'
					and ph.authorization_id > 0
					and ph.delete_sw = 'N'
					and ps.payment_status_cd = '1637'
					and pd.county_cd 
							<> (select pd1.county_cd 
								from tb_payment_header ph1,
									tb_payment_detail pd1
								where ph1.payment_id = pd1.payment_id
									and ph1.delete_sw = 'N'
									and pd1.delete_sw = 'N'
									and ph1.authorization_id = ph.authorization_id
									and coalesce(ph1.manual_sw, '') <> 'Y'
							) 
		);


update tb_payment_detail pd2
set pd2.county_cd 
		= (select pd1.county_cd 
				from tb_payment_header ph1,
					tb_payment_detail pd1
				where ph1.payment_id = pd1.payment_id
					and ph1.delete_sw = 'N'
					and pd1.delete_sw = 'N'
					and ph1.authorization_id 
						= (  select ph2.authorization_id
								from tb_payment_header ph2
							 where ph2.delete_sw  = 'N'
								and ph2.payment_id = pd2.payment_id 
							 )
					and coalesce(ph1.manual_sw, '') <> 'Y'
			),
	pd2.update_ts = now(), 
	pd2.update_user_id = 'CDM-24413'
where pd2.delete_sw  = 'N'
	and pd2.payment_id 
		in (select ph.payment_id
			from tb_payment_header ph,
				tb_payment_status ps,
				tb_payment_detail pd
			where ph.payment_id = ps.payment_id
				and ph.payment_id = pd.payment_id
				and ph.manual_sw = 'Y'
				and ph.payment_type_cd = '3294'
				and ph.authorization_id > 0
				and ph.delete_sw = 'N'
				and ps.payment_status_cd = '1637'
				and pd.county_cd 
				<> (select pd1.county_cd 
					from tb_payment_header ph1,
						tb_payment_detail pd1
					where ph1.payment_id = pd1.payment_id
						and ph1.delete_sw = 'N'
						and pd1.delete_sw = 'N'
						and ph1.authorization_id = ph.authorization_id
						and coalesce(ph1.manual_sw, '') <> 'Y'
					) 
			);	
