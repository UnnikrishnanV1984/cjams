-- CJAMS-59128  Forgot to add supervision note prior to case closure
/*
--	Issue Description: 
	User requested to add the contact note in the case
-- Category/ Module: Contact Notes 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to add the contact note in the case
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

INSERT INTO cjams.progressnote
(progressnoteid, progressnotetypeid, title, description, entitytype, entitytypeid, pagetitle, pageurl, islatest, versionof, 
insertedby, insertedon, archivedby, archivedon, updatedby, updatedon, "timestamp", savemode, progressnotesubtypeid, contactdate, contactname, progressnotetypekey, contactroletypekey, contactphone, contactemail, attemptindicator, activeflag, 
documentpropertiesid, starttime, endtime, instantresults, contactstatus, drugscreen, progressnotepurposetypekey, old_id, traveltime, totaltime, progressnotereasontypekey, locationname, witsinboundid, roletypekey, islocked, stafftypekey, notesid, witsstatus, witsupdatedate, witsupdatebyidno, contactcategoryidno, iconimgtext, parametercodeidno, detaillookup, fk_id, initiationindicator, intakeserviceid, servicecaseid, isintake, otherpersonname, uploadedfile, adjustmentfostercaretext, screeningfortheservicetext, ischildgotoshool, qualityofcaretochildtext, fk_user_id, etl_userid, etl_load_date, fromjurisdictionid, tojurisdictionid, transferdate, transfertime, travelstarttime, travelendtime, servicesprovided, otherservices, anyriskpresented, otherrisk, witsid, 
focusperson, 
factor1_risk_scale, factor2_dependent_independent_scale, factor3_outcome_scale)
VALUES('5ea666d1-4013-405c-8f0a-7bab3c988944', 'a1f78e9f-ea8d-4f0b-8df5-7d4c0eda21cc'::uuid, NULL, 'Supervisor reviewed and discussed case with worker. Family is no longer in need of department intervention.', 'intakeservicerequest', '9d1fd9d7-df7f-4c2a-8631-02155a5b81f2', NULL, NULL, NULL, NULL, 
'9716418b-5994-4d30-8f09-4fd6be9b6a04', '2025-04-15 11:15:00.000', NULL, NULL, 'CJAMS-59128', '2025-04-15 11:15:00.000', 
NULL, true, NULL, '2025-04-15 11:15:00.000', NULL, NULL, NULL, NULL, NULL, false, 1, NULL, '2025-04-15 11:15:00.000', '2025-04-15 11:15:00.000', 1, true, false, NULL, NULL, '', NULL, 'SV,CC', NULL, NULL, NULL, false, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, '2c18ed9f-a35c-4bda-87ca-b6bc8714348a'::uuid, NULL, 'N', 'Julie Campos', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 201359077, 
'{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"f07af9d3-3dba-4f26-a3ca-e13cd72c2ad2","participantid":"f07af9d3-3dba-4f26-a3ca-e13cd72c2ad2","firstname":"Muska","lastname":"Rahmani","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"ae35dd87-a5df-4371-89ec-7e14e8ee25d5","participantid":"ae35dd87-a5df-4371-89ec-7e14e8ee25d5","firstname":"Shamina","lastname":"Rahmani","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"aef79428-fa0f-4569-afa0-6f39951056bc","participantid":"aef79428-fa0f-4569-afa0-6f39951056bc","firstname":"Mirwais","lastname":"Rahmani","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"01b36aee-1e93-42e0-a653-934382b8d0bd","participantid":"01b36aee-1e93-42e0-a653-934382b8d0bd","firstname":"Ozair","lastname":"Rahmani","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"3615fb78-43f6-426f-9747-6c875b2aeda4","participantid":"3615fb78-43f6-426f-9747-6c875b2aeda4","firstname":"Tasal","lastname":"Rahmani","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}'::json, 
NULL, NULL, NULL);

INSERT INTO cjams.progressnotedetail
(progressnotedetailid, progressnoteid, description, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", old_id, isaddendum, fk_user_id, etl_userid, etl_load_date)
values (gen_random_uuid(), '5ea666d1-4013-405c-8f0a-7bab3c988944','Supervisor reviewed and discussed case with worker. Family is no longer in need of department intervention.', 1, '2025-04-15 11:15:00.000', NULL, '9d1fd9d7-df7f-4c2a-8631-02155a5b81f2', '2025-04-15 11:15:00.000', 'CJAMS-59128', '2025-04-15 11:15:00.000', NULL, NULL, 0, NULL, NULL, null);
