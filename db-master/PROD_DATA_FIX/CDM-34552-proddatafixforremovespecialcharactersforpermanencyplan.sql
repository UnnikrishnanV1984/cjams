/*
   Issue Description: CIDM-34552
   Category/ Module  : Prod data fix to remove specail characters
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


/*

 {
    "isInClosedProximity": "0",
    "isInClosedProximityExpln": "The youth does not have a reunification goal. ",
    "meetingSafetyNeedsExpln": "The ILP caregiver is helping the youth obtain life skills so that she will be able to age out ready to fair well in society as she parents her 2 small children. The caregiver is also ensuring that the youth is able to live independently by ensuring that she is demonstrating that she know she how to maintain a neat, clean and safe living space. The caregiver is also ensjuring that the youth will have skills that will be transferable when she exits care to include adhering to the rules and expectations of the program. ",
    "sixMonthsPlacementExpln": "Over the past 6-months the youth had to prepare for becoming a parent to her second child. Over the next 6 months, this worker anticipates that the youth will display that she is able to adjust and adapt to parenting 2 small children while working part time and maitianing the stability of her ILP baby mother placement. ",
    "courtOrdersExpln": "There are no follow up requirements on this court order. ",
    "permToPermExpln": "The youth does not have an adoption plan.",
    "safeAndCareExpln": "This worker completes monthly in-person visits to ensure that the youth's basic needs are being meet. This worker participates in treatment team meetings to discus goals and the progress of those goals. This worker assess the yong parent’s ability to properly and safely parent her two small children This worker discuss concerns with youth to determine if the youth continues to feel safe and supported. This worker assist the youth with getting both her children and hersel to and from medical appointments. This worker also provides the youth with emotional and psychological support. ",
    "assessmentPeriodExpln": "THe ILP team and this worker provides the youth with opportunities to participate in life skills services. ",
    "lifebookExpln": "No, the youth will receive an age out portfolio when she exits care that will include, her medical,educational, legal, placement history and other pertinent documentation during the youth’[s to in care. ",
    "serviceAgreementExpln": "The agency is not working with this youth’s bio-father. The youth’s mother is decesed.",
    "isProviderAgree": "1",
    "isProviderAgreeExpln": null,
    "serviceAgreementForOtherExpln": "The agency is not working with the youth’s family members. "
  }
  */
 
 update permanencyplan set permplanquestdata = '{
  "lifebookExpln": "No, the youth will receive an age out portfolio when she exits care that will include, her medical,educational, legal, placement history and other pertinent documentation during the youths to in care. ",
  "isProviderAgree": "1",
  "permToPermExpln": "The youth does not have an adoption plan.",
  "courtOrdersExpln": "There are no follow up requirements on this court order. ",
  "safeAndCareExpln": "This worker completes monthly in-person visits to ensure that the youth''s basic needs are being meet. This worker participates in treatment team meetings to discus goals and the progress of those goals. This worker assess the yong parents ability to properly and safely parent her two small children This worker discuss concerns with youth to determine if the youth continues to feel safe and supported. This worker assist the youth with getting both her children and hersel to and from medical appointments. This worker also provides the youth with emotional and psychological support. ",
  "isInClosedProximity": "0",
  "isProviderAgreeExpln": null,
  "assessmentPeriodExpln": "THe ILP team and this worker provides the youth with opportunities to participate in life skills services. ",
  "serviceAgreementExpln": "The agency is not working with this youth’s bio-father. The youth’s mother is decesed.",
  "meetingSafetyNeedsExpln": "The ILP caregiver is helping the youth obtain life skills so that she will be able to age out ready to fair well in society as she parents her 2 small children. The caregiver is also ensuring that the youth is able to live independently by ensuring that she is demonstrating that she know she how to maintain a neat, clean and safe living space. The caregiver is also ensjuring that the youth will have skills that will be transferable when she exits care to include adhering to the rules and expectations of the program. ",
  "sixMonthsPlacementExpln": "Over the past 6-months the youth had to prepare for becoming a parent to her second child. Over the next 6 months, this worker anticipates that the youth will display that she is able to adjust and adapt to parenting 2 small children while working part time and maitianing the stability of her ILP baby mother placement. ",
  "isInClosedProximityExpln": "The youth does not have a reunification goal. ",
  "serviceAgreementForOtherExpln": "The agency is not working with the youth’s family members. "
 }', updatedby = 'CDM-34552', updatedon = now()
 where permanencyplanid = '4585426a-118d-4e7b-abe7-c23457aeb064';