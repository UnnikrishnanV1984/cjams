-- CDM-36952 - Aoption Change of Provider and AR
/*
-- Issue Description: 
   To fix Adoption Subsidy Case data and generate payments for the new Provider.
   
-- Baltimore County	ann.brown@maryland.gov
-- Adoption Case ID: 231040045476
-- Client ID: 201013308	(NATHAN Turner) - 2ba0e790-9b5f-44a5-b32e-af46087c2674
-- Adoption iD: 1051691 2022-11-29 To 2037-02-02 - 83551432-6206-4ed4-bc00-1ca0d4ff9a7b
-- New Provider ID: 6104908	(Spenser Turner)  - 07/01/2023 to  ...
-- Old Provider ID: 6002076	(Brittany Turner) - 11/29/2022 to 06/30/2023

-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: Exception scenario, user has changed the Provider on Agreement after the next year's rate apporval 
-- Fix Provided: DataFix has been promoted to fix Adoption Subsidy Case data and remove all on-hold payment & ARs
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete All On HOLD Payments for the old Provider
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id in ( 3947634, 3855408, 3855408, 3773368, 3716003, 3638835 )
	and delete_sw  = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-36952'
where payment_id in ( 3947634, 3855408, 3855408, 3773368, 3716003, 3638835 )
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id in ( 3947634, 3855408, 3855408, 3773368, 3716003, 3638835 )
	and delete_sw  = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-36952'
where payment_id in ( 3947634, 3855408, 3855408, 3773368, 3716003, 3638835 )
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in ( 3947634, 3855408, 3855408, 3773368, 3716003, 3638835 )
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-36952'
where payment_id in ( 3947634, 3855408, 3855408, 3773368, 3716003, 3638835 )
	and delete_sw = 'N' ;
	

-- Delete corresponding one AR
select receivable_detail_id, receivable_id, payment_detail_id, amount_no , delete_sw, update_ts, update_user_id 
	from tb_receivable_detail 
where receivable_detail_id in (1741437, 1741438)
	and delete_sw  = 'N' ;

update tb_receivable_detail
set  delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-36952'
where receivable_detail_id in (1741437, 1741438)
	and delete_sw  = 'N' ;
	
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
	update_user_id = 'CDM-36952'
where rh.receivable_id = 1252028
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
	update_user_id = 'CDM-36952'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1252028 ;
	
-- Update Effective Switch Date
select switchproviderreason, effectiveswitchdate, updatedby, updatedon
from adoptioncaseagreement  
where adoptioncaseid = '83551432-6206-4ed4-bc00-1ca0d4ff9a7b' ;

update adoptioncaseagreement  
set effectiveswitchdate = '2023-06-30 04:00:00.000',
	updatedby = 'CDM-36952', 
	updatedon = now()	
where adoptioncaseid = '83551432-6206-4ed4-bc00-1ca0d4ff9a7b' ;
	
-- Fix Rate end date for the Old provider 
select provider_id, startdate, enddate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate   
where adoptionagreementrateid = '14c0d74d-74ec-4ab6-9136-db04fde71d81' ;

update adoptioncaseagreementrate
set enddate = '2023-06-30 10:00:00.000',
	updatedby = 'CDM-36952', 
	updatedon = now()
where adoptionagreementrateid = '14c0d74d-74ec-4ab6-9136-db04fde71d81' ;	

-- Add Suspension 
INSERT INTO cjams.adoptioncasesuspension
(adoptionsuspensionid, adoptioncaseid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, etl_userid, etl_load_date)
VALUES('9f19a51b-3be8-4fdf-847b-01658f2680a1'::uuid, '83551432-6206-4ed4-bc00-1ca0d4ff9a7b'::uuid, now(), 'OTHR', '2023-07-01 04:00:00.000', NULL, 'To create AR for July 2023 payment which was returned by the provider.  ', '3047', now(), NULL, now(), 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', now(), 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', 1, now(), NULL, NULL, NULL, 'cba3bbde-c3bd-4d1b-9c02-1c6d32d8569e'::uuid, NULL, NULL);
INSERT INTO cjams.adoptioncasesuspension
(adoptionsuspensionid, adoptioncaseid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, etl_userid, etl_load_date)
VALUES('3a7de2bf-d786-4315-84cf-d794a6e5c728'::uuid, '83551432-6206-4ed4-bc00-1ca0d4ff9a7b'::uuid, now(), 'OTHR', '2023-07-01 04:00:00.000', NULL, 'To create AR for July 2023 payment which was returned by the provider.  ', '3045', NULL, NULL, now(), '7ede7161-fee9-4f54-9aba-7ed064ba728d', now(), '7ede7161-fee9-4f54-9aba-7ed064ba728d', 0, now(), NULL, NULL, NULL, 'cba3bbde-c3bd-4d1b-9c02-1c6d32d8569e'::uuid, NULL, NULL);


INSERT INTO cjams.adoptioncasesuspensionrevision
(adoptionsuspensionrevisionid, adoptionsuspensionid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, adoptioncaseid, etl_userid, etl_load_date)
VALUES('9be1b39d-d9df-4b0f-80f9-a23de71299db'::uuid, '9f19a51b-3be8-4fdf-847b-01658f2680a1'::uuid, now(), 'OTHR', '2023-07-01 04:00:00.000', NULL, 'To create AR for July 2023 payment which was returned by the provider.  ', '3047', now(), NULL, now(), 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', now(), 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', 1, now(), NULL, NULL, NULL, 'cba3bbde-c3bd-4d1b-9c02-1c6d32d8569e'::uuid, '83551432-6206-4ed4-bc00-1ca0d4ff9a7b'::uuid, NULL, NULL);

INSERT INTO cjams.adoptioncasesuspensionrevision
(adoptionsuspensionrevisionid, adoptionsuspensionid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, adoptioncaseid, etl_userid, etl_load_date)
VALUES('ffa89351-0e7f-41d5-ab0a-b1e0a5712120'::uuid, '3a7de2bf-d786-4315-84cf-d794a6e5c728'::uuid, now(), 'OTHR', '2023-07-01 04:00:00.000', NULL, 'To create AR for July 2023 payment which was returned by the provider.  ', '3045', now(), NULL, now(), '7ede7161-fee9-4f54-9aba-7ed064ba728d', now(), '7ede7161-fee9-4f54-9aba-7ed064ba728d', 0, now(), NULL, NULL, NULL, 'cba3bbde-c3bd-4d1b-9c02-1c6d32d8569e'::uuid, '83551432-6206-4ed4-bc00-1ca0d4ff9a7b'::uuid, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('aa3dadb4-1306-4725-8cb3-91dc5a9c39e1'::uuid, 'ADSR', 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', '7ede7161-fee9-4f54-9aba-7ed064ba728d', '945a7955-d865-4520-abb0-b908b31db7c8'::uuid, 'CWSP', 'CWCW', '3a7de2bf-d786-4315-84cf-d794a6e5c728', 16, 0, 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', now(), 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', now(), true, 'Adoption Suspension Approved', NULL, 'Adoption Suspension Approved', '231040045476', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('7b7b0afc-e767-4155-8a14-4fcbbba7b401'::uuid, 'ADSR', '7ede7161-fee9-4f54-9aba-7ed064ba728d', 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', '945a7955-d865-4520-abb0-b908b31db7c8'::uuid, 'CWCW', 'CWSP', '3a7de2bf-d786-4315-84cf-d794a6e5c728', 15, 0, '7ede7161-fee9-4f54-9aba-7ed064ba728d', now(), 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', now(), true, 'Adoption Case Suspension Submitted for review', NULL, 'Adoption Case Suspension Submitted for review', '231040045476', 'Adoptioncase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Delete recent incorrect rate slab
delete from adoptioncaseagreementrate   
where adoptionagreementrateid = '08d8cf05-c80b-4dda-a6c0-f14a13469cca' ;

delete from adoptioncaserevision 
where adoptionagreementrateid = '08d8cf05-c80b-4dda-a6c0-f14a13469cca' ;
 	

/*
-- To revert if nedded 

INSERT INTO cjams.adoptioncaseagreementrate
(adoptionagreementrateid, adoptionagreementid, startdate, enddate, provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, parent1actorid, parent2actorid, childrelationship, notes, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES('08d8cf05-c80b-4dda-a6c0-f14a13469cca'::uuid, 'cba3bbde-c3bd-4d1b-9c02-1c6d32d8569e'::uuid, '2023-11-29 15:00:00.000', '2023-08-01 04:00:00.000', 6002076, 887, NULL, '2024-02-01 08:25:26.518', NULL, NULL, NULL, NULL, NULL, 1, '2023-11-17 15:52:00.000', 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', '2023-11-17 15:52:26.364', '5ccbd09e-bff1-44b1-b980-52ca4a411f6a', '2024-02-01 08:25:26.518', NULL, NULL, NULL, '2023-11-17 20:51:46.178', NULL, 'Approved', NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.adoptioncaserevision
(adoptionrevisionid, adoptionagreementid, transactiondate, agreementtypetypekey, adoptivemotherid, adoptivefatherid, startdate, enddate, paymentamout, notes, isssaapproved, ssaapproveddate, isspeacialneeds, specialneedtypekey, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, provider_id, alternateid, adoptionagreementrateid, old_id, etl_userid, etl_load_date, isapproval, parent1providername, parent2providername, childrelationship, effectivedate, specialneedremarks, rateoverwrittensw, status)
VALUES('bff9acbb-5f25-422f-93a4-689a3f534c54'::uuid, 'cba3bbde-c3bd-4d1b-9c02-1c6d32d8569e'::uuid, '2023-11-17 20:51:46.178', NULL, NULL, NULL, '2023-11-29 15:00:00.000', '2024-11-28 10:00:00.000', 887, NULL, NULL, NULL, NULL, NULL, '3047', '2023-11-17 15:52:26.364', NULL, '2023-11-17 15:52:26.364', 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', '2023-11-17 15:52:26.364', 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', 1, 6002076, 1242398, '08d8cf05-c80b-4dda-a6c0-f14a13469cca'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-11-17 15:52:00.000', NULL, NULL, 'Approved');
INSERT INTO cjams.adoptioncaserevision
(adoptionrevisionid, adoptionagreementid, transactiondate, agreementtypetypekey, adoptivemotherid, adoptivefatherid, startdate, enddate, paymentamout, notes, isssaapproved, ssaapproveddate, isspeacialneeds, specialneedtypekey, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, provider_id, alternateid, adoptionagreementrateid, old_id, etl_userid, etl_load_date, isapproval, parent1providername, parent2providername, childrelationship, effectivedate, specialneedremarks, rateoverwrittensw, status)
VALUES('a431c1fe-21da-404f-a3e0-8bd8e6f9a075'::uuid, 'cba3bbde-c3bd-4d1b-9c02-1c6d32d8569e'::uuid, '2023-11-17 20:51:46.178', NULL, NULL, NULL, '2023-11-29 15:00:00.000', '2024-11-28 10:00:00.000', 887, NULL, NULL, NULL, NULL, NULL, '3045', NULL, NULL, '2023-11-17 15:52:00.000', '7ede7161-fee9-4f54-9aba-7ed064ba728d', '2023-11-17 15:52:26.364', 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', 0, 6002076, 1242365, '08d8cf05-c80b-4dda-a6c0-f14a13469cca'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-11-17 15:52:00.000', NULL, NULL, 'Review');

*/	
	
