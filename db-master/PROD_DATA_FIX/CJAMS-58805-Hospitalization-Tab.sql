/*
 Issue Description:
Case ID: 3028040
Client ID: 1144046 (Justice Ray Leggett) 
Hospital Discharged as 'Yes' and Date & Time as '04/03/2024, 10:00 AM'.
Category/ Module: Placement
 Root cause: The case is closed which wasn't allowing user to edit the hospitilization tab.
 Also, the hospitilization wasn't linked with the placement because this record was created before B-186261 -  Hospitalization Tab implementation.
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
/*
select enddt,endtime,hospital_dischargeddate,hospital_discharged ,* from personhospitalization where hospitalizationid = '4da1c8e4-a4df-461c-b72c-8eaa5cb2f566';
*/

update personhospitalization 
set hospital_dischargeddate = '2024-04-03 10:00:00.000',
	hospital_discharged = true,
	updatedby = 'CJAMS-58805',
	updatedon = now()
where hospitalizationid = '4da1c8e4-a4df-461c-b72c-8eaa5cb2f566'
and activeflag = 1;