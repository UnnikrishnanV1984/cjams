/*
Issue:User requested to update the Living Arrangement start date from 9/25/2025 to 9/24/2025 and update the admission start date from 9/25/2025 to 9/24/2025 for the Hai'Den Pierre Snead client (ID: 201215834). 
Root Cause:User request to update hospital_inpatientadmissiondate date.
Fix Provided (Data Fix Only):Data fix was done by Updated tb_service_purchase_authorization.
Data/Code fix ticket#: CJAMS-62399
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/


update placement  
set startdatetime  ='2025-09-24 08:00:00.000',updatedby  ='CJAMS-62399', updatedon =now()
where placementid  ='a5d39dfc-7009-4a3f-b204-fb68253b6f1e' and activeflag =1;



update placementrevision  
set entrydate  ='2025-09-24 08:00:00.000',updatedby  ='CJAMS-62399', updatedon =now()
where placementrevisionid  ='e4789b40-abee-45c4-a051-7107ff013977' and activeflag =1;

update livingarrangement 
set livingstartdate  ='2025-09-24 08:00:00.000',updatedby  ='CJAMS-62399', updatedon =now()
where livingid  ='3d78e851-9952-405e-af8d-6dd16b5a2d78' and activeflag =1;


update personhospitalization 
set hospital_inpatientadmissiondate  ='2025-09-24 08:00:00.000',updatedby  ='CJAMS-62399', updatedon =now()
where hospitalizationid  ='44eba215-642a-46dd-9218-988d6fc6478b' and activeflag =1;

update personhospitalization_history  
set hospital_inpatientadmissiondate  ='2025-09-24 08:00:00.000',updatedby  ='CJAMS-62399', updatedon =now()
where personhospitalizationhistoryid  ='ef213228-85ca-4895-ba11-3bd7aef25dde' and activeflag =1;
