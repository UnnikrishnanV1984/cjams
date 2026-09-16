/*
Issue Description: CJAMS-59842 
Category/Module: Intake
Root cause: User error and they want to update the context in narrative and historic clearance section.
Fix provided: Data fix has been done to Update the context in narrative and historic clearance section.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix should fix it.
*/


update intakedastaging
set jsondata='{
  "sdm": {
    "isar": true,
    "datesubmitted": null,
    "ismaltreatment": false,
    "ischildfatality": false,
    "isrecsc_scrrenin": true,
    "isrecsc_screenout": false,
    "traffickingupdated": false,
    "maltreatmentupdated": false
  },
  "agency": "CW",
  "roacps": null,
  "General": {
    "Time": "2025-05-21T15:52:30.451Z",
    "Iscps": null,
    "Agency": "CW",
    "Author": "LindaSchuster",
    "Purpose": "d207bdd4-f281-4ec8-949c-8fd9657227f9~CW",
    "countyid": "bbce9638-24f9-4336-993c-007f6755c980",
    "Narrative": "<p>subject not cleared for HCDSS, history in Baltimore County 20 years ago.</p>",
    "CreatedDate": "2025-05-21T15:46:18.704Z",
    "InputSource": "b5b40aa0-d2d9-4c04-a3f6-07ed304d904c",
    "PurposeName": "Request for services",
    "RecivedDate": "05/21/2025 11:46:18 AM",
    "teamtypekey": "CW",
    "IntakeNumber": "I251013291981",
    "intakeservice": [
      {
        "description": "CPS History Clearance",
        "intakeservid": "98bda8ba-a7f9-4dc0-9415-52098a74cff6",
        "intakeservsubtype": [],
        "intakeservtypekey": "CPSHC"
      }
    ],
    "receiveddelay": "N/A",
    "requestercity": "Columbia",
    "islocalreferal": 0,
    "supervisorflag": "N",
    "HeadofHousehold": " Marie Antoinette Curtis ",
    "offenselocation": "21046",
    "queAdditionDate": "2025-05-21T15:52:30.030Z",
    "submissiondelay": "N/A",
    "RefuseToShareZip": false,
    "IsUnknownReporter": false,
    "addendumNarrative": null,
    "requesteraddress1": "9780 Patuxent Woods Drive",
    "IsAnonymousReporter": false,
    "cpsHistoryClearance": "<p>Not Cleared</p>",
    "narrativeUpdatedDate": "2025-05-21T15:47:55.737Z",
    "isacknowledgementletter": 1,
    "communicationDescription": "Face to Face",
    "addendumNarrativeCreatedAt": "05/21/2025 11:48 AM",
    "addendumNarrativeCreatedBy": "a4826309-94e9-4680-96bf-eeec3962b46a",
    "addendumNarrativeUpdatedAt": "05/21/2025 11:48 AM",
    "addendumNarrativeUpdatedBy": "a4826309-94e9-4680-96bf-eeec3962b46a",
    "addendumNarrativeCreatedByInfo": "Linda Schuster",
    "addendumNarrativeUpdatedByInfo": "Linda Schuster"
  },
  "persons": [
    {
      "Dob": "1972-10-05T04:00:00.000Z",
      "Pid": "7498de78-5a78-4f54-ab8f-35a510a3ad12",
      "ssn": "212869306",
      "Role": "CPSS",
      "race": [
        {
          "value_text": "Black or African American",
          "racetypekey": "BA"
        }
      ],
      "State": "MD",
      "County": "Anne Arundel",
      "Gender": "F",
      "school": [],
      "emailID": [],
      "testing": [],
      "Lastname": "Curtis",
      "cjamspid": "204148256",
      "employer": [],
      "fullName": " Marie Antoinette Curtis ",
      "guardian": {},
      "vocation": [],
      "Ethnicity": "Unknown",
      "Firstname": "Marie",
      "emergency": [],
      "personRole": [
        {
          "hidden": false,
          "rolekey": "CPSS",
          "isprimary": "true",
          "description": "CPS Hist. Clrnc. - Subject",
          "relationshiptorakey": ""
        },
        {
          "hidden": false,
          "rolekey": "FICTIVEKIN",
          "isprimary": "true",
          "description": "Fictive Kin",
          "relationshiptorakey": ""
        }
      ],
      "substances": [],
      "ishousehold": "yes",
      "personpayee": [],
      "phoneNumber": [],
      "Dangerousself": "no",
      "Mentealimpair": "no",
      "maritalstatus": "Unknown",
      "personsupport": [],
      "physicianinfo": [],
      "Mentealillness": "no",
      "accomplishment": [],
      "Dangerousworker": "no",
      "healthinsurance": [],
      "primarylanguage": "ENG",
      "RelationshiptoRA": "SELF",
      "persondentalinfo": [],
      "personhealthexam": [],
      "isheadofhousehold": true,
      "ishouseholdmember": 1,
      "safehavenbabyflag": 1,
      "citizenalenageflag": "1",
      "personAddressInput": [
        {
          "city": "Linthicum",
          "state": "MD",
          "county": "Anne Arundel",
          "endDate": "04/29/2019",
          "phoneNo": "",
          "zipcode": "21090",
          "Address2": "",
          "address1": "849 Internation",
          "addressid": "",
          "startDate": "",
          "activeflag": 1,
          "addresstype": "31",
          "addresstypeLabel": "Home",
          "knownDangerAddress": "",
          "knownDangerAddressReason": ""
        }
      ],
      "personabusehistory": [],
      "personabusesubstance": [],
      "drugexposednewbornflag": 0,
      "personbehavioralhealth": [],
      "personmedicalcondition": [],
      "sexoffenderregisteredflag": 0,
      "fetalalcoholspctrmdisordflag": 0,
      "personmedicationphyscotropic": [],
      "probationsearchconductedflag": 0
    }
  ],
  "userrole": "CWIW",
  "clwStatus": null,
  "narrative": [
    {
      "Role": "SSP",
      "email": "linda.schuster@maryland.gov",
      "title": null,
      "ZipCode": "",
      "Lastname": "Schuster",
      "RoleName": "Social Services personnel",
      "Firstname": "Linda",
      "Middlename": "T",
      "PhoneNumber": "4108728848",
      "incidentdate": "",
      "organization": "HCDSS",
      "isapproximate": false,
      "PhoneNumberExt": "",
      "incidentlocation": ""
    }
  ],
  "disposition": null,
  "createdCases": null,
  "reviewstatus": {
    "status": "",
    "appevent": "DRAFT",
    "commenttext": "",
    "ispreintake": false
  },
  "crossReference": [],
  "officelocation": "Howard",
  "reasonforDraft": [
    {
      "time": 1747842527102
    },
    {
      "time": 1747842750451
    }
  ],
  "securityuserid": "a4826309-94e9-4680-96bf-eeec3962b46a",
  "evaluationFields": null,
  "identifiedPersons": [
    {
      "dob": "1972-10-05T00:00:00",
      "ssn": 212869306,
      "caseid": null,
      "fullname": "marie morton-curtis",
      "lastname": "morton-curtis",
      "firstname": "marie",
      "insertedon": "2025-05-21T11:48:38",
      "middlename": null,
      "objecttype": "intake",
      "deletestatus": null,
      "intakenumber": "I251013291981",
      "clientmergeid": null,
      "datavalidflag": null,
      "gendertypekey": "F",
      "legalclientid": null,
      "quickpersonid": "393dc4ad-1b5d-4f5e-81bd-2c1e5a0abdfc",
      "expungementflag": null,
      "genderdescription": "Female",
      "quickpersonroleconfig": [
        {
          "description": "CPS Hist. Clrnc. - Subject",
          "actortypekey": "CPSS",
          "quickpersonid": "393dc4ad-1b5d-4f5e-81bd-2c1e5a0abdfc",
          "quickpersonroleconfigid": "609858b4-b840-40e0-a024-45e3b0332fdb"
        },
        {
          "description": "Fictive Kin",
          "actortypekey": "FICTIVEKIN",
          "quickpersonid": "393dc4ad-1b5d-4f5e-81bd-2c1e5a0abdfc",
          "quickpersonroleconfigid": "22d65566-c288-471d-9c7c-ffb9c5f45e4a"
        }
      ],
      "quickpersonsubstconfig": null,
      "substanceexposednewbornflag": null
    }
  ],
  "intakeDATypeDetails": [],
  "focuspersoncasedetails": []
}', updatedby='CJAMS-59842', updatedon=now()
where intakenumber='I251013291981' and activeflag=1;

