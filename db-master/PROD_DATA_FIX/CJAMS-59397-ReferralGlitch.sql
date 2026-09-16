
/*
Issue:
I251013270165:Both referrals are the same intake 251013270165 referral 2510203040562 assigned by me to E Brown on 04/24/25intake 251013270165 referral 251023040564 assigned by Sarah to E Brown on 04/22/25 Screen
Root Cause:The same referral was entered into the system twice by mistake, creating two records for one inatke, this casused confusion and duplicates infomation in the case records.
Fix Provided (Data Fix Only):we fixed the issue by marking the duplciates records as inactive so they wont't show up of affet the case anymore.
Removed the dummy case 251023031612 and its associated records from:
intakeservicequest
activity
activitytask
Inserted a new routing record with corrected closure status and proper metadata for intake I251013261033.
Data/Code fix ticket#: CJAMS-59397
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
	updatedby = 'CJAMS-59397' ,
	updatedon = now()
where
	intakeserviceid = '5dee639e-4de1-4bee-897b-37e6afbaabec'
	and activeflag = 1;

update
	routing
set
	objectid = null,
	updatedby = 'CJAMS-59397' ,
	updatedon = now()
where
	routingid = '62b30125-e176-4283-8afa-e9a70f75a1ee'
	and activeflag = 1;

update
	intakeservicerequestactor
set
	activeflag = 0,
	updatedby = 'CJAMS-59397' ,
	updatedon = now()
where
	intakeservicerequestactorid in ('8293df1c-a5d0-42b1-a28a-d0e7391d0265',
	'296477e5-02da-48a4-b109-c0f41556846e',
	'2800e00f-c7ec-4486-b44f-68f8a330fbf9',
	'ea17ede2-3ced-4a9c-9adb-b799f2180b18',
	'3fa75c0b-46e1-4afc-be2f-e2c2527b394c',
	'58daaa18-9db6-400e-bd49-4c7c1ee8271d')
	and activeflag = 1;

update
	actor
set
	activeflag = 0,
	updatedby = 'CJAMS-59397' ,
	updatedon = now()
where
	actorid in ('c88973ac-ff4c-435c-aa45-0ff4e9367c68',
	'bca767b5-a454-4f93-8288-f74e75944a2a',
	'e6a903c5-a8c7-4843-904c-29c4104b7b65')
	and activeflag = 1;
--   no records
--update intakeservrequestsdmmaltreatment
--    set activeflag=0,
--         updatedby = 'CJAMS-59397' ,updatedon = now()
--    where intakeservicerequestsdmid in (select intakeservicerequestsdmid from intakeservicerequestsdm
--where intakeserviceid in ('ebb2ba2c-fef4-4a10-a1e8-11740ad219a9')    and activeflag = 1)
--    and activeflag = 1;
 update
	intakeservicerequestsdm
set
	activeflag = 0,
	updatedby = 'CJAMS-59397' ,
	updatedon = now()
where
	intakeservicerequestsdmid in ('ebb2ba2c-fef4-4a10-a1e8-11740ad219a9')
	and activeflag = 1;

update
	personprogramarea
set
	activeflag = 0,
	updatedby = 'CJAMS-59397',
	updatedon = now()
where
	personprogramid in('979c2fa7-207d-47f2-bef2-40c0c70f33ef',
	'f292bd25-972a-4d27-a665-f7b975e6213d',
	'a97bcdcb-90ef-4d50-9d20-0ccaa0292457')
	and activeflag = 1;
