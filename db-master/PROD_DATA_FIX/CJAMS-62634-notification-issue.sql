/*
Issue Description:CJAMS-62634 :Worker Mattie McDowell reports that while she has entered all medication for this youth she continues to receive notification asking if the child is prescribed medication, and sometimes what she has entered previously has disappeared.
Category/Module: Psychotrophic medication
Root cause:  B-208462 Health Tab: Medication Mandatory Updates was implemented recently and cjams needs to display
            a Prescribe Medication alert and will require caseworker to update the Medication subtab every 30 days from the child removal start date.
            Updating the previous month records was missing user story implementation.
            We need a Code fix needs to be done to update the activiy status for old months to avoid such issues in future
            Data fix will be done as the part of this ticket to update the status to closed from CRInProgress for
            Case ID: 3156296
            Client ID: 1673930 (Jennifer Lynn Otlowsky)
            Child Removal Start Date: 01/05/2022
Fix provided: Data fix is done as the part of this ticket to update the status to closed from CRInProgress for
            Case ID: 3156296
            Client ID: 1673930 (Jennifer Lynn Otlowsky)
            Child Removal Start Date: 01/05/2022
Regression Impacts: N/A
Is Code fix Required?:Yes
Code fix ticket#: TBD
Reason why no related code fix: N/A
*/


update activitytask 
set activitytaskstatustypekey ='CRClosed',
    completeddate = now(),
    updatedby = 'CJAMS-62634',
    updatedon = now()
where activitytaskid  ='a07616e2-1820-4bdb-bc23-5891e2ef6d1d'
and activeflag=1;