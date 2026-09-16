-- CDM-35140 - Close case
/* Issue Description:User request to delete the blank Service Case # 211030009797

-- Case ID: 211030009797 - 10e336e5-9cb4-4162-8309-757b39201e98

-- Category/ Module: Case Connect (Investigation Management) 

-- Root cause: Exception scenario (Dummy/blank Service case was created) 
-- Fix Provided: Datafix has been promoted to delete the Dummy/blank Service case # 211030009797
-- Pull request# N/A

-- Root cause: unable to close the case because there is no child to add to this case
-- Fix: Removed service case by updating flag=0  
*/

-- Delete
select servicecaseid, servicecasenumber, activeflag, updatedby, updatedon 
	from servicecase 
where servicecaseid = '578ae1d6-2bd3-4d22-996a-8801ea055bc1'
	and activeflag = 1 ;

update servicecase
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35140'
where servicecaseid = '578ae1d6-2bd3-4d22-996a-8801ea055bc1'
	and activeflag = 1 ;

-- Delete
select servicecaserequestid, servicecaseid, activeflag, updatedby, updatedon 
	from servicecaserequest 
where servicecaseid = '578ae1d6-2bd3-4d22-996a-8801ea055bc1'
	and activeflag = 1 ;

update servicecaserequest
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35140'
where servicecaseid = '578ae1d6-2bd3-4d22-996a-8801ea055bc1'
	and activeflag = 1 ;

-- Delete
select servicecasedispositionid, dispositioncode, activeflag, updatedby, updatedon 
	from servicecasedisposition
where servicecaseid = '578ae1d6-2bd3-4d22-996a-8801ea055bc1'
	and activeflag = 1 ;

update servicecasedisposition
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35140'
where servicecaseid = '578ae1d6-2bd3-4d22-996a-8801ea055bc1'
	and activeflag = 1 ;

-- Delete
select routingid, activeflag, updatedby, updatedon 
	from routing
where objectid = '578ae1d6-2bd3-4d22-996a-8801ea055bc1'
	and eventcode = 'SRVC'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35140'
where objectid = '578ae1d6-2bd3-4d22-996a-8801ea055bc1'
	and eventcode = 'SRVC'
	and activeflag = 1 ;

-- Delete 
select activitytaskid, activityid, "name", activeflag, updatedby, updatedon 
	from activitytask
where activityid  
		in ( select activityid from activity where objectid  = '578ae1d6-2bd3-4d22-996a-8801ea055bc1' )
	and activeflag  = 1 ;

update activitytask
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35140'
where activityid  
		in ( select activityid from activity where objectid  = '578ae1d6-2bd3-4d22-996a-8801ea055bc1' )
	and activeflag  = 1 ;

-- Delete 
select activityid, description, activeflag, updatedby, updatedon 
	from activity
where objectid = '578ae1d6-2bd3-4d22-996a-8801ea055bc1'
	and activeflag  = 1 ;
	
update activity
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35140'
where objectid = '578ae1d6-2bd3-4d22-996a-8801ea055bc1'
	and activeflag  = 1 ;

-- Nullify the servicecaseid
select objectid, servicecaseid, activeflag, updatedby, updatedon 
	from assessment
where servicecaseid = '578ae1d6-2bd3-4d22-996a-8801ea055bc1'
	and activeflag = 1 ;

update assessment
set servicecaseid = NULL,
	updatedon = now(), 	
	updatedby = 'CDM-35140'
where servicecaseid = '578ae1d6-2bd3-4d22-996a-8801ea055bc1'
	and activeflag = 1 ;