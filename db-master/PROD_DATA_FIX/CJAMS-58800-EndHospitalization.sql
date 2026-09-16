
/*
Issue Description: Need to end date the hospitalization for youth that shelter care . Hospitalization needs to end on 01/17/2025 4:30PM 
Category/Module: Support
Root cause: The issue happened because the client wasn’t marked as discharged, and the user didn’t have access to edit the discharge details,
 which caused an error when trying to update the record.
Fix provided: DB queries to create new record in personhospitalization table.
Data/Code fix ticket#:CJAMS-58800
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: user error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/

update  personhospitalization 
set updatedby= 'CJAMS-58800' , updatedon=now(),  
hospital_discharged = true ,hospital_dischargeddate = '2025-01-17 16:30:00.000'
where hospitalizationid = 'a89de2b0-eae0-4330-89f9-001deb377a54' and activeflag = 1;


update  personhospitalization_history 
set updatedby= 'CJAMS-58800' , updatedon=now(),
hospital_discharged = true ,hospital_dischargeddate = '2025-01-17 16:30:00.000'
where hospitalizationid = 'a89de2b0-eae0-4330-89f9-001deb377a54' and activeflag = 1;