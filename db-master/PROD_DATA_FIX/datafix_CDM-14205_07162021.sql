-- CDM-14205 - Funding & Payment Approvals
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing records 

-- Authorization ID: 1768100 
-- Case ID: 3295796  
-- Client ID: 4307033 (EMELI LOPEZHERNANDEZ) - 7a79f46d-971d-4179-9e21-f91cac3174fe
   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
-- 1	40	Forwarded to Funding Approval	52a36494-161b-44ac-885a-b96777cdcd95
-- 1	41	Forwarded to Payment Approval	b210d7ce-29f1-4928-9084-444f1fe6b7dc
-- 0	43	Approved						9c98cfc8-bfde-4e76-b245-eae567541c15

select *
	from routing 
where routingid in ('52a36494-161b-44ac-885a-b96777cdcd95',
					'b210d7ce-29f1-4928-9084-444f1fe6b7dc',
					'9c98cfc8-bfde-4e76-b245-eae567541c15'
					)	
	and objectid = '1768100'
	and activeflag = 1 ;
	
select eventcode, objectid, routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing 
where routingid in ('52a36494-161b-44ac-885a-b96777cdcd95',
					'b210d7ce-29f1-4928-9084-444f1fe6b7dc',
					'9c98cfc8-bfde-4e76-b245-eae567541c15'
					)	
	and objectid = '1768100'
	and activeflag = 1 ;

delete from routing   
where routingid in ('52a36494-161b-44ac-885a-b96777cdcd95',
					'b210d7ce-29f1-4928-9084-444f1fe6b7dc',
					'9c98cfc8-bfde-4e76-b245-eae567541c15'
					)	
	and objectid = '1768100' ;

