/*
Issue:CIDM-10869 Invalid year seen for Inpatient admission date in Person profile Hospitalization report.
Category/Module: Person / Hospitalization
Root cause: Invalid year seen for Inpatient admission date in Person profile Hospitalization report due to incorrect user insertion.
            Data fix is needed to correct the ER Visit and Inpatient Admission dates for the client's
            2380547
            2621802
Fix provided: Data fix has been done to correct the ER Visit and Inpatient Admission dates for the client's
            2380547
            2621802
Data/Code fix ticket#: CIDM-10869
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User entry error and data fix should resolve it.
*/


update personhospitalization 
set hospital_examstartdate = '2023-10-04 00:00:00.000',
	hospital_inpatientadmissiondate='2023-10-04 00:00:00.000',
	updatedon = now(), 
	updatedby ='CIDM-10869'
where hospitalizationid  ='3a9fc154-bf92-4b52-8d7f-ba5d2687be5e' and activeflag =1;



update personhospitalization 
set hospital_inpatientadmissiondate='2024-01-11 00:00:00.000',
	updatedon = now(), 
	updatedby ='CIDM-10869'
where hospitalizationid  ='ea36670b-b6d2-4df4-8687-9fb265eb39f1' and activeflag =1;


update personhospitalization 
set hospital_inpatientadmissiondate='2022-12-12 05:00:00',
	updatedon = now(), 
	updatedby ='CIDM-10869'
where hospitalizationid  ='a663939a-dd59-417c-b593-b9f7b9d84342' and activeflag =1;

update personhospitalization 
set hospital_inpatientadmissiondate='2023-01-09 00:00:00',
	updatedon = now(), 
	updatedby ='CIDM-10869'
where hospitalizationid  ='95374b33-a624-4b57-866e-d196ec425a13' and activeflag =1;