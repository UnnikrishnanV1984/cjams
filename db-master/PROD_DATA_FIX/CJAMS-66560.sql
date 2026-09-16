/*
-- Issue Description: Narrative will not save after turning around case
   
-- Category/ Module: Disposition
-- Root cause: Had a call wih user and User created an intake and later when user wants to screenout the case the narrative and few other fields got missed it might have been 
               caused due to a glitch since its working fine for all other intakes, so user has requested for a data fix to add Narrative and screen in the intake so user can keep the case which is already closed.
-- Fix Provided: Data fix is done to add the data the missing data so intake will be removed from user intake pending dashboard
-- Reason why no related code fix: Its not replicable for other intakes.
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/




UPDATE cjams.intakedastaging
SET jsondata = jsonb_set(
                  jsondata,
                  '{General}',
                  (jsondata->'General') || 
                  '{"Narrative": "<p>Arien&nbsp;6&nbsp;Watkins&nbsp;Mill&nbsp;Elem.</p><p></p><p>Teacher&nbsp;asked&nbsp;RS&nbsp;to&nbsp;talk&nbsp;to&nbsp;Arien&nbsp;because&nbsp;Arien&nbsp;has&nbsp;been&nbsp;talking&nbsp;about&nbsp;a&nbsp;fight&nbsp;and&nbsp;her&nbsp;Father&nbsp;being&nbsp;hurt.&nbsp;RS&nbsp;reports&nbsp;Arien&nbsp;said&nbsp;her&nbsp;Father&nbsp;woke&nbsp;up&nbsp;at&nbsp;4&nbsp;am.&nbsp;to&nbsp;look&nbsp;at&nbsp;her&nbsp;Mother&#39;s&nbsp;phone.&nbsp;Arien&nbsp;said&nbsp;her&nbsp;Mother&nbsp;was&nbsp;crying&nbsp;and&nbsp;angry.&nbsp;&nbsp;Arien&nbsp;said&nbsp;her&nbsp;Mother&nbsp;was&nbsp;trying&nbsp;to&nbsp;get&nbsp;her&nbsp;Father&nbsp;with&nbsp;a&nbsp;sharp&nbsp;knife&nbsp;from&nbsp;the&nbsp;kitchen.&nbsp;Arien&nbsp;said&nbsp;she&nbsp;and&nbsp;her&nbsp;Mother&nbsp;went&nbsp;to&nbsp;the&nbsp;car&nbsp;and&nbsp;Mother&nbsp;brought&nbsp;the&nbsp;knife&nbsp;to&nbsp;the&nbsp;car.&nbsp;Arien&nbsp;reports&nbsp;her&nbsp;Mother&nbsp;was&nbsp;driving&nbsp;really&nbsp;fast&nbsp;but&nbsp;they&nbsp;did&nbsp;not&nbsp;crash.&nbsp;Arien&nbsp;said&nbsp;they&nbsp;went&nbsp;to&nbsp;a&nbsp;person&#39;s&nbsp;house&nbsp;and&nbsp;her&nbsp;Mother&nbsp;smoked.&nbsp;Arien&nbsp;said&nbsp;they&nbsp;left&nbsp;and&nbsp;went&nbsp;back&nbsp;home.&nbsp;&nbsp;Arien&nbsp;said&nbsp;mommy&nbsp;was&nbsp;trying&nbsp;to&nbsp;get&nbsp;daddy&nbsp;with&nbsp;the&nbsp;car.&nbsp;The&nbsp;police&nbsp;came&nbsp;and&nbsp;arrested&nbsp;Mother.&nbsp;Arien&nbsp;said&nbsp;her&nbsp;Father&nbsp;is&nbsp;taking&nbsp;care&nbsp;of&nbsp;her&nbsp;and&nbsp;she&nbsp;misses&nbsp;her&nbsp;Mother.&nbsp;&nbsp;Arien&nbsp;also&nbsp;said&nbsp;her&nbsp;Father&#39;s&nbsp;leg&nbsp;is&nbsp;hurt&nbsp;and&nbsp;mentioned&nbsp;a&nbsp;couch.&nbsp;</p><p></p><p>Family&nbsp;is&nbsp;&nbsp;Black&nbsp;and&nbsp;speaks&nbsp;English.&nbsp;</p>"}'::jsonb
               ),
    status = 'Complete',
    updatedon = now(),
    updatedby = 'CJAMS-66560'
WHERE intakenumber = 'I261013972882'
  AND activeflag = 1;

UPDATE cjams.intakedastatus 
SET jsondata = jsonb_set(
                  jsondata,
                  '{General}',
                  (jsondata->'General') || 
                  '{"Narrative": "<p>Arien&nbsp;6&nbsp;Watkins&nbsp;Mill&nbsp;Elem.</p><p></p><p>Teacher&nbsp;asked&nbsp;RS&nbsp;to&nbsp;talk&nbsp;to&nbsp;Arien&nbsp;because&nbsp;Arien&nbsp;has&nbsp;been&nbsp;talking&nbsp;about&nbsp;a&nbsp;fight&nbsp;and&nbsp;her&nbsp;Father&nbsp;being&nbsp;hurt.&nbsp;RS&nbsp;reports&nbsp;Arien&nbsp;said&nbsp;her&nbsp;Father&nbsp;woke&nbsp;up&nbsp;at&nbsp;4&nbsp;am.&nbsp;to&nbsp;look&nbsp;at&nbsp;her&nbsp;Mother&#39;s&nbsp;phone.&nbsp;Arien&nbsp;said&nbsp;her&nbsp;Mother&nbsp;was&nbsp;crying&nbsp;and&nbsp;angry.&nbsp;&nbsp;Arien&nbsp;said&nbsp;her&nbsp;Mother&nbsp;was&nbsp;trying&nbsp;to&nbsp;get&nbsp;her&nbsp;Father&nbsp;with&nbsp;a&nbsp;sharp&nbsp;knife&nbsp;from&nbsp;the&nbsp;kitchen.&nbsp;Arien&nbsp;said&nbsp;she&nbsp;and&nbsp;her&nbsp;Mother&nbsp;went&nbsp;to&nbsp;the&nbsp;car&nbsp;and&nbsp;Mother&nbsp;brought&nbsp;the&nbsp;knife&nbsp;to&nbsp;the&nbsp;car.&nbsp;Arien&nbsp;reports&nbsp;her&nbsp;Mother&nbsp;was&nbsp;driving&nbsp;really&nbsp;fast&nbsp;but&nbsp;they&nbsp;did&nbsp;not&nbsp;crash.&nbsp;Arien&nbsp;said&nbsp;they&nbsp;went&nbsp;to&nbsp;a&nbsp;person&#39;s&nbsp;house&nbsp;and&nbsp;her&nbsp;Mother&nbsp;smoked.&nbsp;Arien&nbsp;said&nbsp;they&nbsp;left&nbsp;and&nbsp;went&nbsp;back&nbsp;home.&nbsp;&nbsp;Arien&nbsp;said&nbsp;mommy&nbsp;was&nbsp;trying&nbsp;to&nbsp;get&nbsp;daddy&nbsp;with&nbsp;the&nbsp;car.&nbsp;The&nbsp;police&nbsp;came&nbsp;and&nbsp;arrested&nbsp;Mother.&nbsp;Arien&nbsp;said&nbsp;her&nbsp;Father&nbsp;is&nbsp;taking&nbsp;care&nbsp;of&nbsp;her&nbsp;and&nbsp;she&nbsp;misses&nbsp;her&nbsp;Mother.&nbsp;&nbsp;Arien&nbsp;also&nbsp;said&nbsp;her&nbsp;Father&#39;s&nbsp;leg&nbsp;is&nbsp;hurt&nbsp;and&nbsp;mentioned&nbsp;a&nbsp;couch.&nbsp;</p><p></p><p>Family&nbsp;is&nbsp;&nbsp;Black&nbsp;and&nbsp;speaks&nbsp;English.&nbsp;</p>"}'::jsonb
               ),
    updatedon = now(),
    updatedby = 'CJAMS-66560'
WHERE intakenumber = 'I261013972882'
  AND activeflag = 1;
 

UPDATE cjams.intakedastaging
SET 
    jsondata = jsonb_set(
        jsondata,
        '{disposition}',
        '[{"supDisposition": "Scrnin"}]'::jsonb,
        true
    ),
    updatedon = now(),
    updatedby = 'CJAMS-66560'
WHERE intakenumber = 'I261013972882'
  AND activeflag = 1;

delete from cjams.administrativeoverrides where entityid = 'I261013972882';

/*
 INSERT INTO cjams.administrativeoverrides
(administrativeoverrideid, approvalid, entitytypekey, entityid, referralsnapshotid, overridereasontypekey, overridetypekey, overridedate, overridetimestamp, overridestaffid, "comments", insertedon, insertedby, updatedon, updatedby, activeflag, overridekeyid, intakeserviceid, old_id, etl_userid, etl_load_date, intakeapproveddate, contactmadewithhhmember)
VALUES('079f4fd0-e128-4d98-873f-dc90d10a0813'::uuid, '00000000-0000-0000-0000-000000000000'::uuid, '2530', 'I261013972882', NULL, 'ATNA', '2530', '2026-03-19 13:22:44.239', '2026-03-19 13:22:44.239', 'd86bb458-2309-4182-b155-ae22d36cf9d6', NULL, '2026-03-19 09:23:25.770', 'd86bb458-2309-4182-b155-ae22d36cf9d6', '2026-03-19 09:23:25.770', 'd86bb458-2309-4182-b155-ae22d36cf9d6', 1, 1, NULL, NULL, NULL, NULL, NULL, false);

 */
    
DELETE FROM cjams.routing
WHERE routingid='0489b5df-96d2-4e39-8697-5f7fbc376c41'::uuid;

/*
 INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('0489b5df-96d2-4e39-8697-5f7fbc376c41'::uuid, 'INTR', 'd86bb458-2309-4182-b155-ae22d36cf9d6', 'ec9cc7d9-2bda-435d-800e-a08e572ad221', 'b70ab9c8-0cdb-4c71-a0a7-5af7e623d406'::uuid, 'CWSP', 'CWCW', 'I261013972882', 861, 1, 'd86bb458-2309-4182-b155-ae22d36cf9d6', '2026-03-19 09:23:25.770', 'd86bb458-2309-4182-b155-ae22d36cf9d6', '2026-03-19 09:23:25.770', false, 'Return to worker', NULL, 'Return to Worker', ' ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Return to Worker', NULL);

*/

