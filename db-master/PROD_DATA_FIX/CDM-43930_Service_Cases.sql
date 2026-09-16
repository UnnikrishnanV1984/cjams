/*
   Issue Description: CDM-43930 Service cases
    remove the case assignment as intake, persons and contacts data are not available and need to remove it on the workload 
    '221030015920',
    '221030013496',
    '221030016440',
    '211030012365',
    '221030013494',
    '221030014751'
   Category/ Module  :Workload, Assessment
   Root cause: The family assignment was created as the part of user story CIDM-9543 which created a family assignment for the case
    When opening or reopening a case, family caseworker assignment must be mandatory.
    No worker of any type (Child, Admin) can be assigned to a case until a family worker has been assigned
   Fix provided : Data fix has been done to update the case assignment record.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

/*
select updatedby,* from  caseassignment
	where objectid in(
	select servicecaseid 
	from servicecase 
	where servicecasenumber in (
		'221030015920',
		'221030013496',
		'221030016440',
		'211030012365',
		'221030013494',
		'221030014751'
		) 
	and activeflag =1
	)
and activeflag=1
and  updatedby = 'CIDM-9543';
*/
update caseassignment
set updatedby = 'CDM-43930',
	updatedon = now(),
	activeflag = 0
	where objectid in(
	select servicecaseid
	from servicecase 
	where servicecasenumber in (
		'221030015920',
		'221030013496',
		'221030016440',
		'211030012365',
		'221030013494',
		'221030014751'
		) 
	and activeflag =1
	)
and activeflag=1
and  updatedby = 'CIDM-9543';

/*
servicecaseid:
c6ce74b1-e474-48c9-8e25-9643a822078f
d63ad61c-7d9e-4839-a53b-511c36700913
8982f759-2b1e-40eb-ac77-328711206e6f
59a2579a-31a6-4749-b74b-48d96041851f
ca4673c9-59c6-4a37-bb6e-80b13e820569
d6be1a96-4570-4302-83e9-8b3fa3312438

select servicecasedispositionid,* 
from servicecasedisposition 
where servicecaseid in (
'c6ce74b1-e474-48c9-8e25-9643a822078f',
'd63ad61c-7d9e-4839-a53b-511c36700913',
'8982f759-2b1e-40eb-ac77-328711206e6f',
'59a2579a-31a6-4749-b74b-48d96041851f',
'ca4673c9-59c6-4a37-bb6e-80b13e820569',
'd6be1a96-4570-4302-83e9-8b3fa3312438')
and activeflag = 1;
*/

update servicecasedisposition
set intakeserreqstatustypekey = 'Closed',
	dispositioncode = 'Closed',
	"comments" = 'Dev Closed', 
	updatedby = 'CDM-43930', 
	updatedon = now()
where servicecasedispositionid in (
'feb94d68-4e20-4d30-91bb-a9d5cfce1fd9',
'fc017e38-230c-497b-949a-5f5bda51b874',
'd5e5fd69-860a-49e0-8130-dce55d728108',
'87e53e15-7b68-4e78-8f75-34881466bf4f',
'a6bfcb07-6eac-4a44-9464-fd5e5ecd17cf',
'1bedce6d-1295-4033-8614-f15698c45db8'
)and activeflag = 1;


/*
select dispositioncode , statustypekey ,updatedby, * from servicecase s
where servicecaseid in (
'c6ce74b1-e474-48c9-8e25-9643a822078f',
'd63ad61c-7d9e-4839-a53b-511c36700913',
'8982f759-2b1e-40eb-ac77-328711206e6f',
'59a2579a-31a6-4749-b74b-48d96041851f',
'ca4673c9-59c6-4a37-bb6e-80b13e820569',
'd6be1a96-4570-4302-83e9-8b3fa3312438'
) and activeflag = 1;

*/

UPDATE cjams.servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', updatedby = 'CDM-43930',updatedon = now() 
where servicecaseid in (
'c6ce74b1-e474-48c9-8e25-9643a822078f',
'd63ad61c-7d9e-4839-a53b-511c36700913',
'8982f759-2b1e-40eb-ac77-328711206e6f',
'59a2579a-31a6-4749-b74b-48d96041851f',
'ca4673c9-59c6-4a37-bb6e-80b13e820569',
'd6be1a96-4570-4302-83e9-8b3fa3312438'
) and activeflag = 1;