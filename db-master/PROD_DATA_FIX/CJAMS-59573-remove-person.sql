/*
Issue Description: 3277076:CJAMS PID 204124080 needs to be removed from case, as child is not biologically related and does not reside in the household
Category/Module: person card
Root cause: User added incorrect data
Fix provided: Data fix has been done by deleting the person card from this case.
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error
*/

update actor
set activeflag =0, updatedby ='CJAMS-59573', updatedon=now()
where actorid = '20374442-5f42-4af7-b5f5-81a5e5bb1e06' and activeflag =1;

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CJAMS-59573', updatedon = now()
where intakeservicerequestactorid = '6dfba32e-a4af-4c04-a201-fcc1105ca927' and activeflag =1;

update actorrelationship 
set activeflag =0, updatedby ='CJAMS-59573', updatedon =now()
where servicecaseid  = '479077a8-90a6-47c4-9256-6b9e02ceaffa'
and intakeservicerequestactorid = '6dfba32e-a4af-4c04-a201-fcc1105ca927' and activeflag =1;

update personrole
set activeflag = 0, updatedby = 'CJAMS-59573', updatedon = now()
where personroleid = '04ade1e2-968d-4963-b9af-c30bdf29d666' and activeflag = 1;

update personroletype 
set activeflag =0, updatedby ='CJAMS-59573', updatedon =now()
where personroletypeid  ='48899bdb-3f2d-4157-acd1-0e3419ddc1e3' and activeflag =1;

update personprogramarea 
set activeflag =0, updatedby ='CJAMS-59573', updatedon =now()
where personid ='b3318f64-c7a6-4b7a-bfee-427fcd850a4d' and personprogramid ='ce3266a2-a88b-4238-a56f-75287bbc560e' and activeflag =1;

update intakeservicerequestactor 
set activeflag = 0, updatedby ='CJAMS-59573', updatedon =now()
where servicecaseid  = '479077a8-90a6-47c4-9256-6b9e02ceaffa'
and personid  = 'b3318f64-c7a6-4b7a-bfee-427fcd850a4d' and activeflag=1;

--Deleting person from contact notes
update contactparticipant
set activeflag = 0,
    updatedby ='CJAMS-59573', 
    updatedon =now()
where contactparticipantid='f50f59aa-2e62-436f-a26a-13bb66e777b4'
and activeflag=1;

--deleting person from safe-c assessment
update
	cjams.assessment
set
	submissiondata = jsonb_set(submissiondata, '{childdatagrid}', '[
    {
      "age": "8 Yrs",
      "clientid": "4087539",
      "childname": "ZAYLAN S DERENZO"
    },
    {
      "age": "7 Day(s)",
      "clientid": "204124079",
      "childname": " Devotion  Downes "
    }
  ]') ,
	updatedon = now()
where
	assessmentid = '861fe53a-9122-4450-a304-98c19b1bf9b4';

--Deleting person from MFIRA assessment
update
	cjams.assessment
