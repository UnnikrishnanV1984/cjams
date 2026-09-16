DELETE FROM cjams.audittraillukup
WHERE audittraillukupid='4c3a8a02-7187-424d-9c2a-e2b0887fdb25' and typekey = 'safecohpassessment';


INSERT INTO cjams.audittraillukup
(audittraillukupid, typekey, fieldjson, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('4c3a8a02-7187-424d-9c2a-e2b0887fdb25'::uuid, 'safecohpassessment', '[
  {
    "displayname": "Date Assessment Initiated",
    "key": "dateassessmentinitiated"
  },
  {
    "displayname": "Case ID",
    "key": "caseid"
  },
  {
    "displayname": "head of Household",
    "key": "casehead"
  },
  {
    "displayname": "Child Name",
    "key": "ClientName"
  },
  {
    "displayname": "CJAMS PID",
    "key": "clientid"
  },
  {
    "displayname": "Date of birth",
    "key": "dob"
  },
  {
    "displayname": "Current Placement",
    "key": "currentplacement"
  },
  {
    "displayname": "Potential Resource",
    "key": "potentialresource"
  },
  {
    "displayname": "Name of Placement Resource",
    "key": "placementlivingarrangement"
  },
  {
    "displayname": "STAFF MEMBER INTERVIEWED/COMMENTS",
    "key": "staffmember"
  },
  {
    "displayname": "When Circumstances Suggest That the Childs/Youths Safety May be Jeopardized.",
    "key": "timeframe1"
  },
  {
    "displayname": "Initial/Replacement Placements.",
    "key": "timeframe2"
  },
  {
    "displayname": "Before Completing a Case Reconsideration.",
    "key": "timeframe3"
  },
  {
    "displayname": "This childs immediate health needs are being or will be met in a manner that will prevent immediate danger to self or others",
    "key": "safetyinfluenceq1"
  },
  {
    "displayname": "If the child was on medication, the medication is or will be secured and managed in a manner that prevents immediate danger to self or others",
    "key": "safetyinfluenceq2"
  },
  {
    "displayname": "If the child had a history of suicidal or self-destructive behavior, their emotional or psychological needs are being or will be addressed and managed to prevent immediate danger to self or others.",
    "key": "safetyinfluenceq3"
  },
  {
    "displayname": "If the child had a history of aggressive or violent behavior, their needs are being or will be addressed and managed to prevent immediate danger to self or others",
    "key": "safetyinfluenceq4"
  },
  {
    "displayname": "If the child had a history of sexual behaviors, their needs are being or will be addressed and managed to prevent immediate danger to self or others",
    "key": "safetyinfluenceq5"
  },
  {
    "displayname": "If the child had a history of drug or alcohol abuse, their needs are being or will be addressed danger to self or others",
    "key": "safetyinfluenceq6"
  },
  {
    "displayname": "This childs sleeping arrangements have been observed by caseworker and are appropriate.",
    "key": "safetyinfluenceq7"
  },
  {
    "displayname": "This child is or will be protected from visits/visitation placing the child in immediate danger",
    "key": "safetyinfluenceq8"
  },
  {
    "displayname": "This child does not express specific fears of other children, providers, or the environment that suggest that the child is in immediate danger",
    "key": "safetyinfluenceq9"
  },
  {
    "displayname": "Provider appears competent, coherent, and currently able to carry out his/her responsibilities and poses no immediate danger to the child.",
    "key": "safetyinfluenceq10"
  },
  {
    "displayname": "Any injuries to the child in this placement/living arrangement have been appropriately explained and documented and suggest no immediate danger to the child",
    "key": "safetyinfluenceq11"
  },
  {
    "displayname": "This childs whereabouts are known",
    "key": "safetyinfluenceq12"
  },
  {
    "displayname": "Unsafe Influences Identified",
    "key": "unsafeinfluencesidentified"
  },
  {
    "displayname": "Safety decision",
    "key": "safetydecision"
  },
  {
    "displayname": "Child Is Safe (Influences 1-12 Marked YES)",
    "key": "safetydecision1"
  },
  {
    "displayname": "Unsafe (Any influence 1-12 was checked NO)",
    "key": "childIsUnsafeAnyInfluence112WasCheckedNo"
  },
  {
    "displayname": "Whereabouts of Child/Youth is Unknown",
    "key": "WUInsafe1"
  },
  {
    "displayname": "If Placed with the Potential Resource Provider",
    "key": "WUInsafe2"
  },
  {
    "displayname": "If they remain with the Current placement / Living arrangement",
    "key": "WUInsafe3"
  },
  {
    "displayname": "Comments",
    "key": "Comments"
  },
  {
    "displayname": "Signature Obtained",
    "key": "SignatureObtained"
  },
  {
    "displayname": "Representative / Title",
    "key": "representativetitle"
  },
  {
    "displayname": "Local Department",
    "key": "localdepartment"
  },
  {
    "displayname": "Caseworker",
    "key": "assessor"
  },
  {
    "displayname": "Supervisor Name",
    "key": "supervisorname"
  },
  {
    "displayname": "Submit for Approval",
    "key": "assessmentreviewed"
  },
  {
    "displayname": "Safety Assessment Completion Date Time",
    "key": "safetyassessmentcompletiondate"
  },
  {
    "displayname": "Re-route to Supervisor",
    "key": "reroutesupervisor"
  },
  {
    "displayname": "Caseworker comments",
    "key": "caseworkercomments"
  },
  {
    "displayname": "Assessment status",
    "key": "assessmentstatus"
  },
  {
    "displayname": "Date Approved",
    "key": "approveddate"
  },
  {
    "displayname": "Supervisor comments",
    "key": "supervisorcomments"
  },
  {
    "displayname": "Address Line 1",
    "key": "addressline1"
  },
  {
    "displayname": "Address Line 2",
    "key": "addressline2"
  },
  {
    "displayname": "zipcode",
    "key": "zipcode"
  },
  {
    "displayname": "CPA Home Provider Address",
    "key": "provideraddress"
  },
  {
    "displayname": "fax",
    "key": "fax"
  },
  {
    "displayname": "work",
    "key": "work"
  },
  {
    "displayname": "EXT",
    "key": "ext"
  },
  {
    "displayname": "Signature Obtained Date",
    "key": "signatureObtainedDate"
  }
]'::json::json, 1, 'ADMIN', now(), 'CIDM-9537', now()) on conflict do nothing;