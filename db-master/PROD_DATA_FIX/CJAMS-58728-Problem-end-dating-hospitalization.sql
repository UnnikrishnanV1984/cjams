/*
 Issue Description:
Case ID: 221030017708
Client ID: 200167649 (Taliyah Whitfield)
Hospital Name: Christiana Care Union Hospital    
ER Visit - Yes;  ER Visit Date - 7/5/2024 ; ER Visit Time - 6:00 AM
Discharged - Yes;  Discharged Date - 7/5/2024; Discharged Time - 11:00 AM

Category/ Module: Placement
 Root cause: User Request, as system wasn't allowing user to update the discharge date.
  Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select enddt,endtime,hospital_dischargeddate,hospital_discharged ,hospital_erexamination,hospital_examstartdate,* from personhospitalization where hospitalizationid = '12176571-4261-490f-9b6e-c3787d5501bb';
*/

update personhospitalization 
set hospital_dischargeddate = '2024-07-05 11:00:00.000',
	hospital_discharged = true,
	hospital_erexamination = true,
	hospital_examstartdate = '2024-07-05 6:00:00.000',
	updatedby = 'CJAMS-58728',
	updatedon = now()
where hospitalizationid = '12176571-4261-490f-9b6e-c3787d5501bb'
and activeflag = 1;