set
	submissiondata = jsonb_set(submissiondata, '{familyHOUSEHOLD,familyArray}', '[
      {
        "dob": "1992-11-05T05:00:00.000Z",
        "name": "AMI N CAIN",
        "personid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
        "caregiver": "",
        "relationship": "Self",
        "relationshiparray": [
          {
            "firstname": "Devotion",
            "updatedon": "2025-04-19T14:13:17.368761",
            "description": "Biological Brother",
            "primaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "Skylah",
            "updatedon": "2025-04-19T14:13:17.368761",
            "description": "Biological Brother",
            "primaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d",
            "secondaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc"
          },
          {
            "firstname": "Skylah",
            "updatedon": "2025-04-19T14:13:08.42429",
            "description": "Biological Mother",
            "primaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "AMI",
            "updatedon": "2025-04-19T14:13:08.42429",
            "description": "Biological Child",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d"
          },
          {
            "firstname": "AMI",
            "updatedon": "2025-04-19T14:13:08.42429",
            "description": "Biological Child",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2025-04-19T14:13:08.42429",
            "description": "Biological Mother",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "Devotion",
            "updatedon": "2025-04-19T13:52:07",
            "description": "Biological Sister",
            "primaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc",
            "secondaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d"
          },
          {
            "firstname": "Skylah",
            "updatedon": "2025-04-19T13:51:45",
            "description": "Biological Brother",
            "primaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2025-04-19T13:51:44",
            "description": "Biological Sister",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2025-04-19T13:51:37",
            "description": "Biological Brother",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc"
          },
          {
            "firstname": "Devotion",
            "updatedon": "2025-04-19T13:25:22",
            "description": "Biological Mother",
            "primaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2024-03-26T13:00:14",
            "description": "Biological Child",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "c8ae0d8a-1c7c-417f-9e79-41df66904a9f"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2022-05-31T08:58:11",
            "description": "Maternal GrandChild",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "b63ca411-c430-43e1-ad9a-055034c0c98c"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2021-02-13T14:40:55.892019",
            "description": "Biological Child",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "7780fbf1-e56f-471c-9d50-4011811c6dd6"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2021-02-13T14:40:55.892019",
            "description": "Self",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2021-02-13T14:40:55.892019",
            "description": "Self",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2019-09-10T14:46:28",
            "description": "Maternal GrandChild",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "a3ebc4cb-a523-4140-8676-72f9b621155b"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2019-09-10T14:46:28",
            "description": "Maternal GrandChild",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "5b3c6f2e-66f2-4fa7-9f0c-b8c89d83c796"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-06-12T14:34:41",
            "description": "Daycare Child",
            "primaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Other",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Adoptive Parent",
            "primaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Other",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Maternal Cousin",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Maternal Cousin",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-05-23T17:09:57",
            "description": "Other",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-01T11:37:49",
            "description": "Biological Child",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-01T11:36:29",
            "description": "No Relation",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-05-01T11:36:29",
            "description": "No Relation",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-01T11:36:29",
            "description": "No Relation",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-01T11:34:25",
            "description": "No Relation",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-05-01T11:34:25",
            "description": "No Relation",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-01T11:33:20",
            "description": "No Relation",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-05-01T11:33:20",
            "description": "No Relation",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-05-01T11:33:20",
            "description": "No Relation",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-01T11:33:20",
            "description": "Boyfriend",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-01T11:32:03",
            "description": "Biological Mother",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-05-01T11:32:03",
            "description": "No Relation",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-01T11:32:03",
            "description": "No Relation",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-01T11:32:03",
            "description": "Biological Child",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-01T11:32:03",
            "description": "No Relation",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-01T11:32:03",
            "description": "Biological Child",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-01T11:32:03",
            "description": "Girlfriend",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-05-01T11:32:03",
            "description": "No Relation",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2016-12-01T14:37:53",
            "description": "Friend",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "df0e0c54-ead0-4ec2-befe-df3e1feb6f30"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2016-09-19T14:08:08",
            "description": "Other",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "c8ae0d8a-1c7c-417f-9e79-41df66904a9f"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2016-07-26T13:53:16",
            "description": "Maternal GrandChild",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "991bccc9-b21b-47c5-b2bb-c2103ce7dff5"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2016-07-26T13:50:31",
            "description": null,
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "991bccc9-b21b-47c5-b2bb-c2103ce7dff5"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2015-03-02T18:55:18",
            "description": "Biological Child",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "06fba1a8-fb5b-4627-a785-a1e52bec4126"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2015-03-02T18:54:56",
            "description": "Biological Child",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "08722ab8-94c5-4022-86f6-21f19ec9969d"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2006-10-06T01:31:26",
            "description": "Biological Mother",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2006-10-05T15:19:36",
            "description": "Spouse",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "f99608d7-bbe0-4547-a4e8-3e62fbef2403"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2006-10-05T15:19:35",
            "description": "Biological Child",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "4df266ba-5db0-423d-b72c-441fde71a58c"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2006-06-01T22:45:27",
            "description": "Biological Mother",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "e7f31059-79b3-4f48-afba-671c903c8d3f"
          }
        ],
        "intakeservicerequestactorid": "5020f919-6d29-44c4-8ba0-57ac3bc1bc11"
      },
      {
        "dob": "2016-08-31T04:00:00.000Z",
        "name": "ZAYLAN S DERENZO",
        "personid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
        "caregiver": "",
        "relationship": "Biological Child",
        "relationshiparray": [
          {
            "firstname": "Devotion",
            "updatedon": "2025-04-19T14:13:17.368761",
            "description": "Biological Brother",
            "primaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "Skylah",
            "updatedon": "2025-04-19T14:13:17.368761",
            "description": "Biological Brother",
            "primaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d",
            "secondaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc"
          },
          {
            "firstname": "Skylah",
            "updatedon": "2025-04-19T14:13:08.42429",
            "description": "Biological Mother",
            "primaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "AMI",
            "updatedon": "2025-04-19T14:13:08.42429",
            "description": "Biological Child",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d"
          },
          {
            "firstname": "AMI",
            "updatedon": "2025-04-19T14:13:08.42429",
            "description": "Biological Child",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2025-04-19T14:13:08.42429",
            "description": "Biological Mother",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "Devotion",
            "updatedon": "2025-04-19T13:52:07",
            "description": "Biological Sister",
            "primaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc",
            "secondaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d"
          },
          {
            "firstname": "Skylah",
            "updatedon": "2025-04-19T13:51:45",
            "description": "Biological Brother",
            "primaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2025-04-19T13:51:44",
            "description": "Biological Sister",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2025-04-19T13:51:37",
            "description": "Biological Brother",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc"
          },
          {
            "firstname": "Devotion",
            "updatedon": "2025-04-19T13:25:22",
            "description": "Biological Mother",
            "primaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2024-03-26T13:00:14",
            "description": "Biological Child",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "c8ae0d8a-1c7c-417f-9e79-41df66904a9f"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2022-05-31T08:58:11",
            "description": "Maternal GrandChild",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "b63ca411-c430-43e1-ad9a-055034c0c98c"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2021-02-13T14:40:55.892019",
            "description": "Biological Child",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "7780fbf1-e56f-471c-9d50-4011811c6dd6"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2021-02-13T14:40:55.892019",
            "description": "Self",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2021-02-13T14:40:55.892019",
            "description": "Self",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2019-09-10T14:46:28",
            "description": "Maternal GrandChild",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "a3ebc4cb-a523-4140-8676-72f9b621155b"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2019-09-10T14:46:28",
            "description": "Maternal GrandChild",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "5b3c6f2e-66f2-4fa7-9f0c-b8c89d83c796"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-06-12T14:34:41",
            "description": "Daycare Child",
            "primaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Other",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Adoptive Parent",
            "primaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Other",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Maternal Cousin",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Maternal Cousin",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-05-23T17:09:57",
            "description": "Other",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-01T11:37:49",
            "description": "Biological Child",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-01T11:36:29",
            "description": "No Relation",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-05-01T11:36:29",
            "description": "No Relation",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-01T11:36:29",
            "description": "No Relation",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-01T11:34:25",
            "description": "No Relation",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-05-01T11:34:25",
            "description": "No Relation",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-01T11:33:20",
            "description": "No Relation",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-05-01T11:33:20",
            "description": "No Relation",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-05-01T11:33:20",
            "description": "No Relation",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-01T11:33:20",
            "description": "Boyfriend",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-01T11:32:03",
            "description": "Biological Mother",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-05-01T11:32:03",
            "description": "No Relation",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-01T11:32:03",
            "description": "No Relation",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-01T11:32:03",
            "description": "Biological Child",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-01T11:32:03",
            "description": "No Relation",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-01T11:32:03",
            "description": "Biological Child",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-01T11:32:03",
            "description": "Girlfriend",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-05-01T11:32:03",
            "description": "No Relation",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2016-12-01T14:37:53",
            "description": "Friend",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "df0e0c54-ead0-4ec2-befe-df3e1feb6f30"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2016-09-19T14:08:08",
            "description": "Other",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "c8ae0d8a-1c7c-417f-9e79-41df66904a9f"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2016-07-26T13:53:16",
            "description": "Maternal GrandChild",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "991bccc9-b21b-47c5-b2bb-c2103ce7dff5"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2016-07-26T13:50:31",
            "description": null,
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "991bccc9-b21b-47c5-b2bb-c2103ce7dff5"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2015-03-02T18:55:18",
            "description": "Biological Child",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "06fba1a8-fb5b-4627-a785-a1e52bec4126"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2015-03-02T18:54:56",
            "description": "Biological Child",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "08722ab8-94c5-4022-86f6-21f19ec9969d"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2006-10-06T01:31:26",
            "description": "Biological Mother",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2006-10-05T15:19:36",
            "description": "Spouse",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "f99608d7-bbe0-4547-a4e8-3e62fbef2403"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2006-10-05T15:19:35",
            "description": "Biological Child",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "4df266ba-5db0-423d-b72c-441fde71a58c"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2006-06-01T22:45:27",
            "description": "Biological Mother",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "e7f31059-79b3-4f48-afba-671c903c8d3f"
          }
        ],
        "intakeservicerequestactorid": "4cd33f24-50b0-4329-95db-6845c4b57e66"
      },
      {
        "dob": "2025-04-18T04:00:00.000Z",
        "name": " Devotion  Downes ",
        "personid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc",
        "caregiver": "",
        "relationship": "Biological Child",
        "relationshiparray": [
          {
            "firstname": "Devotion",
            "updatedon": "2025-04-19T14:13:17.368761",
            "description": "Biological Brother",
            "primaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "Skylah",
            "updatedon": "2025-04-19T14:13:17.368761",
            "description": "Biological Brother",
            "primaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d",
            "secondaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc"
          },
          {
            "firstname": "Skylah",
            "updatedon": "2025-04-19T14:13:08.42429",
            "description": "Biological Mother",
            "primaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "AMI",
            "updatedon": "2025-04-19T14:13:08.42429",
            "description": "Biological Child",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d"
          },
          {
            "firstname": "AMI",
            "updatedon": "2025-04-19T14:13:08.42429",
            "description": "Biological Child",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2025-04-19T14:13:08.42429",
            "description": "Biological Mother",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "Devotion",
            "updatedon": "2025-04-19T13:52:07",
            "description": "Biological Sister",
            "primaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc",
            "secondaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d"
          },
          {
            "firstname": "Skylah",
            "updatedon": "2025-04-19T13:51:45",
            "description": "Biological Brother",
            "primaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2025-04-19T13:51:44",
            "description": "Biological Sister",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "b3318f64-c7a6-4b7a-bfee-427fcd850a4d"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2025-04-19T13:51:37",
            "description": "Biological Brother",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc"
          },
          {
            "firstname": "Devotion",
            "updatedon": "2025-04-19T13:25:22",
            "description": "Biological Mother",
            "primaryuserid": "ad7cec24-17f7-439e-ac99-929f8f9bfcbc",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2024-03-26T13:00:14",
            "description": "Biological Child",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "c8ae0d8a-1c7c-417f-9e79-41df66904a9f"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2022-05-31T08:58:11",
            "description": "Maternal GrandChild",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "b63ca411-c430-43e1-ad9a-055034c0c98c"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2021-02-13T14:40:55.892019",
            "description": "Biological Child",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "7780fbf1-e56f-471c-9d50-4011811c6dd6"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2021-02-13T14:40:55.892019",
            "description": "Self",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2021-02-13T14:40:55.892019",
            "description": "Self",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2019-09-10T14:46:28",
            "description": "Maternal GrandChild",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "a3ebc4cb-a523-4140-8676-72f9b621155b"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2019-09-10T14:46:28",
            "description": "Maternal GrandChild",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "5b3c6f2e-66f2-4fa7-9f0c-b8c89d83c796"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-06-12T14:34:41",
            "description": "Daycare Child",
            "primaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Other",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Adoptive Parent",
            "primaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-06-12T14:33:48",
            "description": "Friend",
            "primaryuserid": "e8b51086-125d-4e94-92ca-878cff287a10",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Other",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Maternal Cousin",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "0be51b76-c943-4742-b413-521d4be54f15"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Maternal Cousin",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-23T17:14:35",
            "description": "Friend",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-05-23T17:09:57",
            "description": "Other",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-01T11:37:49",
            "description": "Biological Child",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-01T11:36:29",
            "description": "No Relation",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-05-01T11:36:29",
            "description": "No Relation",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-01T11:36:29",
            "description": "No Relation",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-01T11:34:25",
            "description": "No Relation",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-05-01T11:34:25",
            "description": "No Relation",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-01T11:33:20",
            "description": "No Relation",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2017-05-01T11:33:20",
            "description": "No Relation",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-05-01T11:33:20",
            "description": "No Relation",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-01T11:33:20",
            "description": "Boyfriend",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-01T11:32:03",
            "description": "Biological Mother",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-05-01T11:32:03",
            "description": "No Relation",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "AMI",
            "updatedon": "2017-05-01T11:32:03",
            "description": "No Relation",
            "primaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-01T11:32:03",
            "description": "Biological Child",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "c90b72c0-8898-4b8f-92ba-b8d91b8b7b3d"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-01T11:32:03",
            "description": "No Relation",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2017-05-01T11:32:03",
            "description": "Biological Child",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2017-05-01T11:32:03",
            "description": "Girlfriend",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "ZAYLAN",
            "updatedon": "2017-05-01T11:32:03",
            "description": "No Relation",
            "primaryuserid": "4470b556-106c-4a35-b6de-00ec3f2205e9",
            "secondaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2016-12-01T14:37:53",
            "description": "Friend",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "df0e0c54-ead0-4ec2-befe-df3e1feb6f30"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2016-09-19T14:08:08",
            "description": "Other",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "c8ae0d8a-1c7c-417f-9e79-41df66904a9f"
          },
          {
            "firstname": "RUSSELL",
            "updatedon": "2016-07-26T13:53:16",
            "description": "Maternal GrandChild",
            "primaryuserid": "85ada284-cf9a-4316-bb11-be4cde779908",
            "secondaryuserid": "991bccc9-b21b-47c5-b2bb-c2103ce7dff5"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2016-07-26T13:50:31",
            "description": null,
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "991bccc9-b21b-47c5-b2bb-c2103ce7dff5"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2015-03-02T18:55:18",
            "description": "Biological Child",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "06fba1a8-fb5b-4627-a785-a1e52bec4126"
          },
          {
            "firstname": "TYNEESHA",
            "updatedon": "2015-03-02T18:54:56",
            "description": "Biological Child",
            "primaryuserid": "0be51b76-c943-4742-b413-521d4be54f15",
            "secondaryuserid": "08722ab8-94c5-4022-86f6-21f19ec9969d"
          },
          {
            "firstname": "EDWARD",
            "updatedon": "2006-10-06T01:31:26",
            "description": "Biological Mother",
            "primaryuserid": "77ac4238-3ca9-4d28-833f-5269456b3135",
            "secondaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2006-10-05T15:19:36",
            "description": "Spouse",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "f99608d7-bbe0-4547-a4e8-3e62fbef2403"
          },
          {
            "firstname": "BELINDA",
            "updatedon": "2006-10-05T15:19:35",
            "description": "Biological Child",
            "primaryuserid": "3c9662d7-345d-43a9-8438-3f1efe8d4a34",
            "secondaryuserid": "4df266ba-5db0-423d-b72c-441fde71a58c"
          },
          {
            "firstname": "ALYSSA",
            "updatedon": "2006-06-01T22:45:27",
            "description": "Biological Mother",
            "primaryuserid": "ab139615-9406-4b1a-9da6-570eb0752626",
            "secondaryuserid": "e7f31059-79b3-4f48-afba-671c903c8d3f"
          }
        ],
        "intakeservicerequestactorid": "757cf6aa-8a85-49bd-bc5c-d62edd0016a7"
      }
    ]') ,
	updatedon = now()
