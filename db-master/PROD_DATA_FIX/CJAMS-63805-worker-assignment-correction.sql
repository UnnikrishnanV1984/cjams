/*
Issue: CJAMS-63805 Worker Assignment Errors
Category/Module: Case assignment
Root cause: This issue has occurred due to a data fix provided with a user ticket (CJAMS-63470).The case assignment was updated in production before this data fix.
            With this ticket the Caseworker name "Emma Roth" has been changed to "Emma Brown" and the prior Family assignment has been ended and the new Family assignment was added for the new name. This fix has been deployed to Production on 11/19/2025 but before that on 11/18/2025 a new Family assignment has been added to the Caseworker "Samira Jackson" in the production.
            Need data fix as mentioned below to update the Caseworker assignments for the Case# 3266673, 

            Emma Brown - Administrative - 08/20/2025 - Open
            Emma Brown - Family - 09/20/2023 - (DELETE this assignment)
            Samira Jackson - Family - 08/20/2025 - Open
            Emma Roth - Family - 09/20/2023 - 08/20/2025 (Change the end date from 11/19/2025 to 08/20/2025)
Fix provided: Data fix has been done to update the case worker assignments for case # 3266673  
Data/Code fix ticket#: CJAMS-63805
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This occured due to data fix CJAMS-63470 and we need to correct it with data fix.
*/


update caseassignment
set enddate ='2025-08-20',
    updatedby = 'CJAMS-63805', 
    updatedon = now()
where caseassignmentid = '947dec4b-eb8c-4abb-a363-a52f33870afd' 
and activeflag = 1 ;


update caseassignment
set activeflag =0,
    updatedby = 'CJAMS-63805',
    updatedon = now()
where caseassignmentid = '4a7a051a-c3e5-407c-bc7f-4edfc3280c84'
and activeflag = 1 ; 


update caseassignment
set startdate ='2025-08-20',
    updatedby = 'CJAMS-63805',
    updatedon = now()
where caseassignmentid = '77ab462d-bc4a-4984-9157-90347dead429'
and activeflag = 1 ;
