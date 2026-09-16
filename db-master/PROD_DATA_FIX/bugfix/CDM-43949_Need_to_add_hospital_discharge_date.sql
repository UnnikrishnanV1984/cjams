/*
   Issue Description: CDM-43949
   Category/ Module  : Hospitilization
   Root cause: data fix to enter the discharge date 12/01/2023 10:00 AM
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
    Olivia Sheets CASE# 3220627 Case was closed in October 2024 (aged-out in August 2024).
    Worker needs to add discharge date from Lifebridge Health Carroll Hospital ER visit 12/01/2023. OSheets was discharged from the ER on the same day.
    No psychiatric hospital admission and no overstay. */
/*
select enddt,endtime,hospital_dischargeddate,* from personhospitalization where hospitalizationid = '513c3dcf-ae17-418a-a249-3ae87e72821c';
2023-12-01 10:00
*/

update personhospitalization 
set hospital_dischargeddate = '2023-12-01 10:00',
	updatedby = 'CDM-43949',
	updatedon = now()
where hospitalizationid = '513c3dcf-ae17-418a-a249-3ae87e72821c'
and activeflag = 1;