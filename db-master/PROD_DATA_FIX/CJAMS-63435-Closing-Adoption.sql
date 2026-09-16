/*
Issue: 3215122:Need to close out this child's MA case- reading that the adoption subsidy needs an end date & there is no one with a program assignment; neither which are valid for this kind of case. Please assist in closing. 
Root cause: :The case did not close because the system was missing the required closure records and approval details, so the case remained open.
Fix provided: DB query to adoptioncasedisposition,routing,adoptioncase tables.
Data/Code fix ticket#:CJAMS-63435
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:  
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
insert into adoptioncasedisposition
(adoptioncasedispositionid, adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag,
insertedby, insertedon, updatedby, updatedon)
values (gen_random_uuid(), '09847d2b-9ef2-44fb-a71a-dcdc52c622bb', '2025-07-19 00:00:00.000', 'Closed', 'Closed',
'approved to close as youth has turned 18 years old', '2025-07-19 00:00:00.000', 1, 'ab5963bc-43fe-4567-8487-62195fa3936b',
'2025-07-09 00:00:00.000', 'CJAMS-63435', now());

insert into routing 
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag,
insertedby, insertedon, updatedby, updatedon, isreviewrequest, servicerequestnumber)
values (gen_random_uuid(), 'ACDR', '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', 'ab5963bc-43fe-4567-8487-62195fa3936b',
'a4bf63ee-9314-458b-95d9-0c7095db11a4', 'CWSP', 'CWCW', 
(select adoptioncasedispositionid from adoptioncasedisposition where adoptioncaseid = '09847d2b-9ef2-44fb-a71a-dcdc52c622bb' and intakeserreqstatustypekey = 'Closed' and activeflag=1),
16, 1, '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', '2025-07-19 00:00:00.000', 'CJAMS-63435', now(),
true, '3215122');


update adoptioncase
set statustypekey = 'Closed',updatedby='CJAMS-63435',updatedon=NOW()
where adoptioncaseid = '09847d2b-9ef2-44fb-a71a-dcdc52c622bb' and activeflag=1;

--Deleting the subsidy rate related info
update adoptioncaseagreementrate
 set activeflag = 0,
 	 updatedon = now(),
 	 updatedby = 'CJAMS-63435'
 where adoptionagreementrateid ='ee37bbc4-de9b-4140-b555-eab8aad80179'
 and activeflag =1;
