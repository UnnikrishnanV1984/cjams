-- CDM-15108 - Log 1785265
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing records 

-- Authorization ID: 1785265 
-- Case ID: 3295661 & Client ID: 200653114
   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
-- 39	Forwarded to Case Supervisor	256d856c-1428-4dbb-9115-8536956b1301
-- 40	Forwarded to Funding Approval	d3309f98-02e9-4279-a29e-63c259be339b
-- 40	Forwarded to Funding Approval	b514aac5-99de-4551-9355-40edf727a708
-- 40	Forwarded to Funding Approval	2a34fa00-f44f-41a0-81db-798c639c326d

select *
	from routing 
where routingid in (	'd3309f98-02e9-4279-a29e-63c259be339b', 'b514aac5-99de-4551-9355-40edf727a708',
						'2a34fa00-f44f-41a0-81db-798c639c326d', '256d856c-1428-4dbb-9115-8536956b1301'
					)	
	and objectid = '1785265'
	and activeflag = 1 ;
	
select eventcode, objectid, routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing 
where routingid in (	'd3309f98-02e9-4279-a29e-63c259be339b', 'b514aac5-99de-4551-9355-40edf727a708',
						'2a34fa00-f44f-41a0-81db-798c639c326d', '256d856c-1428-4dbb-9115-8536956b1301'
					)	
	and objectid = '1785265'
	and activeflag = 1 ;

delete from routing   
where routingid in (	'd3309f98-02e9-4279-a29e-63c259be339b', 'b514aac5-99de-4551-9355-40edf727a708',
						'2a34fa00-f44f-41a0-81db-798c639c326d', '256d856c-1428-4dbb-9115-8536956b1301'
					)	
	and objectid = '1785265'
	and activeflag = 1 ;
