/*
   Issue Description: CDM-23410
   Category/ Module  : Case Plan
   Root cause: Person-HealthInfo might have created/updated after the caseplan snapshot created
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

 	Snapshot info update:
	Father Details and Mother details
	person->healthinfo 
		Medication Info : medicationeffectivedate and medicationexpirationdate are null and no medication information to pull for the  period 
		Annual Exam: Updating snapshot with Annual exam info
		Followup Exam: Updating snapshot with Followup Exam info
*/
update snapshothist set snapshotdata = '[
	{
		"caseworker": "Paulette Hose",
		"serviceLogs": [],
		"versionList": [
			{
				"id": "fa0a7467-9296-415f-96b5-986cb093d598",
				"serviceplanid": "6cff30e4-48eb-491e-a449-27618436cbdd"
			},
			{
				"id": "594c1e5e-9539-459e-94e5-45701c755d99",
				"serviceplanid": "5a73647c-d8b0-44c6-a252-123d20dd1103"
			}
		],
		"jurisdiction": "Allegany",
		"assetsdetails": [
			{
				"facevalue": 0,
				"detailtype": "None",
				"assettypekey": "NON",
				"disposaldate": null,
				"purchasedate": "2021-01-07T00:00:00"
			}
		],
		"fatherdetails": {
                    "dob": "1990-02-03T00:00:00",
                    "akaname": " ",
                    "clientid": 3989215,
                    "ssnvalue": "220272073",
                    "parentname": "CURTIS MATREY",
                    "phonenumber": null,
                    "parentaddress": "216 Shaw St  Frostburg MD 21532"
                },
		"headersection": {
			"dob": "2020-12-23T05:00:00",
			"cisid": "426059789",
			"mdm_id": "MDT-136469699",
			"enddate": "2022-07-01T04:00:00",
			"clientid": 200300040,
			"childname": "Brodie Matrey-Cosner",
			"startdate": "2022-01-02T05:00:00"
		},
		"incomedetails": [
			{
				"amount": 10,
				"enddate": "9999-12-31T00:00:00",
				"startdate": "2021-01-01T00:00:00",
				"detailtype": null,
				"incomesourcetypekey": null
			},
			{
				"amount": 10,
				"enddate": null,
				"startdate": "2021-02-17T00:00:00",
				"detailtype": null,
				"incomesourcetypekey": null
			},
			{
				"amount": 0,
				"enddate": null,
				"startdate": "2021-01-07T00:00:00",
				"detailtype": "None - Earned",
				"incomesourcetypekey": "13"
			},
			{
				"amount": 0,
				"enddate": null,
				"startdate": "2021-01-07T00:00:00",
				"detailtype": "None - Unearned",
				"incomesourcetypekey": "4"
			}
		],
		"motherdetails": {
			"dob": "1994-02-01T00:00:00",
			"akaname": " ",
			"clientid": 200223256,
			"ssnvalue": "214413255",
			"parentname": "BRITTNEY COSNER",
			"phonenumber": null,
			"parentaddress": "216 Shaw St Apt. 5 Frostburg MD 21532"
		},
		"cplanquestions": {
			"dayCare": null,
			"iepDated": null,
			"parentName": null,
			"refMadeDate": null,
			"respiteCare": null,
			"otherReasons": null,
			"reimbursement": null,
			"tprDeniedDate": null,
			"blockEComments": null,
			"healthPassport": null,
			"schoolSchedule": null,
			"tprGrantedDate": null,
			"transportation": null,
			"discussServices": null,
			"faceToFaceVisit": null,
			"specialTraining": null,
			"tprPetitionDate": null,
			"writeOtherReson": null,
			"atOrNearAgeLevel": null,
			"diagnosedAxisOne": false,
			"diagnosedAxisTwo": false,
			"financialSupport": null,
			"lengthOfHomeless": null,
			"outOfHomeService": null,
			"addressChildNeeds": null,
			"diagnosedAxisFive": false,
			"diagnosedAxisFour": false,
			"episodeExperience": null,
			"isChildCoComitted": null,
			"reasonTPRPetition": null,
			"diagnosedAxisThree": false,
			"childInAndOutOfHome": null,
			"currentRelationship": null,
			"tprAppealDateFather": null,
			"tprAppealDateMother": null,
			"educationProgramGoal": null,
			"servicesForStability": null,
			"discussVisitationPlan": "Virtual visits due to treatment and incarceration. ",
			"explainChangeOfSchool": null,
			"conditionsAndAllergies": null,
			"discussionOfVisitation": null,
			"episodesOfHomelessness": null,
			"lastprogressreportdate": null,
			"parentChildInteraction": "Brittney engages appropriately. Cutis has not visited Brodie yet. ",
			"placementChangedSchool": null,
			"schoolProximityToPrior": null,
			"childEnrolledInFiveDays": null,
			"diagnosedAxisOneComment": "",
			"diagnosedAxisTwoComment": "",
			"discussionOfChildsNeeds": null,
			"problemsWithPeersBlockD": null,
			"problemsWithPeersBlockE": null,
			"sixMonthsPlacementExpln": null,
			"behavioralProblemsBlockD": null,
			"behavioralProblemsBlockE": null,
			"diagnosedAxisFiveComment": "",
			"diagnosedAxisFourComment": "",
			"emotionalSupportGuidance": null,
			"episodeExperienceExplain": null,
			"juvenileCourtInvolvement": null,
			"schoolAdjustmentComments": null,
			"servicecourtorderdetails": null,
			"describeStrengthsAndNeeds": null,
			"diagnosedAxisThreeComment": "",
			"extraCurricularActivities": null,
			"physicalOrMentaldiagnosis": null,
			"childCurrentReportCardCopy": null,
			"faceToFaceVisitContactDate": null,
			"individualEducationProgram": null,
			"passportRecordConfirmation": null,
			"servicesForPermanencyOther": null,
			"specifyTheNeedsAndServices": null,
			"supportiveServicesRequired": null,
			"faceToFaceVisitAuthoredDate": null,
			"passportRecordConfirmedDate": null,
			"tprAppealDecisionDateFather": null,
			"tprAppealDecisionDateMother": null,
			"utilizationOrNonUtilization": null,
			"visitationcourtorderdetails": null,
			"educationalServicesReceiving": null,
			"servicesForPermanencyClients": null,
			"voluntarySignatureDateFather": null,
			"voluntarySignatureDateMother": null,
			"educationalParentSurrogateName": null,
			"eighteenToTwentyOneChildStatus": null,
			"isChildEnrolledInSpecialProgram": null,
			"educationalParentSurrogateAddress": null,
			"educationalParentSurrogateWeakness": null,
			"educationalParentSurrogateRequested": null,
			"educationalParentSurrogateStrengths": null,
			"facilitatePermanencySelfSufficiency": null,
			"discussChildCurrentEducationalSetting": null,
			"facilitatePermanencySelfSufficiencyEndDate": null,
			"facilitatePermanencySelfSufficiencyStartDate": null
		},
		"supportdetails": null,
		"childannualexam": [
			{
				"annualtype": "Annual Health Examination",
				"annualprovider": "Allegany Hearing & Balance",
				"annualdate": "2022-03-07T00:00:00"
			},
			{
				"annualtype": "Annual Health Examination",
				"annualprovider": "Al-Qatarneh, MD",
				"annualdate": "2022-02-18T00:00:00"
			},
			{
				"annualtype": "Annual Health Examination",
				"annualprovider": "Dr. Hurtt",
				"annualdate": "2022-01-11T00:00:00"
			},
			{
				"annualtype": "Annual Health Examination",
				"annualprovider": "Dr. Hurtt",
				"annualdate": "2022-02-25T00:00:00"
			},
			{
				"annualtype": "Annual Health Examination",
				"annualprovider": "Dr. Hurtt",
				"annualdate": "2022-04-26T00:00:00"
			},
			{
				"annualtype": "Annual Health Examination",
				"annualprovider": "Hurtt",
				"annualdate": "2022-01-11T00:00:00"
			},
			{
				"annualtype": "Annual Health Examination",
				"annualprovider": null,
				"annualdate": "2022-02-07T00:00:00"
			}
			],
		"childinitialexam": null,
		"childremovaldate": "2021-01-07T00:00:00",
		"childfollowupexam": [
			{
				"followuptype": "Problem Follow-up Health Examination",
				"appt_date": "04/20/2022",
				"provider_details": "Hussein Jaffal, MD,   Morgantown WV, ",
				"followupreason": null,
				"nextappt_dt": null
			},
			{
				"followuptype": "Problem Follow-up Health Examination",
				"appt_date": "05/17/2022",
				"provider_details": "Tracy Coup,    , 3045984835",
				"followupreason": null,
				"nextappt_dt": "09/19/2022"
			}
			],
		"servicecasenumber": "2020036305006",
		"childremovalreason": "(\"Drug Abuse (Parent)\"),(Neglect)",
		"servicecourtdetails": {
			"courtorderdetails": "Addiction and Mental Health"
		},
		"placementinformation": [
			{
				"address": "Name: Sharon Slider Address: 12508 Blue Valley Cumberland Md 21502 Phone Number: ",
				"cpahomes": null,
				"serviceid": 10,
				"enddatetime": null,
				"servicename": "Regular Foster Care",
				"placementtype": "Placement",
				"startdatetime": "2021-01-07T00:00:00",
				"livingarrangementtype": null,
				"livingarrangementaddress": "Name:  Address: Blue Valley  Cumberland Md 21502 Phone Number: 3016973807"
			}
		],
		"assessmentinformation": [
			{
				"outcome": "",
				"assessmentname": "SAFE-C OHP",
				"assessmentcompletiondate": "2022-01-19T13:34:53"
			}
		],
		"childdbehaviourhealth": null,
		"childlegalinformation": [
			{
				"courtdocketnum": "C-01-JV-21-00005",
				"hearingdetails": [
					{
						"hearingdate": "2022-02-24T13:15:00",
						"hearingtype": "Permanency Planning",
						"hearingstatus": "Scheduled"
					},
					{
						"hearingdate": "2022-01-27T14:30:00",
						"hearingtype": "Permanancy Plan Review",
						"hearingstatus": "Continuance"
					},
					{
						"hearingdate": "2022-01-06T14:00:00",
						"hearingtype": "Permanency Planning",
						"hearingstatus": "Continuance"
					}
				],
				"childattorneyinfo": null
			}
		],
		"visitationcourtdetails": {
			"courtorderdetails": "minimu 3 times per week "
		},
		"childtprlegalinformation": null,
		"caseworkerservicesandplan": {
			"establisheddate": "2021-01-14T05:00:00",
			"cuurentplacetolive": "Regular Foster Care",
			"permanancyplandata": {
				"lifebookExpln": "No photos are being taken.  Baby is 2 weeks old and just was released form the hospital",
				"isProviderAgree": "1",
				"permToPermExpln": "Visitations are scheduled to maintain relationship between parent and child. ",
				"courtOrdersExpln": "Visitation with the parent",
				"safeAndCareExpln": "Child is in a licensed foster home",
				"isInClosedProximity": "1",
				"isProviderAgreeExpln": null,
				"assessmentPeriodExpln": "Plan of safe care was unsuccessful.  Family meeting took place prior to foster care placement to look for family resources.  ",
				"serviceAgreementExpln": "Monthly visitation, appropriate referrals and visitation",
				"meetingSafetyNeedsExpln": "Child is currently in a foster care placement but many efforts  to place with family",
				"sixMonthsPlacementExpln": "NA",
				"isInClosedProximityExpln": null,
				"serviceAgreementForOtherExpln": "No siblings.  Family supports have been contacted or are being contacted."
			},
			"facetofacecontactdate": [
				{
					"insertedon": "2022-01-13T08:24:21.620419",
					"contactdate": "2022-01-12T00:00:00"
				},
				{
					"insertedon": "2022-01-19T11:39:21.981903",
					"contactdate": "2022-01-14T00:00:00"
				},
				{
					"insertedon": "2022-01-19T11:58:36.98478",
					"contactdate": "2022-01-18T00:00:00"
				},
				{
					"insertedon": "2022-01-21T11:07:51.473802",
					"contactdate": "2022-01-19T00:00:00"
				},
				{
					"insertedon": "2022-01-26T10:40:18.363487",
					"contactdate": "2022-01-24T00:00:00"
				}
			],
			"primarypermanencytype": "Reunification",
			"treatmentteameetingdate": null,
			"concurrentpermanencytype": "Guardianship by relative"
		},
		"childeducationinformation": null,
		"childdisabilityinformation": null,
		"childemploymentinformation": null,
		"childmedicationinformation": null
	}
]' , updatedby = 'CDM-23410', updatedon = now()
where id = '4a72abef-7de3-4c44-bd29-1acf0cd09c94';