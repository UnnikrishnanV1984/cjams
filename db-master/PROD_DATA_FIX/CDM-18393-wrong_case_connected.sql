/*
 Issue Description:CDM-18393
 Category/ Module:wrong case connected
 Root cause: wrong case
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
---unlinking the CPS IR 211020154840 from Wrong service Case and linking to correct one .
update intakeservicerequest set servicecaseid='a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',updatedby='CDM-18393',updatedon=now()where servicerequestnumber='211020154840';
---closing the wrong service case
update servicecase set enddate='2021-11-30 00:00:00',statustypekey='Closed',updatedon=now(),updatedby='CDM-18393'where servicecaseid ='c6761e3e-2372-47e5-b069-ac7eabbd9b43';
insert into cjams.servicecasedisposition(servicecaseid,statusdate,intakeserreqstatustypekey, dispositioncode, "comments",effectivedate,activeflag,insertedby, insertedon,updatedby,updatedon,expirationdate,old_id,etl_userid,etl_load_date)
values('c6761e3e-2372-47e5-b069-ac7eabbd9b43'::uuid, '2021-11-30 00:00:00', 'Closed', 'Closed', 'closed', '2021-11-30 00:00:00',1,'CDM-18393',now(),'CDM-18393', now(), NULL, NULL, NULL, NULL);
-----removing users from old case
update intakeservicerequestactor set servicecaseid='a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',updatedby='CDM-18393',updatedon=now()where intakeservicerequestactorid='b25d998b-6558-4788-8994-39600896ba74';
update intakeservicerequestactor set servicecaseid='a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',updatedby='CDM-18393',updatedon=now()where intakeservicerequestactorid='d883a700-924c-4d2c-b15e-d937e6d4c0ce';
update intakeservicerequestactor set servicecaseid='a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',updatedby='CDM-18393',updatedon=now()where intakeservicerequestactorid='f40294e1-a1ac-47bf-b28b-11056f26e4d9';
update intakeservicerequestactor set servicecaseid='a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',updatedby='CDM-18393',updatedon=now()where intakeservicerequestactorid='560a81f7-db99-4557-b6d7-86053892e50e';
update intakeservicerequestactor set servicecaseid='a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',updatedby='CDM-18393',updatedon=now()where intakeservicerequestactorid='74bb5a12-6a25-4bf4-a0da-5ab23831875d';
update intakeservicerequestactor set servicecaseid='a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',updatedby='CDM-18393',updatedon=now()where intakeservicerequestactorid='a6edc214-ebde-4762-ad8b-ffec150ad7b3';
update intakeservicerequestactor set activeflag=0,updatedby='CDM-18393',updatedon=now() where personid='26212acb-fd32-4931-b9f9-fee144ebb633'and servicecaseid='a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c';

update actor set servicecaseid='a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',updatedby='CDM-18393',updatedon=now()where actorid='23d04477-a46b-49ba-af2f-09ad89da9dd3';
update actor set servicecaseid='a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',updatedby='CDM-18393',updatedon=now()where actorid='d874eb9c-0c71-4f12-a02a-f066403f3756';
update actor set activeflag =0, updatedby='CDM-18393', updatedon=now() where actorid in ('348295c0-eb6e-45b0-8661-bce347f1afee');

---changing the status to Open of the correct case
update servicecase set statustypekey ='Open',dispositioncode='Open',enddate=null,updatedby='CDM-18393',updatedon=now() where servicecaseid='a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c';
update servicecasedisposition set activeflag=0,updatedby='CDM-18393',updatedon=now()where servicecasedispositionid='b1745333-b25f-4884-ad66-e192c2ccb64f';
insert into cjams.servicecasedisposition(servicecaseid,statusdate,intakeserreqstatustypekey,dispositioncode,"comments",effectivedate,activeflag,insertedby,insertedon,updatedby,updatedon,expirationdate,old_id,etl_userid,etl_load_date)
values('a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c','2021-11-05 00:00:00','Reopen','Inprogress','Case Re-Opened','2021-11-05 00:00:00',1,'CDM-18393',now(),'CDM-18393',now(),null,null,null,null);