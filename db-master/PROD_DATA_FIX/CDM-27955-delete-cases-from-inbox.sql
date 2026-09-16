-- CDM-27955 - Delete cases from inbox
/*
-- Issue Description: 
   User request to delete the blank Service Case 211030010143 
                                                 221030017333

servicecaseid: "812552c7-26ba-4c0d-a55f-03c1129baad3"
servicecasenumber: "211030010143"

servicecaseid: "be3eedac-9c3b-46eb-a001-0b4efc1062b8"
servicecasenumber: "221030017333"

-- Category/ Module: Case Connect (Investigation Management) 
-- Fix Provided: Datafix has been promoted to delete the service cases
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete
select servicecaseid, servicecasenumber, activeflag, updatedby, updatedon 
	from servicecase 
where servicecaseid in ('812552c7-26ba-4c0d-a55f-03c1129baad3','be3eedac-9c3b-46eb-a001-0b4efc1062b8')
	and activeflag = 1 ;

update servicecase
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-27955'
where servicecaseid in ('812552c7-26ba-4c0d-a55f-03c1129baad3','be3eedac-9c3b-46eb-a001-0b4efc1062b8')
	and activeflag = 1 ;

-- Delete 
select servicecaserequestid, servicecaseid, activeflag, updatedby, updatedon 
	from servicecaserequest 
where servicecaseid in ('812552c7-26ba-4c0d-a55f-03c1129baad3','be3eedac-9c3b-46eb-a001-0b4efc1062b8')
	and activeflag = 1 ;

update servicecaserequest
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-27955'
where servicecaseid in ('812552c7-26ba-4c0d-a55f-03c1129baad3','be3eedac-9c3b-46eb-a001-0b4efc1062b8')
	and activeflag = 1 ;

-- Delete
select servicecasedispositionid, dispositioncode, activeflag, updatedby, updatedon 
	from servicecasedisposition
where servicecaseid in ('812552c7-26ba-4c0d-a55f-03c1129baad3','be3eedac-9c3b-46eb-a001-0b4efc1062b8')
	and activeflag = 1 ;

update servicecasedisposition
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-27955'
where servicecaseid in ('812552c7-26ba-4c0d-a55f-03c1129baad3','be3eedac-9c3b-46eb-a001-0b4efc1062b8')
	and activeflag = 1 ;

-- Delete
select routingid, activeflag, updatedby, updatedon 
	from routing
where objectid in ('812552c7-26ba-4c0d-a55f-03c1129baad3','be3eedac-9c3b-46eb-a001-0b4efc1062b8')
	and eventcode = 'SRVC'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-27955'
where objectid in ('812552c7-26ba-4c0d-a55f-03c1129baad3','be3eedac-9c3b-46eb-a001-0b4efc1062b8')
	and eventcode = 'SRVC'
	and activeflag = 1 ;

-- Delete 
select activitytaskid, activityid, "name", activeflag, updatedby, updatedon 
	from activitytask
where activityid  
		in ( select activityid from activity where objectid IN  ('812552c7-26ba-4c0d-a55f-03c1129baad3','be3eedac-9c3b-46eb-a001-0b4efc1062b8'))
	and activeflag  = 1 ;

update activitytask
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-27955'
where activityid  
		in ( select activityid from activity where objectid IN  ('812552c7-26ba-4c0d-a55f-03c1129baad3','be3eedac-9c3b-46eb-a001-0b4efc1062b8'))
	and activeflag  = 1 ;

-- Delete 
select activityid, description, activeflag, updatedby, updatedon 
	from activity
where objectid in ('812552c7-26ba-4c0d-a55f-03c1129baad3','be3eedac-9c3b-46eb-a001-0b4efc1062b8')
	and activeflag  = 1 ;
	
update activity
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-27955'
where objectid in ('812552c7-26ba-4c0d-a55f-03c1129baad3','be3eedac-9c3b-46eb-a001-0b4efc1062b8')
	and activeflag  = 1 ;

-- Nullify the servicecaseid
select objectid, servicecaseid, activeflag, updatedby, updatedon 
	from assessment
where servicecaseid in ('812552c7-26ba-4c0d-a55f-03c1129baad3','be3eedac-9c3b-46eb-a001-0b4efc1062b8')
	and activeflag = 1 ;

update assessment
set servicecaseid = NULL,
	updatedon = now(), 	
	updatedby = 'CDM-27955'
where servicecaseid in ('812552c7-26ba-4c0d-a55f-03c1129baad3','be3eedac-9c3b-46eb-a001-0b4efc1062b8')
	and activeflag = 1 ;
