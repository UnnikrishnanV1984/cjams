/*
   Issue Description: CDM-39348
   Category/ Module  : Assignments
   Root cause:We opened an intake referral (I241012304053) on 5/13 and connected it to the wrong case (3230957). We have since created a new referral and opened a service case under the correct person. This was a SEN's case and the referral is not applicable to the Ashley S Schoofield case (3230957). The newborn was added to the case (Hunter Scott) and he should not have been. Hunter has been added to the correct case, so we need him removed from case 3230957. If possible, the contact notes dated 5/13/24, 5/14/245 and 5/24/24 should be deleted as well. The case should be closed for the same date/time it was opened.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update actor set activeflag = 0, updatedby = 'CDM-39348', updatedon = now() 
where personid='4e743919-5575-48fa-8943-d31055f46cd3' and servicecaseid = '047a367f-fa27-4915-8d71-d71e0d08f00f' and activeflag = 1;

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-39348', updatedon = now() 
where personid='4e743919-5575-48fa-8943-d31055f46cd3' and servicecaseid = '047a367f-fa27-4915-8d71-d71e0d08f00f' and activeflag = 1;

update personrole set activeflag = 0, updatedby = 'CDM-39348', updatedon = now() 
where personid='4e743919-5575-48fa-8943-d31055f46cd3' and servicecaseid = '047a367f-fa27-4915-8d71-d71e0d08f00f' and activeflag = 1;

update personprogramarea set activeflag = 0, updatedby = 'CDM-39348', updatedon = now() 
where personid='4e743919-5575-48fa-8943-d31055f46cd3' and objectid = '367a96a2-2a1a-4038-82d7-0e409ee97add' and activeflag = 1;

update progressnote set 
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39348' where progressnoteid 
in ('fea3a37b-f92b-435f-9b20-e37cf9aa33cf','47c80579-63d6-449a-956b-1872703a6901','476b0ece-a229-4f51-8967-3bd3c52fa873');


delete from servicecasedisposition where servicecasedispositionid='6b0b075d-812f-4bdc-9d52-450fe312b37b';

delete from routing where routingid='1e941fc7-f631-4d7a-9e40-c94d5cf8d37a';
   
INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES('6b0b075d-812f-4bdc-9d52-450fe312b37b', '047a367f-fa27-4915-8d71-d71e0d08f00f', '2024-05-13 13:42:15.388', 'Closed', 'Closed', 'Case was opened in error', '2024-05-13 16:12:45.000', 1, 'ab7e0e4d-9082-454c-88de-df66a416fcab', '2024-06-04 16:12:45.000', 'CDM-39348', '2024-06-04 16:39:39.836', NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('1e941fc7-f631-4d7a-9e40-c94d5cf8d37a', 'SCDR', 'fc4bbb12-0172-445a-b017-2156c261d052', 'fc4bbb12-0172-445a-b017-2156c261d052', '6b001ced-532b-4755-a0e8-5d2eb23b2bab', 'CWSP', 'CWSP', '6b0b075d-812f-4bdc-9d52-450fe312b37b', 16, 1, 'fc4bbb12-0172-445a-b017-2156c261d052', '2024-06-04 16:13:15.406', 'fc4bbb12-0172-445a-b017-2156c261d052', '2024-06-04 17:01:35.237', true, 'Case was opened in error', NULL, '', '3230957', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);