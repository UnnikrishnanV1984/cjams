/*
 * CDM-35021 - Remove/Delete an empty service case
 * Customer Email ID:wanda.collins@maryland.gov
 * Customer Name:Wanda Collins
 * Focus Area:Assignments
 * Description - 231030167512:I have an empty service case sitting in my assignment workload with no one attached to the case and no referral summary. 
 * remove/delete service case # 231030167512 as there is no information available on the case
 * 
 */

--"objectid":"7d7d0ff8-2d28-4db6-a799-4bb64254d76e"
--"intakeserviceid":"7d7d0ff8-2d28-4db6-a799-4bb64254d76e"
--"servicerequestid":"7d7d0ff8-2d28-4db6-a799-4bb64254d76e"

select servicecaseid, servicecasenumber, activeflag, updatedby, updatedon 
	from servicecase 
where servicecasenumber = '231030167512'
	and activeflag = 1 ;

-- Delete
select servicecaseid, servicecasenumber, activeflag, updatedby, updatedon 
	from servicecase 
where servicecaseid = '7d7d0ff8-2d28-4db6-a799-4bb64254d76e'
	and activeflag = 1 ;

update servicecase
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35021'
where servicecaseid = '7d7d0ff8-2d28-4db6-a799-4bb64254d76e'
	and activeflag = 1 ;

-- Delete 
select servicecaserequestid, servicecaseid, activeflag, updatedby, updatedon 
	from servicecaserequest 
where servicecaseid = '7d7d0ff8-2d28-4db6-a799-4bb64254d76e'
	and activeflag = 1 ;

update servicecaserequest
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35021'
where servicecaseid = '7d7d0ff8-2d28-4db6-a799-4bb64254d76e'
	and activeflag = 1 ;

-- Delete
select servicecasedispositionid, dispositioncode, activeflag, updatedby, updatedon 
	from servicecasedisposition
where servicecaseid = '7d7d0ff8-2d28-4db6-a799-4bb64254d76e'
	and activeflag = 1 ;

update servicecasedisposition
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35021'
where servicecaseid = '7d7d0ff8-2d28-4db6-a799-4bb64254d76e'
	and activeflag = 1 ;

-- Delete
select routingid, activeflag, updatedby, updatedon 
	from routing
where objectid = '7d7d0ff8-2d28-4db6-a799-4bb64254d76e'
	and eventcode = 'SRVC'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35021'
where objectid = '7d7d0ff8-2d28-4db6-a799-4bb64254d76e'
	and eventcode = 'SRVC'
	and activeflag = 1 ;

-- Delete 
select activitytaskid, activityid, "name", activeflag, updatedby, updatedon 
	from activitytask
where activityid  
		in ( select activityid from activity where objectid  = '7d7d0ff8-2d28-4db6-a799-4bb64254d76e' )
	and activeflag  = 1 ;

update activitytask
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35021'
where activityid  
		in ( select activityid from activity where objectid  = '7d7d0ff8-2d28-4db6-a799-4bb64254d76e' )
	and activeflag  = 1 ;

-- Delete 
select activityid, description, activeflag, updatedby, updatedon 
	from activity
where objectid = '7d7d0ff8-2d28-4db6-a799-4bb64254d76e'
	and activeflag  = 1 ;
	
update activity
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35021'
where objectid = '7d7d0ff8-2d28-4db6-a799-4bb64254d76e'
	and activeflag  = 1 ;

-- Nullify the servicecaseid
select objectid, servicecaseid, activeflag, updatedby, updatedon 
	from assessment
where servicecaseid = '7d7d0ff8-2d28-4db6-a799-4bb64254d76e'
	and activeflag = 1 ;

update assessment
set servicecaseid = NULL,
	updatedon = now(), 	
	updatedby = 'CDM-35021'
where servicecaseid = '7d7d0ff8-2d28-4db6-a799-4bb64254d76e'
	and activeflag = 1 ;
    