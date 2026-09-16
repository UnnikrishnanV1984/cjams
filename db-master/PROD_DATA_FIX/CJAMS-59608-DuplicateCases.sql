/*
Issue:
Need data fix to delete duplicate cases created 251023050786 and 251023050789.
Root Cause:The same referral was entered into the system twice by mistake, creating two records for one inatke, this casused confusion and duplicates infomation in the case records.
Fix Provided (Data Fix Only):we fixed the issue by marking the duplciates records as inactive so they wont't show up of affet the case anymore.
Removed the dummy case 251023031612 and its associated records from:
intakeservicequest
activity
activitytask
Inserted a new routing record with corrected closure status and proper metadata for intake I251013279816.
Data/Code fix ticket#: CJAMS-59608
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data-only issue; no logic/code changes required.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update
	intakeservicerequest
set
	servicerequestnumber = null,
	updatedby = 'CJAMS-59608' ,
	updatedon = now()
where
	intakeserviceid in ('6548d732-b29a-4b57-8d1e-db2c3f344164','fc1ef558-663c-4d61-8ceb-e131422090d3')
	and activeflag = 1;


update
	routing
set
	objectid = null,
	updatedby = 'CJAMS-59608' ,
	updatedon = now()
where
	routingid = '62b30125-e176-4283-8afa-e9a70f75a1ee'
	and activeflag = 1;


update
	intakeservicerequestactor
set
	activeflag = 0,
	updatedby = 'CJAMS-59608' ,
	updatedon = now()
where
	intakeservicerequestactorid in ('0919ce8f-6a25-4998-b332-c7e6afb1708b',
	'0b888499-139f-48f2-bd26-3c3373f20180',
	'5bbc5f90-9449-4ebc-a465-f314bcbd706a',
	'1ebca373-6ecb-498e-8493-f66ea4484774')
	and activeflag = 1;




update
	actor
set
	activeflag = 0,
	updatedby = 'CJAMS-59608' ,
	updatedon = now()
where
	actorid in ('1f4ee0ec-33fb-4124-9e12-0ed52e18ad6d',
'8efe7159-965a-4e1e-a17f-67a5c343bbf0')
	and activeflag = 1;


update intakeservrequestsdmmaltreatment
    set activeflag=0,
         updatedby = 'CJAMS-59608' ,updatedon = now()
    where intakeservicerequestsdmid in (select intakeservicerequestsdmid from intakeservicerequestsdm
where intakeserviceid in ('6548d732-b29a-4b57-8d1e-db2c3f344164','fc1ef558-663c-4d61-8ceb-e131422090d3')   and activeflag = 1)
    and activeflag = 1;


 update
	intakeservicerequestsdm
set
	activeflag = 0,
	updatedby = 'CJAMS-59608' ,
	updatedon = now()
where
	intakeservicerequestsdmid in ('c2101460-5a49-42a8-990c-6a0b77396ac7',
'90bc4019-e162-4805-ab4b-5777a1ef0f18')
	and activeflag = 1;


update
	personprogramarea
set
	activeflag = 0,
	updatedby = 'CJAMS-59608',
	updatedon = now()
where
	personprogramid in('59d489b4-0033-4c3a-9a3f-162345abc458',
'6d700b71-102e-4f64-bef1-ab58077f2e36',
'00f8f830-a6e8-445a-a573-fb1e09e9f600',
'ae27470a-aa14-4264-894e-1f3e2bd3769b',
'ba1a26c6-0e36-48ae-99e5-20895eecb9d5',
'5ab70c08-5070-4647-9da7-087112013f34')
	and activeflag = 1;