-- CIDM-6406 - CPS closed cases history not showing in application under decision tab
/*
-- Issue Description: 
  Datafix to Close impacted CPS cases in CJAMS 
  where having 'Recommend for closure' approval record with activeflag = 0 (soft-deleted record)

-- Category/ Module: GAP (Case Management) 
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to remove Program Assignment End date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete  
select count(*) from routing where updatedby = 'CIDM-6406-R2' and activeflag = 1 ;
update routing set activeflag = 0 where insertedby = 'CIDM-6406-R2' and activeflag = 1 ;

/*
AR	20200104017535	ad1f355b-d4f6-4e61-aec9-f930d2947fc4
IR	20200169021461	4c265c01-4546-47d6-a623-36329b0394a2
IR	20200247032917	d7d7abb7-ce6c-41de-8994-1bc5e5bc5e26
AR	20200300046101	2b9a18df-814f-425f-a3da-a80311f1185a
AR	20200303047279	8601f5e8-ec9b-4724-ae2a-7b46e21ba5fd
IR	20200339060344	a495f63d-0bb9-4653-b5c3-7db2f407fa06
AR	221020188787	cf9fae7c-9866-438e-b2aa-88b078ad35ae
AR	221020218910	ef52088f-2847-47c6-98e4-b96fccfa3c13
*/

select routingid, servicerequestnumber, activeflag, updatedby, updatedon  
from routing 
where routingid 
	in ( 	'd8eab279-c825-4434-87d0-3ef69dff8bb3',
			'b8ea127d-9d30-4f97-acae-85bd242d272d',
			'7369ac5c-11f2-4a4c-843c-f84045981ffe',
			'6c2555d3-cb6d-4372-b6f5-d0aa1cb5071b',
			'c38d46ea-37d5-442b-956d-a9e5ffea6c1d',
			'799253f3-2d21-4f4b-a273-a6acd924ef3c',
			'3bc66b1b-f912-4077-a204-1e69a6047847',
			'237c8dde-6a86-413f-a299-da0e69476e7e'
		)
	and eventcode = 'INDR'
	and routingstatustypeid  = 16
	and activeflag = 0 ;
	
update routing
set activeflag = 1,
	-- updatedon = now(),
	updatedby = 'CIDM-6406-R2'	
where routingid 
	in ( 	'd8eab279-c825-4434-87d0-3ef69dff8bb3',
			'b8ea127d-9d30-4f97-acae-85bd242d272d',
			'7369ac5c-11f2-4a4c-843c-f84045981ffe',
			'6c2555d3-cb6d-4372-b6f5-d0aa1cb5071b',
			'c38d46ea-37d5-442b-956d-a9e5ffea6c1d',
			'799253f3-2d21-4f4b-a273-a6acd924ef3c',
			'3bc66b1b-f912-4077-a204-1e69a6047847',
			'237c8dde-6a86-413f-a299-da0e69476e7e'
		)
	and eventcode = 'INDR'
	and routingstatustypeid  = 16
	and activeflag = 0 ;
	
-- End date open CPS program assignmnets 
select personprogramid, entityid, programkey, subprogramkey, startdate, enddate, updatedon, updatedby,
	(select exitdate from intakeservicerequest where intakeserviceid  = objectid::uuid ) as new_end_date
from personprogramarea  
where programkey = 'CPS'
	and activeflag = 1
	and enddate is null
	and objectid 
		in ( select intakeserviceid::character varying
				from intakeservicerequest 
			where servicerequestnumber  
				in ( '20200339060344', '221020188787', '221020218910', '20200169021461', '20200247032917',
					 '20200303047279', '20200300046101', '20200104017535'
					)
				and activeflag  = 1
			) ;


update personprogramarea
set enddate = (select exitdate from intakeservicerequest where intakeserviceid  = objectid::uuid ),
	updatedon = now(),
	updatedby = 'CIDM-6406-R2'
where programkey = 'CPS'
	and activeflag = 1
	and enddate is null
	and objectid 
		in ( select intakeserviceid::character varying
				from intakeservicerequest 
			where servicerequestnumber  
				in ( '20200339060344', '221020188787', '221020218910', '20200169021461', '20200247032917',
					 '20200303047279', '20200300046101', '20200104017535'
					)
				and activeflag  = 1
			) ;			
	