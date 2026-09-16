/*
 * CDM-34536 - language
 * Customer Email ID:ashley.williams@maryland.gov
 * Description - 231030167876:In the service plan I add English and Amharic, 
 * but once I printed the services plan the Amharic language was removed. In its place was boxes. 
 * Case # 231030167876 - Old Service Plan - The Amharic language is not appear on the PDF (In-Home & OOH)
 * Category/ Module  : Serviceplan 
 * Fix Provided: Did data fix to update those goals into the serviceplan version 
 */


update cjams.snapshothist
SET snapshotdata = jsonb_set(snapshotdata::jsonb, '{splangoal}',
'[
  {
    "splangoalid": "dc44fb44-d534-4708-980b-73f57d61a151",
    "serviceplanid": "ee8f1212-289f-4c6c-a825-7094aad3fe05",
    "goalname": "Youth physical and mental health needs are met",
    "approvalstatustypekey": null,
    "activeflag": 1,
    "status": "In Progress",
    "splanobjective": [
      {
        "splanobjectiveid": "e6a189f8-3b45-4a61-b02b-02c86a52c24b",
        "splangoalid": "dc44fb44-d534-4708-980b-73f57d61a151",
        "objectivename": "The family will ensure that  Noah is connected to services that would address his needs with the Autism diagnosis by  February 12, 2024.ቤተሰቡ እስከ ፌብሩዋሪ 12፣ 2024 ድረስ ኖህ ፍላጎቱን ከኦቲዝም ምርመራ ጋር ከሚያሟሉ አገልግሎቶች ጋር የተገናኘ መሆኑን ያረጋግጣል።",
        "needs": null,
        "strengths": [
          "Financial Resources",
          "Knowledge of family-child needs",
          "Knowledge of rights & responsibilities"
        ],
        "approvalstatustypekey": null,
        "comments": "",
        "activeflag": 1,
        "status": "Achieved",
        "serviceplanaction": [
          {
            "serviceplanactionid": "de741005-489e-465c-83d0-9e933a8e9154",
            "splanobjectiveid": "e6a189f8-3b45-4a61-b02b-02c86a52c24b",
            "serviceplanactionname": "Mr. Mulugeta will make a intake appointment with Childrens National Hospital for Noah by December 15, 2023. The Department will monitor during weekly visit.አቶ ሙሉጌታ በታህሳስ 15 ቀን 2023 ከህጻናት ብሔራዊ ሆስፒታል ጋር ለኖህ አገልግሎት ይሰጣሉ። መምሪያው በሳምንታዊ ጉብኝት ወቅት ክትትል ያደርጋል።  ",
            "personresponsible": "Sirak Mulugeta ,Rahmete A Hussen ",
            "startdate": "2023-11-11T01:00:00.000Z",
            "enddate": "2024-02-13T01:00:00.000Z",
            "status": "Achieved",
            "approvalstatustypekey": null,
            "serviceplanoutcome": "",
            "goalreason": "",
            "comments": "",
            "activeflag": 1,
            "plantype": null,
            "planfor": "IHSFP",
            "serviceplanpersoninvolved": [
              {
                "serviceplanpersoninvolvedid": "4f63df2d-014d-40dc-a659-214d0410099c",
                "serviceplanactionid": "de741005-489e-465c-83d0-9e933a8e9154",
                "personinvolved": "50c150a3-1426-409c-8ec8-3800cb625eb8",
                "activeflag": 1,
                "person": {
                  "activeflag": 1,
                  "firstname": "Noah",
                  "lastname": "Sirak",
                  "middlename": "",
                  "personid": "50c150a3-1426-409c-8ec8-3800cb625eb8",
                  "suffix": ""
                }
              }
            ]
          },
          {
            "serviceplanactionid": "161221cf-89a0-4750-a0a9-2f9f487a94c0",
            "splanobjectiveid": "e6a189f8-3b45-4a61-b02b-02c86a52c24b",
            "serviceplanactionname": "Mr. Mulugeta will ensure that Noah attends his appointment with Childrens National to complete the intake process. The Department will monitor the progress of this task during weekly visiአቶ ሙሉጌታ የመግቢያ ሂደቱን ለማጠናቀቅ ኖህ ከህጻናት ብሄራዊ ጋር በነበራቸው ቀጠሮ መገኘታቸውን ያረጋግጣሉ። መምሪያው በየሳምንቱ በሚደረጉ ጉብኝቶች የዚህን ተግባር ሂደት ይከታተላል.ts.  ",
            "personresponsible": "Sirak Mulugeta ,Rahmete A Hussen ",
            "startdate": "2023-11-11T01:00:00.000Z",
            "enddate": "2024-02-13T01:00:00.000Z",
            "status": "Achieved",
            "approvalstatustypekey": null,
            "serviceplanoutcome": null,
            "goalreason": null,
            "comments": null,
            "activeflag": 1,
            "plantype": null,
            "planfor": "IHSFP",
            "serviceplanpersoninvolved": [
              {
                "serviceplanpersoninvolvedid": "58fb59a3-4169-4a57-8324-5f6d888194f9",
                "serviceplanactionid": "161221cf-89a0-4750-a0a9-2f9f487a94c0",
                "personinvolved": "50c150a3-1426-409c-8ec8-3800cb625eb8",
                "activeflag": 1,
                "person": {
                  "activeflag": 1,
                  "firstname": "Noah",
                  "lastname": "Sirak",
                  "middlename": "",
                  "personid": "50c150a3-1426-409c-8ec8-3800cb625eb8",
                  "suffix": ""
                }
              }
            ]
          },
          {
            "serviceplanactionid": "1749fc22-8847-4371-b31c-2f53013712fb",
            "splanobjectiveid": "e6a189f8-3b45-4a61-b02b-02c86a52c24b",
            "serviceplanactionname": "Mr. Mulugeta and Mrs. Hussen will provided the doctor accurate information about Noah, as requested by providers. The Department will montoir during weekly visit.  እነ አቶ ሙሉጌታ እና ወ/ሮ ሁሴን በአቅራቢዎች በተጠየቁት መሰረት ስለ ኖህ ትክክለኛ መረጃ ለዶክተሩ ያቀርቡታል። መምሪያው በሳምንታዊ ጉብኝት ወቅት ክትትል ያደርጋል።",
            "personresponsible": "Sirak Mulugeta ,Rahmete A Hussen ",
            "startdate": "2023-11-11T01:00:00.000Z",
            "enddate": "2024-02-13T01:00:00.000Z",
            "status": "Not Achieved",
            "approvalstatustypekey": null,
            "serviceplanoutcome": "",
            "goalreason": "Referral made but has not started",
            "comments": "",
            "activeflag": 1,
            "plantype": null,
            "planfor": "IHSFP",
            "serviceplanpersoninvolved": [
              {
                "serviceplanpersoninvolvedid": "63332ecf-9d91-4de0-b07d-d0d093b7c21c",
                "serviceplanactionid": "1749fc22-8847-4371-b31c-2f53013712fb",
                "personinvolved": "50c150a3-1426-409c-8ec8-3800cb625eb8",
                "activeflag": 1,
                "person": {
                  "activeflag": 1,
                  "firstname": "Noah",
                  "lastname": "Sirak",
                  "middlename": "",
                  "personid": "50c150a3-1426-409c-8ec8-3800cb625eb8",
                  "suffix": ""
                }
              }
            ]
          },
          {
            "serviceplanactionid": "93741dd1-6578-4c2d-8d4c-4cc4bf34e57e",
            "splanobjectiveid": "e6a189f8-3b45-4a61-b02b-02c86a52c24b",
            "serviceplanactionname": "The family will provide DDA with updated assessments for Noah.The Department will montoir during weekly visit. ቤተሰቡ ለዲዲኤ የተዘመነ የኖህ ግምገማዎችን ያቀርባል። መምሪያው በሳምንታዊ ጉብኝት ወቅት ክትትል ያደርጋል።",
            "personresponsible": "Sirak Mulugeta ,Rahmete A Hussen ",
            "startdate": "2023-11-10T20:00:00.000Z",
            "enddate": "2024-02-12T20:00:00.000Z",
            "status": "Achieved",
            "approvalstatustypekey": null,
            "serviceplanoutcome": null,
            "goalreason": null,
            "comments": null,
            "activeflag": 1,
            "plantype": null,
            "planfor": "IHSFP",
            "serviceplanpersoninvolved": [
              {
                "serviceplanpersoninvolvedid": "ca6fd619-3979-4512-971e-c914a0177b3e",
                "serviceplanactionid": "93741dd1-6578-4c2d-8d4c-4cc4bf34e57e",
                "personinvolved": "50c150a3-1426-409c-8ec8-3800cb625eb8",
                "activeflag": 1,
                "person": {
                  "activeflag": 1,
                  "firstname": "Noah",
                  "lastname": "Sirak",
                  "middlename": "",
                  "personid": "50c150a3-1426-409c-8ec8-3800cb625eb8",
                  "suffix": ""
                }
              }
            ]
          },
          {
            "serviceplanactionid": "623cf921-b9a6-4ef4-9f9c-c1975f66f099",
            "splanobjectiveid": "e6a189f8-3b45-4a61-b02b-02c86a52c24b",
            "serviceplanactionname": "The Department will provide the family with information to Childrens National Autism department.  መምሪያው ለቤተሰቡ መረጃ ለህፃናት ብሔራዊ ኦቲዝም ክፍል ይሰጣል።",
            "personresponsible": "Ashley Williams ",
            "startdate": "2023-11-11T11:00:00.000Z",
            "enddate": "2024-02-12T10:00:00.000Z",
            "status": "Achieved",
            "approvalstatustypekey": null,
            "serviceplanoutcome": null,
            "goalreason": null,
            "comments": null,
            "activeflag": 1,
            "plantype": null,
            "planfor": "IHSFP",
            "serviceplanpersoninvolved": [
              {
                "serviceplanpersoninvolvedid": "d2035770-73d6-43ed-a6f2-972d9d9d0d18",
                "serviceplanactionid": "623cf921-b9a6-4ef4-9f9c-c1975f66f099",
                "personinvolved": "50c150a3-1426-409c-8ec8-3800cb625eb8",
                "activeflag": 1,
                "person": {
                  "activeflag": 1,
                  "firstname": "Noah",
                  "lastname": "Sirak",
                  "middlename": "",
                  "personid": "50c150a3-1426-409c-8ec8-3800cb625eb8",
                  "suffix": ""
                }
              }
            ]
          },
          {
            "serviceplanactionid": "06e5c5e8-f55e-4742-9eef-4df0b44d45e6",
            "splanobjectiveid": "e6a189f8-3b45-4a61-b02b-02c86a52c24b",
            "serviceplanactionname": "The Department will provide an update to the school about Noahs new assessments. መምሪያው ስለ ኖህ አዳዲስ ግምገማዎች ለትምህርት ቤቱ ወቅታዊ መረጃ ይሰጣል",
            "personresponsible": "Ashley Williams ,Roy Bolden ",
            "startdate": "2023-11-10T20:00:00.000Z",
            "enddate": "2024-02-12T20:00:00.000Z",
            "status": "Achieved",
            "approvalstatustypekey": null,
            "serviceplanoutcome": null,
            "goalreason": null,
            "comments": null,
            "activeflag": 1,
            "plantype": null,
            "planfor": "IHSFP",
            "serviceplanpersoninvolved": [
              {
                "serviceplanpersoninvolvedid": "5e6dbe38-4d0c-48f5-844c-8c63f3d93e1e",
                "serviceplanactionid": "06e5c5e8-f55e-4742-9eef-4df0b44d45e6",
                "personinvolved": "50c150a3-1426-409c-8ec8-3800cb625eb8",
                "activeflag": 1,
                "person": {
                  "activeflag": 1,
                  "firstname": "Noah",
                  "lastname": "Sirak",
                  "middlename": "",
                  "personid": "50c150a3-1426-409c-8ec8-3800cb625eb8",
                  "suffix": ""
                }
              }
            ]
          },
          {
            "serviceplanactionid": "6996725d-a8d8-4f15-aca5-6845fa0ce806",
            "splanobjectiveid": "e6a189f8-3b45-4a61-b02b-02c86a52c24b",
            "serviceplanactionname": "The Department will obtain the information about Noahs assessments from Childrens National. መምሪያው ስለ ኖህ ግምገማዎች መረጃውን ከህፃናት ብሄራዊ ይቀበላል።",
            "personresponsible": "Ashley Williams ",
            "startdate": "2023-11-10T20:00:00.000Z",
            "enddate": "2024-02-12T20:00:00.000Z",
            "status": "Achieved",
            "approvalstatustypekey": null,
            "serviceplanoutcome": null,
            "goalreason": null,
            "comments": null,
            "activeflag": 1,
            "plantype": null,
            "planfor": "IHSFP",
            "serviceplanpersoninvolved": [
              {
                "serviceplanpersoninvolvedid": "1082d5d9-1c45-4efc-8f1b-b1154df69328",
                "serviceplanactionid": "6996725d-a8d8-4f15-aca5-6845fa0ce806",
                "personinvolved": "50c150a3-1426-409c-8ec8-3800cb625eb8",
                "activeflag": 1,
                "person": {
                  "activeflag": 1,
                  "firstname": "Noah",
                  "lastname": "Sirak",
                  "middlename": "",
                  "personid": "50c150a3-1426-409c-8ec8-3800cb625eb8",
                  "suffix": ""
                }
              }
            ]
          }
        ]
      }
    ]
  }
]'::jsonb, true)
      
 where id :: character varying   = 'df579b61-344f-4160-abe3-4ac8a407eb94' :: character varying and activeflag =1;