update intakesnapshot
set jsondata='{
  "sdm": {
    "isar": true,
    "isroh": false,
    "datesubmitted": null,
    "ismaltreatment": false,
    "ischildfatality": false,
    "isrecsc_scrrenin": true,
    "isoverriderequest": false,
    "isrecsc_screenout": false,
    "traffickingupdated": false,
    "maltreatmentupdated": false
  },
  "DAType": {
    "DATypeDetail": [
      {
        "caseID": "",
        "DAStatus": "Closed",
        "DaTypeKey": "d207bdd4-f281-4ec8-949c-8fd9657227f9",
        "intakeAction": "",
        "issubtypekey": true,
        "DADisposition": "Closed",
        "serviceTypeID": "",
        "dispositioncode": "Closed",
        "ServiceRequestNumber": "I251013291981",
        "intakeserreqstatustypekey": "Closed",
        "supMultipleDispositionDropdown": [],
        "intakeMultipleDispositionDropdown": []
      }
    ]
  },
  "roacps": null,
  "General": {
    "Time": "2025-05-21T15:53:15.611Z",
    "Iscps": null,
    "Agency": "CW",
    "Author": "LindaSchuster",
    "Source": "b5b40aa0-d2d9-4c04-a3f6-07ed304d904c",
    "Purpose": "d207bdd4-f281-4ec8-949c-8fd9657227f9",
    "Lastname": "Schuster",
    "countyid": "bbce9638-24f9-4336-993c-007f6755c980",
    "Firstname": "Linda",
    "Narrative": "<p>subject not cleared for HCDSS, history in Baltimore County 20 years ago.</p>",
    "AgencyCode": "CW",
    "Middlename": "T",
    "CreatedDate": "2025-05-21T15:46:18.704Z",
    "InputSource": "b5b40aa0-d2d9-4c04-a3f6-07ed304d904c",
    "PurposeName": "Request for services",
    "RecivedDate": "05/21/2025 11:46:18 AM",
    "IntakeNumber": "I251013291981",
    "intakeservice": [
      {
        "description": "CPS History Clearance",
        "intakeservid": "98bda8ba-a7f9-4dc0-9415-52098a74cff6",
        "intakeservsubtype": [],
        "intakeservtypekey": "CPSHC"
      }
    ],
    "isDisposition": true,
    "receiveddelay": "N/A",
    "requestercity": "Columbia",
    "islocalreferal": 0,
    "HeadofHousehold": " Marie Antoinette Curtis ",
    "offenselocation": "21046",
    "queAdditionDate": "2025-05-21T15:52:30.030Z",
    "submissiondelay": "N/A",
    "RefuseToShareZip": false,
    "IsUnknownReporter": false,
    "addendumNarrative": null,
    "requesteraddress1": "9780 Patuxent Woods Drive",
    "IsAnonymousReporter": false,
    "cpsHistoryClearance": "<p>not cleared</p>",
    "narrativeUpdatedDate": "2025-05-21T15:47:55.737Z",
    "isacknowledgementletter": 1,
    "communicationDescription": "Face to Face",
    "addendumNarrativeCreatedAt": "05/21/2025 11:48 AM",
    "addendumNarrativeCreatedBy": "a4826309-94e9-4680-96bf-eeec3962b46a",
    "addendumNarrativeUpdatedAt": "05/21/2025 11:48 AM",
    "addendumNarrativeUpdatedBy": "a4826309-94e9-4680-96bf-eeec3962b46a",
    "addendumNarrativeCreatedByInfo": "Linda Schuster",
    "addendumNarrativeUpdatedByInfo": "Linda Schuster"
  },
  "clwStatus": null,
  "narrative": [
    {
      "Role": "SSP",
      "email": "linda.schuster@maryland.gov",
      "title": "",
      "ZipCode": "",
      "Lastname": "Schuster",
      "RoleName": "Social Services personnel",
      "Firstname": "Linda",
      "Middlename": "T",
      "PhoneNumber": "4108728848",
      "incidentdate": "",
      "organization": "HCDSS",
      "isapproximate": false,
      "requestercity": "Columbia",
      "PhoneNumberExt": "",
      "requesterstate": "",
      "offenselocation": "21046",
      "requestercounty": "",
      "incidentlocation": "",
      "requesteraddress1": "9780 Patuxent Woods Drive",
      "requesteraddress2": "",
      "requestercountyname": ""
    }
  ],
  "Allegations": [],
  "disposition": [
    {
      "caseID": "",
      "DAStatus": "Closed",
      "DaTypeKey": "d207bdd4-f281-4ec8-949c-8fd9657227f9",
      "intakeAction": "",
      "issubtypekey": true,
      "DADisposition": "Closed",
      "serviceTypeID": "",
      "dispositioncode": "Closed",
      "ServiceRequestNumber": "I251013291981",
      "intakeserreqstatustypekey": "Closed",
      "supMultipleDispositionDropdown": [],
      "intakeMultipleDispositionDropdown": []
    }
  ],
  "clearhistory": {
    "close": true,
    "reason": "KCP",
    "comments": null,
    "individual": null,
    "thirdparty": true,
    "workername": "LindaSchuster",
    "startdatetime": "2025-05-20T04:00:00.000Z"
  },
  "createdCases": null,
  "reviewstatus": {
    "appevent": "INTR",
    "commenttext": "",
    "ispreintakeapproved": false,
    "youthstatuseventcode": ""
  },
  "persondetails": {
    "Person": [
      {
        "Dob": "1972-10-05T04:00:00.000Z",
        "Pid": "7498de78-5a78-4f54-ab8f-35a510a3ad12",
        "ssn": "212869306",
        "Role": "CPSS",
        "race": [
          {
            "value_text": "Black or African American",
            "racetypekey": "BA"
          }
        ],
        "State": "MD",
        "County": "Anne Arundel",
        "Gender": "F",
        "school": [],
        "address": [
          {
            "city": "Linthicum",
            "state": "MD",
            "county": "Anne Arundel",
            "endDate": "04/29/2019",
            "phoneNo": "",
            "zipcode": "21090",
            "Address2": "",
            "address1": "849 Internation",
            "addressid": "",
            "startDate": "",
            "activeflag": 1,
            "addresstype": "31",
            "addresstypeLabel": "Home",
            "knownDangerAddress": "",
            "knownDangerAddressReason": ""
          }
        ],
        "emailID": [],
        "testing": [],
        "Lastname": "Curtis",
        "cjamspid": "204148256",
        "contacts": [],
        "employer": [],
        "fullName": " Marie Antoinette Curtis ",
        "guardian": {},
        "vocation": [],
        "Ethnicity": "Unknown",
        "Firstname": "Marie",
        "emergency": [],
        "personRole": [
          {
            "hidden": false,
            "rolekey": "CPSS",
            "isprimary": "true",
            "description": "CPS Hist. Clrnc. - Subject",
            "relationshiptorakey": ""
          },
          {
            "hidden": false,
            "rolekey": "FICTIVEKIN",
            "isprimary": "true",
            "description": "Fictive Kin",
            "relationshiptorakey": ""
          }
        ],
        "substances": [],
        "ishousehold": "yes",
        "personpayee": [],
        "phoneNumber": [],
        "contactsmail": [],
        "Dangerousself": "no",
        "Mentealimpair": "no",
        "maritalstatus": "Unknown",
        "personsupport": [],
        "physicianinfo": [],
        "Mentealillness": "no",
        "accomplishment": [],
        "Dangerousworker": "no",
        "healthinsurance": [],
        "primarylanguage": "ENG",
        "RelationshiptoRA": "SELF",
        "persondentalinfo": [],
        "personhealthexam": [],
        "isheadofhousehold": true,
        "ishouseholdmember": 1,
        "safehavenbabyflag": 1,
        "citizenalenageflag": "1",
        "personAddressInput": [
          {
            "city": "Linthicum",
            "state": "MD",
            "county": "Anne Arundel",
            "endDate": "04/29/2019",
            "phoneNo": "",
            "zipcode": "21090",
            "Address2": "",
            "address1": "849 Internation",
            "addressid": "",
            "startDate": "",
            "activeflag": 1,
            "addresstype": "31",
            "addresstypeLabel": "Home",
            "knownDangerAddress": "",
            "knownDangerAddressReason": ""
          }
        ],
        "personabusehistory": [],
        "personabusesubstance": [],
        "drugexposednewbornflag": 0,
        "personbehavioralhealth": [],
        "personmedicalcondition": [],
        "sexoffenderregisteredflag": 0,
        "fetalalcoholspctrmdisordflag": 0,
        "personmedicationphyscotropic": [],
        "probationsearchconductedflag": 0
      }
    ]
  },
  "officelocation": "Howard",
  "securityuserid": "a4826309-94e9-4680-96bf-eeec3962b46a",
  "CrossReferences": [],
  "evaluationFields": null,
  "identifiedPersons": [
    {
      "dob": "1972-10-05T00:00:00",
      "ssn": 212869306,
      "caseid": null,
      "fullname": "marie morton-curtis",
      "lastname": "morton-curtis",
      "firstname": "marie",
      "insertedon": "2025-05-21T11:48:38",
      "middlename": null,
      "objecttype": "intake",
      "deletestatus": null,
      "intakenumber": "I251013291981",
      "clientmergeid": null,
      "datavalidflag": null,
      "gendertypekey": "F",
      "legalclientid": null,
      "quickpersonid": "393dc4ad-1b5d-4f5e-81bd-2c1e5a0abdfc",
      "expungementflag": null,
      "genderdescription": "Female",
      "quickpersonroleconfig": [
        {
          "description": "CPS Hist. Clrnc. - Subject",
          "actortypekey": "CPSS",
          "quickpersonid": "393dc4ad-1b5d-4f5e-81bd-2c1e5a0abdfc",
          "quickpersonroleconfigid": "609858b4-b840-40e0-a024-45e3b0332fdb"
        },
        {
          "description": "Fictive Kin",
          "actortypekey": "FICTIVEKIN",
          "quickpersonid": "393dc4ad-1b5d-4f5e-81bd-2c1e5a0abdfc",
          "quickpersonroleconfigid": "22d65566-c288-471d-9c7c-ffb9c5f45e4a"
        }
      ],
      "quickpersonsubstconfig": null,
      "substanceexposednewbornflag": null
    }
  ],
  "intakeDATypeDetails": [
    {
      "caseID": "",
      "DAStatus": "Closed",
      "DaTypeKey": "d207bdd4-f281-4ec8-949c-8fd9657227f9",
      "intakeAction": "",
      "issubtypekey": true,
      "DADisposition": "Closed",
      "serviceTypeID": "",
      "dispositioncode": "Closed",
      "ServiceRequestNumber": "I251013291981",
      "intakeserreqstatustypekey": "Closed",
      "supMultipleDispositionDropdown": [],
      "intakeMultipleDispositionDropdown": []
    }
  ],
  "focuspersoncasedetails": []
}', updatedby='CJAMS-59842', updatedon=now()
where intakenumber='I251013291981' and activeflag=1;