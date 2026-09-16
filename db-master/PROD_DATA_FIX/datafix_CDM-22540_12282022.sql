-- CDM-22540 - Close case
/*
-- Issue Description: 
   User request to delete the blank Service Case # 221030015912
   
-- Case ID: 221030015912 - 10e336e5-9cb4-4162-8309-757b39201e98

-- Category/ Module: Case Connect (Investigation Management) 
-- Root cause: Exception scenario (Dummy/blank Service case was created) 
-- Fix Provided: Datafix has been promoted to delete the Dummy/blank Service case # 221030015912
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete
select servicecaseid, servicecasenumber, activeflag, updatedby, updatedon 
	from servicecase 
where servicecaseid = '10e336e5-9cb4-4162-8309-757b39201e98'
	and activeflag = 1 ;

update servicecase
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-22540'
where servicecaseid = '10e336e5-9cb4-4162-8309-757b39201e98'
	and activeflag = 1 ;

-- Delete 
select servicecaserequestid, servicecaseid, activeflag, updatedby, updatedon 
	from servicecaserequest 
where servicecaseid = '10e336e5-9cb4-4162-8309-757b39201e98'
	and activeflag = 1 ;

update servicecaserequest
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-22540'
where servicecaseid = '10e336e5-9cb4-4162-8309-757b39201e98'
	and activeflag = 1 ;

-- Delete
select servicecasedispositionid, dispositioncode, activeflag, updatedby, updatedon 
	from servicecasedisposition
where servicecaseid = '10e336e5-9cb4-4162-8309-757b39201e98'
	and activeflag = 1 ;

update servicecasedisposition
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-22540'
where servicecaseid = '10e336e5-9cb4-4162-8309-757b39201e98'
	and activeflag = 1 ;

-- Delete
select routingid, activeflag, updatedby, updatedon 
	from routing
where objectid = '10e336e5-9cb4-4162-8309-757b39201e98'
	and eventcode = 'SRVC'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-22540'
where objectid = '10e336e5-9cb4-4162-8309-757b39201e98'
	and eventcode = 'SRVC'
	and activeflag = 1 ;

-- Delete 
select activitytaskid, activityid, "name", activeflag, updatedby, updatedon 
	from activitytask
where activityid  
		in ( select activityid from activity where objectid  = '10e336e5-9cb4-4162-8309-757b39201e98' )
	and activeflag  = 1 ;

update activitytask
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-22540'
where activityid  
		in ( select activityid from activity where objectid  = '10e336e5-9cb4-4162-8309-757b39201e98' )
	and activeflag  = 1 ;

-- Delete 
select activityid, description, activeflag, updatedby, updatedon 
	from activity
where objectid = '10e336e5-9cb4-4162-8309-757b39201e98'
	and activeflag  = 1 ;
	
update activity
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-22540'
where objectid = '10e336e5-9cb4-4162-8309-757b39201e98'
	and activeflag  = 1 ;

-- Nullify the servicecaseid
select objectid, servicecaseid, activeflag, updatedby, updatedon 
	from assessment
where servicecaseid = '10e336e5-9cb4-4162-8309-757b39201e98'
	and activeflag = 1 ;

update assessment
set servicecaseid = NULL,
	updatedon = now(), 	
	updatedby = 'CDM-22540'
where servicecaseid = '10e336e5-9cb4-4162-8309-757b39201e98'
	and activeflag = 1 ;
