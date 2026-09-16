/*
Issue:CJAMS-64599 Missing DOD and Fatality Button
Category/Module: Person profile/SDM 
Root cause: Data entry error and user has missed to enter the Date of Death of the alleged victim.
            The child Alicia Cinto Ramirez's date of death is 10/8/2025 and is not entered into the case. The DOD needs to be entered and the Fatality button needs to be selected as "yes." 
Fix provided:  Data fix has been provided to add the Date of Death and select the fatality button as yes in SDM tab.
Data/Code fix ticket#: CJAMS-64599
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update person
set dateofdeath = '2025-10-08 00:00:00',
    updatedon = now(),
    updatedby = 'CJAMS-64599'
where personid = '8eb3e870-9b2f-4d82-9c41-b605aa185a0e'
and activeflag =1;    

update intakesnapshot
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
 updatedby = 'CJAMS-64599',  updatedon =now()
where intakenumber = 'I241013153479' and activeflag = 1;

update intakeservicerequestsdm
set ischildfatality = true,
   updatedby = 'CJAMS-64599',  updatedon =now()
where intakeserviceid='06432ffb-8c1d-4849-95f5-19b0b0fe1d23' and activeflag =1;

update intakedastaging
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
updatedby = 'CJAMS-64599',  updatedon =now()
where intakenumber='I241013153479' and activeflag=1;