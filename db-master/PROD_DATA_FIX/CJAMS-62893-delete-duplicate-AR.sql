/*
Issue:CJAMS-62893 AR Case Summary.
Category/Module: AR Summary
Root cause: Duplicate AR has been created and QA was unable to reproduce the issue in stg environment.
            Data fix needed to delete the duplicate AR.
            We found that two duplicate AR records have been created and it might be incorrectly created by the user as the timestamps are different.
Fix provided: Data fix has been done to delete the duplicate AR for the case 251023123884
Data/Code fix ticket#: CJAMS-62893
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:  BA/QA is trying to replicate this and then we will work on the code fix.
*/


update Investigationmaltreatment 
set    activeflag = 0,
       updatedby = 'CJAMS-62893',
       updatedon = now()
where  maltreatmentid in ('59eff732-5c23-4830-a1ff-8fb20c807b47','600ad023-bbc8-4bc0-a3c1-cb1c6daf27f4');

update investigationmaltreatmentactor 
set    activeflag = 0,
       updatedby = 'CJAMS-62893',
       updatedon = now()
where  investigationmaltreatmentactorid in  ('83575359-227f-4bcd-9457-875f5f8b8f6f','3f39e95b-6915-4d87-a438-2ae280a54354');

update investigationallegation 
set    activeflag = 0,
       updatedby = 'CJAMS-62893',
       updatedon = now()
where  maltreatmentid in ('59eff732-5c23-4830-a1ff-8fb20c807b47','600ad023-bbc8-4bc0-a3c1-cb1c6daf27f4');
