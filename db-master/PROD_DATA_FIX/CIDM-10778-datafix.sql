/*
Issue Description: CIDM-10778
Data Fix - Case Plan pulling wrong Permanency Plan
Category/Module: Case plan 
Root cause: Case plan is fetching data from the old permanency plan. Data fix has been to done to update the correct reason
Fix provided: Data fix has been done to update the correct reason in the case plan
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#:N/A
Reason why no related code fix: We have tried to replicate this issue and it is working as expected. We need to investigate further if this issue happens in other cases.
*/

update snapshothist 
set snapshotdata = '[
  {
    "caseworker": "Amanda Greenwood",
    "jurisdiction": "Carroll",
    "assetsdetails": [
      {
        "facevalue": 0,
        "detailtype": "None",
        "assettypekey": "NON",
        "disposaldate": null,
        "purchasedate": "2022-03-18T00:00:00"
      }
    ],
    "fatherdetails": {
      "dob": "1987-10-29T00:00:00",
      "akaname": " ",
      "clientid": 200410716,
      "ssnvalue": "623385685",
      "parentname": "DARYL GASSAWAY",
      "phonenumber": null,
      "parentaddress": "Rappahanock Regional Jail  1745 Richmond Hwy  Stafford VA 22554"
    },
    "headersection": {
      "dob": "2021-06-20T00:00:00",
      "cisid": "442061696",
      "mdm_id": "MDT-138482765",
      "enddate": "2025-08-29T15:20:27.538",
      "clientid": 200775427,
      "childname": "Khali Stauffer",
      "startdate": "2025-03-03T05:00:00"
    },
    "incomedetails": [
      {
        "amount": 0,
        "enddate": null,
        "startdate": "2022-03-18T00:00:00",
        "detailtype": "None - Earned",
        "incomesourcetypekey": "13"
      },
      {
        "amount": 0,
        "enddate": null,
        "startdate": "2022-03-18T00:00:00",
        "detailtype": "None - Unearned",
        "incomesourcetypekey": "4"
      }
    ],
    "motherdetails": {
      "dob": "1986-06-06T00:00:00",
      "akaname": "Lyndsay White",
      "clientid": 2389610,
      "ssnvalue": "218252091",
      "parentname": "LYNDSAY Stauffer",
      "phonenumber": null,
      "parentaddress": "94 W Main St  Westminster MD 21157"
    },
    "cplanquestions": null,
    "supportdetails": null,
    "childannualexam": [
      {
        "annualdate": "2025-07-07T00:00:00",
        "annualtype": "Annual Health Examination",
        "annualprovider": ""
      }
    ],
    "childinitialexam": null,
    "childremovaldate": "2022-03-18T00:00:00",
    "childfollowupexam": null,
    "servicecasenumber": "3306070",
    "childremovalreason": "(\"Drug Abuse (Parent)\"),(Abandonment)",
    "servicecourtdetails": {
      "courtorderdetails": "See Court Order in CJAMS documents"
    },
    "placementinformation": [
      {
        "address": "Name: Kristin Somers Address: 56 Houcksville Hampstead Md 21074 Phone Number: ",
        "cpahomes": null,
        "serviceid": 10,
        "enddatetime": null,
        "servicename": "Regular Foster Care",
        "placementtype": "Placement",
        "startdatetime": "2024-01-22T00:00:00",
        "livingarrangementtype": null,
        "livingarrangementaddress": "Name:  Address: Houcksville  Hampstead Md 21074 Phone Number: "
      }
    ],
    "assessmentinformation": [
      {
        "outcome": "Safe",
        "assessmentname": "SAFE-C OHP",
        "assessmentcompletiondate": "2025-08-07T14:52:18"
      },
      {
        "outcome": "Unsafe",
        "assessmentname": "cans-v2",
        "assessmentcompletiondate": "2025-06-18T11:15:45"
      },
      {
        "outcome": "Unsafe",
        "assessmentname": "cans-v2",
        "assessmentcompletiondate": "2025-05-29T14:55:52"
      },
      {
        "outcome": "Unsafe",
        "assessmentname": "MARYLAND FAMILY RISK REASSESSMENT",
        "assessmentcompletiondate": "2025-06-18T09:15:54"
      },
      {
        "outcome": "Unsafe",
        "assessmentname": "MARYLAND FAMILY RISK REASSESSMENT",
        "assessmentcompletiondate": "2025-05-29T12:43:20"
      }
    ],
    "childdbehaviourhealth": null,
    "childlegalinformation": [
      {
        "courtdocketnum": "C-06-JV-22-15",
        "hearingdetails": [
          {
            "hearingdate": "2025-08-12T08:45:00",
            "hearingtype": "Permanancy Plan Review",
            "hearingstatus": "Postponed"
          },
          {
            "hearingdate": "2025-03-28T08:45:00",
            "hearingtype": "Permanancy Plan Review",
            "hearingstatus": "Postponed"
          },
          {
            "hearingdate": "2025-06-18T08:45:00",
            "hearingtype": "Permanancy Plan Review",
            "hearingstatus": "Continuance"
          },
          {
            "hearingdate": "2025-07-21T13:30:00",
            "hearingtype": "Permanancy Plan Review",
            "hearingstatus": "Concluded"
          }
        ],
        "childattorneyinfo": null
      }
    ],
    "visitationcourtdetails": {
      "courtorderdetails": "See Court Order in CJAMS documents"
    },
    "childtprlegalinformation": null,
    "caseworkerservicesandplan": {
      "establisheddate": "2022-06-14T04:00:00",
      "cuurentplacetolive": "Regular Foster Care",
      "permanancyplandata": {
        "lifebookExpln": "Foster parents are working on it.",
        "isProviderAgree": "1",
        "permToPermExpln": "A contested permanency plan change hearing, set before a Judge, was held on June 18th and July 21st. The plan was changed to Adoption by a Non Relative. The Department will be filing a Guardianship Petition in early August 2025.Khali current resource parents are long term resources who intend to adopt Khali. ",
        "courtOrdersExpln": "Khali continues with regular visits with her parents and two youngest siblings.",
        "safeAndCareExpln": "This worker is ensuring that Khali is receiving appropriate care as this worker maintains regular contact with the foster family and birth family regarding Khali’s care.  The Department completes at least monthly visits with Khali (in the home and in the community).",
        "isInClosedProximity": "N/A",
        "isProviderAgreeExpln": "The foster parents agree with the permanency plan of reunification but are also open to being a long term resource.",
        "assessmentPeriodExpln": "This worker meetings with the parents to monitor completion of Court ordered tasks. This worker makes necessary referrals. This worker assures that visitation between Khali and her parents are completed.",
        "serviceAgreementExpln": "Mr. Gassaway was incareated for the majorty of the CINA case. He was released in March of 2025. Ms. Stauffer has struggled to maintain compliance with the Service Agreement, particularly in maintaining mental health counseling, and remaining drug/alcohol free. ",
        "meetingSafetyNeedsExpln": "The pre-adoptive resource parents are meeting of a Khalis medical, social, educational, mental, and physical needs. Khali has been placed in the same home since she entered out of home placement with the exception of the Trial Home visit period between November 2023-January 2024. This home setting is the most appropriate and least restrictive placement for Khali. The resource parents are longer term resources and adoptive resources. ",
        "sixMonthsPlacementExpln": "There are no plans to change placement. Resource Home is a long term resource.",
        "isInClosedProximityExpln": "N/A",
        "serviceAgreementForOtherExpln": "Ms. Stauffer has 4 older children she does not have custody of (Delaynie Denford DOB 05/01/05 whose father is Michael Denford DOB 02/06/83; twins; Kennadie White DOB 02/07/20 whose father is Charles White DOB 10/11/87).  Khali is currently having visitation with her half sister Kennadie."
      },
      "facetofacecontactdate": [
        {
          "insertedon": "2025-03-20T16:21:04.797154",
          "contactdate": "2025-03-19T00:00:00"
        },
        {
          "insertedon": "2025-03-27T09:52:48.815861",
          "contactdate": "2025-03-21T00:00:00"
        },
        {
          "insertedon": "2025-03-27T09:52:48.815861",
          "contactdate": "2025-03-21T00:00:00"
        },
        {
          "insertedon": "2025-03-27T09:52:48.815861",
          "contactdate": "2025-03-21T00:00:00"
        },
        {
          "insertedon": "2025-03-27T09:52:48.815861",
          "contactdate": "2025-03-21T00:00:00"
        },
        {
          "insertedon": "2025-03-27T09:52:48.815861",
          "contactdate": "2025-03-21T00:00:00"
        },
        {
          "insertedon": "2025-03-27T09:52:48.815861",
          "contactdate": "2025-03-21T00:00:00"
        },
        {
          "insertedon": "2025-03-27T09:52:48.815861",
          "contactdate": "2025-03-21T00:00:00"
        },
        {
          "insertedon": "2025-03-27T09:52:48.815861",
          "contactdate": "2025-03-21T00:00:00"
        },
        {
          "insertedon": "2025-03-27T09:52:48.815861",
          "contactdate": "2025-03-21T00:00:00"
        },
        {
          "insertedon": "2025-03-27T09:52:48.815861",
          "contactdate": "2025-03-21T00:00:00"
        },
        {
          "insertedon": "2025-03-31T19:33:10.297912",
          "contactdate": "2025-03-28T00:00:00"
        },
        {
          "insertedon": "2025-03-31T19:33:10.297912",
          "contactdate": "2025-03-28T00:00:00"
        },
        {
          "insertedon": "2025-03-31T19:33:10.297912",
          "contactdate": "2025-03-28T00:00:00"
        },
        {
          "insertedon": "2025-03-31T19:33:10.297912",
          "contactdate": "2025-03-28T00:00:00"
        },
        {
          "insertedon": "2025-03-31T19:33:10.297912",
          "contactdate": "2025-03-28T00:00:00"
        },
        {
          "insertedon": "2025-03-31T19:33:10.297912",
          "contactdate": "2025-03-28T00:00:00"
        },
        {
          "insertedon": "2025-03-31T19:33:10.297912",
          "contactdate": "2025-03-28T00:00:00"
        },
        {
          "insertedon": "2025-03-31T19:33:10.297912",
          "contactdate": "2025-03-28T00:00:00"
        },
        {
          "insertedon": "2025-03-31T19:33:10.297912",
          "contactdate": "2025-03-28T00:00:00"
        },
        {
          "insertedon": "2025-03-31T19:33:10.297912",
          "contactdate": "2025-03-28T00:00:00"
        },
        {
          "insertedon": "2025-03-31T19:33:10.297912",
          "contactdate": "2025-03-28T00:00:00"
        },
        {
          "insertedon": "2025-03-31T19:33:10.297912",
          "contactdate": "2025-03-28T00:00:00"
        },
        {
          "insertedon": "2025-03-31T19:33:10.297912",
          "contactdate": "2025-03-28T00:00:00"
        },
        {
          "insertedon": "2025-03-31T19:33:10.297912",
          "contactdate": "2025-03-28T00:00:00"
        },
        {
          "insertedon": "2025-03-31T19:33:10.297912",
          "contactdate": "2025-03-28T00:00:00"
        },
        {
          "insertedon": "2025-04-08T13:38:54.551552",
          "contactdate": "2025-04-04T00:00:00"
        },
        {
          "insertedon": "2025-04-08T13:38:54.551552",
          "contactdate": "2025-04-04T00:00:00"
        },
        {
          "insertedon": "2025-04-08T13:38:54.551552",
          "contactdate": "2025-04-04T00:00:00"
        },
        {
          "insertedon": "2025-04-08T13:38:54.551552",
          "contactdate": "2025-04-04T00:00:00"
        },
        {
          "insertedon": "2025-04-08T13:38:54.551552",
          "contactdate": "2025-04-04T00:00:00"
        },
        {
          "insertedon": "2025-04-08T13:38:54.551552",
          "contactdate": "2025-04-04T00:00:00"
        },
        {
          "insertedon": "2025-04-08T13:38:54.551552",
          "contactdate": "2025-04-04T00:00:00"
        },
        {
          "insertedon": "2025-04-08T13:38:54.551552",
          "contactdate": "2025-04-04T00:00:00"
        },
        {
          "insertedon": "2025-04-08T13:38:54.551552",
          "contactdate": "2025-04-04T00:00:00"
        },
        {
          "insertedon": "2025-04-08T13:38:54.551552",
          "contactdate": "2025-04-04T00:00:00"
        },
        {
          "insertedon": "2025-04-08T13:38:54.551552",
          "contactdate": "2025-04-04T00:00:00"
        },
        {
          "insertedon": "2025-04-08T13:38:54.551552",
          "contactdate": "2025-04-04T00:00:00"
        },
        {
          "insertedon": "2025-04-08T13:38:54.551552",
          "contactdate": "2025-04-04T00:00:00"
        },
        {
          "insertedon": "2025-04-08T13:38:54.551552",
          "contactdate": "2025-04-04T00:00:00"
        },
        {
          "insertedon": "2025-04-11T09:56:26.73321",
          "contactdate": "2025-04-09T00:00:00"
        },
        {
          "insertedon": "2025-04-11T09:56:26.73321",
          "contactdate": "2025-04-09T00:00:00"
        },
        {
          "insertedon": "2025-04-11T09:56:26.73321",
          "contactdate": "2025-04-09T00:00:00"
        },
        {
          "insertedon": "2025-05-09T08:27:59.129555",
          "contactdate": "2025-04-14T00:00:00"
        },
        {
          "insertedon": "2025-05-09T08:27:59.129555",
          "contactdate": "2025-04-14T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-23T12:16:22.10888",
          "contactdate": "2025-04-15T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-04-26T00:21:03.05352",
          "contactdate": "2025-04-25T00:00:00"
        },
        {
          "insertedon": "2025-05-06T10:08:50.0241",
          "contactdate": "2025-05-02T00:00:00"
        },
        {
          "insertedon": "2025-05-09T14:13:19.348511",
          "contactdate": "2025-05-06T00:00:00"
        },
        {
          "insertedon": "2025-05-09T14:13:19.348511",
          "contactdate": "2025-05-06T00:00:00"
        },
        {
          "insertedon": "2025-05-09T14:13:19.348511",
          "contactdate": "2025-05-06T00:00:00"
        },
        {
          "insertedon": "2025-05-19T11:22:06.681465",
          "contactdate": "2025-05-16T00:00:00"
        },
        {
          "insertedon": "2025-05-19T11:22:06.681465",
          "contactdate": "2025-05-16T00:00:00"
        },
        {
          "insertedon": "2025-06-06T13:08:56.688809",
          "contactdate": "2025-06-03T00:00:00"
        },
        {
          "insertedon": "2025-06-06T13:43:46.058894",
          "contactdate": "2025-06-05T00:00:00"
        },
        {
          "insertedon": "2025-06-06T13:43:46.058894",
          "contactdate": "2025-06-05T00:00:00"
        },
        {
          "insertedon": "2025-06-17T23:29:22.661584",
          "contactdate": "2025-06-06T00:00:00"
        },
        {
          "insertedon": "2025-06-17T23:29:22.661584",
          "contactdate": "2025-06-06T00:00:00"
        },
        {
          "insertedon": "2025-06-17T23:29:22.661584",
          "contactdate": "2025-06-06T00:00:00"
        },
        {
          "insertedon": "2025-06-17T23:29:22.661584",
          "contactdate": "2025-06-06T00:00:00"
        },
        {
          "insertedon": "2025-06-17T23:29:22.661584",
          "contactdate": "2025-06-06T00:00:00"
        },
        {
          "insertedon": "2025-06-17T23:29:22.661584",
          "contactdate": "2025-06-06T00:00:00"
        },
        {
          "insertedon": "2025-06-17T23:29:22.661584",
          "contactdate": "2025-06-06T00:00:00"
        },
        {
          "insertedon": "2025-06-17T23:29:22.661584",
          "contactdate": "2025-06-06T00:00:00"
        },
        {
          "insertedon": "2025-06-17T23:29:22.661584",
          "contactdate": "2025-06-06T00:00:00"
        },
        {
          "insertedon": "2025-06-17T23:29:22.661584",
          "contactdate": "2025-06-06T00:00:00"
        },
        {
          "insertedon": "2025-06-17T23:29:22.661584",
          "contactdate": "2025-06-06T00:00:00"
        },
        {
          "insertedon": "2025-06-17T23:29:22.661584",
          "contactdate": "2025-06-06T00:00:00"
        },
        {
          "insertedon": "2025-06-17T23:29:22.661584",
          "contactdate": "2025-06-06T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-07T16:17:26.587926",
          "contactdate": "2025-06-13T00:00:00"
        },
        {
          "insertedon": "2025-07-01T14:34:30.101369",
          "contactdate": "2025-06-17T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:28:59.009758",
          "contactdate": "2025-07-10T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:28:59.009758",
          "contactdate": "2025-07-10T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:28:59.009758",
          "contactdate": "2025-07-10T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:28:59.009758",
          "contactdate": "2025-07-10T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:28:59.009758",
          "contactdate": "2025-07-10T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:28:59.009758",
          "contactdate": "2025-07-10T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:28:59.009758",
          "contactdate": "2025-07-10T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:47:04.665674",
          "contactdate": "2025-07-11T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:47:04.665674",
          "contactdate": "2025-07-11T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:47:04.665674",
          "contactdate": "2025-07-11T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:47:04.665674",
          "contactdate": "2025-07-11T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:47:04.665674",
          "contactdate": "2025-07-11T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:47:04.665674",
          "contactdate": "2025-07-11T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:47:04.665674",
          "contactdate": "2025-07-11T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:47:04.665674",
          "contactdate": "2025-07-11T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:47:04.665674",
          "contactdate": "2025-07-11T00:00:00"
        },
        {
          "insertedon": "2025-07-23T14:47:04.665674",
          "contactdate": "2025-07-11T00:00:00"
        },
        {
          "insertedon": "2025-07-17T11:42:30.73602",
          "contactdate": "2025-07-15T00:00:00"
        },
        {
          "insertedon": "2025-07-17T14:34:15.606052",
          "contactdate": "2025-07-16T00:00:00"
        },
        {
          "insertedon": "2025-07-23T15:16:29.468561",
          "contactdate": "2025-07-17T00:00:00"
        },
        {
          "insertedon": "2025-07-23T15:16:29.468561",
          "contactdate": "2025-07-17T00:00:00"
        },
        {
          "insertedon": "2025-07-23T15:16:29.468561",
          "contactdate": "2025-07-17T00:00:00"
        },
        {
          "insertedon": "2025-07-23T15:16:29.468561",
          "contactdate": "2025-07-17T00:00:00"
        },
        {
          "insertedon": "2025-07-23T15:16:29.468561",
          "contactdate": "2025-07-17T00:00:00"
        },
        {
          "insertedon": "2025-07-23T15:16:29.468561",
          "contactdate": "2025-07-17T00:00:00"
        },
        {
          "insertedon": "2025-07-23T15:16:29.468561",
          "contactdate": "2025-07-17T00:00:00"
        },
        {
          "insertedon": "2025-07-25T14:39:06.830741",
          "contactdate": "2025-07-24T00:00:00"
        },
        {
          "insertedon": "2025-07-25T14:39:06.830741",
          "contactdate": "2025-07-24T00:00:00"
        },
        {
          "insertedon": "2025-07-25T14:39:06.830741",
          "contactdate": "2025-07-24T00:00:00"
        },
        {
          "insertedon": "2025-07-25T14:39:06.830741",
          "contactdate": "2025-07-24T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-05T16:40:03.695977",
          "contactdate": "2025-08-04T00:00:00"
        },
        {
          "insertedon": "2025-08-19T14:41:40.269607",
          "contactdate": "2025-08-07T00:00:00"
        },
        {
          "insertedon": "2025-08-19T14:41:40.269607",
          "contactdate": "2025-08-07T00:00:00"
        },
        {
          "insertedon": "2025-08-11T16:01:51.90854",
          "contactdate": "2025-08-07T00:00:00"
        },
        {
          "insertedon": "2025-08-19T14:41:40.269607",
          "contactdate": "2025-08-07T00:00:00"
        }
      ],
      "primarypermanencytype": "Adoption by a non-relative",
      "treatmentteameetingdate": null,
      "concurrentpermanencytype": "Guardianship by a non relative"
    },
    "childeducationinformation": [
      {
        "end_dt": "06/13/2025",
        "sasidno": "MD",
        "setting": "Public",
        "tel_num": null,
        "start_dt": "09/03/2024",
        "school_nm": "Head Start",
        "grade_last": null,
        "mode_trans": null,
        "type_class": null,
        "edu_program": null,
        "exit_reason": null,
        "grade_current": "Pre School / Head Start",
        "fungrade_level": null,
        "school_address": "Head Start,,Maryland",
        "special_ed_code": null,
        "quarterly_grade1": null,
        "quarterly_grade2": null,
        "quarterly_grade3": null,
        "quarterly_grade4": null
      }
    ],
    "childdisabilityinformation": null,
    "childemploymentinformation": null,
    "childmedicationinformation": null
  }
]',
 updatedon = now(),
 updatedby = 'CIDM-10778'
where personid = '0fd5272e-34cc-4532-aded-2154375b7ea0' 
and id = 'd44c97e0-27e0-401e-997b-50a9f9401100'
and objectid = '2cf62e39-3e60-48dc-9a56-6c714f336436'
and activeflag = 1;