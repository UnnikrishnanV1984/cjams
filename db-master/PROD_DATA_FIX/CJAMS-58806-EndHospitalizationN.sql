
/*
Issue Description: Unable to end date hospitalization. Receiving popup of overlapping dates. Hospitalization needs to end on 04/25/2024 at 1:50 PM 
Category/Module: Support                
Root cause: The issue happened because the client wasn’t marked as discharged, and the user didn’t have access to edit the discharge details,
 which caused an error when trying to update the record.
Fix provided: DB queries to create new record in personhospitalization table.
Data/Code fix ticket#: CJAMS-58806
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/

update  personhospitalization 
set updatedby= 'CJAMS-58806' , updatedon=now(),  
hospital_discharged = true ,hospital_overstay = false ,hospital_dischargeddate = '2024-04-25 13:50:00.000'
where hospitalizationid = '5b1c76d2-9704-4846-9e45-e380ac5921e4' and activeflag = 1;


update  personhospitalization_history 
set updatedby= 'CJAMS-58806' , updatedon=now(),
hospital_discharged = true ,hospital_overstay = false ,hospital_dischargeddate = '2024-04-25 13:50:00.000'
where hospitalizationid = '5b1c76d2-9704-4846-9e45-e380ac5921e4' and activeflag = 1;