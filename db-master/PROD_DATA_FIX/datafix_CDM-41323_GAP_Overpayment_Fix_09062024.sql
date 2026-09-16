-- CDM-41323 - GAP overpayment
/*
-- Issue Description: 
	CJAMS is paying double payments for the below 3 GAP subsidies. 

-- 1)
-- Case ID: 3306858
-- Client ID: 4479125 (BRANDON S PLATER) - ab8c1a5e-ca77-48cc-a922-236cb070aeed
-- GAP ID: 1005906 - 2021-11-22 To 2041-03-08 - 4d8cc4e1-3bb0-45b4-b20c-3dc78a0e3b8b
-- Provider ID: 6003060	(Brenda Lee  Chase-Buck) 

-- 2)
-- Case ID: 3272699
-- Client ID: 4031259 (TEVIN PAUL TREGANOWAN) - 17150814-fc33-4b55-b862-afa7091bee49
-- GAP ID: 1006021 - 2022-04-01 To 2034-03-22 - 41810712-0e41-43b7-8924-3e6b9c632174
-- Provider ID: 6005497	(LYNN ANNE TOPOLANSKY)  

-- 3)
-- Case ID: 3264063
-- Client ID: 3927673 (BENTLEY S THOMPSON) - fd2f9aac-8958-40c6-bb1a-c2b349bbf197
-- GAP ID: 1005534 - 2020-09-24 To 2024-04-25 - 5d8c5a29-d0c8-4f34-a662-52b0ca0df5e9
-- Provider ID: 5082010	(Linda Clark)  
  
-- Root cause: Data issue, the GAP agreement table is having duplicate records. This error happened on 11/08/2021. 
-- Fix Provided: Datafix has been promoted to remove the duplicate GAP agreement records and to create Account Receivables for the duplicate payments.
-- Regression Impacts: GAP setup in CJAMS. 
-- Is Code fix Required?: TDB
--	Code fix ticket#: TBD
--	Reason why no related code fix: TBD

*/

-- To fix the GAP overpayment error (CDM-41323)

delete from tb_receivable_header where create_user_id = 'CDM-41323';
delete from tb_receivable_detail where create_user_id = 'CDM-41323';
delete from tb_receivable_collection_status where create_user_id = 'CDM-41323';

delete from tb_payment_plan where create_user_id = 'CDM-41323';
delete from tb_receivable_collection_status where create_user_id = 'CDM-41323';

delete from tb_ticklers where create_user_id = 'CDM-41323';

-- 1)
-- Case ID: 3306858
-- Client ID: 4479125 (BRANDON S PLATER) - ab8c1a5e-ca77-48cc-a922-236cb070aeed
-- GAP ID: 1005906 - 2021-11-22 To 2041-03-08 - 4d8cc4e1-3bb0-45b4-b20c-3dc78a0e3b8b
-- Provider ID: 6003060	(Brenda Lee  Chase-Buck) 

-- delete gapagreementid = 'bcd3d57d-3e41-428a-9ea4-8c8e18cad60d'
-- delete gapagreementrateid = 'ea231eca-7666-4e5f-8008-47068ad31789'

-- Dulicate Payments
-- Craete ARs - NO data in tb_receivable_header

update gapagreement
set activeflag = 0,
	updatedby = 'CDM-41323',
	updatedon = now()
where gapagreementid = 'bcd3d57d-3e41-428a-9ea4-8c8e18cad60d'
	and activeflag = 1;

update gapagreementrevision
set activeflag = 0,
	updatedby = 'CDM-41323',
	updatedon = now()
where gapagreementid = 'bcd3d57d-3e41-428a-9ea4-8c8e18cad60d'
	and activeflag = 1;

-- No data in routing - Agreement
update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-41323',
	updatedon = now()  
where gapagreementid = 'bcd3d57d-3e41-428a-9ea4-8c8e18cad60d'
	and activeflag = 1 ;

update gapratesrevision 
set activeflag = 0,
	updatedby = 'CDM-41323',
	updatedon = now()  
where gaprateid = 'ea231eca-7666-4e5f-8008-47068ad31789'
	and activeflag = 1 ;

-- No active data in routing - Rate

-- Dulicate Payments
-- Craete ARs - NO data in tb_receivable_header
insert into tb_receivable_header
	(  	receivable_id, 
		provider_id, balance_no, receivable_original_amount_no, written_off_amount_no,
		create_ts, create_user_id, update_ts, update_user_id, delete_sw
	)
