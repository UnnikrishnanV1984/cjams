
/*
Issue Description: CJAMS-66064 -data is not loading on following 2 screens,Maltreatment Allegation,Investigation Findings
Category/Module: Case Management
Root cause: SDM roles were missing for the service request which is causing the data not to load on the screens
Fix provided: Data fix has been promoted to update missing sdm roles from backend
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
update intakeservicerequestsdm set ismalsa_sexualmolestation=true, 
updatedby ='CJAMS-66064',updatedon=now() 
where intakeservicerequestsdmid ='000b581b-94d3-4bf2-af82-c28494127cb0' 
and intakeserviceid ='41d4348d-893b-4e42-91db-6d30ea3c302c' and activeflag =1;