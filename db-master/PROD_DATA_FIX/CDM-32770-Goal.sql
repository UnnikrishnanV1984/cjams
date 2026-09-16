/*
   Issue Description: CDM-32770
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
      "splangoalid": "43209c67-a50d-4df5-9e34-53b4b8cc26ab",
      "serviceplanid": "3e08e97e-1555-42ef-97de-83c554d9b10b",
      "splanobjective": [
        {
          "needs": null,
          "status": "In Progress",
          "comments": "",
          "strengths": null,
          "activeflag": 1,
          "splangoalid": "43209c67-a50d-4df5-9e34-53b4b8cc26ab",
          "objectivename": "Cecilia Clara will have regular contact with extended family members.",
          "splanobjectiveid": "f106f644-fb8e-4fae-b11e-5d31d1bf4569",
          "serviceplanaction": [
            {
              "status": "In Progress",
              "enddate": "2023-06-01T08:00:00.000Z",
              "planfor": "OOH",
              "comments": null,
              "plantype": null,
              "startdate": "2023-01-01T10:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "f106f644-fb8e-4fae-b11e-5d31d1bf4569",
              "personresponsible": "Melinda Boykin ,AbigailStevens",
              "serviceplanoutcome": null,
              "serviceplanactionid": "9bb56dfe-8371-473d-89c5-e5eada3d68e3",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Visitation with extended family members will be arranged between the Boykin family and/or the Department and the family members.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Clara",
                    "personid": "92c2ee25-9862-4dae-900f-42f34ac51011",
                    "firstname": "Cecilia",
                    "activeflag": 1,
                    "middlename": "Marie"
                  },
                  "activeflag": 1,
                  "personinvolved": "92c2ee25-9862-4dae-900f-42f34ac51011",
                  "serviceplanactionid": "9bb56dfe-8371-473d-89c5-e5eada3d68e3",
                  "serviceplanpersoninvolvedid": "9db13360-f67f-4e41-9d2e-d708eaba67b2"
                }
              ]
            }
          ],
		  
		  
          "approvalstatustypekey": null
        },
        {
          "needs": null,
          "status": "In Progress",
          "comments": null,
          "strengths": null,
          "activeflag": 1,
          "splangoalid": "43209c67-a50d-4df5-9e34-53b4b8cc26ab",
          "objectivename": "Mr. Clara and Ms. Moy will maintain regular visitation with Cecilia.",
          "splanobjectiveid": "1949a056-0d34-42a6-948f-7fff324a5210",
          "serviceplanaction": [
            {
              "status": "In Progress",
              "enddate": "2023-06-01T12:00:00.000Z",
              "planfor": "OOH",
              "comments": null,
              "plantype": null,
              "startdate": "2023-01-01T15:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "1949a056-0d34-42a6-948f-7fff324a5210",
              "personresponsible": "BRITTANY MOY ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "707ed692-f923-4350-aefa-d8a822e5ca53",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Moy will attend all scheduled in-person or virtual visitations.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Clara",
                    "personid": "92c2ee25-9862-4dae-900f-42f34ac51011",
                    "firstname": "Cecilia",
                    "activeflag": 1,
                    "middlename": "Marie"
                  },
                  "activeflag": 1,
                  "personinvolved": "92c2ee25-9862-4dae-900f-42f34ac51011",
                  "serviceplanactionid": "707ed692-f923-4350-aefa-d8a822e5ca53",
                  "serviceplanpersoninvolvedid": "d8a9c1ef-805c-4384-85e3-cc55cc442909"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-06-01T12:00:00.000Z",
              "planfor": "OOH",
              "comments": null,
              "plantype": null,
              "startdate": "2023-01-01T15:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "1949a056-0d34-42a6-948f-7fff324a5210",
              "personresponsible": "BRITTANY MOY ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "682cb2d4-93bd-4ce7-99c3-f35c4cb4f431",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Mr. Clara will attend all scheduled in-person or virtual visitations.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Clara",
                    "personid": "92c2ee25-9862-4dae-900f-42f34ac51011",
                    "firstname": "Cecilia",
                    "activeflag": 1,
                    "middlename": "Marie"
                  },
                  "activeflag": 1,
                  "personinvolved": "92c2ee25-9862-4dae-900f-42f34ac51011",
                  "serviceplanactionid": "682cb2d4-93bd-4ce7-99c3-f35c4cb4f431",
                  "serviceplanpersoninvolvedid": "24e5ba4a-64af-4e88-8eb5-51822fd7da04"
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
      "splangoalid": "6ec1f88e-55d3-4d4d-a8f8-a822f65e2cb0",
      "serviceplanid": "3e08e97e-1555-42ef-97de-83c554d9b10b",
      "splanobjective": [
        {
          "needs": null,
          "status": "In Progress",
          "comments": null,
          "strengths": null,
          "activeflag": 1,
          "splangoalid": "6ec1f88e-55d3-4d4d-a8f8-a822f65e2cb0",
          "objectivename": "Cecilia Clara will have her medical needs met.",
          "splanobjectiveid": "fecd659e-17a8-428a-b852-285d44df8f93",
          "serviceplanaction": [
            {
              "status": "In Progress",
              "enddate": "2023-06-01T08:00:00.000Z",
              "planfor": null,
              "comments": null,
              "plantype": null,
              "startdate": "2023-01-01T10:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "fecd659e-17a8-428a-b852-285d44df8f93",
              "personresponsible": "Melinda Boykin ,AbigailStevens",
              "serviceplanoutcome": null,
              "serviceplanactionid": "3377196e-12e7-4cc9-a097-3c7a623fd580",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Boykin will take Cecilia to all regularly scheduled doctors appointments and any follow-up or specialty appointments needed.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Boykin",
                    "personid": "a22718df-c733-41fa-854a-44d980854e40",
                    "firstname": "Melinda",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "a22718df-c733-41fa-854a-44d980854e40",
                  "serviceplanactionid": "3377196e-12e7-4cc9-a097-3c7a623fd580",
                  "serviceplanpersoninvolvedid": "7c2cb504-96e2-4b74-9c01-3efe1fb9e394"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-07-01T08:00:00.000Z",
              "planfor": "OOH",
              "comments": "",
              "plantype": null,
              "startdate": "2023-07-01T08:00:00.000Z",
              "activeflag": 1,
              "goalreason": "",
              "splanobjectiveid": "fecd659e-17a8-428a-b852-285d44df8f93",
              "personresponsible": "CAMERON CLARA ,BRITTANY MOY ,AbigailStevens",
              "serviceplanoutcome": "",
              "serviceplanactionid": "5ef6ccab-9022-47aa-b753-a77c92f0f501",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Mr. Clara and Ms. Moy will attend all of Cecilias regularly scheduled doctors appointments and any follow-up or specialty appointments needed.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Clara",
                    "personid": "92c2ee25-9862-4dae-900f-42f34ac51011",
                    "firstname": "Cecilia",
                    "activeflag": 1,
                    "middlename": "Marie"
                  },
                  "activeflag": 1,
                  "personinvolved": "92c2ee25-9862-4dae-900f-42f34ac51011",
                  "serviceplanactionid": "5ef6ccab-9022-47aa-b753-a77c92f0f501",
                  "serviceplanpersoninvolvedid": "7de629d8-8281-41ab-9196-b971bb1eef91"
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
      "goalname": "Families have enhanced capacity to provide for their youths needs",
      "activeflag": 1,
      "splangoalid": "cc006747-fef2-40b8-91a7-07afd8844377",
      "serviceplanid": "3e08e97e-1555-42ef-97de-83c554d9b10b",
      "splanobjective": [
        {
          "needs": null,
          "status": "In Progress",
          "comments": "",
          "strengths": null,
          "activeflag": 1,
          "splangoalid": "cc006747-fef2-40b8-91a7-07afd8844377",
          "objectivename": "Mr. Clara and Ms. Moy will engage in visitation coaching services.",
          "splanobjectiveid": "0c3a34ff-f8ec-4654-b6cb-5d59fa5e70f7",
          "serviceplanaction": [
            {
              "status": "In Progress",
              "enddate": "2024-01-11T10:00:00.000Z",
              "planfor": "AXYS",
              "comments": "Mr. Clara and Ms. Moy attend weekly parent coaching through the Mental Health Association of Frederick County. ",
              "plantype": null,
              "startdate": "2023-04-10T08:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "0c3a34ff-f8ec-4654-b6cb-5d59fa5e70f7",
              "personresponsible": "CAMERON CLARA ,BRITTANY MOY ,AbigailStevens",
              "serviceplanoutcome": null,
              "serviceplanactionid": "04f41e6b-0b7b-4a96-b4b0-bad882a91065",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Mr. Clara and Ms. Moy will continue to participate in weekly parent coaching sessions. ",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "CLARA",
                    "personid": "0890e1df-ce65-4901-8b6c-e9706627e604",
                    "firstname": "CAMERON",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "0890e1df-ce65-4901-8b6c-e9706627e604",
                  "serviceplanactionid": "04f41e6b-0b7b-4a96-b4b0-bad882a91065",
                  "serviceplanpersoninvolvedid": "5da74a7c-04a6-4905-bc17-504e88d13c4f"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "MOY",
                    "personid": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                    "firstname": "BRITTANY",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                  "serviceplanactionid": "04f41e6b-0b7b-4a96-b4b0-bad882a91065",
                  "serviceplanpersoninvolvedid": "bdba4c2c-60af-4fac-a0f4-8ec718c77bb7"
                },
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Clara",
                    "personid": "92c2ee25-9862-4dae-900f-42f34ac51011",
                    "firstname": "Cecilia",
                    "activeflag": 1,
                    "middlename": "Marie"
                  },
                  "activeflag": 1,
                  "personinvolved": "92c2ee25-9862-4dae-900f-42f34ac51011",
                  "serviceplanactionid": "04f41e6b-0b7b-4a96-b4b0-bad882a91065",
                  "serviceplanpersoninvolvedid": "ce845396-ca12-48cf-ace7-d389b5f6f913"
                }
              ]
            }
          ],
          "approvalstatustypekey": null
        },
        {
          "needs": [
            "Involvement with care",
            "Knowledge",
            "Safety"
          ],
          "status": "In Progress",
          "comments": "",
          "strengths": null,
          "activeflag": 1,
          "splangoalid": "cc006747-fef2-40b8-91a7-07afd8844377",
          "objectivename": "Mr. Clara and Ms. Moy will complete parenting classes. ",
          "splanobjectiveid": "12f57ea1-6f11-4ade-bb1b-30ae6b0857b3",
          "serviceplanaction": [
            {
              "status": "Achieved",
              "enddate": "2023-07-14T16:00:00.000Z",
              "planfor": "AXYS",
              "comments": "Mr. Clara and Ms. Moy completed parenting classes through The Family Tree in Baltimore on February 28th, 2023.  ",
              "plantype": null,
              "startdate": "2023-02-07T20:00:00.000Z",
              "activeflag": 1,
              "goalreason": "",
              "splanobjectiveid": "12f57ea1-6f11-4ade-bb1b-30ae6b0857b3",
              "personresponsible": "CAMERON CLARA ,JENNIFER MOY ,AbigailStevens",
              "serviceplanoutcome": "",
              "serviceplanactionid": "0de9eb07-5228-40a0-b797-de21124c6aea",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Mr. Clara and Ms. Moy will continue to participate in parenting education classes until completion. ",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": "",
                    "lastname": "Clara",
                    "personid": "92c2ee25-9862-4dae-900f-42f34ac51011",
                    "firstname": "Cecilia",
                    "activeflag": 1,
                    "middlename": "Marie"
                  },
                  "activeflag": 1,
                  "personinvolved": "92c2ee25-9862-4dae-900f-42f34ac51011",
                  "serviceplanactionid": "0de9eb07-5228-40a0-b797-de21124c6aea",
                  "serviceplanpersoninvolvedid": "315f7dc6-59df-443a-ada0-e437fb0231b5"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "CLARA",
                    "personid": "0890e1df-ce65-4901-8b6c-e9706627e604",
                    "firstname": "CAMERON",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "0890e1df-ce65-4901-8b6c-e9706627e604",
                  "serviceplanactionid": "0de9eb07-5228-40a0-b797-de21124c6aea",
                  "serviceplanpersoninvolvedid": "4e609531-7926-4e91-b99c-8ae0062673f4"
                },
                {
                  "person": {
                    "suffix": null,
                    "lastname": "MOY",
                    "personid": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                    "firstname": "BRITTANY",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                  "serviceplanactionid": "0de9eb07-5228-40a0-b797-de21124c6aea",
                  "serviceplanpersoninvolvedid": "a7c47666-d6e5-41c4-8c5b-c6ad66724e8c"
                }
              ]
            }
          ],
          "approvalstatustypekey": null
        },
        {
          "needs": [],
          "status": "In Progress",
          "comments": "",
          "strengths": null,
          "activeflag": 1,
          "splangoalid": "cc006747-fef2-40b8-91a7-07afd8844377",
          "objectivename": "Mr. Clara and Ms. Moy will provide a safe and stable home for Cecilia.",
          "splanobjectiveid": "1f144f1f-d7f8-4fa1-8562-d6ec8aa6e88e",
          "serviceplanaction": [
            {
              "status": "In Progress",
              "enddate": "2023-06-01T08:00:00.000Z",
              "planfor": "AXYS",
              "comments": null,
              "plantype": null,
              "startdate": "2023-01-01T10:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "1f144f1f-d7f8-4fa1-8562-d6ec8aa6e88e",
              "personresponsible": "CAMERON CLARA ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "74e239d8-13c3-4bed-aa5c-31072e9d6753",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Mr. Clara will obtain and maintain stable employment.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "CLARA",
                    "personid": "0890e1df-ce65-4901-8b6c-e9706627e604",
                    "firstname": "CAMERON",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "0890e1df-ce65-4901-8b6c-e9706627e604",
                  "serviceplanactionid": "74e239d8-13c3-4bed-aa5c-31072e9d6753",
                  "serviceplanpersoninvolvedid": "b9c9b864-430a-406f-9742-9f6e589e32db"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-06-01T08:00:00.000Z",
              "planfor": "AXYS",
              "comments": null,
              "plantype": null,
              "startdate": "2023-01-01T10:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "1f144f1f-d7f8-4fa1-8562-d6ec8aa6e88e",
              "personresponsible": "BRITTANY MOY ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "a3826336-ddee-4917-8029-c9858e3038c8",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Moy will obtain and maintain stable employment.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "MOY",
                    "personid": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                    "firstname": "BRITTANY",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                  "serviceplanactionid": "a3826336-ddee-4917-8029-c9858e3038c8",
                  "serviceplanpersoninvolvedid": "616caef1-96f6-499b-bef4-8a968b175af9"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-06-01T08:00:00.000Z",
              "planfor": "AXYS",
              "comments": null,
              "plantype": null,
              "startdate": "2023-01-01T10:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "1f144f1f-d7f8-4fa1-8562-d6ec8aa6e88e",
              "personresponsible": "CAMERON CLARA ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "40fc68f0-91fe-41b9-bd48-bcbd18f6dc6a",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Clara will obtain and maintain safe and appropriate housing.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "CLARA",
                    "personid": "0890e1df-ce65-4901-8b6c-e9706627e604",
                    "firstname": "CAMERON",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "0890e1df-ce65-4901-8b6c-e9706627e604",
                  "serviceplanactionid": "40fc68f0-91fe-41b9-bd48-bcbd18f6dc6a",
                  "serviceplanpersoninvolvedid": "82d3a57f-95dd-415b-87c0-bc1bac43e29f"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-06-01T08:00:00.000Z",
              "planfor": "AXYS",
              "comments": null,
              "plantype": null,
              "startdate": "2023-01-01T10:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "1f144f1f-d7f8-4fa1-8562-d6ec8aa6e88e",
              "personresponsible": "BRITTANY MOY ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "d03e08fd-ccb2-4574-9341-e89963081742",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Moy will obtain and maintain safe and appropriate housing.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "MOY",
                    "personid": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                    "firstname": "BRITTANY",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                  "serviceplanactionid": "d03e08fd-ccb2-4574-9341-e89963081742",
                  "serviceplanpersoninvolvedid": "256fef8c-e0ab-4e6b-81d6-acb823fd2b9b"
                }
              ]
            }
          ],
          "approvalstatustypekey": null
        },
        {
          "needs": null,
          "status": "In Progress",
          "comments": "",
          "strengths": null,
          "activeflag": 1,
          "splangoalid": "cc006747-fef2-40b8-91a7-07afd8844377",
          "objectivename": "Ms. Moy will remain drug and alcohol free, shall not use any intoxicants, and shall not abuse any prescription medications.",
          "splanobjectiveid": "f5ebbd6c-9cf6-449e-bb14-6074423419d7",
          "serviceplanaction": [
            {
              "status": "Achieved",
              "enddate": "2023-06-01T12:00:00.000Z",
              "planfor": "AXYS",
              "comments": "Ms. Moy completed a substance abuse evaluation and initial treatment plan 1/25/23 with Treyway Multitreatment Services. ",
              "plantype": null,
              "startdate": "2023-01-01T15:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "f5ebbd6c-9cf6-449e-bb14-6074423419d7",
              "personresponsible": "BRITTANY MOY ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "b7905311-ca2c-47d7-9a43-2ba5b04dbb4f",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Moy will have a substance abuse evaluation.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "MOY",
                    "personid": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                    "firstname": "BRITTANY",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                  "serviceplanactionid": "b7905311-ca2c-47d7-9a43-2ba5b04dbb4f",
                  "serviceplanpersoninvolvedid": "bc19248f-ad11-4867-b1cf-5c55e2302f45"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-06-01T08:00:00.000Z",
              "planfor": "AXYS",
              "comments": null,
              "plantype": null,
              "startdate": "2023-01-01T10:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "f5ebbd6c-9cf6-449e-bb14-6074423419d7",
              "personresponsible": "BRITTANY MOY ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "ce57b387-88a0-4071-9136-8db9c95b510c",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Moy will follow recommendations of substance abuse evaluations.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "MOY",
                    "personid": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                    "firstname": "BRITTANY",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                  "serviceplanactionid": "ce57b387-88a0-4071-9136-8db9c95b510c",
                  "serviceplanpersoninvolvedid": "2b117c26-6172-4bc0-baa7-d7941e7a8079"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-06-01T08:00:00.000Z",
              "planfor": "AXYS",
              "comments": null,
              "plantype": null,
              "startdate": "2023-01-01T10:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "f5ebbd6c-9cf6-449e-bb14-6074423419d7",
              "personresponsible": "BRITTANY MOY ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "5a93680a-0b54-4fb3-9519-667ee30a762b",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Moy will submit to random substance abuse tests.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "MOY",
                    "personid": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                    "firstname": "BRITTANY",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                  "serviceplanactionid": "5a93680a-0b54-4fb3-9519-667ee30a762b",
                  "serviceplanpersoninvolvedid": "7e129593-cbe1-4bef-bfb4-f4936bdeaca8"
                }
              ]
            }
          ],
          "approvalstatustypekey": null
        },
        {
          "needs": [],
          "status": "In Progress",
          "comments": "",
          "strengths": null,
          "activeflag": 1,
          "splangoalid": "cc006747-fef2-40b8-91a7-07afd8844377",
          "objectivename": "Mr. Clara will remain drug and alcohol free, shall not use any intoxicants, and shall not abuse any prescription medications.",
          "splanobjectiveid": "f5d4d365-58e6-48c2-b1c8-2a9c03f8d8a7",
          "serviceplanaction": [
            {
              "status": "Achieved",
              "enddate": "2023-06-01T16:00:00.000Z",
              "planfor": "AXYS",
              "comments": "Mr. Clara completed his substance abuse evaluation and initial treatment plan on 1/26/2023 through Treyway Multitreatment Services. ",
              "plantype": null,
              "startdate": "2023-01-01T20:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "f5d4d365-58e6-48c2-b1c8-2a9c03f8d8a7",
              "personresponsible": "CAMERON CLARA ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "309bf335-be6e-40e7-b18a-13e795691686",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Mr. Clara will have a substance abuse evaluation.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "CLARA",
                    "personid": "0890e1df-ce65-4901-8b6c-e9706627e604",
                    "firstname": "CAMERON",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "0890e1df-ce65-4901-8b6c-e9706627e604",
                  "serviceplanactionid": "309bf335-be6e-40e7-b18a-13e795691686",
                  "serviceplanpersoninvolvedid": "14a77dea-9cf2-4f30-af99-364b02d44d9b"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-06-01T08:00:00.000Z",
              "planfor": "AXYS",
              "comments": null,
              "plantype": null,
              "startdate": "2023-01-01T10:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "f5d4d365-58e6-48c2-b1c8-2a9c03f8d8a7",
              "personresponsible": "CAMERON CLARA ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "4a0e4699-4734-440d-aa0f-8305f01498da",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Mr. Clara will follow recommendations for substance abuse evaluation.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "CLARA",
                    "personid": "0890e1df-ce65-4901-8b6c-e9706627e604",
                    "firstname": "CAMERON",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "0890e1df-ce65-4901-8b6c-e9706627e604",
                  "serviceplanactionid": "4a0e4699-4734-440d-aa0f-8305f01498da",
                  "serviceplanpersoninvolvedid": "321b1724-1a94-46f2-93b2-fae6ce14e990"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-06-01T08:00:00.000Z",
              "planfor": "AXYS",
              "comments": null,
              "plantype": null,
              "startdate": "2023-01-01T10:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "f5d4d365-58e6-48c2-b1c8-2a9c03f8d8a7",
              "personresponsible": "CAMERON CLARA ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "05f92ac8-e226-42be-b320-9a9837ded73c",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Mr. Clara shall submit to random substance abuse tests.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "CLARA",
                    "personid": "0890e1df-ce65-4901-8b6c-e9706627e604",
                    "firstname": "CAMERON",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "0890e1df-ce65-4901-8b6c-e9706627e604",
                  "serviceplanactionid": "05f92ac8-e226-42be-b320-9a9837ded73c",
                  "serviceplanpersoninvolvedid": "264e0553-0e71-43de-92f1-f0356b3b4ac0"
                }
              ]
            }
          ],
          "approvalstatustypekey": null
        },
        {
          "needs": null,
          "status": "In Progress",
          "comments": "",
          "strengths": null,
          "activeflag": 1,
          "splangoalid": "cc006747-fef2-40b8-91a7-07afd8844377",
          "objectivename": "Mr. Clara will have his mental health needs met",
          "splanobjectiveid": "5e433ff6-5e60-4cb0-b541-7b63b117c229",
          "serviceplanaction": [
            {
              "status": "Achieved",
              "enddate": "2023-06-01T16:00:00.000Z",
              "planfor": "AXYS",
              "comments": "Mr. Clara completed a mental health evaluation on 5/31/2023 through Quincy Orchard Psychotherapy. ",
              "plantype": null,
              "startdate": "2023-01-01T20:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "5e433ff6-5e60-4cb0-b541-7b63b117c229",
              "personresponsible": "CAMERON CLARA ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "76b97784-03fc-48a8-9d94-cdeda20e57dc",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Mr. Clara will have his mental health needs met",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "CLARA",
                    "personid": "0890e1df-ce65-4901-8b6c-e9706627e604",
                    "firstname": "CAMERON",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "0890e1df-ce65-4901-8b6c-e9706627e604",
                  "serviceplanactionid": "76b97784-03fc-48a8-9d94-cdeda20e57dc",
                  "serviceplanpersoninvolvedid": "2a31e0b7-70e6-4e3e-92e8-c7cafc2cb099"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-06-01T08:00:00.000Z",
              "planfor": "AXYS",
              "comments": null,
              "plantype": null,
              "startdate": "2023-01-01T10:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "5e433ff6-5e60-4cb0-b541-7b63b117c229",
              "personresponsible": "CAMERON CLARA ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "99613db9-3559-4bd7-af47-f6a6130b24bc",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Mr. Clara will follow recommendations from mental health evaluations.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "CLARA",
                    "personid": "0890e1df-ce65-4901-8b6c-e9706627e604",
                    "firstname": "CAMERON",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "0890e1df-ce65-4901-8b6c-e9706627e604",
                  "serviceplanactionid": "99613db9-3559-4bd7-af47-f6a6130b24bc",
                  "serviceplanpersoninvolvedid": "4a01b4dc-462a-493b-a3b9-3d62fef60ca9"
                }
              ]
            }
          ],
          "approvalstatustypekey": null
        },
        {
          "needs": [],
          "status": "In Progress",
          "comments": "",
          "strengths": null,
          "activeflag": 1,
          "splangoalid": "cc006747-fef2-40b8-91a7-07afd8844377",
          "objectivename": "Ms. Moy will have her mental health needs met",
          "splanobjectiveid": "6e2e36dd-495c-494a-b2fa-2642e6bb9ae4",
          "serviceplanaction": [
            {
              "status": "Achieved",
              "enddate": "2023-06-01T20:00:00.000Z",
              "planfor": "AXYS",
              "comments": "Ms. Moy completed a mental status evaluation on 12/30/23 with her mental health provider and continues to attend therapy through Live Balance Life. ",
              "plantype": null,
              "startdate": "2023-01-02T01:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "6e2e36dd-495c-494a-b2fa-2642e6bb9ae4",
              "personresponsible": "BRITTANY MOY ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "cc688314-8e4a-44dd-8b7b-de14425f8d95",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Moy will have a mental health evaluation ",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "MOY",
                    "personid": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                    "firstname": "BRITTANY",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                  "serviceplanactionid": "cc688314-8e4a-44dd-8b7b-de14425f8d95",
                  "serviceplanpersoninvolvedid": "6977acc0-0664-4cf8-83c6-ee445ec7932d"
                }
              ]
            },
            {
              "status": "In Progress",
              "enddate": "2023-06-01T08:00:00.000Z",
              "planfor": "AXYS",
              "comments": null,
              "plantype": null,
              "startdate": "2023-01-01T10:00:00.000Z",
              "activeflag": 1,
              "goalreason": null,
              "splanobjectiveid": "6e2e36dd-495c-494a-b2fa-2642e6bb9ae4",
              "personresponsible": "BRITTANY MOY ",
              "serviceplanoutcome": null,
              "serviceplanactionid": "3b136f74-abe3-4bca-99fb-d8c6eecc4a7c",
              "approvalstatustypekey": null,
              "serviceplanactionname": "Ms. Moy will follow recommendations from mental health evaluations.",
              "serviceplanpersoninvolved": [
                {
                  "person": {
                    "suffix": null,
                    "lastname": "MOY",
                    "personid": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                    "firstname": "BRITTANY",
                    "activeflag": 1,
                    "middlename": ""
                  },
                  "activeflag": 1,
                  "personinvolved": "e2d73fee-72ab-4ae1-aa97-4a77ece4d4ae",
                  "serviceplanactionid": "3b136f74-abe3-4bca-99fb-d8c6eecc4a7c",
                  "serviceplanpersoninvolvedid": "ab2972b8-3678-4963-9065-ac1bab34e187"
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
      
 where id :: character varying   = '8f7cb3d4-c28c-4e23-968d-8cc513832b7a' :: character varying and activeflag =1;











