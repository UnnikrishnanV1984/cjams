-- CDM-19154 - Duplicate vendor
/*
-- Issue Description: 
   Reequest to delete the duplicate purchase authorizations 
   
-- Case ID: 211030009325
-- Client ID: 3942671 (ADYSON MORELAND) - 108c0d1d-9496-46d5-a6f1-b297f6ea22fd
-- Service Log ID: 2018243 - Birth Certificate (Paid)
-- Provider ID: 5026062 (Vitalchek)
   
-- Case ID: 211030012574
-- Service Log ID: 2025221 - 2021-12-14	To 2021-12-17 - Clothing Purchase (Paid)
-- Provider ID: 5005960	(Gabriel Brothers, Inc.)
-- Duplicate Authorization ID: 1810130 ( Other Authorization ID: 1810131) 

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: TDB (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Soft_delete the requested Duplucate Service Purchase Authorization
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id = 1810130
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-19154'
where authorization_id = 1810130
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

-- Delete duplicate routing records for Approved Auth ID: 1810131
-- 1	39	Forwarded to Case Supervisor	52cd2dae-1e30-462b-ace0-44cfbf6a588c	PCAUTH
select *
	from routing 
where routingid = '52cd2dae-1e30-462b-ace0-44cfbf6a588c'
	and objectid = '1810131'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;


delete from routing   
where routingid = '52cd2dae-1e30-462b-ace0-44cfbf6a588c'
	and objectid = '1810131'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;

-- should be dynamic
-- 1	40	Forwarded to Funding Approval	0e33924b-5782-474e-9a54-77edbe396dea	PCAUTHR
-- 1	40	Forwarded to Funding Approval	76564c71-ef59-4215-bef0-c25ca7d4be1d	PCAUTHR
select *
	from routing 
where routingid in ( '0e33924b-5782-474e-9a54-77edbe396dea', 
						  '76564c71-ef59-4215-bef0-c25ca7d4be1d' 
						)
	and objectid = '1810131'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;

select *
	from routing 
where routingid = '0e33924b-5782-474e-9a54-77edbe396dea'
	and objectid = '1810131'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 
	and (select count(*)
			from routing 
		 where routingid in ( '0e33924b-5782-474e-9a54-77edbe396dea', 
							  '76564c71-ef59-4215-bef0-c25ca7d4be1d' 
							 )		 
			and objectid = '1810131'
			and eventcode in ( 'PCAUTHR', 'PCAUTH' )
			and activeflag = 1 
		) = 2 ;
	
delete from routing   
where routingid = '0e33924b-5782-474e-9a54-77edbe396dea'
	and objectid = '1810131'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 
	and (select count(*)
			from routing 
		 where routingid in ( '0e33924b-5782-474e-9a54-77edbe396dea', 
							  '76564c71-ef59-4215-bef0-c25ca7d4be1d' 
							)		 
			and objectid = '1810131'
			and eventcode in ( 'PCAUTHR', 'PCAUTH' )
			and activeflag = 1 
		) = 2 ;

select *
	from routing 
where routingid = '76564c71-ef59-4215-bef0-c25ca7d4be1d'
	and objectid = '1810131'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 
	and (select count(*)
			from routing 
		 where routingid in ( '0e33924b-5782-474e-9a54-77edbe396dea', 
							  '76564c71-ef59-4215-bef0-c25ca7d4be1d' 
							)		 
			and objectid = '1810131'
			and eventcode in ( 'PCAUTHR', 'PCAUTH' )
			and activeflag = 1 
		) = 2 ;	
	 
delete from routing   
where routingid = '76564c71-ef59-4215-bef0-c25ca7d4be1d'
	and objectid = '1810131'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 
	and (select count(*)
			from routing 
		 where routingid in ( '0e33924b-5782-474e-9a54-77edbe396dea', 
						  '76564c71-ef59-4215-bef0-c25ca7d4be1d' 
						)		 
		and objectid = '1810131'
		and eventcode in ( 'PCAUTHR', 'PCAUTH' )
		and activeflag = 1 
     ) = 2 ;		 

delete from routing   
where routingstatustypeid = 40 
		and objectid = '1810131'
		and eventcode in ( 'PCAUTHR', 'PCAUTH' )
		and activeflag = 1 
		and ( select count(*) 
				from routing 
			  where objectid = '1810131'
				and eventcode in ( 'PCAUTHR', 'PCAUTH' )
				and activeflag = 0 
				and routingstatustypeid = 40 
			) > 0 ;

select *
	from routing 
where routingid in ( '0e33924b-5782-474e-9a54-77edbe396dea', 
						  '76564c71-ef59-4215-bef0-c25ca7d4be1d' 
						)
	and objectid = '1810131'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;


/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('52cd2dae-1e30-462b-ace0-44cfbf6a588c'::uuid, 'PCAUTH', 'be997f35-227d-417f-a4d5-2df232639a24', '68ded231-16ad-4c93-a496-273eb0a62c02', '5331ba88-f394-4423-a641-0af2dc6fbc0a'::uuid, 'CWCW', 'CWSP', '1810131', 39, 1, 'be997f35-227d-417f-a4d5-2df232639a24', '2021-12-14 11:19:12.039', 'be997f35-227d-417f-a4d5-2df232639a24', '2021-12-14 11:19:12.039', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '211030012574', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('0e33924b-5782-474e-9a54-77edbe396dea'::uuid, 'PCAUTHR', '68ded231-16ad-4c93-a496-273eb0a62c02', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1810131', 40, 1, '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-12-14 11:33:28.099', '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-12-14 11:33:28.099', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '211030012574', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('76564c71-ef59-4215-bef0-c25ca7d4be1d'::uuid, 'PCAUTHR', '68ded231-16ad-4c93-a496-273eb0a62c02', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1810131', 40, 1, '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-12-14 11:32:50.171', '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-12-14 11:32:50.171', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '211030012574', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
