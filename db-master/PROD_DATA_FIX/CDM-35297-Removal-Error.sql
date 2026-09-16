/*
 Issue Description: CDM-35297
 Category/ Module  : Child removal
 Root cause: : A removal was entered in error. User asked to get a data fix to delete the case from the system. 
 Pull request# for code fix: 
 Reason why no related code fix:  data fix done 
 Status of the code fix if already submitted and expected prod fix date: 
 */
UPDATE
    intakeservreqchildremoval
SET
    activeflag = 0,
    updatedby = 'CDM-35297',
    updatedon = now()
WHERE
    servicecaseid = 'd30e65e7-2bc9-472d-9147-603d7feb977a'
    AND personid = '485bde9f-e8ac-4bc0-bf36-caf4d6f1a401'
    AND intakeservreqchildremovalid = '9ba7be1b-4a34-4690-a3b6-de463280e7cf';

UPDATE
    personprogramarea
SET
    activeflag = 0,
    updatedby = 'CDM-35297',
    updatedon = now()
WHERE
    personprogramid = 'e9b035a0-f4a8-4cc1-9afc-908343f0bbc0';

UPDATE
    tb_client_eligibility
SET
    delete_sw = 'Y',
    update_user_id = 'CDM-35297',
    update_ts = now()
WHERE
    removal_id = '292513';

UPDATE
    intakeservreqchildremoval_history
SET
    activeflag = 0,
    updatedby = 'CDM-35297',
    updatedon = now()
WHERE
    intakeservreqchildremovalid = '9ba7be1b-4a34-4690-a3b6-de463280e7cf'
    AND activeflag = 1;

UPDATE
    routing
SET
    activeflag = 0,
    updatedby = 'CDM-35297',
    updatedon = now()
WHERE
    objectid = '9ba7be1b-4a34-4690-a3b6-de463280e7cf'
    AND activeflag = 1;

UPDATE
    placement
SET
    intakeservreqchildremovalid = null,
    updatedby = 'CDM-35297',
    updatedon = now()
WHERE
    intakeservreqchildremovalid = '9ba7be1b-4a34-4690-a3b6-de463280e7cf'
    AND activeflag = 1;