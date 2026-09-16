-- CDM-19063 - Case connection
/*
-- Issue Description: 
   User request to disconnect Investigation #211020165045 and Service Case #211030012858
   Investigation #211020165045 SHOULD BE connected to #3265689

-- Intake I211010219204 (1102c9e2-0065-4f1b-a154-5e09dc6a58d2)
-- CPS-IR 211020165045

-- Wrong Service case # 3af3b8c7-9422-4ebc-8500-02a41794f005 (211030012858)

-- Correct Service Case # 43469452-72b3-4088-849d-538f30744fca (3265689)

-- Category/ Module: Case Connect (Investigation Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Nullify the servicecaseid
select intakenumber, actiontype, servicecaseid, updatedby, updatedon
	from intakeservicerequest 
where servicerequestnumber = 211020165045
	and activeflag = 1 ;

update intakeservicerequest 
set servicecaseid = null,
	updatedon = now(), 
	updatedby = 'CDM-19063'
where servicerequestnumber = 211020165045
	and activeflag = 1 ;

-- Delete
select servicecaseid, servicecasenumber, activeflag, updatedby, updatedon 
	from servicecase 
where servicecaseid = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag = 1 ;

update servicecase
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-19063'
where servicecaseid = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag = 1 ;

-- Delete 
select servicecaserequestid, servicecaseid, activeflag, updatedby, updatedon 
	from servicecaserequest 
where servicecaseid = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag = 1 ;

update servicecaserequest
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-19063'
where servicecaseid = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag = 1 ;

-- Nullify the servicecaseid
select intakeservicerequestactorid, intakeserviceid, servicecaseid, 
	personid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon 
	from intakeservicerequestactor 
where servicecaseid  = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag = 1 ;

update intakeservicerequestactor
set servicecaseid = null,
	updatedon = now(), 
	updatedby = 'CDM-19063'
where servicecaseid  = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag = 1 ;

-- Nullify the servicecaseid
select actorid, intakeserviceid, servicecaseid, personid, activeflag, updatedby, updatedon 
	from actor
where servicecaseid  = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag = 1 ;

update actor
set servicecaseid = null,
	updatedon = now(), 
	updatedby = 'CDM-19063'
where servicecaseid  = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag = 1 ;

-- Nullify the servicecaseid
select personroleid, intakeserviceid, servicecaseid, personid, activeflag, updatedby, updatedon 
	from personrole 
where servicecaseid = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag  = 1 ;

update personrole
set servicecaseid = null,
	updatedon = now(), 
	updatedby = 'CDM-19063'
where servicecaseid = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag = 1 ;

-- Delete
select servicecasedispositionid, dispositioncode, activeflag, updatedby, updatedon 
	from servicecasedisposition
where servicecaseid = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag = 1 ;

update servicecasedisposition
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-19063'
where servicecaseid = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag = 1 ;

-- Delete
select routingid, activeflag, updatedby, updatedon 
	from routing
where objectid = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and eventcode = 'SRVC'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-19063'
where objectid = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and eventcode = 'SRVC'
	and activeflag = 1 ;


-- Delete 
select activitytaskid, activityid, "name", activeflag, updatedby, updatedon 
	from activitytask
where activityid  
		in ( select activityid from activity where objectid  = '3af3b8c7-9422-4ebc-8500-02a41794f005' )
	and activeflag  = 1 ;

update activitytask
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-19063'
where activityid  
		in ( select activityid from activity where objectid  = '3af3b8c7-9422-4ebc-8500-02a41794f005' )
	and activeflag  = 1 ;

-- Delete 
select activityid, description, activeflag, updatedby, updatedon 
	from activity
where objectid = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag  = 1 ;
	
update activity
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-19063'
where objectid = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag  = 1 ;


-- Nullify the servicecaseid
select objectid, servicecaseid, activeflag, updatedby, updatedon 
	from assessment
where servicecaseid  = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag = 1 ;

update assessment
set servicecaseid = NULL,
	updatedon = now(), 	
	updatedby = 'CDM-19063'
where servicecaseid = '3af3b8c7-9422-4ebc-8500-02a41794f005'
	and activeflag = 1 ;
	
/*
-- No data
-- Delete 
select * 
	from documentattachment
where documentpropertiesid in (
select documentpropertiesid from documentproperties
where objectid  = '3af3b8c7-9422-4ebc-8500-02a41794f005' )
and activeflag  = 1

-- Delete 
select * from documentproperties
where objectid  = '3af3b8c7-9422-4ebc-8500-02a41794f005'
and activeflag  = 1

-- Nullify the servicecaseid
select * from personprogramarea
where objecttypekey  = 'servicecase'
and objectid  = '3af3b8c7-9422-4ebc-8500-02a41794f005'
and activeflag = 1

-- Delete 
select *
from collateraladdress
where collateralid  in (
select collateralid from collateral
where caseid  = '3af3b8c7-9422-4ebc-8500-02a41794f005'
and activeflag = 1
)
and activeflag  = 1

-- Delete 
select * from collateralroleconfig
where collateralid  in (
select collateralid from collateral
where caseid  = '3af3b8c7-9422-4ebc-8500-02a41794f005'
and activeflag = 1
)
and activeflag  = 1

-- Delete 
select * from collateral
where caseid  = '3af3b8c7-9422-4ebc-8500-02a41794f005'
and activeflag = 1

-- Nullify the servicecaseid
select * from intakeservreqchildremoval
where servicecaseid  = '3af3b8c7-9422-4ebc-8500-02a41794f005'
and activeflag = 1

-- Not required
select * from auditlog 
where objectid  = '3af3b8c7-9422-4ebc-8500-02a41794f005'
and objecttype  = 'servicecase'
*/

