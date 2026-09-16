/*
 * CDM-33451 - issue
 * Customer Email ID:taylor.mast@maryland.gov
 * Customer Name:Taylor Mast
 * Focus Area:Case Audit Trail
 * delete the case 231030118598 which is created in error.
 * 
 */


--select * from servicecase where servicecasenumber = '231030118598'; -- 776e2919-2e5c-4876-b645-cf89c2107171

-- Delete
select servicecaseid, servicecasenumber, activeflag, updatedby, updatedon 
	from servicecase 
where servicecaseid in ('776e2919-2e5c-4876-b645-cf89c2107171')
	and activeflag = 1 ;

update servicecase
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-33451'
where servicecaseid in ('776e2919-2e5c-4876-b645-cf89c2107171')
	and activeflag = 1 ;

-- Delete 
select servicecaserequestid, servicecaseid, activeflag, updatedby, updatedon 
	from servicecaserequest 
where servicecaseid in ('776e2919-2e5c-4876-b645-cf89c2107171')
	and activeflag = 1 ;

update servicecaserequest
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-33451'
where servicecaseid in ('776e2919-2e5c-4876-b645-cf89c2107171')
	and activeflag = 1 ;

-- Delete
select servicecasedispositionid, dispositioncode, activeflag, updatedby, updatedon 
	from servicecasedisposition
where servicecaseid in ('776e2919-2e5c-4876-b645-cf89c2107171')
	and activeflag = 1 ;

update servicecasedisposition
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-33451'
where servicecaseid in ('776e2919-2e5c-4876-b645-cf89c2107171')
	and activeflag = 1 ;

-- Delete
select routingid, activeflag, updatedby, updatedon 
	from routing
where objectid in ('776e2919-2e5c-4876-b645-cf89c2107171')
	and eventcode = 'SRVC'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-33451'
where objectid in ('776e2919-2e5c-4876-b645-cf89c2107171')
	and eventcode = 'SRVC'
	and activeflag = 1 ;

-- Delete 
select activitytaskid, activityid, "name", activeflag, updatedby, updatedon 
	from activitytask
where activityid  
		in ( select activityid from activity where objectid IN  ('776e2919-2e5c-4876-b645-cf89c2107171'))
	and activeflag  = 1 ;

update activitytask
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-33451'
where activityid  
		in ( select activityid from activity where objectid IN  ('776e2919-2e5c-4876-b645-cf89c2107171'))
	and activeflag  = 1 ;

-- Delete 
select activityid, description, activeflag, updatedby, updatedon 
	from activity
where objectid in ('776e2919-2e5c-4876-b645-cf89c2107171')
	and activeflag  = 1 ;
	
update activity
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-33451'
where objectid in ('776e2919-2e5c-4876-b645-cf89c2107171')
	and activeflag  = 1 ;

-- Nullify the servicecaseid
select objectid, servicecaseid, activeflag, updatedby, updatedon 
	from assessment
where servicecaseid in ('776e2919-2e5c-4876-b645-cf89c2107171')
	and activeflag = 1 ;

update assessment
set servicecaseid = NULL,
	updatedon = now(), 	
	updatedby = 'CDM-33451'
where servicecaseid in ('776e2919-2e5c-4876-b645-cf89c2107171')
	and activeflag = 1 ;

