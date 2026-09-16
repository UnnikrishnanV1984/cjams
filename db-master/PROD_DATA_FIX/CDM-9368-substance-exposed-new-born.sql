update actor set drugexposednewbornflag = 1, updatedby = 'CDM-9368', updatedon = now() where personid = 'a6a18f8e-8133-44be-a2da-897050f34419';
update intakeservicerequestactor set drugexposednewbornflag = 1, updatedby = 'CDM-9368', updatedon = now() where personid = 'a6a18f8e-8133-44be-a2da-897050f34419';
update personrole set drugexposednewbornflag = 1, drugexposedtypekey = '["BMTD"]', updatedby = 'CDM-9368', updatedon = now() where personid = 'a6a18f8e-8133-44be-a2da-897050f34419';


update intakedastatus

set jsondata = '{
    "sdm": {
        "isar": false,
        "isir": false,
        "worker": "",
        "comments": "",
        "countyid": null,
        "isschool": false,
        "provider": [],
        "screenIn": {},
        "immediate": "",
        "screenOut": {
            "duplicatereportflag": null
        },
        "referralid": "",
        "reportdate": null,
        "riskofHarm": {
            "isnegrh_exposednewborn": true
        },
        "supervisor": "",
        "workerdate": null,
        "badgenumber": "",
        "isoutofhome": false,
        "referraldob": "1970-01-01T00:00:00.000Z",
        "sexualAbuse": {},
        "maltreatment": "no",
        "recordnumber": "",
        "referralname": "",
        "allegedvictim": [
            {
                "victimname": " Majesty  Rheubottom "
            }
        ],
        "childfatality": "no",
        "datesubmitted": null,
        "immediateList": {},
        "isreportmeets": false,
        "issexualabuse": false,
        "physicalAbuse": {},
        "providerKnown": null,
        "generalNeglect": {},
        "ismaltreatment": false,
        "supervisordate": null,
        "cpsResponseType": null,
        "ischildfatality": false,
        "isfinalscreenin": "false",
        "noImmediateList": {},
        "officerlastname": "",
        "unattendedChild": {},
        "arGeneralNeglect": {},
        "isdeathorserious": false,
        "isrecsc_scrrenin": false,
        "officerfirstname": "",
        "allegedmaltreator": [
            {
                "maltreatorsname": "AMANDA E TYLER"
            }
        ],
        "childUnderOneYear": "",
        "childunderoneyear": "",
        "islicenseddaycare": false,
        "isrecsc_screenout": true,
        "officermiddlename": "",
        "isprivateplacement": false,
        "issignordiagonises": false,
        "screeningRecommend": "ScreenOUT",
        "duplicatereportflag": null,
        "scnRecommendOveride": "",
        "disqualifyingFactors": {},
        "isfcplacementsetting": false,
        "disqualifyingCriteria": {
            "isoutofhome": false,
            "isreportmeets": false,
            "issexualabuse": false,
            "isdeathorserious": false,
            "issignordiagonises": false
        },
        "providerunknowndetail": null,
        "isnegrh_exposednewborn": true,
        "isnegfp_cargiverintervene": false,
        "isnegmn_unreasonabledelay": false,
        "ismenab_psycologicalability": false,
        "ismenng_psycologicalability": false
    },
    "agency": "CW",
    "roacps": null,
    "General": {
        "Time": "2021-01-26T21:36:36.735Z",
        "Iscps": null,
        "Agency": "CW",
        "Author": "JamesGreen",
        "Purpose": "247a8b26-cdee-4ce8-b36e-b37e49fd0103~CW",
        "countyid": "7665ca54-5374-4174-be07-a687b811a82c",
        "Narrative": "<p class=\"ql-align-justify\"><strong>*NOTE: This report is being reloaded from CJAMS ID# I202000409347*</strong></p><p class=\"ql-align-justify\"><strong>This Substance Exposed Newborn report will be assigned to Andrea Clark (ext. 37394) Division 1. The supervisor is Angelesa Blackwell (ext. 37051). The Unit Manager is Ms. Kimyetta Holder (ext. 37277).</strong></p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><strong><u>Reporter:</u></strong></p><p class=\"ql-align-justify\">Madison Resnick, Social Worker</p><p class=\"ql-align-justify\">University of Maryland</p><p class=\"ql-align-justify\"><span style=\"color: rgb(32, 33, 36);\">22 S Greene Street </span></p><p class=\"ql-align-justify\"><span style=\"color: rgb(32, 33, 36);\">Baltimore, MD 21201</span></p><p class=\"ql-align-justify\">Phone: 410-328-3361</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><strong><u>Casehead:</u></strong></p><p class=\"ql-align-justify\">Amanda Tyler (Mother) DOB: 07/17/1990</p><p class=\"ql-align-justify\"><span style=\"color: rgb(51, 51, 51);\">3605 Springdale Avenue</span></p><p class=\"ql-align-justify\">Baltimore, MD 21216</p><p class=\"ql-align-justify\">Phone: 443-803-0285</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><strong><u>Father:</u></strong></p><p class=\"ql-align-justify\">Franklin Rheubottom (Father)</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><strong><u>Child(ren): </u></strong></p><p class=\"ql-align-justify\">Majesty Rheubottom DOB: 12/13/2020</p><p class=\"ql-align-justify\"><strong><u>&nbsp;</u></strong></p><p class=\"ql-align-justify\"><strong><u>Other adults in the home:&nbsp;</u></strong></p><p class=\"ql-align-justify\">Unknown</p><p class=\"ql-align-justify\"><strong><u>&nbsp;</u></strong></p><p class=\"ql-align-justify\"><strong><u>Other children in the home: </u></strong></p><p class=\"ql-align-justify\">Unknown</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><strong><u>Describe the Situation:&nbsp;</u></strong></p><p>On December 17, 2020 Ms. Madison Resnick, a Social Worker at the University of Maryland Medical Center called the agency to make a report on behalf of newborn child Majesty Rheubottom. The caller stated both Majesty and her mother, Ms. Amanda Tyler were tested positive for Methadone. The caller stated Ms. Tyler was prescribed for Methadone. The caller said Majesty was moved last night to the NICU unit as the child is experiencing withdrawal symptoms. The caller said the APGARS are 9&amp;9 and the gestation was 40 weeks and 3 days. The caller stated Ms. Tyler did not complete Pre Natal-Care as she only took one class. The caller said Ms. Tyler receives family support and she also receives wick and TCA. The caller said Ms. Tyler is medically diagnosed with PTSD, Depression and BiPolar II. The caller said Ms. Tyler is seeking outpatient treatment, and she has been seeing a therapist for the past 3 years. The caller said Ms. Tyler is not taking any medications for her mental health issues at this time. The caller said Ms. Tyler denied any domestic violence issues at home. The caller said Majesty’s discharge date is unknown as she was moved to the NICU unit last evening.</p>",
        "CreatedDate": "2021-01-13T14:51:36.093Z",
        "InputSource": "0bdda2ab-b74f-4d74-ba17-3b9b37a9ca19",
        "PurposeName": "Child Protective Services",
        "RecivedDate": "1/13/2021, 9:51:36 AM",
        "teamtypekey": "CW",
        "IntakeNumber": "I202100316309",
        "intakeservice": [],
        "requestercity": "Baltimore",
        "islocalreferal": 0,
        "requesterstate": "MD",
        "servicerequest": [],
        "supervisorflag": "N",
        "HeadofHousehold": "AMANDA E TYLER",
        "offenselocation": "21201",
        "queAdditionDate": "2021-01-26T21:34:32.214Z",
        "requestercounty": "7665ca54-5374-4174-be07-a687b811a82c",
        "RefuseToShareZip": false,
        "IsUnknownReporter": false,
        "requesteraddress1": "22 S Greene St",
        "suggestedresource": [],
        "IsAnonymousReporter": false,
        "cpsHistoryClearance": "<p>CJAMS records revealed a Risk Of Harm report dated 11/06/2020 I202000596199. The Maryland Judiciary Case Search revealed history but not a 3-year history relevant to CPS.</p>",
        "requestercountyname": "Baltimore City",
        "narrativeUpdatedDate": "2021-01-13T14:54:05.559Z",
        "isacknowledgementletter": 1,
        "communicationDescription": "Phone"
    },
    "persons": [
        {
            "Dob": "1990-07-17T04:00:00.000Z",
            "Pid": "ae090876-c53e-46a5-8ed6-bb1d7fb028ae",
            "ssn": "217295925",
            "City": "Baltimore",
            "Role": "AM",
            "race": [
                {
                    "value_text": "White",
                    "racetypekey": "WH"
                }
            ],
            "State": "MD",
            "County": "Anne Arundel",
            "Gender": "F",
            "school": [],
            "Address": "1200 N COLLINGTON AVE",
            "emailID": [],
            "testing": [],
            "Lastname": "TYLER",
            "cjamspid": "1385299",
            "employer": [],
            "fullName": "AMANDA E TYLER",
            "guardian": {},
            "vocation": [],
            "Firstname": "AMANDA",
            "emergency": [],
            "personRole": [
                {
                    "hidden": false,
                    "rolekey": "AM",
                    "isprimary": "true",
                    "description": "Alleged Maltreator",
                    "relationshiptorakey": ""
                },
                {
                    "hidden": false,
                    "rolekey": "PARENT",
                    "isprimary": "true",
                    "description": "Parent",
                    "relationshiptorakey": ""
                }
            ],
            "substances": [],
            "addressinfo": [
                {
                    "city": "Baltimore",
                    "state": "MD",
                    "county": null,
                    "danger": false,
                    "address": "1200 N COLLINGTON AVE",
                    "country": "USA",
                    "mergeid": null,
                    "zipcode": null,
                    "address2": "",
                    "adrboxno": null,
                    "activeflag": 1,
                    "directions": null,
                    "streetname": "Collington ",
                    "addresstype": "Home",
                    "county_desc": null,
                    "durationday": null,
                    "changereason": null,
                    "dangerreason": null,
                    "addressstatus": null,
                    "acknowledgement": null,
                    "personaddressid": "52059918-e7fd-411a-ba1f-87ea9fea6f36",
                    "addressstartdate": "2012-05-09T00:00:00",
                    "incidentlocation": null,
                    "personadrenddate": null,
                    "formattedcityname": null,
                    "ishouseholdmember": false,
                    "personadrstartdate": "2012-05-09T00:00:00",
                    "acknowledgementflag": null,
                    "currentlocationflag": 1,
                    "formattedstreetname": null,
                    "incidentlocationflag": null,
                    "personaddresstypekey": "HO",
                    "adrstreetsuffixtypekey": "AVE",
                    "personaddresssubtypekey": null
                },
                {
                    "city": "Baltimore",
                    "state": "MD",
                    "county": null,
                    "danger": false,
                    "address": "832 E BALTIMORE ST",
                    "country": "USA",
                    "mergeid": null,
                    "zipcode": "21202",
                    "address2": "",
                    "adrboxno": null,
                    "activeflag": 1,
                    "directions": null,
                    "streetname": "Baltimore",
                    "addresstype": "Home",
                    "county_desc": null,
                    "durationday": null,
                    "changereason": null,
                    "dangerreason": null,
                    "addressstatus": null,
                    "acknowledgement": null,
                    "personaddressid": "2c4aed55-b98c-4c0a-a849-066bc4f025f0",
                    "addressstartdate": "2012-05-04T00:00:00",
                    "incidentlocation": null,
                    "personadrenddate": "2012-05-09T00:00:00",
                    "formattedcityname": null,
                    "ishouseholdmember": false,
                    "personadrstartdate": "2012-05-04T00:00:00",
                    "acknowledgementflag": null,
                    "currentlocationflag": 0,
                    "formattedstreetname": null,
                    "incidentlocationflag": null,
                    "personaddresstypekey": "HO",
                    "adrstreetsuffixtypekey": "ST",
                    "personaddresssubtypekey": null
                },
                {
                    "city": "Baltimore",
                    "state": "MD",
                    "county": null,
                    "danger": false,
                    "address": "423 WESTHAM WAY",
                    "country": "USA",
                    "mergeid": null,
                    "zipcode": "21224",
                    "address2": "",
                    "adrboxno": null,
                    "activeflag": 1,
                    "directions": null,
                    "streetname": "Westham",
                    "addresstype": "Home",
                    "county_desc": null,
                    "durationday": null,
                    "changereason": null,
                    "dangerreason": null,
                    "addressstatus": null,
                    "acknowledgement": null,
                    "personaddressid": "defc00f8-4e86-4505-b8d8-82bb109feef1",
                    "addressstartdate": "2011-06-23T00:00:00",
                    "incidentlocation": null,
                    "personadrenddate": "2011-06-23T00:00:00",
                    "formattedcityname": null,
                    "ishouseholdmember": false,
                    "personadrstartdate": "2011-06-23T00:00:00",
                    "acknowledgementflag": null,
                    "currentlocationflag": null,
                    "formattedstreetname": null,
                    "incidentlocationflag": null,
                    "personaddresstypekey": "HO",
                    "adrstreetsuffixtypekey": "WAY",
                    "personaddresssubtypekey": null
                },
                {
                    "city": "Baltimore",
                    "state": "MD",
                    "county": null,
                    "danger": false,
                    "address": "6401 YORK RD",
                    "country": "USA",
                    "mergeid": null,
                    "zipcode": "21212",
                    "address2": "",
                    "adrboxno": null,
                    "activeflag": 1,
                    "directions": null,
                    "streetname": "York",
                    "addresstype": "Home",
                    "county_desc": null,
                    "durationday": null,
                    "changereason": null,
                    "dangerreason": null,
                    "addressstatus": null,
                    "acknowledgement": null,
                    "personaddressid": "01365fd1-ad45-42cb-ab71-c23b4d56e8b2",
                    "addressstartdate": "2005-04-15T00:00:00",
                    "incidentlocation": null,
                    "personadrenddate": "2005-07-05T00:00:00",
                    "formattedcityname": null,
                    "ishouseholdmember": false,
                    "personadrstartdate": "2005-04-15T00:00:00",
                    "acknowledgementflag": null,
                    "currentlocationflag": null,
                    "formattedstreetname": null,
                    "incidentlocationflag": null,
                    "personaddresstypekey": "HO",
                    "adrstreetsuffixtypekey": "RD",
                    "personaddresssubtypekey": null
                },
                {
                    "city": "Baltimore",
                    "state": "MD",
                    "county": null,
                    "danger": false,
                    "address": "6401 YORK RD",
                    "country": "USA",
                    "mergeid": null,
                    "zipcode": "21212",
                    "address2": "",
                    "adrboxno": null,
                    "activeflag": 1,
                    "directions": null,
                    "streetname": "York",
                    "addresstype": "Home",
                    "county_desc": null,
                    "durationday": null,
                    "changereason": null,
                    "dangerreason": null,
                    "addressstatus": null,
                    "acknowledgement": null,
                    "personaddressid": "48f91db9-b765-4779-9595-2537984fd0ff",
                    "addressstartdate": "2005-07-05T00:00:00",
                    "incidentlocation": null,
                    "personadrenddate": "2005-07-05T00:00:00",
                    "formattedcityname": null,
                    "ishouseholdmember": false,
                    "personadrstartdate": "2005-07-05T00:00:00",
                    "acknowledgementflag": null,
                    "currentlocationflag": null,
                    "formattedstreetname": null,
                    "incidentlocationflag": null,
                    "personaddresstypekey": "HO",
                    "adrstreetsuffixtypekey": "RD",
                    "personaddresssubtypekey": null
                }
            ],
            "fullAddress": "1200 N COLLINGTON AVE",
            "ishousehold": "yes",
            "personpayee": [],
            "phoneNumber": [],
            "phonedetails": [
                {
                    "enddate": null,
                    "ismobile": null,
                    "startdate": "2017-10-30T00:00:00",
                    "phonenumber": "4433555761",
                    "phoneextension": null,
                    "personphonetype": "Cell",
                    "personphonetypekey": "CL",
                    "reversephonenumber": null,
                    "personphonenumberid": "d7db9a73-7526-4317-896a-231b8611cdec"
                }
            ],
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
            "everbeenadoptedflag": 0,
            "personabusesubstance": [],
            "drugexposednewbornflag": 1,
            "personbehavioralhealth": [],
            "personmedicalcondition": [],
            "sexoffenderregisteredflag": 0,
            "fetalalcoholspctrmdisordflag": 0,
            "personmedicationphyscotropic": [],
            "probationsearchconductedflag": 0
        },
        {
            "Dob": "2020-12-13T05:00:00.000Z",
            "Pid": "a6a18f8e-8133-44be-a2da-897050f34419",
            "Role": "CHILD",
            "State": "MD",
            "County": "Anne Arundel",
            "Gender": "F",
            "school": [],
            "emailID": [],
            "testing": [],
            "Lastname": "Rheubottom",
            "cjamspid": "200306117",
            "employer": [],
            "fullName": " Majesty  Rheubottom ",
            "guardian": {},
            "vocation": [],
            "Firstname": "Majesty",
            "emergency": [],
            "personRole": [
                {
                    "hidden": false,
                    "rolekey": "CHILD",
                    "isprimary": "true",
                    "description": "Child",
                    "relationshiptorakey": ""
                },
                {
                    "hidden": false,
                    "rolekey": "AV",
                    "isprimary": "true",
                    "description": "Alleged Victim",
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
            "drugexposednewbornflag": 1,
            "personbehavioralhealth": [],
            "personmedicalcondition": [],
            "sexoffenderregisteredflag": 0,
            "fetalalcoholspctrmdisordflag": 0,
            "personmedicationphyscotropic": [],
            "probationsearchconductedflag": 0
        },
        {
            "Dob": "1900-01-10T05:00:00.000Z",
            "Pid": "f3315622-42d9-45c5-860c-bf445c975e94",
            "Role": "PARENT",
            "State": "MD",
            "County": "Anne Arundel",
            "Gender": "M",
            "school": [],
            "emailID": [],
            "testing": [],
            "Lastname": "Rheubottom",
            "cjamspid": "200305659",
            "employer": [],
            "fullName": " Franklin  Rheubottom ",
            "guardian": {},
            "vocation": [],
            "Firstname": "Franklin",
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
            "drugexposednewbornflag": 1,
            "personbehavioralhealth": [],
            "personmedicalcondition": [],
            "sexoffenderregisteredflag": 0,
            "fetalalcoholspctrmdisordflag": 0,
            "personmedicationphyscotropic": [],
            "probationsearchconductedflag": 0
        }
    ],
    "userrole": "CWCW",
    "clwStatus": null,
    "narrative": [
        {
            "Role": "SSP",
            "email": "",
            "title": "Social Worker",
            "ZipCode": "",
            "Lastname": "Resnick",
            "RoleName": "Social Services personnel",
            "Firstname": "Madison",
            "Middlename": "",
            "PhoneNumber": "4103283361",
            "incidentdate": "2021-01-13T05:00:00.000Z",
            "organization": "",
            "isapproximate": false,
            "PhoneNumberExt": "",
            "incidentlocation": "3605 Springdale Ave Balto MD 21216"
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
    "officelocation": "Baltimore City",
    "reasonforDraft": [
        {
            "time": 1610549649958
        },
        {
            "time": 1610549762135
        },
        {
            "time": 1610549768154
        },
        {
            "time": 1610550043683
        },
        {
            "time": 1610550132607
        },
        {
            "time": 1610550190435
        },
        {
            "time": 1610550214672
        },
        {
            "time": 1610550304880
        },
        {
            "time": 1610550511257
        },
        {
            "time": 1610550613460
        },
        {
            "time": 1610550664044
        },
        {
            "time": 1610550704948
        },
        {
            "time": 1610550737717
        },
        {
            "time": 1610550808618
        },
        {
            "time": 1610551085240
        },
        {
            "time": 1610551181924
        },
        {
            "time": 1610551217963
        },
        {
            "time": 1610551287293
        },
        {
            "time": 1610551677378
        },
        {
            "time": 1610551708453
        },
        {
            "time": 1610551739692
        },
        {
            "time": 1610551791359
        },
        {
            "time": 1610552116386
        },
        {
            "time": 1610552215615
        },
        {
            "time": 1610552488795
        },
        {
            "time": 1610552559523
        },
        {
            "time": 1610552607050
        },
        {
            "time": 1610552655065
        },
        {
            "time": 1610552736227
        },
        {
            "time": 1610552813475
        },
        {
            "time": 1610552866105
        },
        {
            "time": 1610552986821
        },
        {
            "time": 1610553024442
        },
        {
            "time": 1610553158424
        },
        {
            "time": 1610553264476
        },
        {
            "time": 1610553352147
        },
        {
            "time": 1610553437599
        },
        {
            "time": 1610553589575
        },
        {
            "time": 1610553639900
        },
        {
            "time": 1610554002918
        },
        {
            "time": 1610554011091
        },
        {
            "time": 1610555054249
        },
        {
            "time": 1610555215425
        },
        {
            "time": 1610555260197
        },
        {
            "time": 1610555280584
        },
        {
            "time": 1610555325010
        },
        {
            "time": 1610562531324
        },
        {
            "time": 1610562652247
        },
        {
            "time": 1610562708751
        },
        {
            "time": 1610562750930
        },
        {
            "time": 1610562859197
        },
        {
            "time": 1610631406109
        },
        {
            "time": 1610631458319
        },
        {
            "time": 1610631537569
        },
        {
            "time": 1610716550181
        },
        {
            "time": 1610716596617
        },
        {
            "time": 1610716647039
        },
        {
            "time": 1610716676951
        },
        {
            "time": 1611244850227
        },
        {
            "time": 1611244947441
        },
        {
            "time": 1611245148900
        },
        {
            "time": 1611245177548
        },
        {
            "time": 1611245200298
        },
        {
            "time": 1611245284284
        },
        {
            "time": 1611673879784
        },
        {
            "time": 1611674315634
        },
        {
            "time": 1611696996734
        }
    ],
    "securityuserid": "d0d8ef63-c0e3-4e1c-8d3b-f37b486d03c9",
    "evaluationFields": null,
    "intakeDATypeDetails": [],
    "focuspersoncasedetails": []
}'

,updatedon = now(),
updatedby = 'CDM-9368'

where intakenumber = 'I202100316309' and activeflag = 1;
