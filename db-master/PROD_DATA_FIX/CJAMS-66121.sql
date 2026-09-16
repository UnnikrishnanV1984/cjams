
/*
Issue:CJAMS-66121 AR Case Summary.
Category/Module: AR Summary
Root cause: Duplicate AR has been created and QA was unable to reproduce the issue in stg environment.
            Data fix needed to delete the duplicate AR.
            We found that two duplicate AR records have been created and it might be incorrectly created by the user as the timestamps are different.
Fix provided: Data fix has been done to delete the duplicate AR for the case.
Data/Code fix ticket#: CJAMS-66121
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:  BA/QA is trying to replicate this and then we will work on the code fix.
*/
update Investigationmaltreatment 
set    activeflag = 0,
       updatedby = 'CJAMS-66121',
       updatedon = now()
where  maltreatmentid = '2cc04e7d-1325-4049-a872-4fd2e1e5efe2';

update investigationmaltreatmentactor 
set    activeflag = 0,
       updatedby = 'CJAMS-66121',
       updatedon = now()
where  maltreatmentid = '2cc04e7d-1325-4049-a872-4fd2e1e5efe2';

update investigationallegation 
set    activeflag = 0,
       updatedby = 'CJAMS-66121',
       updatedon = now()
where  maltreatmentid = '2cc04e7d-1325-4049-a872-4fd2e1e5efe2';