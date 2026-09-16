/*
    Issue Description: CDM-36703
    Category/ Module : Service case
    Root cause: This is an empty service case with no people and no allegations in the case.
    Fix: Datafix provided to delete the service case
    Pull request# for code fix: 
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date:
*/

-- Query to get servicerequestid
select servicecaseid, servicecasenumber, activeflag, updatedby, updatedon 
	from servicecase 
where servicecasenumber = '221030016434'
	and activeflag = 1 ;

-- Update query
select servicecaseid, servicecasenumber, activeflag, updatedby, updatedon 
	from servicecase 
where servicecaseid = '4f029d14-5afa-4f55-ae73-df7fd9f0d4cf'
	and activeflag = 1 ;

update servicecase
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-36703'
where servicecaseid = '4f029d14-5afa-4f55-ae73-df7fd9f0d4cf'
	and activeflag = 1 ;

-- Update query 
select servicecaserequestid, servicecaseid, activeflag, updatedby, updatedon 
	from servicecaserequest 
where servicecaseid = '4f029d14-5afa-4f55-ae73-df7fd9f0d4cf'
	and activeflag = 1 ;

update servicecaserequest
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-36703'
where servicecaseid = '4f029d14-5afa-4f55-ae73-df7fd9f0d4cf'
	and activeflag = 1 ;

-- Update query
select servicecasedispositionid, dispositioncode, activeflag, updatedby, updatedon 
	from servicecasedisposition
where servicecaseid = '4f029d14-5afa-4f55-ae73-df7fd9f0d4cf'
	and activeflag = 1 ;

update servicecasedisposition
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-36703'
where servicecaseid = '4f029d14-5afa-4f55-ae73-df7fd9f0d4cf'
	and activeflag = 1 ;

-- Update query
select routingid, activeflag, updatedby, updatedon 
	from routing
where objectid = '4f029d14-5afa-4f55-ae73-df7fd9f0d4cf'
	and eventcode = 'SRVC'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-36703'
where objectid = '4f029d14-5afa-4f55-ae73-df7fd9f0d4cf'
	and eventcode = 'SRVC'
	and activeflag = 1 ;

-- Update query 
select activitytaskid, activityid, "name", activeflag, updatedby, updatedon 
	from activitytask
where activityid  
		in ( select activityid from activity where objectid  = '4f029d14-5afa-4f55-ae73-df7fd9f0d4cf' )
	and activeflag  = 1 ;

update activitytask
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-36703'
where activityid  
		in ( select activityid from activity where objectid  = '4f029d14-5afa-4f55-ae73-df7fd9f0d4cf' )
	and activeflag  = 1 ;

-- Update query 
select activityid, description, activeflag, updatedby, updatedon 
	from activity
where objectid = '4f029d14-5afa-4f55-ae73-df7fd9f0d4cf'
	and activeflag  = 1 ;
	
update activity
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-36703'
where objectid = '4f029d14-5afa-4f55-ae73-df7fd9f0d4cf'
	and activeflag  = 1 ;

-- Nullify the servicecaseid
select objectid, servicecaseid, activeflag, updatedby, updatedon 
	from assessment
where servicecaseid = '4f029d14-5afa-4f55-ae73-df7fd9f0d4cf'
	and activeflag = 1 ;

update assessment
set servicecaseid = NULL,
	updatedon = now(), 	
	updatedby = 'CDM-36703'
where servicecaseid = '4f029d14-5afa-4f55-ae73-df7fd9f0d4cf'
	and activeflag = 1 ;
    