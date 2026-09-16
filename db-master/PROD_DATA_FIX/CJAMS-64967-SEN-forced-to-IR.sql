/*
   Issue Description: CIDM-64967 -Intake SEN flag
   Category/ Module  :Intakes
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
--Need to add information at the addendum to narrative with language as "Screened out this intake and please refer to new intake # I261013890442" on the intake I251013611463
UPDATE intakesnapshot
SET jsondata = jsonb_set(
                 jsondata::jsonb, 
                 '{General, addendumNarrative}', 
                 '"<p>Corrected deceased childs status as other child not in household to reflect status and change case to ROH SEN. Child fatality investigated when it occurred.</p><p>Screened out this intake and please refer to new intake # I261013890442 on the intake I251013611463</p>"'::jsonb, 
                 true
              ),
   updatedby = 'CJAMS-64967', updatedon = now()
where intakenumber = 'I251013611463' and activeflag = 1;


UPDATE intakedastaging
SET jsondata = jsonb_set(
                 jsondata::jsonb, 
                 '{General, addendumNarrative}', 
                 '"<p>Corrected deceased childs status as other child not in household to reflect status and change case to ROH SEN. Child fatality investigated when it occurred.</p><p>Screened out this intake and please refer to new intake # I261013890442 on the intake I251013611463</p>"'::jsonb, 
                 true
              ),
   updatedby = 'CJAMS-64967', updatedon = now()
where intakenumber = 'I251013611463' and activeflag = 1;
 

--Remove the Alleged Maltreator role from client ID # 4322089 (DESTINY ELIJA'E COLEMAN) and add the Parent role.
update intakeservicerequestactor
set intakeservicerequestpersontypekey ='PARENT', updatedby ='CJAMS-64967', updatedon =now()
where intakeservicerequestactorid =
'98fda8cd-6762-49a1-bbce-76ffeb004ed8' and activeflag = 1;


update actor
set actortype  ='PARENT', updatedby ='CJAMS-64967', updatedon =now()
where actorid='5a28bd78-fca3-4e9c-94b8-48cd4fffa959' and activeflag = 1;

--Update the Supervisor Decision as screen out and closed the intake # I251013611463 with approval date on 12/23/2025 -4:06 PM

UPDATE intakedastaging 
SET 
updatedby = 'CJAMS-64967', 
updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I251013611463' AND activeflag=1;

update routing 
set routingstatustypeid = 8,updatedby = 'CJAMS-64967', updatedon = now(),
supervisordecision = 'ScreenOUT'
WHERE objectid = 'I251013611463' and activeflag = 1;

update intakeDAStatus set status = 8, updatedby = 'CJAMS-64967', updatedon = now() 
where intakenumber = 'I251013611463' and activeflag =1;

update intakedastaging 
set status = 'Closed', updatedby = 'CJAMS-64967', updatedon = now()
where intakenumber = 'I251013611463' and activeflag = 1;

UPDATE intakesnapshot 
SET 
updatedby = 'CJAMS-64967', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I251013611463' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-64967', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I251013611463' AND activeflag=1;

UPDATE intakeservicerequest  
SET   
    actiontype = null, servicecaseid = null,intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
    updatedby = 'CJAMS-64967', updatedon = now() 
WHERE 
    
intakeserviceid = '1eb14b7f-d0bc-4e5d-b6e3-566ae885b494'
AND activeflag = 1;


update 
  routing
set
  activeflag = 0,  
  updatedby = 'CJAMS-64967',
  updatedon = now() 
where objectid = 'I251013611463' and activeflag = 1;

--Delete the CPS IR # 251023361710
update actor 
set activeflag = 0, updatedon =now(), updatedby = 'CJAMS-64967'
where intakeserviceid  =  '1eb14b7f-d0bc-4e5d-b6e3-566ae885b494' 
and activeflag = 1 ;

update personrole  
set activeflag = 0, updatedon =now(), updatedby = 'CJAMS-64967'
where intakeserviceid  =  '1eb14b7f-d0bc-4e5d-b6e3-566ae885b494' 
and activeflag = 1 ;

update actorrelationship  
set activeflag = 0, updatedon =now(), updatedby = 'CJAMS-64967'
where intakeserviceid  =  '1eb14b7f-d0bc-4e5d-b6e3-566ae885b494' 
and activeflag = 1 ;

update personroletype  
set activeflag = 0, updatedon =now(), updatedby = 'CJAMS-64967'
where personroleid 
    in ( select personroleid from personrole
            where intakeserviceid  = '1eb14b7f-d0bc-4e5d-b6e3-566ae885b494' )
and activeflag  = 1;


update routing  
set activeflag = 0, updatedon =now(), updatedby = 'CJAMS-64967'
where objectid =  '1eb14b7f-d0bc-4e5d-b6e3-566ae885b494' 
and activeflag = 1 ;

update intakeservicerequestsdm  
set activeflag = 0, updatedon =now(), updatedby = 'CJAMS-64967'
where intakeserviceid  =  '1eb14b7f-d0bc-4e5d-b6e3-566ae885b494' 
and activeflag = 1 ;


update intakeservicerequestactor  
set activeflag = 0, updatedon =now(), updatedby = 'CJAMS-64967'
where intakeserviceid  =  '1eb14b7f-d0bc-4e5d-b6e3-566ae885b494' 
and activeflag = 1 ;

update intakeservicerequestdispositioncode  
set activeflag = 0, updatedon =now(), updatedby = 'CJAMS-64967'
where intakeserviceid  =  '1eb14b7f-d0bc-4e5d-b6e3-566ae885b494' 
and activeflag = 1 ;

update caseassignment  
set activeflag = 0, updatedon =now(), updatedby = 'CJAMS-64967'
where objectid =  '1eb14b7f-d0bc-4e5d-b6e3-566ae885b494' 
and activeflag = 1 ;

update personprogramarea  
set activeflag = 0, updatedon =now(), updatedby = 'CJAMS-64967'
where objectid =  '1eb14b7f-d0bc-4e5d-b6e3-566ae885b494' 
and activeflag = 1 ;








