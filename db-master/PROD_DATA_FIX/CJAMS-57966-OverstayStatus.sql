
/*
Issue Description: Please provide the data fix to remove the Discharge Date in the Living arrangement record 
Category/Module: Support
Root cause: user can not update  exisiting placements dates.
Fix provided: DB queries to create new record in personhospitalization table.
Data/Code fix ticket#: CJAMS-57966
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/
--

update  personhospitalization 
set updatedby= 'CJAMS-57966' , updatedon=now(),  
hospital_discharged = false ,actual_placement_after_discharge = null,hospital_overstay = false ,hospital_dischargerecommendation = null,hospital_dischargeddate = null
where hospitalizationid = '4d41546e-339a-49ec-a8d9-5ebd19d9aa35' and activeflag = 0;


update  personhospitalization_history 
set updatedby= 'CJAMS-57966' , updatedon=now(),
hospital_discharged = false ,actual_placement_after_discharge = null,hospital_overstay = false ,hospital_dischargerecommendation = null,hospital_dischargeddate = null
where hospitalizationid = '4d41546e-339a-49ec-a8d9-5ebd19d9aa35' and activeflag = 0;