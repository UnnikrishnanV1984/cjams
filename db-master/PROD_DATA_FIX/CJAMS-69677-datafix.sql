/*
Issue Description: CJAMS-69677 - Support with child removal for adoption planning
Root cause: The user picked the wrong placement exit type. They chose PLCC (Permanently Leaving
            Custody & Care) instead of CIPS (Change in Placement Structure). PLCC closed the removal
            and the OOH program on 07/20/2026, so the worker cannot add the pre-adoptive placement.
Fix provided: Data fix to change the exit type to CIPS, clear the removal exit date, the OOH program
            end date and the IV-E eligibility end date, and add a history row for the fix. This
            reopens the removal so the worker can add the Pre-Finalized Adoptive Home placement. 
Data/Code fix ticket#: CJAMS-69677
Regression Impacts: NA
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Expected behaviour

*/

UPDATE cjams.placement
   SET exittypekey = 'CIPS',
       updatedon   = now(),
       updatedby   = 'CJAMS-69677'
 WHERE placementid                 = '561e1b20-6459-40d0-8c97-1ea0d2e70325'
   AND personid                    = 'd2d8546c-4c7d-4a64-9687-eb27c17ec2c7'
   AND servicecaseid               = '26d36db9-d67c-4bdb-b946-55219bffe856'
   AND intakeservreqchildremovalid = 'cb288858-8fd9-49e8-9de4-2c148fd12297'
   AND exittypekey                 = 'PLCC'
   AND activeflag                  = 1;

UPDATE cjams.intakeservreqchildremoval
   SET exitdate          = NULL,
       removalexitreason = NULL,
       returndate        = NULL,
       returntime        = NULL,
       updatedon         = now(),
       updatedby         = 'CJAMS-69677'
 WHERE intakeservreqchildremovalid = 'cb288858-8fd9-49e8-9de4-2c148fd12297'
   AND personid                    = 'd2d8546c-4c7d-4a64-9687-eb27c17ec2c7'
   AND servicecaseid               = '26d36db9-d67c-4bdb-b946-55219bffe856'
   AND activeflag                  = 1;

UPDATE cjams.personprogramarea
   SET enddate      = NULL,
       endreasonkey = NULL,
       updatedon    = now(),
       updatedby    = 'CJAMS-69677'
 WHERE personprogramid = '5f6c85e0-955f-47cb-906c-ecc5ba9b0345'
   AND personid        = 'd2d8546c-4c7d-4a64-9687-eb27c17ec2c7'
   AND objectid        = '26d36db9-d67c-4bdb-b946-55219bffe856'
   AND programkey      = 'OOH'
   AND activeflag      = 1;

UPDATE cjams.tb_client_eligibility
   SET end_dt         = NULL,
       update_user_id = 'CJAMS-69677',
       update_ts      = now()
 WHERE eligibility_id = 10101771
   AND removal_id     = 321535
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
    'cb288858-8fd9-49e8-9de4-2c148fd12297',
    NULL,
    '1',
    'CJAMS-69677',
    now(),
    'CJAMS-69677',
    now(),
    NULL,
    NULL,
    'aeacf071-958f-4701-8432-6d132f4b424f',
    '26d36db9-d67c-4bdb-b946-55219bffe856',
    'd2d8546c-4c7d-4a64-9687-eb27c17ec2c7',
    '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal exit date was cleared with the datafix ticket CJAMS-69677","display_name": "Comments"}]}');