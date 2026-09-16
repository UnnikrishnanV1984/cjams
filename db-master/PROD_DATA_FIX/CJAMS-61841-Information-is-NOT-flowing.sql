/*
Issue Description: CJAMs-61834
Data Fix - Case Plan pulling wrong Permanency Plan
Category/Module: Case plan 
Root cause: Case plan is fetching data from the old permanency plan. Data fix has been to done to update the correct reason
Fix provided: Data fix has been done to update the correct reason in the case plan
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CDM-44499 
Reason why no related code fix: We have tried to replicate this issue and it is working as expected. We need to investigate further if this issue happens in other cases.
*/

UPDATE snapshothist
SET
  snapshotdata = jsonb_set(
    snapshotdata,
    '{0,caseworkerservicesandplan}',
    ' {
      "establisheddate": "2025-06-04T04:00:00",
      "cuurentplacetolive": "Kinship",
      "permanancyplandata": {
        "lifebookExpln": "No. This is not necessary because the youth has only been in care for 60 days. The plan is reunification. ",
        "isProviderAgree": "1",
        "permToPermExpln": " The plan is reunification on this case. ",
        "courtOrdersExpln": "There are no anticipated changes within the last months.",
        "safeAndCareExpln": "The worker continues to make monthly visits, ensure that the medical and dental needs are completed. Request documentation from educational source and document monthly visits. During the monthly visits the worker ensures that the youth is safe and that there are no immediate concerns. This is currently the least restricted placement at this time. ",
        "isInClosedProximity": "1",
        "isProviderAgreeExpln": null,
		"meetingSafetyNeedsExpln": "Yes. The caregiver is meeting the youths mental, physical and mental needs of the youth.There are no current issues at this time.",
        "assessmentPeriodExpln": "During this assessment period, the youth has shared that she would like to maintain her current placement with her biological brother in order to maintain normalcy in her life. The worker has assisted the family with obtaining clothing, food, and ensured that the provider was approved for long term financial assistance (monthly stipend). ",
        "serviceAgreementExpln": "Mom and dad have not made their selves available to the department. However, dad waived his rights to Summer and mom is confined to a bed in a nursing facility and is unable to make any decisions for Summer due to her physical and mental state. ",
        "sixMonthsPlacementExpln": "There has been no changes in the last six months. ",
        "isInClosedProximityExpln": null,
        "serviceAgreementForOtherExpln": "Summer has a sister that is also in care and they maintain a relationship and see each other weekly and communicate via telephone daily."
      },
      "facetofacecontactdate": [
        {
          "insertedon": "2025-05-16 10:21:56.068",
          "contactdate": "2025-05-15 00:00:00.000"
        },
        {
          "insertedon": "2025-06-27 20:29:04.803",
          "contactdate": "2025-06-25 00:00:00.000"
        },
        {
          "insertedon": "2025-07-22 16:04:15.010",
          "contactdate": "2025-07-11 00:00:00.000"
        }
      ],
      "primarypermanencytype": "Reunification",
      "treatmentteameetingdate": null,
      "concurrentpermanencytype": "Guardianship by Relative"
    }'::jsonb
  ),
  updatedby = 'CJAMS-61841',
  updatedon = now()
WHERE
  objectid = 'd813ee64-f4bd-4c9c-af74-c23536132718'
  AND id = '1e6c14bc-d2a2-4c04-8505-bff66e622853'
  AND personid = 'bce86901-5e1b-4cee-aa99-709fa535d5ec'
  AND activeflag =1;