values
	(
	   SP_nextid( 'sq_receivable_header'::character varying),
	   6003060, 0.00, 0.00,  NULL,    
	   now(), 'CDM-41323', now(), 'CDM-41323','N'
	) ;


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
		(select receivable_id from tb_receivable_header where provider_id = 6003060 and delete_sw  = 'N'),
		final_amount_no,
		final_amount_no,
		'19',-- OUTSTANDING
		current_date,
		final_service_start_dt,
		final_service_end_dt,
		'N',
		'Created thru Under Over Batch',
		now(),
		'CDM-41323',
		now(),
		'CDM-41323',
		'N',
		'926', -- GAP,
		'3047',
		current_date,
		county_cd,
		now()
	from cjams.tb_payment_detail pd 
	where payment_detail_id
	in (4310352, 4326950, 4343176, 4360158, 4376180, 4393305, 4410494, 4426986, 4444262, 4460194,
		4477071, 4495721, 4495722, 4517821, 4547578, 4596374, 4630296, 4661128, 4692766, 4731438,
		4798906, 4880350, 4956360, 5014993, 5095074, 5095075, 5183767, 5270991, 5296386, 5319461,
		5370132, 5489191, 5600144, 5705055, 5801849	
		);
		

update tb_receivable_header
set balance_no 
	= (	select sum(amount_no)
			from tb_receivable_detail	
			where delete_sw = 'N'
				and payment_detail_id
				in (4310352, 4326950, 4343176, 4360158, 4376180, 4393305, 4410494, 4426986, 4444262, 4460194,
					4477071, 4495721, 4495722, 4517821, 4547578, 4596374, 4630296, 4661128, 4692766, 4731438,
					4798906, 4880350, 4956360, 5014993, 5095074, 5095075, 5183767, 5270991, 5296386, 5319461,
					5370132, 5489191, 5600144, 5705055, 5801849	
					)
	  	),
	receivable_original_amount_no
	= (	select sum(amount_no)
			from tb_receivable_detail	
			where delete_sw = 'N'
				and payment_detail_id
				in (4310352, 4326950, 4343176, 4360158, 4376180, 4393305, 4410494, 4426986, 4444262, 4460194,
					4477071, 4495721, 4495722, 4517821, 4547578, 4596374, 4630296, 4661128, 4692766, 4731438,
					4798906, 4880350, 4956360, 5014993, 5095074, 5095075, 5183767, 5270991, 5296386, 5319461,
					5370132, 5489191, 5600144, 5705055, 5801849	
					)
		)			
where provider_id = 6003060 
	and delete_sw  = 'N'; 	

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
		'CDM-41323',
		now(),
		receivable_detail_id,
		'CDM-41323',  
		'N'	
	from tb_receivable_detail	
	where delete_sw = 'N'
		and payment_detail_id
		in (4310352, 4326950, 4343176, 4360158, 4376180, 4393305, 4410494, 4426986, 4444262, 4460194,
			4477071, 4495721, 4495722, 4517821, 4547578, 4596374, 4630296, 4661128, 4692766, 4731438,
			4798906, 4880350, 4956360, 5014993, 5095074, 5095075, 5183767, 5270991, 5296386, 5319461,
			5370132, 5489191, 5600144, 5705055, 5801849	
			);
			
		
insert into tb_payment_plan 
	(	payment_plan_id, plan_dt, 
		receivable_id, 
		amount_no,
		percentage_no, months_no, start_dt, end_dt,
		offset_sw, payment_option_sw, offset_option_sw, manual_sw,
		create_ts, create_user_id, update_ts, update_user_id, delete_sw,
		current_receivable_amount
	)
values 
	(	SP_nextid('sq_payment_plan'::character varying), current_date, 
		(select receivable_id from tb_receivable_header where provider_id = 6003060 and delete_sw  = 'N'), 
		(	select sum(amount_no)
			from tb_receivable_detail	
			where delete_sw = 'N'
				and payment_detail_id
				in (4310352, 4326950, 4343176, 4360158, 4376180, 4393305, 4410494, 4426986, 4444262, 4460194,
					4477071, 4495721, 4495722, 4517821, 4547578, 4596374, 4630296, 4661128, 4692766, 4731438,
					4798906, 4880350, 4956360, 5014993, 5095074, 5095075, 5183767, 5270991, 5296386, 5319461,
					5370132, 5489191, 5600144, 5705055, 5801849	
					)
		),
		100.00,	NULL, current_date, NULL,
		NULL, 'A', NULL, 'N',
		now(), 'CDM-41323', now(), 'CDM-41323', 'N',
		(	select sum(amount_no)
				from tb_receivable_detail	
			where delete_sw = 'N'
				and payment_detail_id
				in (4310352, 4326950, 4343176, 4360158, 4376180, 4393305, 4410494, 4426986, 4444262, 4460194,
					4477071, 4495721, 4495722, 4517821, 4547578, 4596374, 4630296, 4661128, 4692766, 4731438,
					4798906, 4880350, 4956360, 5014993, 5095074, 5095075, 5183767, 5270991, 5296386, 5319461,
					5370132, 5489191, 5600144, 5705055, 5801849	
					)
		)
	);

insert into tb_receivable_collection_status
	( 	collection_status_id, 
		collection_status_cd,
		collection_status_dt,
		active_sw, create_ts, create_user_id, update_ts, receivable_detail_id, update_user_id, delete_sw
	)
