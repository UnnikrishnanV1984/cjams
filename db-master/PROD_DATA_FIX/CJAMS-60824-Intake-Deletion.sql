/*
Issue Description: Delete error intake
Category/Module: Intake
Root cause: I251013307899 Intake was created by mistake and user requested to delete it
Fix provided: Data fix has been to done to delete the incorrect intake from all the intake related tables.
Data/Code fix ticket#:N/A
Regression Impacts: N/A
Is Code fix Required?: N/A
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

--This intake in present in only two table and in review state

update cjams.intakedastatus set activeflag =0,updatedby ='CJAMS-60824', updatedon =now()
where intakenumber ='I251013307899';

update cjams.intakedastaging set activeflag =0,updatedby ='CJAMS-60824',updatedon =now()
where intakenumber ='I251013307899' and activeflag=1;

