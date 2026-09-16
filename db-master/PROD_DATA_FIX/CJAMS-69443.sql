/*
Issue Description: CJAMS-69443 - Breaking the link for adoption case
Category/Module: Adoption / Child Removal / Placement / Program Area
Root cause: The placement exit type was set to PLCC (Permanently Leaving Custody & Care), which
            ends the removal and the OOH program. A PLCC exit is not a placement-to-
            placement transition, so the removal cannot remain open for the adoption break-the-link
            step. The exit represents a change of placement structure, not the child permanently
            leaving custody and care.
Fix provided: Data fix to (1) change the placement exit type from PLCC to CIPS (Change in Placement
            Structure), (2) clear the exit date on the removal record, and (3) clear the end date on
            the OOH program assignment. This reopens the removal so the worker can add the
            Pre-Finalized Adoptive Home placement and complete the adoption break-the-link.
Data/Code fix ticket#: CJAMS-69443
Regression Impacts: Validate payment impact after the next batch run (placement referenced
            paymentheaderid 5241656). Finance reconciliation is a separate business step.
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Expected behaviour (child not placed in a Pre-Finalized Adoptive
            Home; user recorded the wrong placement exit type).
*/

--  Change the placement exit type from PLCC to CIPS (Change in Placement Structure)
UPDATE cjams.placement
   SET exittypekey = 'CIPS',
       updatedon   = now(),
       updatedby   = 'CJAMS-69443'
 WHERE placementid                 = '4054023b-ba2e-4e60-9368-dafdadd51648'
   AND personid                    = 'de0fec19-4907-4d11-a7f5-6a17a788678c'
   AND servicecaseid               = '26d36db9-d67c-4bdb-b946-55219bffe856'
   AND intakeservreqchildremovalid = 'c3c9a693-98f2-4eec-befc-49078353c662'
   AND exittypekey                 = 'PLCC'
   AND activeflag                  = 1;

--  Remove the end (exit) date of the child removal record
UPDATE cjams.intakeservreqchildremoval
   SET exitdate          = NULL,
       removalexitreason = NULL,
       returndate        = NULL,
       returntime        = NULL,
       updatedon         = now(),
       updatedby         = 'CJAMS-69443'
 WHERE intakeservreqchildremovalid = 'c3c9a693-98f2-4eec-befc-49078353c662'
   AND personid                    = 'de0fec19-4907-4d11-a7f5-6a17a788678c'
   AND servicecaseid               = '26d36db9-d67c-4bdb-b946-55219bffe856'
   AND activeflag                  = 1;

--  Remove the end date of the Out-of-Home (OOH) program assignment
UPDATE cjams.personprogramarea
   SET enddate      = NULL,
       endreasonkey = NULL,
       updatedon    = now(),
       updatedby    = 'CJAMS-69443'
 WHERE personprogramid = '8c7e946f-5c46-42a6-abf1-7d882ad89c57'
   AND personid        = 'de0fec19-4907-4d11-a7f5-6a17a788678c'
   AND objectid        = '26d36db9-d67c-4bdb-b946-55219bffe856'
   AND programkey      = 'OOH'
   AND activeflag      = 1;

UPDATE cjams.tb_client_eligibility
   SET end_dt         = NULL,
       update_user_id = 'CJAMS-69443',
       update_ts      = now()
 WHERE eligibility_id = 10101738
   AND removal_id     = 321534
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
    'c3c9a693-98f2-4eec-befc-49078353c662',
    NULL,
    '1',
    'CJAMS-69443',
    now(),
    'CJAMS-69443',
    now(),
    NULL,
    NULL,
    'b9807b1c-073b-4104-b402-8e940e316648',
    '26d36db9-d67c-4bdb-b946-55219bffe856',
    'de0fec19-4907-4d11-a7f5-6a17a788678c',
    '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal exit date were cleared with the datafix ticket CJAMS-69443.","display_name": "Comments"}]}');