select SP_nextid('sq_receivable_collection_status'::character varying),
	'780', -- Recovery
	current_date,                            
	'Y', now(), 'CDM-41323', now(), receivable_detail_id, 'CDM-41323', 'N'
from tb_receivable_detail	
where delete_sw = 'N'
	and payment_detail_id
	in (4310352, 4326950, 4343176, 4360158, 4376180, 4393305, 4410494, 4426986, 4444262, 4460194,
		4477071, 4495721, 4495722, 4517821, 4547578, 4596374, 4630296, 4661128, 4692766, 4731438,
		4798906, 4880350, 4956360, 5014993, 5095074, 5095075, 5183767, 5270991, 5296386, 5319461,
		5370132, 5489191, 5600144, 5705055, 5801849	
		) ;

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
	   'A Subsidy/GAP overpayment has occurred for the provider Brenda Lee  Chase-Buck. Send Overpayment Notice (Recovery).',
	   'S',
	   (current_date + 30),
	   (current_date + 30 ) - 30,
       '2953',
	   6003060,
	   'Brenda Lee  Chase-Buck',
	   NULL,
	   4479125,
	   current_timestamp,
	   'CDM-41323',
	   current_timestamp,
	   'CDM-41323',
	   'N',
	   '1431', -- Calvert
	   11020,
	   42,
	   '2532', -- Fiscal
	   '1431', -- Calvert
	   NULL,
	   (current_date + 30 ) + 30,
	   (select max(receivable_detail_id)
			from tb_receivable_detail	
		where delete_sw = 'N'
			and payment_detail_id
			in (4310352, 4326950, 4343176, 4360158, 4376180, 4393305, 4410494, 4426986, 4444262, 4460194,
				4477071, 4495721, 4495722, 4517821, 4547578, 4596374, 4630296, 4661128, 4692766, 4731438,
				4798906, 4880350, 4956360, 5014993, 5095074, 5095075, 5183767, 5270991, 5296386, 5319461,
				5370132, 5489191, 5600144, 5705055, 5801849	
				)
		)		,
	   1005906, -- GAP ID
	   NULL 
	 );

-- 2)
-- Case ID: 3272699
-- Client ID: 4031259 (TEVIN PAUL TREGANOWAN) - 17150814-fc33-4b55-b862-afa7091bee49
-- GAP ID: 1006021 - 2022-04-01 To 2034-03-22 - 41810712-0e41-43b7-8924-3e6b9c632174
-- Provider ID: 6005497	(LYNN ANNE TOPOLANSKY)  

-- delete gapagreementid = '99414889-2ad8-43f1-9118-aedb27d8f8d3'
-- NO GAP Rates 
-- No Dulicate Payments

update gapagreement
set activeflag = 0,
	updatedby = 'CDM-41323',
	updatedon = now()
where gapagreementid = '99414889-2ad8-43f1-9118-aedb27d8f8d3'
	and activeflag = 1;

update gapagreementrevision
set activeflag = 0,
	updatedby = 'CDM-41323',
	updatedon = now()
where gapagreementid = '99414889-2ad8-43f1-9118-aedb27d8f8d3'
	and activeflag = 1;

update routing 
set activeflag = 0,
	updatedby = 'CDM-41323',
	updatedon = now()
where objectid = '99414889-2ad8-43f1-9118-aedb27d8f8d3'
	and eventcode = 'GAAR'
	and activeflag = 1 ;

-- No GAP Rate

-- 3)
-- Case ID: 3264063
-- Client ID: 3927673 (BENTLEY S THOMPSON) - fd2f9aac-8958-40c6-bb1a-c2b349bbf197
-- GAP ID: 1005534 - 2020-09-24 To 2024-04-25 - 5d8c5a29-d0c8-4f34-a662-52b0ca0df5e9
-- Provider ID: 5082010	(Linda Clark)  

-- delete gapagreementid = '4e57e990-9680-41d3-b1ed-83ad43348ce5'
-- delete gapagreementrateid = '38656601-daa0-4784-84e1-5fcd7047ac1f'

-- No Dulicate Payments

update gapagreement
set activeflag = 0,
	updatedby = 'CDM-41323',
	updatedon = now()
where gapagreementid = '4e57e990-9680-41d3-b1ed-83ad43348ce5'
	and activeflag = 1;

update gapagreementrevision
set activeflag = 0,
	updatedby = 'CDM-41323',
	updatedon = now()
where gapagreementid = '4e57e990-9680-41d3-b1ed-83ad43348ce5'
	and activeflag = 1;

-- No data in routing - Agreement

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-41323',
	updatedon = now()  
where gapagreementid = '4e57e990-9680-41d3-b1ed-83ad43348ce5'
	and activeflag = 1 ;

update gapratesrevision 
set activeflag = 0,
	updatedby = 'CDM-41323',
	updatedon = now()  
where gaprateid = '38656601-daa0-4784-84e1-5fcd7047ac1f'
	and activeflag = 1 ;

-- No data in routing - Rate
