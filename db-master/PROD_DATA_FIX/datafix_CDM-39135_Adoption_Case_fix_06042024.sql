-- CDM-39135 - subsidy rate dates need adjusting
/*
-- Issue Description: 
   Adoption subsidy rate dates need adjusting

-- Case ID: 3225346 - brad.wofford@montgomerycountymd.gov - nathaniel.parks@montgomerycountymd.gov
-- Adoption ID: 37228 - 06/26/2013 To 04/23/2029 - f0ef9631-d992-49aa-9ff8-2b5b2734f7a2
-- Client ID: 3537928 (BAUTISTA TRIGO NAVARRO) - e9ef9d54-308c-44ce-be1e-8b509496806a
-- New  Provider ID: 6114248 (Alberto Trigo)
-- Old Provider ID: 5038235	(Ana Navarro) 
   
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to fix the Adoption Case Data for fiscal adjustments. 
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update Adoption Case Data for fiscal adjustments (CDM-39135) 

-- 1. Subsidy agreement need to revert to old provider
update adoptioncaseagreement 
set providerid = 5038235, -- NULL
	parent1providerid = 5038235, -- 6114248
	parent1providername = 'Ana Navarro', -- 'Alberto Trigo'
	-- parent2providerid = NULL,  
	-- parent2providername = NULL, 
	-- issingleparent = NULL,
	updatedby = 'CDM-39135',
	updatedon = now()
where adoptioncaseid = 'f0ef9631-d992-49aa-9ff8-2b5b2734f7a2'
	and activeflag  = 1 ;
	
	
-- 2. For last two subsidy rate slab, the provider ID need to be change to the old provider ID
-- See # 3 & 4

-- 3. change the subsidy rate end-date from 03/31/2024 to 01/31/2024
-- 6114248	2023-07-01	2024-03-31	37228	3971dd6e-4501-4410-bd96-49b514d49dcd
-- New end date 01/31/2024

update adoptioncaseagreementrate
set provider_id = 5038235,
	enddate = '2024-01-31 04:00:00.000',
	-- approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-39135'
where adoptionagreementid = 'fa4b8c9c-e7f8-493f-8055-706acfece986'
	and adoptionagreementrateid = '3971dd6e-4501-4410-bd96-49b514d49dcd'
	and activeflag = 1 ;

update adoptioncaserevision
set provider_id = 5038235,
	enddate = '2024-01-31 04:00:00.000',
	updatedon = now(), 
	updatedby = 'CDM-39135'
where adoptionagreementid = 'fa4b8c9c-e7f8-493f-8055-706acfece986'
	and adoptionagreementrateid = '3971dd6e-4501-4410-bd96-49b514d49dcd';
	
-- 4. change the subsidy rate start date from 04/01/2024 to 02/01/2024
-- 6114248	2024-04-01	2024-06-30	37228	17742251-83a2-497b-a0cc-b93117efcfe5
-- New start date  02/01/2024

update adoptioncaseagreementrate
set provider_id = 5038235,
	startdate = '2024-02-01 04:00:00.000',
	-- approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-39135'
where adoptionagreementid = 'fa4b8c9c-e7f8-493f-8055-706acfece986'
	and adoptionagreementrateid = '17742251-83a2-497b-a0cc-b93117efcfe5'
	and activeflag = 1 ;

update adoptioncaserevision
set provider_id = 5038235,
	startdate = '2024-02-01 04:00:00.000',
	updatedon = now(), 
	updatedby = 'CDM-39135'
where adoptionagreementid = 'fa4b8c9c-e7f8-493f-8055-706acfece986'
	and adoptionagreementrateid = '17742251-83a2-497b-a0cc-b93117efcfe5' ;
	
-- 5. Create a suspension starting on 02/01/2024 to 03/31/2024
INSERT INTO cjams.adoptioncasesuspensionrevision
(adoptionsuspensionrevisionid, adoptionsuspensionid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, adoptioncaseid, etl_userid, etl_load_date)
VALUES('15d62f2c-c021-4650-930e-687d84fe23dc'::uuid, '9be6e7fd-be89-46de-b671-a735740561a7'::uuid, '2024-06-04 13:42:06.109', 'OTHR', '2024-02-01 05:00:00.000', '2024-03-31 04:00:00.000', 'To create AR for the old the provider.', '3045', '2024-06-04 13:42:06.109', NULL, '2024-06-04 13:39:54.000', '27920e1e-978e-4231-a9d5-ea7323ceb413', '2024-06-04 13:42:06.109', '27920e1e-978e-4231-a9d5-ea7323ceb413', 0, '2024-06-04 13:39:54.000', NULL, NULL, NULL, 'fa4b8c9c-e7f8-493f-8055-706acfece986'::uuid, 'f0ef9631-d992-49aa-9ff8-2b5b2734f7a2'::uuid, NULL, NULL);

INSERT INTO cjams.adoptioncasesuspensionrevision
(adoptionsuspensionrevisionid, adoptionsuspensionid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, adoptioncaseid, etl_userid, etl_load_date)
VALUES('fd8e7c54-8c9b-4129-964a-b4de2d5a6032'::uuid, '71a9a29f-552d-4f52-9705-ad39e42d5edf'::uuid, '2024-06-04 13:42:06.109', 'OTHR', '2024-02-01 05:00:00.000', '2024-03-31 04:00:00.000', 'To create AR for the old the provider.', '3047', '2024-06-04 13:42:06.109', NULL, '2024-06-04 13:42:06.109', '169264bc-38d0-4925-9623-fb14dea8a599', '2024-06-04 13:42:06.109', '169264bc-38d0-4925-9623-fb14dea8a599', 1, '2024-06-04 13:39:54.000', NULL, NULL, NULL, 'fa4b8c9c-e7f8-493f-8055-706acfece986'::uuid, 'f0ef9631-d992-49aa-9ff8-2b5b2734f7a2'::uuid, NULL, NULL);


INSERT INTO cjams.adoptioncasesuspension
(adoptionsuspensionid, adoptioncaseid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, etl_userid, etl_load_date)
VALUES('9be6e7fd-be89-46de-b671-a735740561a7'::uuid, 'f0ef9631-d992-49aa-9ff8-2b5b2734f7a2'::uuid, '2024-06-04 13:39:54.000', 'OTHR', '2024-02-01 05:00:00.000', '2024-03-31 04:00:00.000', 'To create AR for the old the provider.', '3045', NULL, NULL, '2024-06-04 13:39:54.000', '27920e1e-978e-4231-a9d5-ea7323ceb413', '2024-06-04 13:42:06.109', '27920e1e-978e-4231-a9d5-ea7323ceb413', 0, '2024-06-04 13:39:54.000', NULL, NULL, NULL, 'fa4b8c9c-e7f8-493f-8055-706acfece986'::uuid, NULL, NULL);

INSERT INTO cjams.adoptioncasesuspension
(adoptionsuspensionid, adoptioncaseid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, etl_userid, etl_load_date)
VALUES('71a9a29f-552d-4f52-9705-ad39e42d5edf'::uuid, 'f0ef9631-d992-49aa-9ff8-2b5b2734f7a2'::uuid, '2024-06-04 13:39:54.000', 'OTHR', '2024-02-01 05:00:00.000', '2024-03-31 04:00:00.000', 'To create AR for the old the provider.', '3047', '2024-06-04 13:42:06.109', NULL, '2024-06-04 13:42:06.109', '169264bc-38d0-4925-9623-fb14dea8a599', '2024-06-04 13:42:06.109', '169264bc-38d0-4925-9623-fb14dea8a599', 1, '2024-06-04 13:39:54.000', NULL, NULL, NULL, 'fa4b8c9c-e7f8-493f-8055-706acfece986'::uuid, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('bf9c8c11-be1e-4744-8593-7c5062dab5a5'::uuid, 'ADSR', '27920e1e-978e-4231-a9d5-ea7323ceb413', '169264bc-38d0-4925-9623-fb14dea8a599', 'f8348f64-e5d4-4ee9-8cf4-2fe3627446fb'::uuid, 'CWSP', 'CWSP', '9be6e7fd-be89-46de-b671-a735740561a7', 15, 0, '27920e1e-978e-4231-a9d5-ea7323ceb413', '2024-06-04 13:39:09.572', '169264bc-38d0-4925-9623-fb14dea8a599', '2024-06-04 13:42:06.109', true, 'Adoption Case Suspension Submitted for review', NULL, 'Adoption Case Suspension Submitted for review', '3225346', 'Adoptioncase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('3d2f7a12-c482-4055-ac0c-fdce491f41bd'::uuid, 'ADSR', '169264bc-38d0-4925-9623-fb14dea8a599', '27920e1e-978e-4231-a9d5-ea7323ceb413', 'f8348f64-e5d4-4ee9-8cf4-2fe3627446fb'::uuid, 'CWSP', 'CWSP', '71a9a29f-552d-4f52-9705-ad39e42d5edf', 16, 1, '169264bc-38d0-4925-9623-fb14dea8a599', '2024-06-04 13:42:06.109', '169264bc-38d0-4925-9623-fb14dea8a599', '2024-06-04 13:42:06.109', true, 'Adoption Suspension Approved', NULL, 'Adoption Suspension Approved', '3225346', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('c160c1a9-4245-43f7-a7f6-395c5ea7462c'::uuid, 'ADSR', '169264bc-38d0-4925-9623-fb14dea8a599', '27920e1e-978e-4231-a9d5-ea7323ceb413', 'f8348f64-e5d4-4ee9-8cf4-2fe3627446fb'::uuid, 'CWSP', 'CWSP', '9be6e7fd-be89-46de-b671-a735740561a7', 16, 0, '169264bc-38d0-4925-9623-fb14dea8a599', '2024-06-04 13:42:06.109', '169264bc-38d0-4925-9623-fb14dea8a599', '2024-06-04 13:42:06.109', true, 'Adoption Suspension Approved', NULL, 'Adoption Suspension Approved', '3225346', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


-- 6. Delete the hold payment for March 2024 - Payment ID 4074856
update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-28824'
where payment_id = 4074856
	and delete_sw = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-28824'
where payment_id = 4074856
	and delete_sw = 'N' ;
	
update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-28824'
where payment_id = 4074856
	and delete_sw = 'N' ;