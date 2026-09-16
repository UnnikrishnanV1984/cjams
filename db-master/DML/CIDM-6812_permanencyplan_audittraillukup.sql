DELETE FROM cjams.audittraillukup WHERE typekey='permanencyplan';

INSERT INTO cjams.audittraillukup
(typekey, fieldjson, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('permanencyplan', '[
  {
    "displayname": "Permanency Plan Established Date",
    "key": "primaryplandate"
  },
  {
    "displayname": "Concurrent Plan Established Date",
    "key": "concurrentplandate"
  },
  {
    "displayname": "Primary Permanency Plan",
    "key": "primarypermanencytype"
  },
  {
    "displayname": "Concurrent Permanency Plan",
    "key": "concurrentpermanencytype"
  },
  {
    "displayname": "primary arrange type",
    "key": "primaryarrangetype"
  },
  {
    "displayname": "Primary Permanency Plan Comments",
    "key": "remarks"
  },
  {
    "displayname": "Concurrent Permanency Plan Comments",
    "key": "concurrentcomments"
  },
  {
    "displayname": " Court order received and uploaded in CJAMS",
    "key": "courtorderreceived"
  },
  {
    "displayname": "If the permanency plan is to return home or relative placement, is the placement in close proximity to the child’s family?",
    "key": "isInClosedProximity"
  },
  {
    "displayname": "If the permanency plan is to return home or relative placement, is the placement in close proximity to the child’s family? - Explanation required",
    "key": "isInClosedProximityExpln"
  },
  {
    "displayname": "Discuss how the caregiver is meeting the safety needs of the child as well as the appropriateness and the restrictiveness of the present placement, the child’s adjustment to the placement, and how the placement meets the best interest and the special needs of the child. - Explanation required",
    "key": "meetingSafetyNeedsExpln"
  },
  {
    "displayname": "Discuss and explain changes in the child’s placement during the last 6 months. Discuss any anticipated changes in placement in the next 6 months. - Explanation required  ",
    "key": "sixMonthsPlacementExpln"
  },
  {
    "displayname": "Describe how the worker is carrying out specific court orders pertaining to the child. - Explanation required",
    "key": "courtOrdersExpln"
  },
  {
    "displayname": "Document what steps have been taken to finalize the placement for children whose permanency plan is adoption or placement at another permanent home? - Explanation required",
    "key": "permToPermExpln"
  },
  {
    "displayname": "Parent 1 Name",
    "key": "parentname"
  },
  {
    "displayname": "Parent 2 Name",
    "key": "parent2name"
  },
  {
    "displayname": "Describe how the worker is ensuring that the child receives safe and appropriate care. Discuss specific outcomes of ongoing/past services that have been offered to the child during the assessment period? - Explanation required",
    "key": "safeAndCareExpln"
  },
  {
    "displayname": "What efforts were made to promote permanency for the child during this assessment period? - Explanation required",
    "key": "assessmentPeriodExpln"
  },
  {
    "displayname": "Has a Lifebook been prepared? If no, Explain?",
    "key": "lifebookExpln"
  },
  {
    "displayname": "Describe the parent’s compliance in developing and carrying out the terms of the Service Agreement. (Discuss specific outcomes during this assessment period). Describe the parent’s involvement including dates of case planning meetings, in working with the caseworker to develop the case plan. Discuss specific outcomes of ongoing and past services offered to the parent(s) during this assessment period, including times of participation and the results of any meetings. - Explanation required",
    "key": "serviceAgreementExpln"
  },
  {
    "displayname": "Does the Provider agree with the Permanency Plan?",
    "key": "isProviderAgree"
  },
  {
    "displayname": "Provider agree with the Permanency Plan? - Explanation required",
    "key": "isProviderAgreeExpln"
  },
  {
    "displayname": "Discuss services being provided to other significant persons including contacts with siblings, extended family, permanent foster parents, prospective adoptive parents, etc.Describe the child’s relationship with these significant others and/or any other relevant issues.Explain why child not placed with siblings, including how such placement would be contrary to the safety or well being of any of the siblings. - Explanation required",
    "key": "serviceAgreementForOtherExpln"
  },
  {
    "displayname": "End Reason",
    "key": "reason"
  },
  {
    "displayname": "End Date",
    "key": "enddate"
  },
  {
    "displayname": "Achieved Date",
    "key": "achieveddate"
  },
  {
    "displayname": "Permanency Plan Remains the same",
    "key": "permanencyplanremainssame"
  },
  {
    "displayname": "Review Date",
    "key": "permanencyplanremainssamedate"
  },
  {
      "displayname": "Status",
      "key": "approvalstatus"
  },
  {
      "displayname": "updated date and time",
      "key": "updateddate"
  },
  {
      "displayname": "Updated By",
      "key": "updateduser"
  }
]'::json::json, 1, 'ADMIN', now(), 'CIDM-6812', now());
