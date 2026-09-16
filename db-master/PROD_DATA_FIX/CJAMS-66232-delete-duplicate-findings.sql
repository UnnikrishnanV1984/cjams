/*
Issue: CJAMS-66232 Duplicate Tab Incorrectly Populated
Category/Module: Investigation Findings
Root cause: User data entry error and data fix is needed to delete the duplicate investigation findings record
Fix provided:  Data fix has been done to delete the incorrect duplicate investigation finding record that has been entered by the user.
Data/Code fix ticket#: CJAMS-66232
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User data entry error.
*/


--select *from investigationallegation where allegationid ='e11fc4b5-1edf-4f17-af54-b536bbf6df31' and investigationallegationid='287a0433-b548-4506-b38f-bc0809710ce7' and activeflag=1;


update investigationallegation
set activeflag = 0,
    updatedby = 'CJAMS-66232',
    updatedon = now()
where allegationid ='e11fc4b5-1edf-4f17-af54-b536bbf6df31' 
and investigationallegationid='287a0433-b548-4506-b38f-bc0809710ce7'
and activeflag=1;


update Investigationallegationmaltreators
set activeflag = 0,
    updatedby = 'CJAMS-66232',
    updatedon = now()
where investigationallegationid='287a0433-b548-4506-b38f-bc0809710ce7'
and activeflag=1;

