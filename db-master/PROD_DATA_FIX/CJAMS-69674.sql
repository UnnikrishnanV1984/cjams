/*
Issue Description: End dated wrong child. 
Category/Module: Child Removal / Foster Care Eligibility
Case ID: 3227760
Client ID: 3232658 (JOSEPH BUSH)
Root cause: This is not a defect. The worker exited the placement with the reason 'Permanently Leaving
            Custody & Care' on the wrong child. When that reason is used, the system automatically end dates
            the child's removal, the OOH program assignment and the Title IV-E eligibility. So all three got
            end dated on 08/05/2026 for a child who should still be open.
Fix provided: Removed the end dates the system had added - the Child Removal exit date (along with the exit
              reason and return date/time it set), the OOH Program Assignment end date and the Title IV-E
              Client Eligibility end date. Added an entry in the Child Removal audit table to record that the
              removal was re-opened by this data fix.
Data/Code fix ticket#: CJAMS-69674
Regression Impacts: N/A - scoped to a single removal (removalid 311486) for one client.
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error. The placement was exited with reason 'Permanently Leaving
                                Custody & Care' on the wrong child, which end dates the child removal by
                                design.
*/

update cjams.intakeservreqchildremoval
set    exitdate          = null,
       removalexitreason = null,
       returndate        = null,
       returntime        = null,
       returntransts     = null,
       updatedby         = 'CJAMS-69674',
       updatedon         = now()
where  intakeservreqchildremovalid = '8d2bf791-2515-4e33-a7ac-b700cf513ef2'
and    removalid = '311486'
and    activeflag = 1;

update cjams.personprogramarea
set    enddate   = null,
       updatedby = 'CJAMS-69674',
       updatedon = now()
where  personprogramid = '8c41bae3-2a0b-4936-b535-52eab4f2ec66'
and    programkey = 'OOH'
and    activeflag = 1;

update cjams.tb_client_eligibility
set    end_dt         = null,
       update_user_id = 'CJAMS-69674',
       update_ts      = now()
where  eligibility_id = 10085572
and    client_id = 3232658
and    removal_id = 311486
and    delete_sw = 'N';

insert into cjams.intakeservreqchildremoval_history(
       intakeservreqchildremovalhistoryid,
       rowtype,
       intakeservreqchildremovalid,
       activeflag,
       insertedby,
       insertedon,
       updatedby,
       updatedon,
       intakeservicerequestactorid,
       removaltypekey,
       servicecaseid,
       personid,
       removalid,
       modifieddata)
values (
       gen_random_uuid(),
       'HISTORY',
       '8d2bf791-2515-4e33-a7ac-b700cf513ef2',
       1,
       'CJAMS-69674',
       now(),
       'CJAMS-69674',
       now(),
       '299f35d2-cdba-4401-89a2-a0c660c4a825',
       'JD',
       '7bd354ff-b609-4b40-b432-17098321b06a',
       '4350c4bb-6aec-4054-8476-d6a7f5f22c7e',
       311486,
       '{"status": "Updated", "data": [ {"key": "comments", "data_type": "text", "new_value": "The child removal was re-opened with the datafix ticket CJAMS-69674 as the wrong child was end dated.", "display_name": "Comments"}]}'::json);
