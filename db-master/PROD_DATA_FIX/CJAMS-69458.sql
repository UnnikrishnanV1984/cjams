/*
Issue Description: CJAMS-69458 - Incorrect placement dates (after void)
Category/Module: Child Removal / Placement / Program Area
Root cause: User voided the placement rather than editing the placement end date. Per system
            design, voiding a placement that carries the PLCC exit cascades an exit date onto
            the removal record and the OOH program assignment.
Fix provided: Data fix to clear the exit/end date on the removal record and on the OOH program
              assignment so the removal is open again. The worker will then re-add the placement
              and re-end-date the removal (exit date 06/17/2026) through the application.
Data/Code fix ticket#: CJAMS-69458
Regression Impacts: Validate payment/overpayment impact after the next batch run (voided
                    placement referenced paymentheaderid 5241420). 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Expected behaviour (user data-entry action, not a defect).


*/

-- Remove the end (exit) date of the child removal record
UPDATE cjams.intakeservreqchildremoval
   SET exitdate          = NULL,
       removalexitreason = NULL,
       returndate        = NULL,
       returntime        = NULL,
       updatedon         = now(),
       updatedby         = 'CJAMS-69458'
 WHERE intakeservreqchildremovalid = 'd483aee2-c464-4a7e-84a9-598b78b21eee'
   AND personid                    = 'de8b3ee5-feb6-48d6-86fb-2c9011796542'
   AND servicecaseid               = 'd380c0b2-e639-4100-8ce7-01b427667d0a'
   AND activeflag                  = 1;

--  Remove the end date of the Out-of-Home (OOH) program assignment
UPDATE cjams.personprogramarea
   SET enddate      = NULL,
       endreasonkey = NULL,
       updatedon    = now(),
       updatedby    = 'CJAMS-69458'
 WHERE personprogramid = 'a557de6f-ed9f-4342-99fe-0a9c2c023914'
   AND personid        = 'de8b3ee5-feb6-48d6-86fb-2c9011796542'
   AND objectid        = 'd380c0b2-e639-4100-8ce7-01b427667d0a'
   AND programkey      = 'OOH'
   AND activeflag      = 1;


UPDATE cjams.tb_client_eligibility
   SET end_dt         = NULL,
       update_user_id = 'CJAMS-69458',
       update_ts      = now()
 WHERE eligibility_id = 10005589
   AND removal_id     = 254493
   AND delete_sw      = 'N';

INSERT INTO cjams.intakeservreqchildremoval_history(
    intakeservreqchildremovalhistoryid,
    rowtype,
    intakeservreqchildremovalid,
    intakeserviceid,
    activeflag,
    insertedby,
    insertedon,
    updatedby,
    updatedon,
    exitdate,
    removalexitreason,
    intakeservicerequestactorid,
    servicecaseid,
    personid,
    modifieddata)
VALUES (
    gen_random_uuid(),
    'HISTORY',
    'd483aee2-c464-4a7e-84a9-598b78b21eee',
    '4eabfecd-9692-416d-881d-e5990984526a',
    '1',
    'CJAMS-69458',
    now(),
    'CJAMS-69458',
    now(),
    NULL,
    NULL,
    '5dce0a94-31c6-4939-9902-57eeab19788a',
    'd380c0b2-e639-4100-8ce7-01b427667d0a',
    'de8b3ee5-feb6-48d6-86fb-2c9011796542',
    '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal exit date were cleared with the datafix ticket CJAMS-69458.","display_name": "Comments"}]}');