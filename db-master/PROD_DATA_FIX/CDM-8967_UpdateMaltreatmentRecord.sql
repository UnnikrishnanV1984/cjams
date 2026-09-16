-- CDM-8967 - Change Maltreatment in AR case

update intakeservicerequestsdm set ismalpa_caregiver = true, updatedby = 'CDM-8967', updatedon = now() 
where intakeservicerequestsdmid='4e5170e8-c113-4be6-9b94-030923b4e792' and activeflag =1;

update intakedastaging set updatedby = 'CDM-8967', updatedon = now(),
jsondata = '
{
  "sdm": {
    "isar": false,
    "isir": false,
    "worker": "Devin Stevenson",
    "comments": "",
    "countyid": null,
    "isschool": false,
    "provider": [],
    "screenIn": {},
    "immediate": "No Immediate",
    "screenOut": {
      "duplicatereportflag": null
    },
    "referralid": "",
    "reportdate": null,
    "riskofHarm": {
      "isnegrh_exposednewborn": false
    },
    "supervisor": "A. Chambers",
    "workerdate": null,
    "badgenumber": "245",
    "isoutofhome": false,
    "referraldob": "1970-01-01T00:00:00.000Z",
    "sexualAbuse": {},
    "maltreatment": "no",
    "recordnumber": "8201100313",
    "referralname": "",
    "allegedvictim": [],
    "childfatality": "no",
    "datesubmitted": "2020-11-02T10:14:38.336Z",
    "immediateList": {
      "immediateList6": null,
      "isimmed_allegation": null,
      "isimmed_otherspecify": null,
      "isimmed_seriousinjury": null,
      "isimmed_childfaatility": null,
      "isimmed_childleftalone": null
    },
    "isreportmeets": false,
    "issexualabuse": false,
    "physicalAbuse": {
      "ismalpa_caregiver": true
    },
    "providerKnown": null,
    "generalNeglect": {},
    "immediateList6": null,
    "ismaltreatment": false,
    "supervisordate": null,
    "cpsResponseType": null,
    "ischildfatality": false,
    "isfinalscreenin": true,
    "noImmediateList": {
      "isnoimmed_risk_harm": false,
      "isnoimmed_sexualabuse": false,
      "isnoimmed_mentalinjury": false,
      "isnoimmed_physicalabuse": false,
      "isnoimmed_neglectresponse": false,
      "isnoimmed_screeninoverride": true,
      "isnoimmed_substantial_risk": false
    },
    "officerlastname": "Sani",
    "unattendedChild": {},
    "arGeneralNeglect": {},
    "isdeathorserious": false,
    "isrecsc_scrrenin": false,
    "officerfirstname": "Ismail",
    "allegedmaltreator": [],
    "childUnderOneYear": "",
    "childunderoneyear": "No",
    "islicenseddaycare": false,
	"ismalpa_caregiver": true,
    "isrecsc_screenout": true,
    "officermiddlename": "",
    "isimmed_allegation": null,
    "isprivateplacement": false,
    "issignordiagonises": false,
    "screeningRecommend": "ScreenOUT",
    "duplicatereportflag": null,
    "isnoimmed_risk_harm": false,
    "scnRecommendOveride": "",
    "disqualifyingFactors": {},
    "isfcplacementsetting": false,
    "isimmed_otherspecify": null,
    "disqualifyingCriteria": {
      "isoutofhome": false,
      "isreportmeets": false,
      "issexualabuse": false,
      "isdeathorserious": false,
      "issignordiagonises": false
    },
    "isimmed_seriousinjury": null,
    "isnoimmed_sexualabuse": false,
    "providerunknowndetail": null,
    "isimmed_childfaatility": null,
    "isimmed_childleftalone": null,
    "isnegrh_exposednewborn": false,
    "isnoimmed_mentalinjury": false,
    "isnoimmed_physicalabuse": false,
    "isnegfp_cargiverintervene": false,
    "isnegmn_unreasonabledelay": false,
    "isnoimmed_neglectresponse": false,
    "isnoimmed_screeninoverride": true,
    "isnoimmed_substantial_risk": false,
    "ismenab_psycologicalability": false,
    "ismenng_psycologicalability": false
  },
  "DAType": {
    "DATypeDetail": [
      {
        "caseID": "",
        "reason": "Submitted on reg day off",
        "Summary": "",
        "DAStatus": "Approved",
        "comments": "",
        "DaTypeKey": "247a8b26-cdee-4ce8-b36e-b37e49fd0103",
        "supStatus": "Approved",
        "agencyName": "",
        "agencyType": "",
        "GroupNumber": null,
        "supComments": "",
        "GroupComment": null,
        "intakeAction": "",
        "issubtypekey": true,
        "DADisposition": "Scrnin",
        "agencyContact": "",
        "captureReason": "",
        "serviceTypeID": "",
        "ReasonforDelay": "",
        "supDisposition": "Scrnin",
        "GroupReasonType": null,
        "dispositioncode": "ScreenOUT",
        "ServiceRequestNumber": "I202000194147",
        "intakeserreqstatustypekey": "Review",
        "supMultipleDispositionDropdown": [],
        "intakeMultipleDispositionDropdown": [
          {
            "text": "Screen In",
            "value": "Scrnin"
          },
          {
            "text": "Screen Out",
            "value": "ScreenOUT"
          }
        ]
      }
    ]
  },
  "agency": "CW",
  "roacps": null,
  "General": {
    "Time": "2020-11-12T14:03:52.521Z",
    "Iscps": null,
    "Agency": "CW",
    "Author": "MichelleFreeman",
    "Purpose": "247a8b26-cdee-4ce8-b36e-b37e49fd0103~CW",
    "countyid": "7665ca54-5374-4174-be07-a687b811a82c",
    "Narrative": "<p>Officer Sani called to report mom and her daughter was having a dispute because she went out of town for the weekend and when she returned she had men in her house. Officer Sani stated mom stated \"this is what she does when she goes out of town; she have different men in and out her house\". Officer Sani reports mom and daughter were arguing and mom told her to get out, to go to her fathers, Officer Sani reports the daughter went outside and called the police. She then sent her mom a text stating \"I''''m gonna get you in trouble\". When Officer Sani got there they started arguing again and she was asking for some of her personal things. Dad arrived to pick her up.</p><p><br></p><p>Officer Sani asked her did she need to go to the hospital for any reason. Daughter stated \"NO, she doesn''''t want to go\". Officer Sani stated the daughter stated mom punched her in her chest. But, she refused medical attention.</p><p><br></p><p><br></p><p><br></p><p>Worker went and attempted to see child at her fathers, however, no answer at door.  Worker tried to call and never answered.</p><p><br></p><p><br></p><p>Assigned to Devin Stevenson, Sup, A. Chambers, Div. 3</p>",
    "CreatedDate": "2020-11-02T06:14:20.629Z",
    "InputSource": "0bdda2ab-b74f-4d74-ba17-3b9b37a9ca19",
    "PurposeName": "Child Protective Services",
    "RecivedDate": "11/2/2020, 1:14:20 AM",
    "teamtypekey": "CW",
    "IntakeNumber": "I202000194147",
    "intakeservice": [],
    "receiveddelay": "Submitted on reg day off",
    "islocalreferal": 0,
    "servicerequest": [],
    "supervisorflag": "Y",
    "HeadofHousehold": " Ikeria  Mason ",
    "offenselocation": "",
    "queAdditionDate": "2020-11-12T13:57:36.012Z",
    "submissiondelay": "",
    "RefuseToShareZip": false,
    "IsUnknownReporter": false,
    "suggestedresource": [],
    "IsAnonymousReporter": false,
    "cpsHistoryClearance": "<p>CLEARANCE COMPLETED</p>",
    "narrativeUpdatedDate": "2020-11-02T10:12:41.454Z",
    "isacknowledgementletter": 1,
    "communicationDescription": "Phone"
  },
  "persons": [
    {
      "Dob": "2004-05-20T04:00:00.000Z",
      "Pid": "3d01a0c3-eb7e-42bb-8ffe-f04d7fa6a184",
      "Role": "CHILD",
      "State": "MD",
      "County": "Anne Arundel",
      "Gender": "F",
      "school": [],
      "emailID": [],
      "testing": [],
      "Lastname": "ELwahhaei",
      "cjamspid": "200167433",
      "employer": [],
      "fullName": " Zkia  ELwahhaei ",
      "guardian": {},
      "vocation": [],
      "Firstname": "Zkia",
      "emergency": [],
      "personRole": [
        {
          "hidden": false,
          "rolekey": "CHILD",
          "isprimary": "true",
          "description": "Child",
          "relationshiptorakey": ""
        }
      ],
      "substances": [],
      "ishousehold": "yes",
      "personpayee": [],
      "phoneNumber": [],
      "Dangerousself": "no",
      "Mentealimpair": "no",
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
      "everbeenadoptedflag": 0,
      "personabusesubstance": [],
      "drugexposednewbornflag": 0,
      "personbehavioralhealth": [],
      "personmedicalcondition": [],
      "sexoffenderregisteredflag": 0,
      "fetalalcoholspctrmdisordflag": 0,
      "personmedicationphyscotropic": [],
      "probationsearchconductedflag": 0
    },
    {
      "Dob": "1970-07-10T04:00:00.000Z",
      "Pid": "ffec6738-452e-4560-a095-4c75adbb21f1",
      "Role": "PARENT",
      "State": "MD",
      "County": "Anne Arundel",
      "Gender": "M",
      "school": [],
      "emailID": [],
      "testing": [],
      "Lastname": "Elwahhaei",
      "cjamspid": "200167434",
      "employer": [],
      "fullName": " Osmon  Elwahhaei ",
      "guardian": {},
      "vocation": [],
      "Firstname": "Osmon",
      "emergency": [],
      "personRole": [
        {
          "hidden": false,
          "rolekey": "PARENT",
          "isprimary": "true",
          "description": "Parent",
          "relationshiptorakey": ""
        }
      ],
      "substances": [],
      "ishousehold": "yes",
      "personpayee": [],
      "phoneNumber": [],
      "Dangerousself": "no",
      "Mentealimpair": "no",
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
      "ishouseholdmember": 2,
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
      "everbeenadoptedflag": 0,
      "personabusesubstance": [],
      "drugexposednewbornflag": 0,
      "personbehavioralhealth": [],
      "personmedicalcondition": [],
      "sexoffenderregisteredflag": 0,
      "fetalalcoholspctrmdisordflag": 0,
      "personmedicationphyscotropic": [],
      "probationsearchconductedflag": 0
    },
    {
      "Dob": "1986-09-15T04:00:00.000Z",
      "Pid": "b65554e3-24e9-4aab-b05a-484695895d7b",
      "Role": "PARENT",
      "State": "MD",
      "County": "Anne Arundel",
      "Gender": "F",
      "school": [],
      "emailID": [],
      "testing": [],
      "Lastname": "Mason",
      "cjamspid": "200167432",
      "employer": [],
      "fullName": " Ikeria  Mason ",
      "guardian": {},
      "vocation": [],
      "Firstname": "Ikeria",
      "emergency": [],
      "personRole": [
        {
          "hidden": false,
          "rolekey": "PARENT",
          "isprimary": "true",
          "description": "Parent",
          "relationshiptorakey": ""
        }
      ],
      "substances": [],
      "ishousehold": "yes",
      "personpayee": [],
      "phoneNumber": [],
      "Dangerousself": "no",
      "Mentealimpair": "no",
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
      "everbeenadoptedflag": 0,
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
  "userrole": "CWSP",
  "clwStatus": null,
  "narrative": [
    {
      "Role": "REP",
      "email": "",
      "title": "Police Officer",
      "ZipCode": "",
      "Lastname": "Sani",
      "RoleName": "Reporter",
      "Firstname": "Ismail",
      "Middlename": "",
      "PhoneNumber": "4103962488",
      "incidentdate": "2020-11-02T05:00:00.000Z",
      "organization": "BCPD",
      "isapproximate": false,
      "PhoneNumberExt": "",
      "incidentlocation": "3138 Belmont Avenue, Balt, MD"
    }
  ],
  "disposition": [
    {
      "caseID": "",
      "reason": "Submitted on reg day off",
      "Summary": "",
      "DAStatus": "Approved",
      "comments": "",
      "DaTypeKey": "247a8b26-cdee-4ce8-b36e-b37e49fd0103",
      "supStatus": "Approved",
      "agencyName": "",
      "agencyType": "",
      "GroupNumber": null,
      "supComments": "",
      "GroupComment": null,
      "intakeAction": "",
      "issubtypekey": true,
      "DADisposition": "Scrnin",
      "agencyContact": "",
      "captureReason": "",
      "serviceTypeID": "",
      "ReasonforDelay": "",
      "supDisposition": "Scrnin",
      "GroupReasonType": null,
      "dispositioncode": "ScreenOUT",
      "ServiceRequestNumber": "I202000194147",
      "intakeserreqstatustypekey": "Review",
      "supMultipleDispositionDropdown": [],
      "intakeMultipleDispositionDropdown": [
        {
          "text": "Screen In",
          "value": "Scrnin"
        },
        {
          "text": "Screen Out",
          "value": "ScreenOUT"
        }
      ]
    }
  ],
  "createdCases": null,
  "reviewstatus": {
    "status": "Approved",
    "appevent": "DRAFT",
    "commenttext": "",
    "ispreintake": false
  },
  "crossReference": [],
  "officelocation": "Baltimore City",
  "reasonforDraft": [
    {
      "time": 1604301696747
    },
    {
      "time": 1604301831717
    },
    {
      "time": 1604302363884
    },
    {
      "time": 1604306821108
    },
    {
      "time": 1604306902965
    },
    {
      "time": 1604309722132
    },
    {
      "time": 1604312060930
    },
    {
      "time": 1605189801351
    },
    {
      "time": 1605189816281
    },
    {
      "time": 1605189832521
    }
  ],
  "securityuserid": "0ae86a6f-5365-4bb2-b079-f85eb391a2ae",
  "evaluationFields": null,
  "identifiedPersons": [],
  "intakeDATypeDetails": [],
  "focuspersoncasedetails": []
}'
where intakenumber = 'I202000194147' and activeflag =1;

update intakesnapshot set updatedby = 'CDM-8967', updatedon = now(), 
jsondata = '{
 "sdm": {
  "isar": false,
  "isir": false,
  "worker": "Devin Stevenson",
  "comments": "",
  "countyid": null,
  "isschool": false,
  "provider": [],
  "screenIn": {},
  "immediate": "No Immediate",
  "screenOut": {
   "duplicatereportflag": null
  },
  "referralid": "",
  "reportdate": null,
  "riskofHarm": {
   "isnegrh_exposednewborn": false
  },
  "supervisor": "A. Chambers",
  "workerdate": null,
  "badgenumber": "245",
  "isoutofhome": false,
  "referraldob": "1970-01-01T00:00:00.000Z",
  "sexualAbuse": {},
  "maltreatment": "no",
  "recordnumber": "8201100313",
  "referralname": "",
  "allegedvictim": [],
  "childfatality": "no",
  "datesubmitted": "2020-11-02T10:14:38.336Z",
  "immediateList": {
   "immediateList6": null,
   "isimmed_allegation": null,
   "isimmed_otherspecify": null,
   "isimmed_seriousinjury": null,
   "isimmed_childfaatility": null,
   "isimmed_childleftalone": null
  },
  "isreportmeets": false,
  "issexualabuse": false,
  "physicalAbuse": {
      "ismalpa_caregiver": true
    },
  "providerKnown": null,
  "generalNeglect": {},
  "immediateList6": null,
  "ismaltreatment": false,
  "supervisordate": null,
  "cpsResponseType": null,
  "ischildfatality": false,
  "isfinalscreenin": true,
  "noImmediateList": {
   "isnoimmed_risk_harm": false,
   "isnoimmed_sexualabuse": false,
   "isnoimmed_mentalinjury": false,
   "isnoimmed_physicalabuse": false,
   "isnoimmed_neglectresponse": false,
   "isnoimmed_screeninoverride": true,
   "isnoimmed_substantial_risk": false
  },
  "officerlastname": "Sani",
  "unattendedChild": {},
  "arGeneralNeglect": {},
  "isdeathorserious": false,
  "isrecsc_scrrenin": false,
  "officerfirstname": "Ismail",
  "allegedmaltreator": [],
  "childUnderOneYear": "",
  "childunderoneyear": "No",
  "islicenseddaycare": false,
	"ismalpa_caregiver": true,
  "isrecsc_screenout": true,
  "officermiddlename": "",
  "isimmed_allegation": null,
  "isprivateplacement": false,
  "issignordiagonises": false,
  "screeningRecommend": "ScreenOUT",
  "duplicatereportflag": null,
  "isnoimmed_risk_harm": false,
  "scnRecommendOveride": "",
  "disqualifyingFactors": {},
  "isfcplacementsetting": false,
  "isimmed_otherspecify": null,
  "disqualifyingCriteria": {
   "isoutofhome": false,
   "isreportmeets": false,
   "issexualabuse": false,
   "isdeathorserious": false,
   "issignordiagonises": false
  },
  "isimmed_seriousinjury": null,
  "isnoimmed_sexualabuse": false,
  "providerunknowndetail": null,
  "isimmed_childfaatility": null,
  "isimmed_childleftalone": null,
  "isnegrh_exposednewborn": false,
  "isnoimmed_mentalinjury": false,
  "isnoimmed_physicalabuse": false,
  "isnegfp_cargiverintervene": false,
  "isnegmn_unreasonabledelay": false,
  "isnoimmed_neglectresponse": false,
  "isnoimmed_screeninoverride": true,
  "isnoimmed_substantial_risk": false,
  "ismenab_psycologicalability": false,
  "ismenng_psycologicalability": false
 },
 "DAType": {
  "DATypeDetail": [
   {
    "caseID": "",
    "reason": "Submitted on reg day off",
    "Summary": "",
    "DAStatus": "Approved",
    "comments": "",
    "DaTypeKey": "247a8b26-cdee-4ce8-b36e-b37e49fd0103",
    "supStatus": "Approved",
    "agencyName": "",
    "agencyType": "",
    "GroupNumber": null,
    "supComments": "",
    "GroupComment": null,
    "intakeAction": "",
    "issubtypekey": true,
    "DADisposition": "Scrnin",
    "agencyContact": "",
    "captureReason": "",
    "serviceTypeID": "",
    "ReasonforDelay": "",
    "supDisposition": "Scrnin",
    "GroupReasonType": null,
    "dispositioncode": "ScreenOUT",
    "ServiceRequestNumber": "I202000194147",
    "intakeserreqstatustypekey": "Review",
    "supMultipleDispositionDropdown": [],
    "intakeMultipleDispositionDropdown": [
     {
      "text": "Screen In",
      "value": "Scrnin"
     },
     {
      "text": "Screen Out",
      "value": "ScreenOUT"
     }
    ]
   }
  ]
 },
 "agency": "CW",
 "roacps": null,
 "General": {
  "Time": "2020-11-12T14:03:52.521Z",
  "Iscps": null,
  "Agency": "CW",
  "Author": "MichelleFreeman",
  "Purpose": "247a8b26-cdee-4ce8-b36e-b37e49fd0103~CW",
  "countyid": "7665ca54-5374-4174-be07-a687b811a82c",
  "Narrative": "<p>Officer Sani called to report mom and her daughter was having a dispute because she went out of town for the weekend and when she returned she had men in her house. Officer Sani stated mom stated \"this is what she does when she goes out of town; she have different men in and out her house\". Officer Sani reports mom and daughter were arguing and mom told her to get out, to go to her fathers, Officer Sani reports the daughter went outside and called the police. She then sent her mom a text stating \"I''''m gonna get you in trouble\". When Officer Sani got there they started arguing again and she was asking for some of her personal things. Dad arrived to pick her up.</p><p><br></p><p>Officer Sani asked her did she need to go to the hospital for any reason. Daughter stated \"NO, she doesn''''t want to go\". Officer Sani stated the daughter stated mom punched her in her chest. But, she refused medical attention.</p><p><br></p><p><br></p><p><br></p><p>Worker went and attempted to see child at her fathers, however, no answer at door.  Worker tried to call and never answered.</p><p><br></p><p><br></p><p>Assigned to Devin Stevenson, Sup, A. Chambers, Div. 3</p>",
  "CreatedDate": "2020-11-02T06:14:20.629Z",
  "InputSource": "0bdda2ab-b74f-4d74-ba17-3b9b37a9ca19",
  "PurposeName": "Child Protective Services",
  "RecivedDate": "11/2/2020, 1:14:20 AM",
  "teamtypekey": "CW",
  "IntakeNumber": "I202000194147",
  "intakeservice": [],
  "receiveddelay": "Submitted on reg day off",
  "islocalreferal": 0,
  "servicerequest": [],
  "supervisorflag": "Y",
  "HeadofHousehold": " Ikeria  Mason ",
  "offenselocation": "",
  "queAdditionDate": "2020-11-12T13:57:36.012Z",
  "submissiondelay": "",
  "RefuseToShareZip": false,
  "IsUnknownReporter": false,
  "suggestedresource": [],
  "IsAnonymousReporter": false,
  "cpsHistoryClearance": "<p>CLEARANCE COMPLETED</p>",
  "narrativeUpdatedDate": "2020-11-02T10:12:41.454Z",
  "isacknowledgementletter": 1,
  "communicationDescription": "Phone"
 },
 "persons": [
  {
   "Dob": "2004-05-20T04:00:00.000Z",
   "Pid": "3d01a0c3-eb7e-42bb-8ffe-f04d7fa6a184",
   "Role": "CHILD",
   "State": "MD",
   "County": "Anne Arundel",
   "Gender": "F",
   "school": [],
   "emailID": [],
   "testing": [],
   "Lastname": "ELwahhaei",
   "cjamspid": "200167433",
   "employer": [],
   "fullName": " Zkia  ELwahhaei ",
   "guardian": {},
   "vocation": [],
   "Firstname": "Zkia",
   "emergency": [],
   "personRole": [
    {
     "hidden": false,
     "rolekey": "CHILD",
     "isprimary": "true",
     "description": "Child",
     "relationshiptorakey": ""
    }
   ],
   "substances": [],
   "ishousehold": "yes",
   "personpayee": [],
   "phoneNumber": [],
   "Dangerousself": "no",
   "Mentealimpair": "no",
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
   "everbeenadoptedflag": 0,
   "personabusesubstance": [],
   "drugexposednewbornflag": 0,
   "personbehavioralhealth": [],
   "personmedicalcondition": [],
   "sexoffenderregisteredflag": 0,
   "fetalalcoholspctrmdisordflag": 0,
   "personmedicationphyscotropic": [],
   "probationsearchconductedflag": 0
  },
  {
   "Dob": "1970-07-10T04:00:00.000Z",
   "Pid": "ffec6738-452e-4560-a095-4c75adbb21f1",
   "Role": "PARENT",
   "State": "MD",
   "County": "Anne Arundel",
   "Gender": "M",
   "school": [],
   "emailID": [],
   "testing": [],
   "Lastname": "Elwahhaei",
   "cjamspid": "200167434",
   "employer": [],
   "fullName": " Osmon  Elwahhaei ",
   "guardian": {},
   "vocation": [],
   "Firstname": "Osmon",
   "emergency": [],
   "personRole": [
    {
     "hidden": false,
     "rolekey": "PARENT",
     "isprimary": "true",
     "description": "Parent",
     "relationshiptorakey": ""
    }
   ],
   "substances": [],
   "ishousehold": "yes",
   "personpayee": [],
   "phoneNumber": [],
   "Dangerousself": "no",
   "Mentealimpair": "no",
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
   "ishouseholdmember": 2,
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
   "everbeenadoptedflag": 0,
   "personabusesubstance": [],
   "drugexposednewbornflag": 0,
   "personbehavioralhealth": [],
   "personmedicalcondition": [],
   "sexoffenderregisteredflag": 0,
   "fetalalcoholspctrmdisordflag": 0,
   "personmedicationphyscotropic": [],
   "probationsearchconductedflag": 0
  },
  {
   "Dob": "1986-09-15T04:00:00.000Z",
   "Pid": "b65554e3-24e9-4aab-b05a-484695895d7b",
   "Role": "PARENT",
   "State": "MD",
   "County": "Anne Arundel",
   "Gender": "F",
   "school": [],
   "emailID": [],
   "testing": [],
   "Lastname": "Mason",
   "cjamspid": "200167432",
   "employer": [],
   "fullName": " Ikeria  Mason ",
   "guardian": {},
   "vocation": [],
   "Firstname": "Ikeria",
   "emergency": [],
   "personRole": [
    {
     "hidden": false,
     "rolekey": "PARENT",
     "isprimary": "true",
     "description": "Parent",
     "relationshiptorakey": ""
    }
   ],
   "substances": [],
   "ishousehold": "yes",
   "personpayee": [],
   "phoneNumber": [],
   "Dangerousself": "no",
   "Mentealimpair": "no",
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
   "everbeenadoptedflag": 0,
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
 "userrole": "CWSP",
 "clwStatus": null,
 "narrative": [
  {
   "Role": "REP",
   "email": "",
   "title": "Police Officer",
   "ZipCode": "",
   "Lastname": "Sani",
   "RoleName": "Reporter",
   "Firstname": "Ismail",
   "Middlename": "",
   "PhoneNumber": "4103962488",
   "incidentdate": "2020-11-02T05:00:00.000Z",
   "organization": "BCPD",
   "isapproximate": false,
   "PhoneNumberExt": "",
   "incidentlocation": "3138 Belmont Avenue, Balt, MD"
  }
 ],
 "disposition": [
  {
   "caseID": "",
   "reason": "Submitted on reg day off",
   "Summary": "",
   "DAStatus": "Approved",
   "comments": "",
   "DaTypeKey": "247a8b26-cdee-4ce8-b36e-b37e49fd0103",
   "supStatus": "Approved",
   "agencyName": "",
   "agencyType": "",
   "GroupNumber": null,
   "supComments": "",
   "GroupComment": null,
   "intakeAction": "",
   "issubtypekey": true,
   "DADisposition": "Scrnin",
   "agencyContact": "",
   "captureReason": "",
   "serviceTypeID": "",
   "ReasonforDelay": "",
   "supDisposition": "Scrnin",
   "GroupReasonType": null,
   "dispositioncode": "ScreenOUT",
   "ServiceRequestNumber": "I202000194147",
   "intakeserreqstatustypekey": "Review",
   "supMultipleDispositionDropdown": [],
   "intakeMultipleDispositionDropdown": [
    {
     "text": "Screen In",
     "value": "Scrnin"
    },
    {
     "text": "Screen Out",
     "value": "ScreenOUT"
    }
   ]
  }
 ],
 "createdCases": null,
 "reviewstatus": {
  "status": "Approved",
  "appevent": "DRAFT",
  "commenttext": "",
  "ispreintake": false
 },
 "crossReference": [],
 "officelocation": "Baltimore City",
 "reasonforDraft": [
  {
   "time": 1604301696747
  },
  {
   "time": 1604301831717
  },
  {
   "time": 1604302363884
  },
  {
   "time": 1604306821108
  },
  {
   "time": 1604306902965
  },
  {
   "time": 1604309722132
  },
  {
   "time": 1604312060930
  },
  {
   "time": 1605189801351
  },
  {
   "time": 1605189816281
  },
  {
   "time": 1605189832521
  }
 ],
 "securityuserid": "0ae86a6f-5365-4bb2-b079-f85eb391a2ae",
 "evaluationFields": null,
 "identifiedPersons": [],
 "intakeDATypeDetails": [],
 "focuspersoncasedetails": []
}'
where intakenumber = 'I202000194147' and activeflag =1;
