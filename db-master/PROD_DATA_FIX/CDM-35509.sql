/*
 * CDM-35509 - Screen out needed
 * Customer Email ID:jameshial.dixon@maryland.gov
 * Customer Name:Jameshia Dixon
 * Focus Area:SDM
 * Intake # I231011462205 has connected to Service Case # 231030221353, and no contacts or assessments has been created in the service case.
 * Need data fix to ;
 * 1. Update the Supervisor Decision from Screen In to Screen Out on Intake # I231011462205
 * 2. Change the Intake status under the Submission History from Accepted to Closed.
 * 3. Intake should be listed under the Screen Out tab
 * 4. Remove/delete the Service Case # 231030221353 and disconnected from Intake # I231011462205
 * 
 */

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-35509', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011462205' AND activeflag=1;

UPDATE intakedastaging
SET 
updatedby = 'CDM-35509', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011462205' AND activeflag=1;

--select routingstatustypeid, routingid, * from routing where objectid = 'I231011462205';  
--select sequencenumber, * from routingstatustype where routingstatustypekey like 'Accepted%';
--select sequencenumber, * from routingstatustype where routingstatustypekey like 'Closed%';
UPDATE cjams.routing
SET routingstatustypeid=8, activeflag=0, updatedby='CDM-35509', updatedon=now()  
WHERE routingid='ed8dcb5f-8e90-420c-8416-d636593bb330'; 

-- Delete
select servicecaseid, servicecasenumber, activeflag, updatedby, updatedon 
	from servicecase 
where servicecasenumber = '231030221353'
	and activeflag = 1 ;

update servicecase
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35509'
where servicecaseid in ('7658c3e3-a5a5-4d91-ad1e-b75e8d4c054e')
	and activeflag = 1 ;

-- Delete 
select servicecaserequestid, servicecaseid, activeflag, updatedby, updatedon 
	from servicecaserequest 
where servicecaseid in ('7658c3e3-a5a5-4d91-ad1e-b75e8d4c054e')
	and activeflag = 1 ;

update servicecaserequest
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35509'
where servicecaseid in ('7658c3e3-a5a5-4d91-ad1e-b75e8d4c054e')
	and activeflag = 1 ;

-- Delete
select servicecasedispositionid, dispositioncode, activeflag, updatedby, updatedon 
	from servicecasedisposition
where servicecaseid in ('7658c3e3-a5a5-4d91-ad1e-b75e8d4c054e')
	and activeflag = 1 ;

update servicecasedisposition
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35509'
where servicecaseid in ('7658c3e3-a5a5-4d91-ad1e-b75e8d4c054e')
	and activeflag = 1 ;

-- Delete
select routingid, activeflag, updatedby, updatedon 
	from routing
where objectid in ('7658c3e3-a5a5-4d91-ad1e-b75e8d4c054e')
	and eventcode = 'SRVC'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35509'
where objectid in ('7658c3e3-a5a5-4d91-ad1e-b75e8d4c054e')
	and eventcode = 'SRVC'
	and activeflag = 1 ;

-- Delete 
select activitytaskid, activityid, "name", activeflag, updatedby, updatedon 
	from activitytask
where activityid  
		in ( select activityid from activity where objectid IN  ('7658c3e3-a5a5-4d91-ad1e-b75e8d4c054e'))
	and activeflag  = 1 ;

update activitytask
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35509'
where activityid  
		in ( select activityid from activity where objectid IN  ('7658c3e3-a5a5-4d91-ad1e-b75e8d4c054e'))
	and activeflag  = 1 ;

-- Delete 
select activityid, description, activeflag, updatedby, updatedon 
	from activity
where objectid in ('7658c3e3-a5a5-4d91-ad1e-b75e8d4c054e')
	and activeflag  = 1 ;
	
update activity
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-35509'
where objectid in ('7658c3e3-a5a5-4d91-ad1e-b75e8d4c054e')
	and activeflag  = 1 ;

-- Nullify the servicecaseid
select objectid, servicecaseid, activeflag, updatedby, updatedon 
	from assessment
where servicecaseid in ('7658c3e3-a5a5-4d91-ad1e-b75e8d4c054e')
	and activeflag = 1 ;

update assessment
set servicecaseid = NULL,
	updatedon = now(), 	
	updatedby = 'CDM-35509'
where servicecaseid in ('7658c3e3-a5a5-4d91-ad1e-b75e8d4c054e')
	and activeflag = 1 ;
