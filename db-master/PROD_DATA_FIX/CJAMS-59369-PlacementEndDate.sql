/*
Issue Description: remove the Child Removal & OOH Program Assignment End Date as requested.
Category/Module: Bug
Root cause: user could not abe to delete end dates ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-59369
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-59369', updatedon = now()
where intakeservreqchildremovalid = 'e963bbb4-68bc-4a97-8194-426110c44cdd' and activeflag =1;


update intakeservreqchildremoval_history 
set exitdate = null ,updatedby = 'CJAMS-59369', updatedon = now()
where intakeservreqchildremovalhistoryid in ('213b8e1e-3f84-43aa-b13a-815a43df5529',
'afe04035-eb29-400f-8167-2d910b3b3972',
'7a4e049f-81c9-4af7-b36b-8220a64602aa',
'46a0a793-36ba-41fd-9fc8-53e29e2ee239',
'5bd9586e-81d2-4fef-aa1b-7e109b66b28b',
'8da80769-df37-405a-bb6f-7dd57891eb1e',
'4d792428-be17-4020-81de-2ab19c68aec0',
'a2eacda5-24ff-43d0-ac9c-beec31b5a429',
'dfc2b8e9-7b07-47f5-9a77-066e011a43f1',
'295c1f08-a955-4c0e-a9fd-b966474dc40e') and activeflag =1;

update personprogramarea
set enddate = null, updatedby = 'CJAMS-59369', updatedon = now()
where personprogramid = '0692882f-d29c-4910-a636-b2d2ddd27a59' and activeflag = 1 ;

update cjams.placement
set enddatetime = null,
endtime = null,
exitreasontypekey = null,
exittypekey = null,
updatedon = now(),
updatedby = 'CJAMS-59369'
where placementid = '497e993d-c1db-4f07-868b-107605f81843'
and activeflag = 1 ;

update cjams.placementrevision
set exitdate = null,
exittime = null,
exitreasontypkey = null,
exittypekey = null,
updatedon = now(),
updatedby = 'CJAMS-59369'
where placementrevisionid  = '2051961b-2803-4cae-b1cc-7c3cccf23034'
and ( exitdate is not null or exittime is not null ) and activeflag =1 ;


update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-59369'
where eligibility_id  = 10021895 and delete_sw = 'N';
