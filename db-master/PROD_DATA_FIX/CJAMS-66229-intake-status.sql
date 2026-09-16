/* 
    Issue Description : CJAMS-66229
    Category/ Module : Intake status
    Root cause :Submission history is missing and intake status is not setting to recommended to close request for services as history clearance object is missing
    Fix Provided: Data fix is done by inserting a record into submission history and updated the history clearance to updatethe intake status
*/

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'INTR', '3b7a94ad-b3e8-42b6-b882-59d979ec1edb', '3b7a94ad-b3e8-42b6-b882-59d979ec1edb', '03f1aaf2-b0e2-4fbb-b396-d34bc13fd2ca'::uuid, 'CWSP', 'CWSP', 'I261013945700', 8, 0, '3b7a94ad-b3e8-42b6-b882-59d979ec1edb', now(), '3b7a94ad-b3e8-42b6-b882-59d979ec1edb', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Closed', NULL, now());

update intakedastaging 
set jsondata ='{
  "sdm": {
    "isar": false,
    "isir": false,
    "isroh": true,
    "datesubmitted": null,
    "ismaltreatment": false,
    "cpsResponseType": null,
    "ischildfatality": false,
    "isrecsc_scrrenin": true,
    "isrecsc_screenout": false,
    "traffickingupdated": false,
    "maltreatmentupdated": false,
    "childfatalityupdated": "no"
  },
  "agency": "CW",
  "roacps": null,
  "General": {
    "Time": "2026-03-06T18:02:18.504Z",
    "Iscps": null,
    "Agency": "CW",
    "Author": "KimberlyMcCamey",
    "Purpose": "d207bdd4-f281-4ec8-949c-8fd9657227f9~CW",
    "countyid": "71066c32-2942-4474-91be-55e9207ce4ed",
    "Narrative": "<p></p><p>Received&nbsp;notarized&nbsp;DHR/SSA&nbsp;1279A&nbsp;from&nbsp;Kacey&nbsp;Ross&nbsp;McGrath&nbsp;of&nbsp;Callahan&nbsp;Learning&nbsp;Center&nbsp;requesting&nbsp;a&nbsp;child&nbsp;welfare&nbsp;background&nbsp;clearance&nbsp;for&nbsp;Angela&nbsp;Austine.</p>",
    "CreatedDate": "2026-03-06T17:35:49.045Z",
    "InputSource": "9d5ab74f-4b48-4f80-b5ec-405286241efe",
    "PurposeName": "Request for services",
    "RecivedDate": "02/10/2026 12:43:46 PM",
    "teamtypekey": "CW",
    "IntakeNumber": "I261013945700",
    "intakeservice": [
      {
        "description": "CPS History Clearance",
        "intakeservid": "98bda8ba-a7f9-4dc0-9415-52098a74cff6",
        "intakeservsubtype": [],
        "intakeservtypekey": "CPSHC"
      }
    ],
    "receiveddelay": "N/A",
    "islocalreferal": 0,
    "supervisorflag": "N",
    "offenselocation": "",
    "queAdditionDate": "2026-03-06T18:02:05.833Z",
    "submissiondelay": "N/A",
    "RefuseToShareZip": false,
    "IsUnknownReporter": false,
    "addendumNarrative": null,
    "IsAnonymousReporter": false,
    "cpsHistoryClearance": "<p>No&nbsp;indicated&nbsp;history&nbsp;found.</p>",
    "narrativeUpdatedDate": "2026-03-06T17:38:09.234Z",
    "isacknowledgementletter": 1,
    "communicationDescription": "Postal Mail",
    "isaddendumnarrativeupdated": false
  },
  "persons": [
    {
      "Dob": "1978-03-22T05:00:00.000Z",
      "Pid": "091b96ad-f8fd-459a-958b-f820f4ce7ff4",
      "Zip": "23117",
      "ssn": "226333660",
      "City": "Mineral",
      "Role": "CPSS",
      "race": [
        {
          "value_text": "White",
          "racetypekey": "WH"
        }
      ],
      "State": "MD",
      "County": "Anne Arundel",
      "Gender": "F",
      "county": "VA54",
      "school": [],
      "Address": "8815 Jefferson Hwy",
      "emailID": [],
      "testing": [],
      "Lastname": "Augustine",
      "cjamspid": "204219189",
      "employer": [],
      "fullName": " Angela Denise Augustine ",
      "guardian": {},
      "vocation": [],
      "Ethnicity": "Unknown",
      "Firstname": "Angela",
      "aliasname": " Angela  Frye ",
      "emergency": [],
      "personRole": [
        {
          "hidden": false,
          "rolekey": "CPSS",
          "isprimary": "true",
          "description": "CPS Hist. Clrnc. - Subject",
          "relationshiptorakey": ""
        }
      ],
      "substances": [],
      "addressinfo": [
        {
          "city": "Mineral",
          "state": "VA",
          "county": "VA54",
          "danger": null,
          "address": "8815 Jefferson Hwy",
          "country": "USA",
          "mergeid": null,
          "zipcode": "23117",
          "address2": "",
          "adrboxno": null,
          "activeflag": 1,
          "directions": null,
          "streetname": null,
          "addresstype": "Home",
          "county_desc": "Louisa",
          "durationday": null,
          "changereason": null,
          "dangerreason": null,
          "addressstatus": null,
          "acknowledgement": null,
          "personaddressid": "fb455739-6020-45a5-9216-1036048eafca",
          "addressstartdate": "2026-02-05T00:00:00",
          "incidentlocation": null,
          "personadrenddate": null,
          "formattedcityname": null,
          "ishouseholdmember": null,
          "personadrstartdate": null,
          "acknowledgementflag": null,
          "currentlocationflag": 1,
          "formattedstreetname": null,
          "incidentlocationflag": null,
          "personaddresstypekey": "HO",
          "adrstreetsuffixtypekey": null,
          "personaddresssubtypekey": null
        }
      ],
      "fullAddress": "8815 Jefferson Hwy",
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
  "userrole": "",
  "clwStatus": null,
  "narrative": [
    {
      "Role": "OTH",
      "email": "",
      "title": null,
      "ZipCode": "",
      "Lastname": "Ross-McGrath",
      "RoleName": "Other",
      "Firstname": "Kacey ",
      "Middlename": "",
      "PhoneNumber": "",
      "incidentdate": "",
      "organization": "Callahan Learning Center",
      "isapproximate": false,
      "PhoneNumberExt": "",
      "incidentlocation": ""
    }
  ],
  "disposition": null,
  "clearhistory": {
    "close": true,
    "reason": "ADPP",
    "comments": null,
    "individual": null,
    "thirdparty": null,
    "workername": "KimberlyMcCamey",
    "startdatetime": null
  },
  "createdCases": null,
  "reviewstatus": {
    "status": "",
    "appevent": "DRAFT",
    "commenttext": "",
    "ispreintake": false
  },
  "crossReference": [],
  "officelocation": "SSC",
  "reasonforDraft": [
    {
      "time": 1772818840797
    },
    {
      "time": 1772818988017
    },
    {
      "time": 1772819055793
    },
    {
      "time": 1772819464496
    },
    {
      "time": 1772820138503
    }
  ],
  "securityuserid": "3b7a94ad-b3e8-42b6-b882-59d979ec1edb",
  "evaluationFields": null,
  "intakeDATypeDetails": [],
  "focuspersoncasedetails": []
}', updatedby='CJAMS-66229', updatedon =now()
where intakenumber ='I261013945700' and activeflag=1;