where
	assessmentid = '768c0e36-895a-4530-a6e4-3152867b614c';

-- Removing child from home health report assessment
update
	cjams.assessment
set
	submissiondata = jsonb_set(submissiondata, '{childrendetails}', '[
    {
      "DOB": "2016-08-31T00:00:00-04:00",
      "childerenname": "ZAYLAN DERENZO"
    },
    {
      "DOB": "2025-04-18T00:00:00-04:00",
      "childerenname": "Devotion Downes"
    }
  ]') ,
	updatedon = now()
where
	assessmentid = '764ad387-dda3-4b98-9e2b-0844d03801af';


update
	cjams.assessment
set
	submissiondata = jsonb_set(submissiondata, '{sleepingarrangementsgrid}', ' [
    {
      "childnamelist": "ZAYLAN DERENZO",
      "sharingbedwith": "",
      "sleepinglocation": ""
    },
    {
      "childnamelist": "Devotion Downes",
      "sharingbedwith": "",
      "sleepinglocation": ""
    }
  ]'), 
	updatedon = now()
where
	assessmentid = '764ad387-dda3-4b98-9e2b-0844d03801af';


update
	cjams.assessment
set
	submissiondata = jsonb_set(submissiondata, '{panel558909475610663DataGrid}', '[
    {
      "childnamelist": "Devotion Downes",
      "sharingbedwith": "pack n play ",
      "sleepinglocation": "mothers room"
    },
    {
      "childnamelist": "ZAYLAN DERENZO",
      "sharingbedwith": "twin size bed",
      "sleepinglocation": "shares room w/ mgm"
    }
  ]'),
	updatedon = now()
where
	assessmentid = '764ad387-dda3-4b98-9e2b-0844d03801af';



    


