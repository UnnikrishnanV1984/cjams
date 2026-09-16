/*
Issue Description:CJAMS-60858 Case Plan not auto populating updated permanency plan
Category/Module: Case plan 
Root cause: Case plan is fetching data from the old permanency plan and we are unable to reproduce this issue for different cases.
            Data fix has been to done to update the correct reason
Fix provided: Data fix has been done to update the correct reason in the case plan
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#:N/A
Reason why no related code fix: We have tried to replicate this issue and it is working as expected. We need to investigate further if this issue happens in other cases.
*/


update snapshothist
set snapshotdata = '[
  {
    "caseworker": "Melanie Adams",
    "jurisdiction": "St. Mary''s",
    "assetsdetails": [
      {
        "facevalue": 0,
        "detailtype": "None",
        "assettypekey": "NON",
        "disposaldate": null,
        "purchasedate": "2014-03-22T00:00:00"
      }
    ],
    "fatherdetails": {
      "dob": "1982-11-22T00:00:00",
      "akaname": " ",
      "clientid": 1123294,
      "ssnvalue": "214024382",
      "parentname": "MARIO BOWMAN",
      "phonenumber": null,
      "parentaddress": "P. O. BOX 313  CHAPTICO MD 206210000"
    },
    "headersection": {
      "dob": "2012-04-17T00:00:00",
      "cisid": "436047305",
      "mdm_id": "MDT-124659105",
      "enddate": "2025-07-22T04:00:00",
      "clientid": 3610356,
      "childname": "JACOB GEARHEART",
      "startdate": "2025-01-23T05:00:00"
    },
    "incomedetails": [
      {
        "amount": 0,
        "enddate": null,
        "startdate": "2014-03-22T00:00:00",
        "detailtype": "None - Unearned",
        "incomesourcetypekey": "4"
      },
      {
        "amount": 0,
        "enddate": null,
        "startdate": "2014-03-22T00:00:00",
        "detailtype": "None - Earned",
        "incomesourcetypekey": "13"
      }
    ],
    "motherdetails": {
      "dob": "1977-06-16T00:00:00",
      "akaname": " ",
      "clientid": 1111387,
      "ssnvalue": "217085955",
      "parentname": "PATRICIA GEARHEART",
      "phonenumber": null,
      "parentaddress": "46358 Columbus Dr Unit 1201 Lexington Park MD 20653"
    },
    "cplanquestions": null,
    "supportdetails": null,
    "childannualexam": null,
    "childinitialexam": null,
    "childremovaldate": "2014-03-22T00:00:00",
    "childfollowupexam": null,
    "servicecasenumber": "3088244",
    "childremovalreason": "(\"Child’s Disabilities\"),(Neglect)",
    "servicecourtdetails": null,
    "placementinformation": [
      {
        "address": "Name: Children''s Choice Lanham Address: 9601 Baltimore College Park Md 20740 Phone Number: 4105466106",
        "cpahomes": [
          {
            "exit_dt": "2016-06-29T00:00:00",
            "exit_tm": "1970-01-01T09:00:00",
            "entry_dt": "2016-03-28T00:00:00",
            "entry_tm": "1970-01-01T09:00:00",
            "cpaaddress": "1434 Clairidge Baltimore Md 21207",
            "provider_id": 5057815,
            "placement_id": 310921,
            "cpaprovidername": "Sharhonda Hudson"
          },
          {
            "exit_dt": "2016-07-22T00:00:00",
            "exit_tm": "1970-01-01T09:00:00",
            "entry_dt": "2016-06-29T00:00:00",
            "entry_tm": "1970-01-01T09:00:00",
            "cpaaddress": "907 Andean Goose Upper Marlboro Md 20774",
            "provider_id": 5057813,
            "placement_id": 310921,
            "cpaprovidername": "Mary Heyward"
          },
          {
            "exit_dt": "2018-04-01T00:00:00",
            "exit_tm": "1970-01-01T09:00:00",
            "entry_dt": "2016-07-22T00:00:00",
            "entry_tm": "1970-01-01T10:00:00",
            "cpaaddress": "20420 Apple Harvest Gaithersburg Md 20876",
            "provider_id": 5071626,
            "placement_id": 310921,
            "cpaprovidername": "Dione Moore"
          },
          {
            "exit_dt": null,
            "exit_tm": null,
            "entry_dt": "2018-04-01T00:00:00",
            "entry_tm": "1970-01-01T10:00:00",
            "cpaaddress": "1505 Branchwood Gambrills Md 21054",
            "provider_id": 5083333,
            "placement_id": 310921,
            "cpaprovidername": "Shirley King"
          }
        ],
        "serviceid": 78,
        "enddatetime": null,
        "servicename": "Treatment Foster Care (Private)",
        "placementtype": "Placement",
        "startdatetime": "2016-03-28T00:00:00",
        "livingarrangementtype": "Placement",
        "livingarrangementaddress": "Name:  Address: Derekwood 10001 Lanham Md 20706 Phone Number: "
      }
    ],
    "assessmentinformation": [
      {
        "outcome": "Unsafe",
        "assessmentname": "CANS-OUT OF HOME PLACEMENT SERVICE",
        "assessmentcompletiondate": "2025-06-26T16:20:53"
      },
      {
        "outcome": "Safe",
        "assessmentname": "SAFE-C OHP",
        "assessmentcompletiondate": "2025-07-18T15:39:19"
      },
      {
        "outcome": "Unsafe",
        "assessmentname": "CANS-OUT OF HOME PLACEMENT SERVICE",
        "assessmentcompletiondate": "2025-04-04T11:57:56"
      },
      {
        "outcome": "Safe",
        "assessmentname": "SAFE-C OHP",
        "assessmentcompletiondate": "2025-03-14T18:30:02.404812"
      }
    ],
    "childdbehaviourhealth": null,
    "childlegalinformation": [
      {
        "courtdocketnum": "43302",
        "hearingdetails": [
          {
            "hearingdate": "2025-03-19T09:00:00",
            "hearingtype": "Permanancy Plan Review",
            "hearingstatus": "Concluded"
          },
          {
            "hearingdate": "2025-06-18T09:00:00",
            "hearingtype": "CINA Review",
            "hearingstatus": "Concluded"
          }
        ],
        "childattorneyinfo": null
      },
      {
        "courtdocketnum": "C-18-JV-21-000011",
        "hearingdetails": [
          {
            "hearingdate": "2025-02-10T09:00:00",
            "hearingtype": "Status Conference",
            "hearingstatus": "Dismissed"
          },
          {
            "hearingdate": "2025-06-18T09:00:00",
            "hearingtype": "CINA Review",
            "hearingstatus": "Scheduled"
          },
          {
            "hearingdate": "2025-03-19T09:00:00",
            "hearingtype": "Permanancy Plan Review",
            "hearingstatus": "Concluded"
          }
        ],
        "childattorneyinfo": null
      }
    ],
    "visitationcourtdetails": null,
    "childtprlegalinformation": null,
    "caseworkerservicesandplan": {
      "establisheddate": "2025-03-19T04:00:00",
      "cuurentplacetolive": "Treatment Foster Care (Private)",
      "permanancyplandata": {
        "lifebookExpln": null,
        "isProviderAgree": "1",
        "permToPermExpln": "n/a",
        "courtOrdersExpln": "The worker monitors all of Jacob''s medical and mental health needs, as well as his visitation with his mother. ",
        "safeAndCareExpln": "The worker maintains monthly visit with Jacob in his foster home, as well as regular phone contact with his foster mother and Treatment Foster Care Worker. The worker has also met Jacob''s ABA Registered Behavior Technician and obtained a copy of Jacob''s ABA treatment plan. The worker referred Jacob to the Center for Autism for an evaluation and met with the evaluation team for the intake and results appointments. The worker submitted an application for DDA on Jacob''s behalf.  ",
        "isInClosedProximity": "0",
        "isProviderAgreeExpln": "Mrs. Finch would like to see Jacob return home if Ms. Gearheart is able to meet his needs. ",
        "assessmentPeriodExpln": "An FTDM was held in May 2025 to discuss the permanency plan for Jacob. This worker also met with Ms. Gearheart and her friend who has agreed to provide care for Jacob when Ms. Gearheart is working should he return home. A referral has been made for a parental capacity evaluation. ",
        "serviceAgreementExpln": "Ms. Gearheart signed a service agreement on April 2, 2025 and July 17, 2025. She agreed to attend IEP meetings, but there have not been any since February 2025. She agreed to maintain monthly visitation with the children. She had visitation in April, June and July. Due to being unable to have a visit in May, she had an additional visit in June 2025. ",
        "meetingSafetyNeedsExpln": "Mrs. Finch ensures that Jacob attends all medical, dental and optical appointments, and maintains contact with his school. She arranged for him to receive ABA services in the home. She ensures that he receives his medication daily. She has a goo relationship with Jacob''s mother and they work together to schedule his monthly visitation. Jacob appears to be comfortable in the home. ",
        "sixMonthsPlacementExpln": "Jacob has had no change in placement in the previous six months and none is expected  in the next 6 months. ",
        "isInClosedProximityExpln": "Jacob is placed in a treatment foster care home in Anne Arundel County the Chidlren''s Choice Treatment Foster Care Program.",
        "serviceAgreementForOtherExpln": "Contact was restabished between the Department and Jacob''s father, Mario Bowman. Mr. Bowman stated that he would like to visit with Jacob to get to know him again and establish a relationship. A visit was scheduled for April 2025 near the foster home, but Mr. Bowman, although initially agreeing to the location, stated that he was unable to attend due to the distance. A visit was then scheduled or June 2025 at McDonalds in Leonardtown. Mr. Bowman attended and spoke with Jacob, told him he loved him and was appropriate. Mr. Bowman failed to attend the court hearing that was held 2 days later and has not been back in touch with the Department since that time. "
      },
      "facetofacecontactdate": [
        {
          "insertedon": "2025-02-25T08:33:49.474549",
          "contactdate": "2025-02-20T00:00:00"
        },
        {
          "insertedon": "2025-02-25T08:33:49.474549",
          "contactdate": "2025-02-20T00:00:00"
        },
        {
          "insertedon": "2025-03-12T09:48:46.182813",
          "contactdate": "2025-03-10T00:00:00"
        },
        {
          "insertedon": "2025-04-09T16:42:47.063113",
          "contactdate": "2025-04-02T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-05-27T09:30:48.74761",
          "contactdate": "2025-05-22T00:00:00"
        },
        {
          "insertedon": "2025-06-16T14:07:24.420748",
          "contactdate": "2025-06-16T00:00:00"
        },
        {
          "insertedon": "2025-06-16T14:07:24.420748",
          "contactdate": "2025-06-16T00:00:00"
        },
        {
          "insertedon": "2025-06-16T14:07:24.420748",
          "contactdate": "2025-06-16T00:00:00"
        },
        {
          "insertedon": "2025-06-16T14:07:24.420748",
          "contactdate": "2025-06-16T00:00:00"
        },
        {
          "insertedon": "2025-06-16T14:07:24.420748",
          "contactdate": "2025-06-16T00:00:00"
        },
        {
          "insertedon": "2025-06-16T14:07:24.420748",
          "contactdate": "2025-06-16T00:00:00"
        },
        {
          "insertedon": "2025-06-16T14:07:24.420748",
          "contactdate": "2025-06-16T00:00:00"
        },
        {
          "insertedon": "2025-06-16T14:07:24.420748",
          "contactdate": "2025-06-16T00:00:00"
        },
        {
          "insertedon": "2025-06-16T14:07:24.420748",
          "contactdate": "2025-06-16T00:00:00"
        },
        {
          "insertedon": "2025-06-16T14:07:24.420748",
          "contactdate": "2025-06-16T00:00:00"
        },
        {
          "insertedon": "2025-06-16T14:07:24.420748",
          "contactdate": "2025-06-16T00:00:00"
        },
        {
          "insertedon": "2025-06-16T14:07:24.420748",
          "contactdate": "2025-06-16T00:00:00"
        },
        {
          "insertedon": "2025-06-18T13:12:34.641175",
          "contactdate": "2025-06-18T00:00:00"
        },
        {
          "insertedon": "2025-06-18T13:12:34.641175",
          "contactdate": "2025-06-18T00:00:00"
        },
        {
          "insertedon": "2025-06-18T13:12:34.641175",
          "contactdate": "2025-06-18T00:00:00"
        },
        {
          "insertedon": "2025-06-18T13:12:34.641175",
          "contactdate": "2025-06-18T00:00:00"
        },
        {
          "insertedon": "2025-06-18T13:12:34.641175",
          "contactdate": "2025-06-18T00:00:00"
        },
        {
          "insertedon": "2025-06-18T13:12:34.641175",
          "contactdate": "2025-06-18T00:00:00"
        },
        {
          "insertedon": "2025-06-18T13:12:34.641175",
          "contactdate": "2025-06-18T00:00:00"
        },
        {
          "insertedon": "2025-06-18T13:12:34.641175",
          "contactdate": "2025-06-18T00:00:00"
        },
        {
          "insertedon": "2025-07-14T15:59:09.300105",
          "contactdate": "2025-07-11T00:00:00"
        },
        {
          "insertedon": "2025-07-14T15:59:09.300105",
          "contactdate": "2025-07-11T00:00:00"
        }
      ],
      "primarypermanencytype": "Reunification",
      "treatmentteameetingdate": null,
      "concurrentpermanencytype": "Guardianship by relative"
    },
    "childeducationinformation": [
      {
        "end_dt": "06/30/2025",
        "sasidno": null,
        "setting": "Public",
        "tel_num": null,
        "start_dt": "09/06/2024",
        "school_nm": "Old Mill Middle School North",
        "grade_last": null,
        "mode_trans": "School Bus",
        "type_class": null,
        "edu_program": null,
        "exit_reason": null,
        "grade_current": "Grade 7",
        "fungrade_level": null,
        "school_address": "Old Mill Middle School North,,Maryland",
        "special_ed_code": null,
        "quarterly_grade1": null,
        "quarterly_grade2": null,
        "quarterly_grade3": null,
        "quarterly_grade4": null
      },
      {
        "end_dt": null,
        "sasidno": null,
        "setting": "Public",
        "tel_num": null,
        "start_dt": "07/07/2025",
        "school_nm": "Old Mill Middle School North",
        "grade_last": null,
        "mode_trans": "School Bus",
        "type_class": null,
        "edu_program": null,
        "exit_reason": null,
        "grade_current": "Grade 8",
        "fungrade_level": null,
        "school_address": "Old Mill Middle School North,,Maryland",
        "special_ed_code": null,
        "quarterly_grade1": null,
        "quarterly_grade2": null,
        "quarterly_grade3": null,
        "quarterly_grade4": null
      }
    ],
    "childdisabilityinformation": [
      {
        "end_dt": null,
        "distype": "Developmental Disability",
        "start_dt": "06/17/2014",
        "permanent": "No"
      },
      {
        "end_dt": null,
        "distype": "Intellectual Disability",
        "start_dt": "06/17/2014",
        "permanent": "No"
      },
      {
        "end_dt": null,
        "distype": "Other Diagnosed Condition",
        "start_dt": "04/17/2012",
        "permanent": "No"
      }
    ],
    "childemploymentinformation": null,
    "childmedicationinformation": null
  }
]',
    updatedon = now(),
    updatedby = 'CJAMS-60858'
WHERE 
    objectid = '344b42b3-1784-4e12-8ede-f89f17668514' 
    AND id = '6460ea8b-06b3-4754-8e65-1b4c4321f622' 
    AND activeflag = 1;