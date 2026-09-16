/*
   Issue Description: CDM-31054
   Category/ Module  : 
   Root cause: user want to change the service case to CPS AR case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 


update intakeservicerequest set  actiontype='AR',servicecaseid=null, activeflag=1, updatedby='CDM-31054',updatedon=now()
where intakenumber='I231010593341';

update personprogramarea set activeflag=0,objectid=null,updatedby='CDM-31054',updatedon=now() where 
personprogramid in ('e1f47ae4-ed67-40e8-a1a4-66f100f413ce','6c7eb53a-2cdf-4c61-bc53-f4d7115af7e3','3dbe5180-8239-4237-8f68-904798b91670');

update intakeservicerequestdispositioncode set activeflag=0  ,updatedby='CDM-31054',updatedon=now()  where intakeserviceid='ea12c607-8928-4cc9-b0df-87657c709965';

update actor set servicecaseid=null,updatedby='CDM-31054',updatedon=now() where servicecaseid='8158b355-e3e4-4c1b-bf0f-66a616064537';
update intakeservicerequestactor set servicecaseid=null,updatedby='CDM-31054',updatedon=now() where servicecaseid='8158b355-e3e4-4c1b-bf0f-66a616064537';

INSERT INTO cjams.personprogramarea
( personid, startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, subprogramkey, objecttypekey, objectid,  sourcetype)
VALUES( 'b1dd1a82-3554-4013-81cd-75b1475797eb', now(), NULL, now(), 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', now(), 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', 1, NULL, NULL, NULL, NULL, NULL, 'CPS', 'AR', 'servicerequest', 'ea12c607-8928-4cc9-b0df-87657c709965', 'CW'),
('9cf33098-de04-4658-af4f-8d8a78eedefc',now(),null, now(), 'f292c712-26e7-43a5-9aaa-b81bc905f8f9',now(), 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', 1, NULL, NULL, NULL, NULL, NULL, 'CPS', 'AR', 'servicerequest', 'ea12c607-8928-4cc9-b0df-87657c709965', 'CW'),
('f355c316-6d32-4176-9ae5-94622dac16f9',now(),null, now(), 'f292c712-26e7-43a5-9aaa-b81bc905f8f9',now(), 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', 1, NULL, NULL, NULL, NULL, NULL, 'CPS', 'AR', 'servicerequest', 'ea12c607-8928-4cc9-b0df-87657c709965', 'CW');



INSERT INTO cjams.investigation
( activeflag, intakeserviceid, riskscore, reviewdate, targetcompletiondate, completiondate, investigationsummary, insertedby, insertedon, updatedby, updatedon, effectivedate)
VALUES( 1, 'ea12c607-8928-4cc9-b0df-87657c709965', NULL, NULL, NULL, NULL, NULL, 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', now(), NULL,now(), now());

INSERT INTO cjams.caseassignment
( fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate,
effectivetime, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey,
activeflag, startdate, enddate, remarks, statustypekey, assignmenttype,
fk_id, assigndate)
VALUES('f292c712-26e7-43a5-9aaa-b81bc905f8f9', NULL, NULL, '2118c30a-7dc5-4db3-bf2f-5867bd7cd015', NULL, NULL, NULL, now(),now(),  
'f292c712-26e7-43a5-9aaa-b81bc905f8f9','f292c712-26e7-43a5-9aaa-b81bc905f8f9',now(),now(), 'servicerequest', 'ea12c607-8928-4cc9-b0df-87657c709965', 
'family', 1, now(), NULL,  NULL, NULL, 
 'W', NULL, now());
INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid,  fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES( 'INVT', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9','2118c30a-7dc5-4db3-bf2f-5867bd7cd015', 'CWSP', 'CWCW', 'ea12c607-8928-4cc9-b0df-87657c709965', 4, 1, 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', now(), 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', now(), false, NULL, NULL, NULL, '231020523436', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);







