/*
Issue Description: CJAMS-62308 Still pulling wrong data into Case Plan
Category/Module: Case plan 
Root cause: Case plan is fetching data from the old permanency plan due to code error and code fix has been done as the part of  CDM-44499 to resolve this.
            Data fix has been requested by the user before the code fix moved to Prod
Fix provided:  data fix is done for the 2nd draft case plan that was created on 09/16/2025 (date range 03/03/2025 - 09/03/2025). 
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:CDM-44499
Reason why no related code fix: N/A
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
      "enddate": "2025-09-03T04:00:00",
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
        "lifebookExpln": "Yes",
        "isProviderAgree": "1",
        "permToPermExpln": "N/A-Permanency plan is reunification",
        "courtOrdersExpln": "The Department is working with the Carroll County Detention Center to schedule virtual visits with Khali’s father.\n\nKhali is having monthly visits with her half-sister Kennadie and maternal grandmother Karen.\n\nKhali will be starting weekly supervised visits with her mother.\n",
        "safeAndCareExpln": "This worker is ensuring that Khali is receiving appropriate care as this worker maintains regular contact with the foster family and birth family regarding Khali’s care.  The Department completes at least monthly visits with Khali (in the home and in the community).  ",
        "isInClosedProximity": "1",
        "isProviderAgreeExpln": "The foster parents agree with the permanency plan of reunification.",
        "assessmentPeriodExpln": "The Department has begun working closely with the parents on reunification. The Department has also provided the necessary referrals to service providers and is in the process of obtaining all needed consents.  This worker has maintained regular contact with all services providers including the foster parents.  Khali''s god parents have presented themselves as a potential placement resource and they have been given the needed clearances to complete.",
        "serviceAgreementExpln": "Mother is currently in treatment at Recovery Network.  Father is still incarcerated.",
        "meetingSafetyNeedsExpln": "The foster parents are meeting all of Khali’s needs by ensuring that all of Khali’s physical, mental, educational and medical needs are being met.  Khali was referred to the Infants and Toddlers Program and she is receiving monthly services.  The foster parents have appropriate baby supplies to provide adequate care for Khali; the foster home is child proofed and appropriate for a 1 y/o child.  The foster parents maintain regular contact with this worker to ensure that all of Khali’s needs are being met.  The foster parents also maintain regular contact with the Pediatrician as needed.  Khali has adjusted well to the foster home and the family enjoys having her there.  There are no safety concerns at this time.  Khali appears to be bonded with all family members.  Khali resides in a home setting (least restrictive placement) and remains the most appropriate at this time.",
        "sixMonthsPlacementExpln": "There are no anticipated placement changes in the upcoming 6 months.",
        "isInClosedProximityExpln": "Khali was sheltered in Carroll County, MD, and placed in a Carroll County licensed foster home in Hampstead, Carroll County, MD.  Khali’s foster is currently incarcerated in Westminster, approximately 14 minutes away from the foster home.  Khali’s mother has entered a treatment center in Baltimore City, approximately 42 minutes away from the foster home. ",
        "serviceAgreementForOtherExpln": "Khali has several older siblings but the Department currently only has contact with one, Kennadie, who Khali has monthly visits with."
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
      "primarypermanencytype": "Reunification",
      "treatmentteameetingdate": null,
      "concurrentpermanencytype": "Adoption by a non-relative"
    },
    "childeducationinformation": [
      {
        "end_dt": null,
        "sasidno": null,
        "setting": "Public",
        "tel_num": null,
        "start_dt": "09/02/2025",
        "school_nm": "Hampstead Elementary School",
        "grade_last": null,
        "mode_trans": null,
        "type_class": null,
        "edu_program": null,
        "exit_reason": null,
        "grade_current": "Pre School / Head Start",
        "fungrade_level": null,
        "school_address": "Hampstead Elementary School,,Maryland",
        "special_ed_code": null,
        "quarterly_grade1": null,
        "quarterly_grade2": null,
        "quarterly_grade3": null,
        "quarterly_grade4": null
      },
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
 updatedby = 'CJAMS-62308'
where personid = '0fd5272e-34cc-4532-aded-2154375b7ea0' 
and id = '6478b2de-cf9e-47f1-94a9-87c8cacb349d'
and objectid = '2cf62e39-3e60-48dc-9a56-6c714f336436'
and activeflag = 1;