/*
   Issue Description:CDM-33789
   Category/ Module  : Serviceplan 
   Root cause: 2 golas are missing in the service plan.
  Fix Provided; Did data fix to added those goals into the serviceplan version 
*/



update cjams.snapshothist

SET snapshotdata = jsonb_set(snapshotdata::jsonb, '{splangoal}',
'[
    {
      "status": "In Progress",
      "goalname": "The continuity of family relationships and connections is preserved for youth",
      "activeflag": 1,
      "splangoalid": "11970b1a-87bd-4a44-a327-a60aeea7a710",
      "serviceplanid": "13f19896-b6e3-4266-be59-523480cf63a1",
      "splanobjective": [
        {
          "needs": [
            "Family communication",
            "Mental Health Needs"
          ],
          "status": "In Progress",
          "comments": null,
          "strengths": null,
          "activeflag": 1,
          "splangoalid": "11970b1a-87bd-4a44-a327-a60aeea7a710",
          "objectivename": "Ms. Greene will demonstrate nurturing, healthy, and positive interactions with her children",
          "splanobjectiveid": "49423232-2f4e-4cb2-9365-6dba8a3a8057",
          "serviceplanaction": [
            {
              "status": "In Progress",
              "enddate": "2024-08-07T08:00:00.000Z",
              "planfor": "IHSFP",
              "comments": null,
              "plantype": null,
              "startdate": "2023-08-07T08:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "49423232-2f4e-4cb2-9365-6dba8a3a8057",
              "personresponsible": "Lisa Gattie",
              "serviceplanoutcome": null,
              "serviceplanactionid": "5cbffeee-fd36-4bd8-a001-67c7c5cc361a",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Worker will refer the family to participate in FFT by 8/7/23.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "WILLIS",
                    "personid": "176edfdb-83c5-456b-a011-bfdc0bc15998",
                    "firstname": "AVA",
                    "activeflag": 1,
                    "middlename": "J"
                  },
                  "activeflag": 1,
                  "personinvolved": "176edfdb-83c5-456b-a011-bfdc0bc15998",
                  "serviceplanactionid": "5cbffeee-fd36-4bd8-a001-67c7c5cc361a",
                  "serviceplanpersoninvolvedid": "3f3d96a7-bfb0-4a2e-8b10-2e53858cb1a3"
                },
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Willis",
                    "personid": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                    "firstname": "Brent \"Norah\"",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                  "serviceplanactionid": "5cbffeee-fd36-4bd8-a001-67c7c5cc361a",
                  "serviceplanpersoninvolvedid": "47d8d8d8-e716-4aec-bcdd-fe3ed35fb992"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "GREENE",
                    "personid": "1287c31d-10b7-4be2-8bdd-734821942a72",
                    "firstname": "DANIELLE",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "1287c31d-10b7-4be2-8bdd-734821942a72",
                  "serviceplanactionid": "5cbffeee-fd36-4bd8-a001-67c7c5cc361a",
                  "serviceplanpersoninvolvedid": "ad54a315-761f-4f34-bb3b-f9822103e52e"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2024-08-07T20:00:00.000Z",
              "planfor": "IHSFP",
              "comments": null,
              "plantype": null,
              "startdate": "2023-08-07T20:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "49423232-2f4e-4cb2-9365-6dba8a3a8057",
              "personresponsible": "DANIELLE GREENE ,Lisa Gattie",
              "serviceplanoutcome": null,
              "serviceplanactionid": "8b64d40a-f0e4-4ba9-9a3e-97f9a31bb547",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Greene will complete the FFT intake appointment, participate and attend all scheduled appointments with Brent/Norah over the next 3-5 months in order to strengthen her parenting skills.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "GREENE",
                    "personid": "1287c31d-10b7-4be2-8bdd-734821942a72",
                    "firstname": "DANIELLE",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "1287c31d-10b7-4be2-8bdd-734821942a72",
                  "serviceplanactionid": "8b64d40a-f0e4-4ba9-9a3e-97f9a31bb547",
                  "serviceplanpersoninvolvedid": "2c780cda-bb42-4754-91df-64591e742031"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "WILLIS",
                    "personid": "176edfdb-83c5-456b-a011-bfdc0bc15998",
                    "firstname": "AVA",
                    "activeflag": 1,
                    "middlename": "J"
                  },
                  "activeflag": 1,
                  "personinvolved": "176edfdb-83c5-456b-a011-bfdc0bc15998",
                  "serviceplanactionid": "8b64d40a-f0e4-4ba9-9a3e-97f9a31bb547",
                  "serviceplanpersoninvolvedid": "c386f1b9-9df6-4bc3-bd5c-74799619a0fe"
                },
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Willis",
                    "personid": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                    "firstname": "Brent \"Norah\"",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                  "serviceplanactionid": "8b64d40a-f0e4-4ba9-9a3e-97f9a31bb547",
                  "serviceplanpersoninvolvedid": "eca35014-6c73-4918-990a-d2c53ff189ae"
                }
              ]
            }
          ],
          "approvalstatustypekey": null
        }
      ],
      "approvalstatustypekey": null
    },
    {
      "status": "In Progress",
      "goalname": "Youth physical and mental health needs are met",
      "activeflag": 1,
      "splangoalid": "1691e6d5-ceb3-46e6-ae92-c03d305f9f54",
      "serviceplanid": "13f19896-b6e3-4266-be59-523480cf63a1",
      "splanobjective": [
        {
          "needs": null,
          "status": "In Progress",
          "comments": "",
          "strengths": null,
          "activeflag": 1,
          "splangoalid": "1691e6d5-ceb3-46e6-ae92-c03d305f9f54",
          "objectivename": "The family will engage in mental health related services. ",
          "splanobjectiveid": "50560ee3-d479-47a1-9b9e-f2f7c860be4b",
          "serviceplanaction": [
            {
              "status": "In Progress",
              "enddate": "2023-08-24T12:00:00.000Z",
              "planfor": "IHSFP",
              "comments": "",
              "plantype": null,
              "startdate": "2023-05-24T12:00:00.000Z",
              "activeflag": 1,
              "goalreason": "",
              "splanobjectiveid": "50560ee3-d479-47a1-9b9e-f2f7c860be4b",
              "personresponsible": "DANIELLE GREENE ",
              "serviceplanoutcome": "",
              "serviceplanactionid": "053bf81f-bdf2-4442-a31f-db7bae1c6b42",
              "approvalstatustypekey": null,
              "serviceplanactionname": "It is encouraged that Ms. Greene continues to participate in mental health related services through Solace. To be reviewed by Worker during weekly visits. ",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Willis",
                    "personid": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                    "firstname": "Brent \"Norah\"",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                  "serviceplanactionid": "053bf81f-bdf2-4442-a31f-db7bae1c6b42",
                  "serviceplanpersoninvolvedid": "3b6dda0d-7a30-472c-9688-c97af6f04625"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "GREENE",
                    "personid": "1287c31d-10b7-4be2-8bdd-734821942a72",
                    "firstname": "DANIELLE",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "1287c31d-10b7-4be2-8bdd-734821942a72",
                  "serviceplanactionid": "053bf81f-bdf2-4442-a31f-db7bae1c6b42",
                  "serviceplanpersoninvolvedid": "e3ce275b-d232-4bb6-b747-eb4afa2e8a52"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "WILLIS",
                    "personid": "176edfdb-83c5-456b-a011-bfdc0bc15998",
                    "firstname": "AVA",
                    "activeflag": 1,
                    "middlename": "J"
                  },
                  "activeflag": 1,
                  "personinvolved": "176edfdb-83c5-456b-a011-bfdc0bc15998",
                  "serviceplanactionid": "053bf81f-bdf2-4442-a31f-db7bae1c6b42",
                  "serviceplanpersoninvolvedid": "e8c028a2-b278-48a0-9b8c-d28e1cebac43"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-08-24T12:00:00.000Z",
              "planfor": "IHSFP",
              "comments": "Workers will provide Ms. Greene with information on how to request a VPA again. ",
              "plantype": null,
              "startdate": "2023-05-24T12:00:00.000Z",
              "activeflag": 1,
              "goalreason": "",
              "splanobjectiveid": "50560ee3-d479-47a1-9b9e-f2f7c860be4b",
              "personresponsible": "DANIELLE GREENE ",
              "serviceplanoutcome": "",
              "serviceplanactionid": "bf0b9f96-4366-4311-b6c1-2d9020479952",
              "approvalstatustypekey": null,
              "serviceplanactionname": "It is encouraged that Ms. Greene request a Voluntary Placement Assessment (VPA). To be reviewed by Worker during weekly visits. ",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Willis",
                    "personid": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                    "firstname": "Brent \"Norah\"",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                  "serviceplanactionid": "bf0b9f96-4366-4311-b6c1-2d9020479952",
                  "serviceplanpersoninvolvedid": "3d39e38f-3dcd-459b-89d0-ab16f75e57f7"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "GREENE",
                    "personid": "1287c31d-10b7-4be2-8bdd-734821942a72",
                    "firstname": "DANIELLE",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "1287c31d-10b7-4be2-8bdd-734821942a72",
                  "serviceplanactionid": "bf0b9f96-4366-4311-b6c1-2d9020479952",
                  "serviceplanpersoninvolvedid": "8525c698-ee95-4c0e-a0dc-4c750eb7a695"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "WILLIS",
                    "personid": "176edfdb-83c5-456b-a011-bfdc0bc15998",
                    "firstname": "AVA",
                    "activeflag": 1,
                    "middlename": "J"
                  },
                  "activeflag": 1,
                  "personinvolved": "176edfdb-83c5-456b-a011-bfdc0bc15998",
                  "serviceplanactionid": "bf0b9f96-4366-4311-b6c1-2d9020479952",
                  "serviceplanpersoninvolvedid": "c0114447-a0e7-42e7-95a5-406cbe2e971a"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-08-24T08:00:00.000Z",
              "planfor": "IHSFP",
              "comments": null,
              "plantype": null,
              "startdate": "2023-08-04T08:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "50560ee3-d479-47a1-9b9e-f2f7c860be4b",
              "personresponsible": "DANIELLE GREENE ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "e4bac90f-ef87-4301-8525-fe905372c9b9",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Greene will contact the IOP Program at Luminis Health and schedule an intake appointment for Norah ASAP per Sheppard Pratts recommendation. To be reviewed by Worker during weekly visits. ",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Willis",
                    "personid": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                    "firstname": "Brent \"Norah\"",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                  "serviceplanactionid": "e4bac90f-ef87-4301-8525-fe905372c9b9",
                  "serviceplanpersoninvolvedid": "7771e473-4042-4378-beec-52e43d06b010"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "GREENE",
                    "personid": "1287c31d-10b7-4be2-8bdd-734821942a72",
                    "firstname": "DANIELLE",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "1287c31d-10b7-4be2-8bdd-734821942a72",
                  "serviceplanactionid": "e4bac90f-ef87-4301-8525-fe905372c9b9",
                  "serviceplanpersoninvolvedid": "9f1ed1e9-6a00-4187-94fe-0c32d2624aa9"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-08-24T08:00:00.000Z",
              "planfor": "IHSFP",
              "comments": null,
              "plantype": null,
              "startdate": "2023-08-04T08:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "50560ee3-d479-47a1-9b9e-f2f7c860be4b",
              "personresponsible": "DANIELLE GREENE ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "286f1e9b-2866-492c-8cdd-567a18d742ec",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Greene will ensure that Norah is attending all of her mental health appointments with Dr. Mitch Odom. To be reviewed by Worker during weekly visits. ",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Willis",
                    "personid": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                    "firstname": "Brent \"Norah\"",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                  "serviceplanactionid": "286f1e9b-2866-492c-8cdd-567a18d742ec",
                  "serviceplanpersoninvolvedid": "33f9c09e-d37b-4c90-af59-77eaa98740a1"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "GREENE",
                    "personid": "1287c31d-10b7-4be2-8bdd-734821942a72",
                    "firstname": "DANIELLE",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "1287c31d-10b7-4be2-8bdd-734821942a72",
                  "serviceplanactionid": "286f1e9b-2866-492c-8cdd-567a18d742ec",
                  "serviceplanpersoninvolvedid": "d2b6556f-0a57-4241-82ca-baa5a2dd2fc0"
                }
              ]
            }
          ],
          "approvalstatustypekey": null
        }
      ],
      "approvalstatustypekey": null
    },
    {
      "status": "In Progress",
      "goalname": "Youth are safely maintained in their homes whenever possible and appropriate",
      "activeflag": 1,
      "splangoalid": "8e0dfc6f-6724-4748-bfd1-588ebbcf5a46",
      "serviceplanid": "13f19896-b6e3-4266-be59-523480cf63a1",
      "splanobjective": [
        {
          "needs": null,
          "status": "In Progress",
          "comments": null,
          "strengths": null,
          "activeflag": 1,
          "splangoalid": "8e0dfc6f-6724-4748-bfd1-588ebbcf5a46",
          "objectivename": "Family will ensure that Ava and Norah are safe and supervised in the home. ",
          "splanobjectiveid": "c4cd4778-88d7-4390-acfc-bebac1a01f2d",
          "serviceplanaction": [
            {
              "status": "In Progress",
              "enddate": "2023-08-24T08:00:00.000Z",
              "planfor": "IHSFP",
              "comments": null,
              "plantype": null,
              "startdate": "2023-05-24T08:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "c4cd4778-88d7-4390-acfc-bebac1a01f2d",
              "personresponsible": "DANIELLE GREENE ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "ecef4c8d-5e84-4089-8e8f-566981a93d48",
              "approvalstatustypekey": null,
              "serviceplanactionname": "The  family will continue to utilize the door alarms, window alarms and cameras that the agency purchased to ensure that Norah and Ava are properly supervised in the family home. To be reviewed by Worker during weekly visits. ",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Willis",
                    "personid": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                    "firstname": "Brent \"Norah\"",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                  "serviceplanactionid": "ecef4c8d-5e84-4089-8e8f-566981a93d48",
                  "serviceplanpersoninvolvedid": "5597642d-491d-4211-b9bc-ad5fe5762989"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "GREENE",
                    "personid": "1287c31d-10b7-4be2-8bdd-734821942a72",
                    "firstname": "DANIELLE",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "1287c31d-10b7-4be2-8bdd-734821942a72",
                  "serviceplanactionid": "ecef4c8d-5e84-4089-8e8f-566981a93d48",
                  "serviceplanpersoninvolvedid": "9e085bc6-848a-46e3-a6ba-6f55b428745c"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "WILLIS",
                    "personid": "176edfdb-83c5-456b-a011-bfdc0bc15998",
                    "firstname": "AVA",
                    "activeflag": 1,
                    "middlename": "J"
                  },
                  "activeflag": 1,
                  "personinvolved": "176edfdb-83c5-456b-a011-bfdc0bc15998",
                  "serviceplanactionid": "ecef4c8d-5e84-4089-8e8f-566981a93d48",
                  "serviceplanpersoninvolvedid": "b8318bab-b76a-4044-a640-a5c0099fedf3"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-08-24T08:00:00.000Z",
              "planfor": "IHSFP",
              "comments": null,
              "plantype": null,
              "startdate": "2023-05-24T08:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "c4cd4778-88d7-4390-acfc-bebac1a01f2d",
              "personresponsible": "DANIELLE GREENE ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "552c586c-5be9-49f6-b957-fc347899c5cf",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Greene will ensure that Norah and Ava are not left alone together and that they are properly supervised by Ms. Greene, Mr. Fleming or a responsible adult. To be reviewed by Worker during weekly visits. ",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Willis",
                    "personid": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                    "firstname": "Brent \"Norah\"",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                  "serviceplanactionid": "552c586c-5be9-49f6-b957-fc347899c5cf",
                  "serviceplanpersoninvolvedid": "3abd080b-8810-4747-a0a0-6190be329989"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "WILLIS",
                    "personid": "176edfdb-83c5-456b-a011-bfdc0bc15998",
                    "firstname": "AVA",
                    "activeflag": 1,
                    "middlename": "J"
                  },
                  "activeflag": 1,
                  "personinvolved": "176edfdb-83c5-456b-a011-bfdc0bc15998",
                  "serviceplanactionid": "552c586c-5be9-49f6-b957-fc347899c5cf",
                  "serviceplanpersoninvolvedid": "9ce620fd-1811-4fe6-aa4e-ac0aa5ecaabb"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "GREENE",
                    "personid": "1287c31d-10b7-4be2-8bdd-734821942a72",
                    "firstname": "DANIELLE",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "1287c31d-10b7-4be2-8bdd-734821942a72",
                  "serviceplanactionid": "552c586c-5be9-49f6-b957-fc347899c5cf",
                  "serviceplanpersoninvolvedid": "eb132e0b-6969-461f-b95e-2402a42f6182"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-08-24T08:00:00.000Z",
              "planfor": "IHSFP",
              "comments": null,
              "plantype": null,
              "startdate": "2023-08-04T08:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "c4cd4778-88d7-4390-acfc-bebac1a01f2d",
              "personresponsible": "DANIELLE GREENE ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "6941dd5c-a5df-4f05-9789-2e6cd04e1287",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Greene will ensure that all medications are properly stored in a safe and that Norah is supervised when taking medication(s). To be reviewed by Worker during weekly visits. ",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "GREENE",
                    "personid": "1287c31d-10b7-4be2-8bdd-734821942a72",
                    "firstname": "DANIELLE",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "1287c31d-10b7-4be2-8bdd-734821942a72",
                  "serviceplanactionid": "6941dd5c-a5df-4f05-9789-2e6cd04e1287",
                  "serviceplanpersoninvolvedid": "0f59fff5-7a00-4057-a038-f758e83afae2"
                },
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Willis",
                    "personid": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                    "firstname": "Brent \"Norah\"",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                  "serviceplanactionid": "6941dd5c-a5df-4f05-9789-2e6cd04e1287",
                  "serviceplanpersoninvolvedid": "db5c67ef-dc22-44ae-9ce0-e32fffbc0bb4"
                }
              ]
            }
          ],
          "approvalstatustypekey": null
        }
      ],
      "approvalstatustypekey": null
    },
    {
      "status": "In Progress",
      "goalname": "Youth educational needs are met",
      "activeflag": 1,
      "splangoalid": "94b58e12-b101-4f2b-8a47-6af8e4790d23",
      "serviceplanid": "13f19896-b6e3-4266-be59-523480cf63a1",
      "splanobjective": [
        {
          "needs": null,
          "status": "In Progress",
          "comments": null,
          "strengths": null,
          "activeflag": 1,
          "splangoalid": "94b58e12-b101-4f2b-8a47-6af8e4790d23",
          "objectivename": "Norah will work towards earning her GED. ",
          "splanobjectiveid": "ad0d7e3e-8cf0-4460-921b-70e2e3d52654",
          "serviceplanaction": [
            {
              "status": "In Progress",
              "enddate": "2023-08-24T08:00:00.000Z",
              "planfor": "IHSFP",
              "comments": null,
              "plantype": null,
              "startdate": "2023-08-04T08:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "ad0d7e3e-8cf0-4460-921b-70e2e3d52654",
              "personresponsible": "DANIELLE GREENE ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "2c529761-2e7f-420f-8cc1-b5d1fddba219",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Greene will follow-up with AACPS (South River High) regarding Norah getting into the GED program at AACC. To be reviewed by Worker during weekly visits. ",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "GREENE",
                    "personid": "1287c31d-10b7-4be2-8bdd-734821942a72",
                    "firstname": "DANIELLE",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "1287c31d-10b7-4be2-8bdd-734821942a72",
                  "serviceplanactionid": "2c529761-2e7f-420f-8cc1-b5d1fddba219",
                  "serviceplanpersoninvolvedid": "05a146e2-0f41-41fa-afed-bfb3a10e922f"
                },
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Willis",
                    "personid": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                    "firstname": "Brent \"Norah\"",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                  "serviceplanactionid": "2c529761-2e7f-420f-8cc1-b5d1fddba219",
                  "serviceplanpersoninvolvedid": "ca16cb80-1644-45c6-92fc-c71021d6509b"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-08-24T08:00:00.000Z",
              "planfor": "IHSFP",
              "comments": null,
              "plantype": null,
              "startdate": "2023-08-04T08:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "ad0d7e3e-8cf0-4460-921b-70e2e3d52654",
              "personresponsible": "SamanthaMarkley",
              "serviceplanoutcome": null,
              "serviceplanactionid": "45def8b1-42e8-4903-a18e-47c71cf2155d",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Workers will provide the family with a Netbook to assist with Norah being able to work towards obtaining her GED. TO be reviewed by Worker during weekly visits. ",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Willis",
                    "personid": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                    "firstname": "Brent \"Norah\"",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "76b04c3d-1f50-40b3-9435-fcbd9d6bac07",
                  "serviceplanactionid": "45def8b1-42e8-4903-a18e-47c71cf2155d",
                  "serviceplanpersoninvolvedid": "39dc6cb7-6b30-4201-9ab1-059b7c7472f5"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "GREENE",
                    "personid": "1287c31d-10b7-4be2-8bdd-734821942a72",
                    "firstname": "DANIELLE",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "1287c31d-10b7-4be2-8bdd-734821942a72",
                  "serviceplanactionid": "45def8b1-42e8-4903-a18e-47c71cf2155d",
                  "serviceplanpersoninvolvedid": "98f2a6c2-cc16-4ff0-8ed4-83e544606beb"
                }
              ]
            }
          ],
          "approvalstatustypekey": null
        }
      ],
      "approvalstatustypekey": null
    }
  ]'::jsonb, true)
      
 where id :: character varying   = 'ff46ab91-928e-458a-a82d-0ef04c91b9b3' :: character varying and activeflag =1;

   	
   	
