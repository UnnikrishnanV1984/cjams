/*
Issue Description: CJAMS-62995
Category/Module: Worker assignment to case did not end
Root cause:Code fix was deployed to production on 02/14/2025, and all adoption cases were closed before 02/14/2025 so ending the caseworker assignment through datafixe.
Fix provided:  Data fix to end the worker case assignment for  adoption cases 3302882,3290473,3053921,3177644.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: COde is already done and deployed as part of CIDM-9999
*/

update caseassignment set enddate = '2024-12-17 00:00:00', updatedby = 'CJAMS-62995', updatedon = now()
where caseassignmentid in ('b51eaa07-5376-4e4f-bc91-f3afe5bd2720') and activeflag = 1; 

update caseassignment set enddate = '2024-06-18 00:00:00', updatedby = 'CJAMS-62995', updatedon = now()
where caseassignmentid in ('ca4b3462-5004-4430-8c57-626e498c6a48') and activeflag = 1;

update caseassignment set enddate = '2024-05-16 00:00:00', updatedby = 'CJAMS-62995', updatedon = now()
where caseassignmentid in ('3476ddb1-6d2d-41e8-9b4e-33ee0f9ae892') and activeflag = 1;

update caseassignment set enddate = '2023-05-18 00:00:00', updatedby = 'CJAMS-62995', updatedon = now()
where caseassignmentid in ('c6a8a4e5-684f-48f1-8b81-0b1c65e1d538') and activeflag = 1;