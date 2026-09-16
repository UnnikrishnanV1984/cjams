/*
 * CDM-33063 - Delete Service Case
 * Customer Email ID:stacie.parker@maryland.gov
 * Customer Name:Stacie Parker
 * Dashboard:Service case 231030150720 was created by a glitch in CJAMS. This is a blank service case that should be deleted and removed from my 
 * Assign Service Case inbox. Screen URL: https://cw.cjams.mdthink.maryland.gov/#/pages/cjams-dashboard/cw-assign-service-case
 * Service case # 231030150720. Please remove the service case as requested.
 * 
 */

--"objectid":"d16144ad-7d3f-4b13-afb0-172e52ee7f4a"
--"intakeserviceid":"d16144ad-7d3f-4b13-afb0-172e52ee7f4a"
--"servicerequestid":"d16144ad-7d3f-4b13-afb0-172e52ee7f4a"


-- Delete
select servicecaseid, servicecasenumber, activeflag, updatedby, updatedon 
	from servicecase 
where servicecaseid = 'd16144ad-7d3f-4b13-afb0-172e52ee7f4a'
	and activeflag = 1 ;

update servicecase
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-33063'
where servicecaseid = 'd16144ad-7d3f-4b13-afb0-172e52ee7f4a'
	and activeflag = 1 ;

-- Delete 
select servicecaserequestid, servicecaseid, activeflag, updatedby, updatedon 
	from servicecaserequest 
where servicecaseid = 'd16144ad-7d3f-4b13-afb0-172e52ee7f4a'
	and activeflag = 1 ;

update servicecaserequest
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-33063'
where servicecaseid = 'd16144ad-7d3f-4b13-afb0-172e52ee7f4a'
	and activeflag = 1 ;

-- Delete
select servicecasedispositionid, dispositioncode, activeflag, updatedby, updatedon 
	from servicecasedisposition
where servicecaseid = 'd16144ad-7d3f-4b13-afb0-172e52ee7f4a'
	and activeflag = 1 ;

update servicecasedisposition
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-33063'
where servicecaseid = 'd16144ad-7d3f-4b13-afb0-172e52ee7f4a'
	and activeflag = 1 ;

-- Delete
select routingid, activeflag, updatedby, updatedon 
	from routing
where objectid = 'd16144ad-7d3f-4b13-afb0-172e52ee7f4a'
	and eventcode = 'SRVC'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-33063'
where objectid = 'd16144ad-7d3f-4b13-afb0-172e52ee7f4a'
	and eventcode = 'SRVC'
	and activeflag = 1 ;

-- Delete 
select activitytaskid, activityid, "name", activeflag, updatedby, updatedon 
	from activitytask
where activityid  
		in ( select activityid from activity where objectid  = 'd16144ad-7d3f-4b13-afb0-172e52ee7f4a' )
	and activeflag  = 1 ;

update activitytask
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-33063'
where activityid  
		in ( select activityid from activity where objectid  = 'd16144ad-7d3f-4b13-afb0-172e52ee7f4a' )
	and activeflag  = 1 ;

-- Delete 
select activityid, description, activeflag, updatedby, updatedon 
	from activity
where objectid = 'd16144ad-7d3f-4b13-afb0-172e52ee7f4a'
	and activeflag  = 1 ;
	
update activity
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-33063'
where objectid = 'd16144ad-7d3f-4b13-afb0-172e52ee7f4a'
	and activeflag  = 1 ;

-- Nullify the servicecaseid
select objectid, servicecaseid, activeflag, updatedby, updatedon 
	from assessment
where servicecaseid = 'd16144ad-7d3f-4b13-afb0-172e52ee7f4a'
	and activeflag = 1 ;

update assessment
set servicecaseid = NULL,
	updatedon = now(), 	
	updatedby = 'CDM-33063'
where servicecaseid = 'd16144ad-7d3f-4b13-afb0-172e52ee7f4a'
	and activeflag = 1 ;