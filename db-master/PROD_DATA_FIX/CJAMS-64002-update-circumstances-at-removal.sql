/*
Issue: CJAMS-64002 Unable to save changes to 'Circumstances At Removal'
Category/Module: Child Removal
Root cause: This is an old case where child removal was done with all options under the circumstances at removal selected as 'NO'
            As per the current implementation the there needs to be some selection for the circumstances at removal to proceed with the Exiting the placement exit type to Permanently Leaving Custody & Care
            data fix has been requested to add the circumstance at removal for the Case Details:

            Case ID #  211030008900
            CJAMS PID # 1716688
            Caretaker’s Significant Impairment-Cognitive  – 'Applies'
            Child Behavior Problem –  'Applies'
Fix provided: Data fix has been done to add circumstances at removal as follows for the case 211030008900
              Caretaker’s Significant Impairment-Cognitive  – 'Applies'
              Child Behavior Problem –  'Applies'
Data/Code fix ticket#: CJAMS-64002
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is an old case with child removal done when circumstances at removal was not mandatory and data fix is needed add them.
*/


update intakeservreqchildremoval
set removalcircumstances = '{
    "abandonment": false,
    "caretakeralcoholuse": false,
    "caretakerdruguse": false,
    "caretakersignificantimpairment": true,
    "caretakerignificantimpphysical": false,
    "childalcoholuse": false,
    "childbehaviorproblem": true,
    "childdruguse": false,
    "childrequestedplacement": false,
    "deathofcaretaker": false,
    "diagnosedcondition": false,
    "domesticviolence": false,
    "failuretoreturn": false,
    "familyconflict": false,
    "homelessness": false,
    "inadequateaccesstomhs": false,
    "inadequateaccesstomedicalservices": false,
    "inadequatehousing": false,
    "incarcerationofcaretaker": false,
    "medicalneglect": false,
    "neglect": false,
    "parentalimmigration": false,
    "physicalabuse": false,
    "prenatalalcoholexposure": false,
    "prenataldrugexposure": false,
    "psychologicalemotionalabuse": false,
    "publicagencytitleive": false,
    "runaway": false,
    "sexualabuse": false,
    "sextrafficking": false,
    "tribaltitleive": false,
    "voluntaryrelinquishment": false,
    "whereaboutsunknown": false
  }'::json,
  updatedby = 'CJAMS-64002',
  updatedon = now()
  where intakeservreqchildremovalid = '8b302545-cef5-4d62-b4b4-cf3640d01742'
  and activeflag = 1;

  update placement
  set placementtypekey = NULL,
      updatedby = 'CJAMS-64002', --- previously updated by CIDM-10306
      updatedon = now()
 where placementid in ('98855ff1-b001-496a-be67-f110d66088d5')
 and activeflag = 1 ;                           